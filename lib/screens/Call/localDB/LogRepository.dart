
import 'package:dating_app/screens/Call/models/LogModel.dart';

import 'SqliteMethods.dart';

class LogRepository {
  static late var dbObject;

  static init({required String dbName}) {
    dbObject = SqliteMethods();
    dbObject.openDb(dbName);
    dbObject.init();
  }

  static addLogs(LogModel log) => dbObject.addLogs(log);

  static deleteLogs(int? logId) => dbObject.deleteLogs(logId);

  static deleteAllLogs() => dbObject.deleteAllLogs();

  static getLogs() => dbObject.getLogs();

  static close() => dbObject.close();
}
