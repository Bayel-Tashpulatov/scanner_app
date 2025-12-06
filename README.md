Scanner App

Простое Flutter-приложение для сканирования QR/штрих-кодов с помощью mobile_scanner.

Функции

Сканирование QR/Barcode через камеру.

Переключение камеры.

Фонарик.

Показ результата.

Копирование результата.

Открытие результата через Google Search.

Установка
git clone <repo>
cd scanner_app
flutter pub get
flutter run

Зависимости (pubspec.yaml)
mobile_scanner: ^3.0.0
url_launcher: ^6.1.10

Разрешения
Android — AndroidManifest.xml
<uses-permission android:name="android.permission.CAMERA" />

iOS — Info.plist
<key>NSCameraUsageDescription</key>
<string>Camera access required for scanning</string>

Структура проекта
lib/
 ├─ main.dart
 ├─ home_screen.dart
 └─ qr_scanner_screen.dart

Основная логика

Сканирование:

MobileScanner(
  controller: controller,
  onDetect: (capture) {
    final code = capture.barcodes.first.rawValue;
    setState(() => qrResult = code ?? "");
  },
);


Открытие результата:

launchUrl(Uri.parse("https://www.google.com/search?q=$qrResult"));

Лицензия

MIT.