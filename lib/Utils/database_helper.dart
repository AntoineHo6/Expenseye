import 'dart:io';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = Strings.dbFileName;
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 4;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    print('creating items table');
    await db.execute('''
              CREATE TABLE ${Strings.tableItems} (
                ${Strings.itemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.itemColumnName} TEXT NOT NULL,
                ${Strings.itemColumnValue} DOUBLE NOT NULL,
                ${Strings.itemColumnDate} TEXT NOT NULL,
                ${Strings.itemColumnCategory} TEXT NOT NULL,
                ${Strings.itemColumnType} INTEGER NOT NULL
              )
              ''');

    print('Creating categories table');
    await db.execute('''
          CREATE TABLE ${Strings.tableCategories} (
            ${Strings.categoryColumnId} TEXT PRIMARY KEY,
            ${Strings.categoryColumnName} TEXT NOT NULL,
            ${Strings.categoryColumnIconCodePoint} TEXT NOT NULL,
            ${Strings.categoryColumnColor} TEXT NOT NULL,
            ${Strings.categoryColumnType} INTEGER NOT NULL
          )
          ''');

    await _insertDefaultCategories(db);

    print('Creating reccurrent expenses table');
    await db.execute('''
            CREATE TABLE ${Strings.tableRecurrentItems} (
              ${Strings.recurrentItemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${Strings.recurrentItemColumnName} TEXT NOT NULL,
              ${Strings.recurrentItemColumnValue} DOUBLE NOT NULL,
              ${Strings.recurrentItemColumnDay} INTEGER NOT NULL,
              ${Strings.recurrentItemColumnIsAdded} INTEGER NOT NULL,
              ${Strings.recurrentItemColumnCategory} TEXT NOT NULL,
              FOREIGN KEY(${Strings.recurrentItemColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId})
            )
            ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('UPGRADINGGGG');
    try {
      await db.execute('''
          CREATE TABLE ${Strings.tableCategories} (
            ${Strings.categoryColumnId} TEXT PRIMARY KEY,
            ${Strings.categoryColumnName} TEXT NOT NULL,
            ${Strings.categoryColumnIconCodePoint} TEXT NOT NULL,
            ${Strings.categoryColumnColor} TEXT NOT NULL,
            ${Strings.categoryColumnType} INTEGER NOT NULL
          )
          ''');
      print('Created categories table');

      await _insertDefaultCategories(db);
      print('Inserted default categories');
    } catch (e) {}

    try {
      await db.rawQuery('DROP TABLE reccurent_items');
      print('Dropped outdated recurrent items table');
    } catch (e) {}

    try {
      await db.execute('''
            CREATE TABLE ${Strings.tableRecurrentItems} (
              ${Strings.recurrentItemColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${Strings.recurrentItemColumnName} TEXT NOT NULL,
              ${Strings.recurrentItemColumnValue} DOUBLE NOT NULL,
              ${Strings.recurrentItemColumnDay} INTEGER NOT NULL,
              ${Strings.recurrentItemColumnIsAdded} INTEGER NOT NULL,
              ${Strings.recurrentItemColumnCategory} TEXT NOT NULL,
              FOREIGN KEY(${Strings.recurrentItemColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId})
            )
            ''');
      print('Created new recurrent expenses table');
    } catch (e) {}
  }

  Future<void> upgrade() async {
    // TODO: temp until expiry date
    Database db = await database;
    await _onUpgrade(db, 3, 4);
  }

  Future<int> insertItem(Item expense) async {
    Database db = await database;
    int id = await db.insert(Strings.tableItems, expense.toMap());
    return id;
  }

  Future<Item> queryItem(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(Strings.tableItems,
        columns: [
          Strings.itemColumnId,
          Strings.itemColumnName,
          Strings.itemColumnValue,
          Strings.itemColumnDate,
          Strings.itemColumnCategory,
          Strings.itemColumnType
        ],
        where: '${Strings.itemColumnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Item.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Item>> queryItemsInDate(DateTime date) async {
    Database db = await database;
    String dateStrToFind = date.toIso8601String().split('T')[0];

    List<Map> maps = await db.query(Strings.tableItems,
        where: '${Strings.itemColumnDate} LIKE \'$dateStrToFind%\'');

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryItemsInMonth(String yearMonth) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableItems,
      where: '${Strings.itemColumnDate} LIKE \'$yearMonth%\'',
      orderBy: '${Strings.itemColumnDate} DESC',
    );

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryItemsInYear(String year) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableItems,
      where: '${Strings.itemColumnDate} LIKE \'$year%\'',
      orderBy: '${Strings.itemColumnDate} DESC',
    );

    return convertMapsToItems(maps);
  }

  Future<List<Item>> queryAllItems() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableItems);

    return convertMapsToItems(maps);
  }

  Future<int> updateItem(Item item) async {
    Database db = await database;

    return await db.update(Strings.tableItems, item.toMap(),
        where: '${Strings.itemColumnId} = ?', whereArgs: [item.id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;

    return await db.delete(Strings.tableItems,
        where: '${Strings.itemColumnId} = ?', whereArgs: [id]);
  }

  // TODO: include other tables
  Future<void> deleteAll() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableItems}');
  }

  List<Item> convertMapsToItems(List<Map> maps) {
    List<Item> items = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        items.add(new Item.fromMap(row));
      }
    }

    return items;
  }

  Future<void> _insertDefaultCategories(Database db) async {
    Category food = Category(
      id: Strings.food,
      name: Strings.food,
      iconData: MdiIcons.silverware,
      color: Color(0xffff8533),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, food.toMap());

    Category transportation = Category(
      id: Strings.transportation,
      name: Strings.transportation,
      iconData: MdiIcons.car,
      color: Colors.yellow,
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, transportation.toMap());

    Category shopping = Category(
      id: Strings.shopping,
      name: Strings.shopping,
      iconData: MdiIcons.cart,
      color: Color(0xffac3973),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, shopping.toMap());

    Category entertainment = Category(
      id: Strings.entertainment,
      name: Strings.entertainment,
      iconData: MdiIcons.movie,
      color: Color(0xff66ccff),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, entertainment.toMap());

    Category activity = Category(
      id: Strings.activity,
      name: Strings.activity,
      iconData: MdiIcons.emoticonOutline,
      color: Color(0xffff66cc),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, activity.toMap());

    Category medical = Category(
      id: Strings.medical,
      name: Strings.medical,
      iconData: MdiIcons.medicalBag,
      color: Color(0xffff3333),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, medical.toMap());

    Category home = Category(
      id: Strings.home,
      name: Strings.home,
      iconData: MdiIcons.home,
      color: Color(0xffcc9966),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, home.toMap());

    Category travel = Category(
      id: Strings.travel,
      name: Strings.travel,
      iconData: MdiIcons.airplane,
      color: Color(0xffcc6600),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, travel.toMap());

    Category people = Category(
      id: Strings.people,
      name: Strings.people,
      iconData: MdiIcons.accountMultiple,
      color: Color(0xff3377ff),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, people.toMap());

    Category education = Category(
      id: Strings.education,
      name: Strings.education,
      iconData: MdiIcons.school,
      color: Color(0xff9933ff),
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, education.toMap());

    Category otherExpenses = Category(
      id: Strings.otherExpenses,
      name: Strings.others,
      iconData: MdiIcons.folderDownload,
      color: Colors.white,
      type: ItemType.expense,
    );
    db.insert(Strings.tableCategories, otherExpenses.toMap());

    // * DEFAULT INCOMES
    Category salary = Category(
      id: Strings.salary,
      name: Strings.salary,
      iconData: MdiIcons.currencyUsd,
      color: Colors.green,
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, salary.toMap());

    Category gift = Category(
      id: Strings.gift,
      name: Strings.gift,
      iconData: MdiIcons.walletGiftcard,
      color: Color(0xffb84dff),
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, gift.toMap());

    Category business = Category(
      id: Strings.business,
      name: Strings.business,
      iconData: MdiIcons.briefcase,
      color: Color(0xff1a8cff),
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, business.toMap());

    Category insurance = Category(
      id: Strings.insurance,
      name: Strings.insurance,
      iconData: MdiIcons.bank,
      color: Color(0xff6666ff),
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, insurance.toMap());

    Category realEstate = Category(
      id: Strings.realEstate,
      name: Strings.realEstate,
      iconData: MdiIcons.homeGroup,
      color: Color(0xffccccff),
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, realEstate.toMap());

    Category investment = Category(
      id: Strings.investment,
      name: Strings.investment,
      iconData: MdiIcons.trendingUp,
      color: Color(0xff00e673),
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, investment.toMap());

    Category refund = Category(
      id: Strings.refund,
      name: Strings.refund,
      iconData: MdiIcons.swapVerticalBold,
      color: Color(0xff66ffff),
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, refund.toMap());

    Category otherIncomes = Category(
      id: Strings.otherIncomes,
      name: Strings.others,
      iconData: MdiIcons.folderUpload,
      color: Colors.white,
      type: ItemType.income,
    );
    db.insert(Strings.tableCategories, otherIncomes.toMap());
  }

  Future<List<Category>> queryCategories() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableCategories);

    return convertMapsToCategories(maps);
  }

  List<Category> convertMapsToCategories(List<Map> maps) {
    List<Category> categories = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        categories.add(new Category.fromMap(row));
      }
    }

    return categories;
  }
}
