import 'dart:io';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/app_localizations.dart';
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
  static final _databaseVersion = 6;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  String languageCode;

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

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

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

  Future<List<Item>> queryItemsByMonth(String yearMonth) async {
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

  Future<int> deleteItemsByCategory(String categoryId) async {
    Database db = await database;

    return await db.delete(Strings.tableItems,
        where: '${Strings.itemColumnCategory} = ?', whereArgs: [categoryId]);
  }

  Future<void> deleteAllItems() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableItems}');
    await db.rawQuery('DELETE FROM ${Strings.tableRecurrentItems}');
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
    for (var category in defaultCategories()) {
      await db.insert(Strings.tableCategories, category.toMap());
    }
  }

  Future<void> insertDefaultCategories() async {
    Database db = await database;
    for (var category in defaultCategories()) {
      await db.insert(Strings.tableCategories, category.toMap());
    }
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

  Future<void> insertCategory(Category category) async {
    Database db = await database;

    await db.insert(Strings.tableCategories, category.toMap());
  }

  Future<void> deleteCategory(String id) async {
    Database db = await database;

    return await db.delete(Strings.tableCategories,
        where: '${Strings.categoryColumnId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllCategories() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableCategories}');
  }

  List<Category> defaultCategories() {
    // Expenses
    String foodName,
        transportationName,
        shoppingName,
        entertainmentName,
        activityName,
        medicalName,
        homeName,
        travelName,
        peopleName,
        educationName,
        otherExpensesName;

    String salaryName,
        giftName,
        businessName,
        insuranceName,
        realEstateName,
        investmentName,
        refundName,
        otherIncomesName;

    switch (languageCode) {
      case 'fr':
        foodName = 'Nourriture';
        break;
      case 'en':
        foodName = Strings.food;
        transportationName = Strings.transportation;
        entertainmentName = Strings.entertainment;
        activityName = Strings.activity;
        medicalName = Strings.medical;
        homeName = Strings.home;
        travelName = Strings.travel;
        peopleName = Strings.people;
        educationName = Strings.education;
        otherExpensesName = Strings.otherExpenses;
        break;
    }

    return [
      Category(
        id: Strings.food.toLowerCase(),
        name: foodName,
        iconData: MdiIcons.silverware,
        color: Color(0xffff8533),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.transportation.toLowerCase(),
        name: transportationName,
        iconData: MdiIcons.car,
        color: Colors.yellow,
        type: ItemType.expense,
      ),
      Category(
        id: Strings.shopping.toLowerCase(),
        name: shoppingName,
        iconData: MdiIcons.cart,
        color: Color(0xffac3973),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.entertainment.toLowerCase(),
        name: entertainmentName,
        iconData: MdiIcons.movie,
        color: Color(0xff66ccff),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.activity.toLowerCase(),
        name: activityName,
        iconData: MdiIcons.emoticonOutline,
        color: Color(0xffff66cc),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.medical.toLowerCase(),
        name: medicalName,
        iconData: MdiIcons.medicalBag,
        color: Color(0xffff3333),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.home.toLowerCase(),
        name: homeName,
        iconData: MdiIcons.home,
        color: Color(0xffcc9966),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.travel.toLowerCase(),
        name: travelName,
        iconData: MdiIcons.airplane,
        color: Color(0xffcc6600),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.people.toLowerCase(),
        name: peopleName,
        iconData: MdiIcons.accountMultiple,
        color: Color(0xff3377ff),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.education.toLowerCase(),
        name: educationName,
        iconData: MdiIcons.school,
        color: Color(0xff9933ff),
        type: ItemType.expense,
      ),
      Category(
        id: Strings.otherExpenses.toLowerCase(),
        name: otherExpensesName,
        iconData: MdiIcons.folderDownload,
        color: Colors.white,
        type: ItemType.expense,
      ),
      Category(
        id: Strings.salary.toLowerCase(),
        name: Strings.salary,
        iconData: MdiIcons.currencyUsd,
        color: Colors.green,
        type: ItemType.income,
      ),
      Category(
        id: Strings.gift.toLowerCase(),
        name: Strings.gift,
        iconData: MdiIcons.walletGiftcard,
        color: Color(0xffb84dff),
        type: ItemType.income,
      ),
      Category(
        id: Strings.business.toLowerCase(),
        name: Strings.business,
        iconData: MdiIcons.briefcase,
        color: Color(0xff1a8cff),
        type: ItemType.income,
      ),
      Category(
        id: Strings.insurance.toLowerCase(),
        name: Strings.insurance,
        iconData: MdiIcons.bank,
        color: Color(0xff6666ff),
        type: ItemType.income,
      ),
      Category(
        id: Strings.realEstate.toLowerCase(),
        name: Strings.realEstate,
        iconData: MdiIcons.homeGroup,
        color: Color(0xffccccff),
        type: ItemType.income,
      ),
      Category(
        id: Strings.investment.toLowerCase(),
        name: Strings.investment,
        iconData: MdiIcons.trendingUp,
        color: Color(0xff00e673),
        type: ItemType.income,
      ),
      Category(
        id: Strings.refund.toLowerCase(),
        name: Strings.refund,
        iconData: MdiIcons.swapVerticalBold,
        color: Color(0xff66ffff),
        type: ItemType.income,
      ),
      Category(
        id: Strings.otherIncomes.toLowerCase(),
        name: Strings.otherIncomes,
        iconData: MdiIcons.folderUpload,
        color: Colors.white,
        type: ItemType.income,
      )
    ];
  }
}
