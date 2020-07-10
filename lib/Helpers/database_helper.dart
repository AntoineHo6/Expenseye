import 'dart:io';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Models/recurring_transac.dart';
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
  // * new version will be 12
  static final _databaseVersion = 12;

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
    print('creating transactions table');
    await db.execute('''
              CREATE TABLE ${Strings.tableTransacs} (
                ${Strings.transacColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.transacColumnName} TEXT NOT NULL,
                ${Strings.transacColumnValue} DOUBLE NOT NULL,
                ${Strings.transacColumnDate} TEXT NOT NULL,
                ${Strings.transacColumnType} INTEGER NOT NULL,
                ${Strings.transacColumnCategory} TEXT NOT NULL,
                ${Strings.transacColumnAccount} TEXT NULL NULL,
                FOREIGN KEY(${Strings.transacColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId}),
                FOREIGN KEY(${Strings.transacColumnAccount}) REFERENCES ${Strings.tableAccounts}(${Strings.accountColumnId})
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

    print('Inserting default categories');
    await _insertDefaultCategories(db);

    print('Creating recurring transactions table');
    await db.execute('''
            CREATE TABLE ${Strings.tableRecurringTransacs} (
              ${Strings.recurringTransacColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${Strings.recurringTransacColumnName} TEXT NOT NULL,
              ${Strings.recurringTransacColumnAmount} DOUBLE NOT NULL,
              ${Strings.recurringTransacColumnDueDate} INTEGER NOT NULL,
              ${Strings.recurringTransacColumnPeriodicity} INTEGER NOT NULL,
              ${Strings.recurringTransacColumnCategory} TEXT NOT NULL,
              ${Strings.recurringTransacColumnAccount} TEXT NULL NULL,
              FOREIGN KEY(${Strings.recurringTransacColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId}),
              FOREIGN KEY(${Strings.recurringTransacColumnAccount}) REFERENCES ${Strings.tableAccounts}(${Strings.accountColumnId})
            )
            ''');

    print('Creating accounts table');
    await db.execute('''
          CREATE TABLE ${Strings.tableAccounts} (
            ${Strings.accountColumnId} TEXT PRIMARY KEY,
            ${Strings.accountColumnName} TEXT NOT NULL,
            ${Strings.accountColumnBalance} DOUBLE NOT NULL
          )
          ''');

    print('Inserting default cash account');
    await _insertDefaultAccount(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('UPGRAADINGGGGGGGG');
    print('Creating accounts table');
    await db.execute('''
          CREATE TABLE ${Strings.tableAccounts} (
            ${Strings.accountColumnId} TEXT PRIMARY KEY,
            ${Strings.accountColumnName} TEXT NOT NULL,
            ${Strings.accountColumnBalance} DOUBLE NOT NULL
          )
          ''');

    print('adding accounts to transactions table');
    await db.execute('ALTER TABLE items RENAME TO tempItems');
    await db.execute(
      '''
              CREATE TABLE ${Strings.tableTransacs} (
                ${Strings.transacColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${Strings.transacColumnName} TEXT NOT NULL,
                ${Strings.transacColumnValue} DOUBLE NOT NULL,
                ${Strings.transacColumnDate} TEXT NOT NULL,
                ${Strings.transacColumnType} INTEGER NOT NULL,
                ${Strings.transacColumnCategory} TEXT NOT NULL,
                ${Strings.transacColumnAccount} TEXT NULL NULL,
                FOREIGN KEY(${Strings.transacColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId}),
                FOREIGN KEY(${Strings.transacColumnAccount}) REFERENCES ${Strings.tableAccounts}(${Strings.accountColumnId})
              )
              ''',
    );
    await db.execute('''
      INSERT INTO ${Strings.tableTransacs}
      (id, name, amount, date, category, type, account)
      SELECT expense_id, name, value, date, category, type, 'cash'
      FROM tempItems;
    ''');
    await db.execute('DROP TABLE tempItems');

    print('adding accounts to recurring transactions table');
    await db.execute('ALTER TABLE recurring_items RENAME TO temp69');
    await db.execute('''
            CREATE TABLE ${Strings.tableRecurringTransacs} (
              ${Strings.recurringTransacColumnId} INTEGER PRIMARY KEY AUTOINCREMENT,
              ${Strings.recurringTransacColumnName} TEXT NOT NULL,
              ${Strings.recurringTransacColumnAmount} DOUBLE NOT NULL,
              ${Strings.recurringTransacColumnDueDate} INTEGER NOT NULL,
              ${Strings.recurringTransacColumnPeriodicity} INTEGER NOT NULL,
              ${Strings.recurringTransacColumnCategory} TEXT NOT NULL,
              ${Strings.recurringTransacColumnAccount} TEXT NULL NULL,
              FOREIGN KEY(${Strings.recurringTransacColumnCategory}) REFERENCES ${Strings.tableCategories}(${Strings.categoryColumnId}),
              FOREIGN KEY(${Strings.recurringTransacColumnAccount}) REFERENCES ${Strings.tableAccounts}(${Strings.accountColumnId})
            )
            ''');
    await db.execute('''
      INSERT INTO ${Strings.tableRecurringTransacs}
      (id, name, amount, due_date, periodicity, category, account)
      SELECT recurring_item_id, name, amount, due_date, periodicity, category, 'cash'
      FROM temp69;
    ''');
    await db.execute('DROP TABLE temp69');

    print('querying all the transactions and calculating balance');
    await _tempAddCashAccountWithOldTransacs(db);
  }

  Future<void> _tempAddCashAccountWithOldTransacs(Database db) async {
    List<Map> maps = await db.query(Strings.tableTransacs);

    List<Transac> transacs = convertMapsToTransacs(maps);

    double total = 0;
    for (var transac in transacs) {
      switch (transac.type) {
        case TransacType.expense:
          total -= transac.amount;
          break;
        case TransacType.income:
          total += transac.amount;
          break;
      }
    }

    String cashAccountName;
    switch (languageCode) {
      case 'en':
        cashAccountName = Strings.cashEN;
        break;
      case 'fr':
        cashAccountName = Strings.cashFR;
        break;
    }

    Account cashAccount = new Account(
      cashAccountName.toLowerCase(),
      cashAccountName,
      total,
    );

    await db.insert(Strings.tableAccounts, cashAccount.toMap());
  }

  // * SQLITE_SEQUENCE
  Future<int> querySequence(String name) async {
    Database db = await database;
    List<Map> map = await db.query(
      Strings.tableSqliteSequence,
      columns: [Strings.sqliteSequenceColumnSeq],
      where: '${Strings.sqliteSequenceColumnName} = ?',
      whereArgs: [name],
    );

    return map.first[Strings.sqliteSequenceColumnSeq];
  }

  // * TRANSACTIONS
  Future<int> insertTransac(Transac expense) async {
    Database db = await database;
    int id = await db.insert(Strings.tableTransacs, expense.toMap());
    return id;
  }

  Future<Transac> queryTransacById(int id) async {
    Database db = await database;
    List<Map> map = await db.query(
      Strings.tableTransacs,
      where: '${Strings.transacColumnId} = ?',
      whereArgs: [id],
    );

    return convertMapsToTransacs(map).first;
  }

  Future<List<Transac>> queryTransacsByCategory(String categoryId) async {
    Database db = await database;
    List<Map> maps = await db.query(
      Strings.tableTransacs,
      where: '${Strings.transacColumnCategory} = ?',
      whereArgs: [categoryId],
    );

    return convertMapsToTransacs(maps);
  }

  Future<List<Transac>> queryTransacsByAccount(String accountId) async {
    Database db = await database;
    List<Map> maps = await db.query(
      Strings.tableTransacs,
      where: '${Strings.transacColumnAccount} = ?',
      whereArgs: [accountId],
    );

    return convertMapsToTransacs(maps);
  }

  Future<List<Transac>> queryTransacsInDate(DateTime date) async {
    Database db = await database;
    String dateStrToFind = date.toIso8601String().split('T')[0];

    List<Map> maps = await db.query(
      Strings.tableTransacs,
      where: '${Strings.transacColumnDate} LIKE \'$dateStrToFind%\'',
    );

    return convertMapsToTransacs(maps);
  }

  Future<List<Transac>> queryTransacsByMonth(String yearMonth) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableTransacs,
      where: '${Strings.transacColumnDate} LIKE \'$yearMonth%\'',
      orderBy: '${Strings.transacColumnDate} DESC',
    );

    return convertMapsToTransacs(maps);
  }

  Future<List<Transac>> queryTransacsInYear(String year) async {
    Database db = await database;

    List<Map> maps = await db.query(
      Strings.tableTransacs,
      where: '${Strings.transacColumnDate} LIKE \'$year%\'',
      orderBy: '${Strings.transacColumnDate} DESC',
    );

    return convertMapsToTransacs(maps);
  }

  Future<List<Transac>> queryAllTransacs() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableTransacs);

    return convertMapsToTransacs(maps);
  }

  Future<int> updateTransac(Transac transac) async {
    Database db = await database;

    return await db.update(
      Strings.tableTransacs,
      transac.toMap(),
      where: '${Strings.transacColumnId} = ?',
      whereArgs: [transac.id],
    );
  }

  Future<int> deleteTransac(int id) async {
    Database db = await database;

    return await db
        .delete(Strings.tableTransacs, where: '${Strings.transacColumnId} = ?', whereArgs: [id]);
  }

  Future<void> updateTransacsAndRecTransacsCategory(
      String oldCategoryId, String newCategoryId) async {
    Database db = await database;

    await db.rawUpdate(
      ''' 
        UPDATE ${Strings.tableTransacs} 
        SET ${Strings.transacColumnCategory} = ? 
        WHERE ${Strings.transacColumnCategory} = ?
      ''',
      [newCategoryId, oldCategoryId],
    );
    await db.rawUpdate(
      '''
        UPDATE ${Strings.tableRecurringTransacs}
        SET ${Strings.recurringTransacColumnCategory} = ?
        WHERE ${Strings.recurringTransacColumnCategory} = ?
      ''',
      [newCategoryId, oldCategoryId],
    );
  }

  Future<int> deleteTransacsByCategory(String categoryId) async {
    Database db = await database;

    return await db.delete(
      Strings.tableTransacs,
      where: '${Strings.transacColumnCategory} = ?',
      whereArgs: [categoryId],
    );
  }

  Future<int> deleteTransacsByAccount(String accountId) async {
    Database db = await database;

    return await db.delete(
      Strings.tableTransacs,
      where: '${Strings.transacColumnAccount} = ?',
      whereArgs: [accountId],
    );
  }

  // TODO: rename
  Future<void> deleteAllTransacsAndRecTransacs() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableTransacs}');
    await db.rawQuery('DELETE FROM ${Strings.tableRecurringTransacs}');
  }

  List<Transac> convertMapsToTransacs(List<Map> maps) {
    List<Transac> transacs = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        transacs.add(new Transac.fromMap(row));
      }
    }

    return transacs;
  }

  // * RECURRING TRANSACTIONS
  Future<void> insertRecurringTransac(RecurringTransac recurringTransac) async {
    Database db = await database;
    await db.insert(Strings.tableRecurringTransacs, recurringTransac.toMap());
  }

  Future<List<RecurringTransac>> queryRecurringTransacs() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableRecurringTransacs);

    return convertMapsToRecurringTransacs(maps);
  }

  List<RecurringTransac> convertMapsToRecurringTransacs(List<Map> maps) {
    List<RecurringTransac> recurringTransacs = new List();

    if (maps.length > 0) {
      for (Map row in maps) {
        recurringTransacs.add(new RecurringTransac.fromMap(row));
      }
    }

    return recurringTransacs;
  }

  Future<void> deleteRecurringTransac(int id) async {
    Database db = await database;

    return await db.delete(Strings.tableRecurringTransacs,
        where: '${Strings.recurringTransacColumnId} = ?', whereArgs: [id]);
  }

  Future<int> updateRecurringTransac(RecurringTransac recurringTransac) async {
    Database db = await database;

    return await db.update(
      Strings.tableRecurringTransacs,
      recurringTransac.toMap(),
      where: '${Strings.recurringTransacColumnId} = ?',
      whereArgs: [recurringTransac.id],
    );
  }

  Future<void> deleteRecurringTransacsByCategory(String categoryId) async {
    Database db = await database;

    return await db.delete(Strings.tableRecurringTransacs,
        where: '${Strings.recurringTransacColumnCategory} = ?', whereArgs: [categoryId]);
  }

  // * ACCOUNTS
  Future<List<Account>> queryAccounts() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableAccounts);

    return _convertMapsToAccounts(maps);
  }

  Future<Account> queryFirstAccount() async {
    Database db = await database;

    List<Map> maps = await db.query(Strings.tableAccounts, limit: 1);

    return _convertMapsToAccounts(maps).first;
  }

  Future<void> deleteAccount(String id) async {
    Database db = await database;

    return await db.delete(
      Strings.tableAccounts,
      where: '${Strings.accountColumnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertAccount(Account account) async {
    Database db = await database;
    await db.insert(Strings.tableAccounts, account.toMap());
  }

  List<Account> _convertMapsToAccounts(List<Map> maps) {
    List<Account> accounts = new List();
    if (maps.length > 0) {
      for (Map row in maps) {
        accounts.add(new Account.fromMap(row));
      }
    }

    return accounts;
  }

  Future<void> addToAccount(String accountId, double amount) async {
    Database db = await database;
    // 1. Query the balance from the account
    List<Map> map = await db.query(
      Strings.tableAccounts,
      columns: [Strings.accountColumnBalance],
      where: '${Strings.accountColumnId} = ?',
      whereArgs: [accountId],
    );

    // 2. use variable to add amount to the balance
    double balance = map.first['balance'];
    balance += amount;

    // 3. update account balance with the new balance
    await db.update(
      Strings.tableAccounts,
      {Strings.accountColumnBalance: balance},
      where: '${Strings.accountColumnId} = ?',
      whereArgs: [accountId],
    );
  }

  Future<void> deductFromAccount(String accountId, double amount) async {
    Database db = await database;
    // 1. Query the balance from the account
    List<Map> map = await db.query(
      Strings.tableAccounts,
      columns: [Strings.accountColumnBalance],
      where: '${Strings.accountColumnId} = ?',
      whereArgs: [accountId],
    );

    // 2. use variable to deduct amount from the balance
    double balance = map.first[Strings.accountColumnBalance];
    balance -= amount;

    // 3. update account balance with the new balance
    await db.update(
      Strings.tableAccounts,
      {Strings.accountColumnBalance: balance},
      where: '${Strings.accountColumnId} = ?',
      whereArgs: [accountId],
    );
  }

  Future<void> removeTransacAmountFromAccBalance(Transac transac) async {
    if (transac.type == TransacType.expense) {
      await addToAccount(transac.accountId, transac.amount);
    } else {
      await deductFromAccount(transac.accountId, transac.amount);
    }
  }

  Future<void> deleteAllAccounts() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableAccounts}');
  }

  Future<void> deleteRecurringTransacsByAccount(String accountId) async {
    Database db = await database;

    return await db.delete(
      Strings.tableRecurringTransacs,
      where: '${Strings.recurringTransacColumnAccount} = ?',
      whereArgs: [accountId],
    );
  }

  Future<void> _insertDefaultAccount(Database db) async {
    Account defaultAccount = _getDefaultAccount();
    await db.insert(Strings.tableAccounts, defaultAccount.toMap());
  }

  Future<void> insertDefaultAccount() async {
    Database db = await database;
    Account defaultAccount = _getDefaultAccount();
    await db.insert(Strings.tableAccounts, defaultAccount.toMap());
  }

  Future<void> updateTransacsAndRecTransacsAccount(String oldAccountId, String newAccountId) async {
    Database db = await database;

    await db.rawUpdate(
      ''' 
        UPDATE ${Strings.tableTransacs} 
        SET ${Strings.transacColumnAccount} = ? 
        WHERE ${Strings.transacColumnAccount} = ?
      ''',
      [newAccountId, oldAccountId],
    );
    await db.rawUpdate(
      '''
        UPDATE ${Strings.tableRecurringTransacs}
        SET ${Strings.recurringTransacColumnAccount} = ?
        WHERE ${Strings.recurringTransacColumnAccount} = ?
      ''',
      [newAccountId, oldAccountId],
    );
  }

  // * CATEGORIES
  Future<void> _insertDefaultCategories(Database db) async {
    for (var category in _getDefaultCategories()) {
      await db.insert(Strings.tableCategories, category.toMap());
    }
  }

  Future<void> insertDefaultCategories() async {
    Database db = await database;
    for (var category in _getDefaultCategories()) {
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

    return await db.delete(
      Strings.tableCategories,
      where: '${Strings.categoryColumnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllCategories() async {
    Database db = await database;
    await db.rawQuery('DELETE FROM ${Strings.tableCategories}');
  }

  Account _getDefaultAccount() {
    String cashAccountName;
    switch (languageCode) {
      case 'fr':
        cashAccountName = Strings.cashFR;
        break;
      default:
        cashAccountName = Strings.cashEN;
        break;
    }

    Account cashAccount = new Account(
      cashAccountName.toLowerCase(),
      cashAccountName,
      0,
    );

    return cashAccount;
  }

  List<Category> _getDefaultCategories() {
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
        educationName;
    // Incomes
    String salaryName,
        giftName,
        businessName,
        insuranceName,
        realEstateName,
        investmentName,
        refundName;

    switch (languageCode) {
      case 'fr':
        foodName = Strings.foodFR;
        transportationName = Strings.transportationFR;
        shoppingName = Strings.shoppingFR;
        entertainmentName = Strings.entertainmentFR;
        activityName = Strings.activityFR;
        medicalName = Strings.medicalFR;
        homeName = Strings.homeFR;
        travelName = Strings.travelFR;
        peopleName = Strings.peopleFR;
        educationName = Strings.educationFR;
        salaryName = Strings.salaryFR;
        giftName = Strings.giftFR;
        businessName = Strings.businessFR;
        insuranceName = Strings.insuranceFR;
        realEstateName = Strings.realEstateFR;
        investmentName = Strings.investmentFR;
        refundName = Strings.refundFR;
        break;
      default:
        foodName = Strings.foodEN;
        transportationName = Strings.transportationEN;
        shoppingName = Strings.shoppingEN;
        entertainmentName = Strings.entertainmentEN;
        activityName = Strings.activityEN;
        medicalName = Strings.medicalEN;
        homeName = Strings.homeEN;
        travelName = Strings.travelEN;
        peopleName = Strings.peopleEN;
        educationName = Strings.educationEN;
        salaryName = Strings.salaryEN;
        giftName = Strings.giftEN;
        businessName = Strings.businessEN;
        insuranceName = Strings.insuranceEN;
        realEstateName = Strings.realEstateEN;
        investmentName = Strings.investmentEN;
        refundName = Strings.refundEN;
        break;
    }

    return [
      Category(
        id: foodName.toLowerCase(),
        name: foodName,
        iconData: MdiIcons.silverware,
        color: Color(0xffff8533),
        type: TransacType.expense,
      ),
      Category(
        id: transportationName.toLowerCase(),
        name: transportationName,
        iconData: MdiIcons.car,
        color: Colors.yellow,
        type: TransacType.expense,
      ),
      Category(
        id: shoppingName.toLowerCase(),
        name: shoppingName,
        iconData: MdiIcons.cart,
        color: Color(0xffac3973),
        type: TransacType.expense,
      ),
      Category(
        id: entertainmentName.toLowerCase(),
        name: entertainmentName,
        iconData: MdiIcons.movie,
        color: Color(0xff66ccff),
        type: TransacType.expense,
      ),
      Category(
        id: activityName.toLowerCase(),
        name: activityName,
        iconData: MdiIcons.emoticonOutline,
        color: Color(0xffff66cc),
        type: TransacType.expense,
      ),
      Category(
        id: medicalName.toLowerCase(),
        name: medicalName,
        iconData: MdiIcons.medicalBag,
        color: Color(0xffff3333),
        type: TransacType.expense,
      ),
      Category(
        id: homeName.toLowerCase(),
        name: homeName,
        iconData: MdiIcons.home,
        color: Color(0xffcc9966),
        type: TransacType.expense,
      ),
      Category(
        id: travelName.toLowerCase(),
        name: travelName,
        iconData: MdiIcons.airplane,
        color: Color(0xffcc6600),
        type: TransacType.expense,
      ),
      Category(
        id: peopleName.toLowerCase(),
        name: peopleName,
        iconData: MdiIcons.accountMultiple,
        color: Color(0xff3377ff),
        type: TransacType.expense,
      ),
      Category(
        id: educationName.toLowerCase(),
        name: educationName,
        iconData: MdiIcons.school,
        color: Color(0xff9933ff),
        type: TransacType.expense,
      ),
      Category(
        id: salaryName.toLowerCase(),
        name: salaryName,
        iconData: MdiIcons.currencyUsd,
        color: Colors.green,
        type: TransacType.income,
      ),
      Category(
        id: giftName.toLowerCase(),
        name: giftName,
        iconData: MdiIcons.walletGiftcard,
        color: Color(0xffb84dff),
        type: TransacType.income,
      ),
      Category(
        id: businessName.toLowerCase(),
        name: businessName,
        iconData: MdiIcons.briefcase,
        color: Color(0xff1a8cff),
        type: TransacType.income,
      ),
      Category(
        id: insuranceName.toLowerCase(),
        name: insuranceName,
        iconData: MdiIcons.bank,
        color: Color(0xff6666ff),
        type: TransacType.income,
      ),
      Category(
        id: realEstateName.toLowerCase(),
        name: realEstateName,
        iconData: MdiIcons.homeGroup,
        color: Color(0xffccccff),
        type: TransacType.income,
      ),
      Category(
        id: investmentName.toLowerCase(),
        name: investmentName,
        iconData: MdiIcons.trendingUp,
        color: Color(0xff00e673),
        type: TransacType.income,
      ),
      Category(
        id: refundName.toLowerCase(),
        name: refundName,
        iconData: MdiIcons.swapVerticalBold,
        color: Color(0xff66ffff),
        type: TransacType.income,
      ),
    ];
  }
}
