import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:postgres/postgres.dart';

class DbConnection {
  static Connection? _connection;
  static String? lastError;

  static Future<Connection> getConnection() async {
    if (_connection != null && _connection!.isOpen) {
      return _connection!;
    }

    final host = dotenv.env['DB_HOST']!;
    final port = int.parse(dotenv.env['DB_PORT'] ?? '5432');
    final database = dotenv.env['DB_NAME']!;
    final username = dotenv.env['DB_USER']!;
    final password = dotenv.env['DB_PASSWORD']!;

    _connection = await Connection.open(
      Endpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
      ),
      settings: const ConnectionSettings(
        sslMode: SslMode.require,
        connectTimeout: Duration(seconds: 30),
      ),
    );

    return _connection!;
  }

  static Future<bool> testConnection() async {
    try {
      final conn = await getConnection();
      await conn.execute('SELECT 1;');
      lastError = null;
      return true;
    } catch (e) {
      lastError = e.toString();
      return false;
    }
  }

  static Future<void> close() async {
    if (_connection != null && _connection!.isOpen) {
      await _connection!.close();
      _connection = null;
    }
  }
}