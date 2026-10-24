import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString('assets/fonts/notosans-OFL.txt');
    yield LicenseEntryWithLineBreaks(['Noto Sans'], text);
  });
}
