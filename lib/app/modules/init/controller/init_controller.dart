import 'package:app_pemenangan_caleg/app/data/db/shared_preferences/user_session.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class InitController extends GetxController {
  late final GetStorage _box;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _box = GetStorage();
  }

  String getToken() {
    return _box.read('token') as String;
  }

  Future<UserSession?> getSession() async {
    final id = _box.read('id') as int?;
    final token = _box.read('token') as String?;
    final role = _box.read('role') as String?;
    final provincesId = _box.read('provincesId') as int?;
    final regenciesId = _box.read('regenciesId') as int?;
    final districtsId = _box.read('districtsId') as int?;

    if (id != null && token != null && role != null) {
      return UserSession(
        id: id,
        token: token,
        role: role,
        provincesId: provincesId ?? 0,
        regenciesId: regenciesId ?? 0,
        districtsId: districtsId ?? 0,
      );
    }

    return null;
  }

  Future<void> setSession(UserSession session) async {
    await _box.write('id', session.id);
    await _box.write('token', session.token);
    await _box.write('role', session.role);
    await _box.write('provincesId', session.provincesId);
    await _box.write('regenciesId', session.regenciesId);
    await _box.write('districtsId', session.districtsId);
  }

  Future<void> deleteSession() async => await _box.erase();
}
