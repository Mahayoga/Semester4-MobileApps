import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'setting': 'Setting',
      'history': 'History',
      'notification': 'Notification',
      'language': 'Language',
      'logout': 'Log Out',
    },
    'id': {
      'setting': 'Pengaturan',
      'history': 'Riwayat',
      'notification': 'Notifikasi',
      'language': 'Bahasa',
      'logout': 'Keluar',
    },
    'es': {
      'setting': 'Configuración',
      'history': 'Historial',
      'notification': 'Notificación',
      'language': 'Idioma',
      'logout': 'Cerrar sesión',
    },
  };
}
