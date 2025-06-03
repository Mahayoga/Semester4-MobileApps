import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'id_ID': {
      'hello': 'Halo',
      'setting': 'Pengaturan',
      'content': 'Konten',
      'history': 'Riwayat',
      'notification': 'Notifikasi',
      'preferences': 'Preferensi',
      'language': 'Bahasa',
      'logout': 'Keluar',
      'nearby clinics': 'Klinik Terdekat'
    },
    'en_US': {
      'hello': 'Hello',
      'setting': 'Setting',
      'content': 'Content',
      'history': 'History',
      'notification': 'Notification',
      'preferences': 'Preferences',
      'language': 'Language',
      'logout': 'Log Out',
      'nearby clinics': 'Nearby Clinics'
    },
    'es_ES': {
      'hello': 'Hola',
      'setting': 'Configuración',
      'content': 'Contenido',
      'history': 'Historial',
      'notification': 'Notificación',
      'preferences': 'Preferencias',
      'language': 'Idioma',
      'logout': 'Cerrar sesión',
      'nearby clinics': 'Clínica Más Cercana'
    },
  };
}