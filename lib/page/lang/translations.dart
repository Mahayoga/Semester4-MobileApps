import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'id_ID': {
      'setting': 'Pengaturan',
      'content': 'Konten',
      'history': 'Riwayat',
      'notification': 'Notifikasi',
      'preferences': 'Preferensi',
      'language': 'Bahasa',
      'logout': 'Keluar',
    },
    'en_US': {
      'setting': 'Setting',
      'content': 'Content',
      'history': 'History',
      'notification': 'Notification',
      'preferences': 'Preferences',
      'language': 'Language',
      'logout': 'Log Out',
    },
    'es_ES': {
      'setting': 'Configuración',
      'content': 'Contenido',
      'history': 'Historial',
      'notification': 'Notificación',
      'preferences': 'Preferencias',
      'language': 'Idioma',
      'logout': 'Cerrar sesión',
    },
  };
}