String buildExportFileName(String originalName, DateTime exportedAt) {
  final name = originalName.split(RegExp(r'[/\\]')).last;
  final extension = name.lastIndexOf('.');
  final stem = extension > 0 ? name.substring(0, extension) : name;
  final safeStem = stem
      .replaceAll(RegExp(r'[<>:"/\\|?*\x00-\x1F]'), '_')
      .trim();
  final prefix = safeStem.isEmpty ? 'image' : safeStem;
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  final date = '${exportedAt.year.toString().padLeft(4, '0')}-'
      '${twoDigits(exportedAt.month)}-${twoDigits(exportedAt.day)}';
  final time = '${twoDigits(exportedAt.hour)}-'
      '${twoDigits(exportedAt.minute)}-${twoDigits(exportedAt.second)}';
  return '${prefix}_${date}_$time.png';
}
