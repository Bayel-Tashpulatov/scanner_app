<img width="200" height="600" alt="Снимок экрана 2025-12-06 134740" src="https://github.com/user-attachments/assets/7eb6cee4-29c2-43ed-9562-7470580637af" />
<img width="200" height="600" alt="Снимок экрана 2025-12-06 134728" src="https://github.com/user-attachments/assets/a0c9cd25-25b0-43af-ad32-6f1646a283b2" />
<img width="200" height="600" alt="Снимок экрана 2025-12-06 134716" src="https://github.com/user-attachments/assets/997e7e8c-ab33-4102-8c11-e9a6cee9cc27" />

# Scanner App

Простое Flutter-приложение для сканирования QR/штрих-кодов с помощью `mobile_scanner`.

---

## Функции

* Сканирование QR/Barcode через камеру.
* Переключение камеры.
* Фонарик.
* Показ результата.
* Копирование результата.
* Открытие результата через Google Search.

---

## Установка

```bash
git clone <repo>
cd scanner_app
flutter pub get
flutter run
```

---

## Зависимости (pubspec.yaml)

```yaml
mobile_scanner: ^3.0.0
url_launcher: ^6.1.10
```

---

## Разрешения

### Android — `AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

### iOS — `Info.plist`

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access required for scanning</string>
```

---

## Структура проекта

```
lib/
 ├─ main.dart
 ├─ home_screen.dart
 └─ qr_scanner_screen.dart
```

---

## Основная логика

Сканирование:

```dart
MobileScanner(
  controller: controller,
  onDetect: (capture) {
    final code = capture.barcodes.first.rawValue;
    setState(() => qrResult = code ?? "");
  },
);
```

Открытие результата:

```dart
launchUrl(Uri.parse("https://www.google.com/search?q=$qrResult"));
```

---

## Roadmap

* История сканирований
* Распознавание типов данных (URL, Wi-Fi, текст)
* Сканирование изображений из галереи

---

## Лицензия

MIT.



