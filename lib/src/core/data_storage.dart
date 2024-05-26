import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dataStorageProvider = Provider<DataStorage>((ref) {
  return DataStorage();
});

class DataStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);
  late FlutterSecureStorage storage;

  DataStorage() {
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  // Read value

  Future<String?> read(String key) async => await storage.read(key: key);

// Read all values
  Future<Map<String, String>> allValues() async => await storage.readAll();

  // Delete value
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  // Delete all
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  // Write value
  Future<void> write(String key, String? value) async {
    await storage.write(key: key, value: value);
  }
}
