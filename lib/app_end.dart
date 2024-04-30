// English Translations

class Localization {
  static String getString(String key, {required String locale}) {
    switch (locale) {
      case 'id':
        return _getStringId(key);
      default:
        return _getStringEn(key);
    }
  }

  static String _getStringEn(String key) {
    switch (key) {
      case 'app_title':
        return 'My App';
      case 'welcome_message':
        return 'Welcome to My App!';
      case 'button_login':
        return 'Login';
      case 'button_signup':
        return 'Sign Up';
      case 'error_username_required':
        return 'Username is required';
      case 'error_password_required':
        return 'Password is required';
      case 'success_login':
        return 'Login successful';
      case 'success_signup':
        return 'Sign Up successful';
      case 'settings':
        return 'Settings';
      case 'language':
        return 'Language';
      default:
        return '';
    }
  }

  static String _getStringId(String key) {
    switch (key) {
      case 'app_title':
        return 'Aplikasi Saya';
      case 'welcome_message':
        return 'Selamat datang di Aplikasi Saya!';
      case 'button_login':
        return 'Masuk';
      case 'button_signup':
        return 'Daftar';
      case 'error_username_required':
        return 'Nama pengguna harus diisi';
      case 'error_password_required':
        return 'Kata sandi harus diisi';
      case 'success_login':
        return 'Berhasil masuk';
      case 'success_signup':
        return 'Berhasil mendaftar';
      case 'settings':
        return 'Pengaturan';
      case 'language':
        return 'Bahasa';
      default:
        return '';
    }
  }
}
