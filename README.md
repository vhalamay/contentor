# Contentor

A Flutter application for creating social media content on Android and Windows.

The editor divides its available area equally between preview and settings. Portrait windows show the preview above the settings; landscape windows show it on the left. Only the settings panel scrolls. The preview fits within its half without stretching, and dialogue state is retained when resizing or rotating.

Choose a PNG, JPG, JPEG, or WebP image to preview it in a white Polaroid frame. The canvas is 1080 px wide, with a centered crop inside a 1020 × 1020 px illustration area. White borders measure 30 px on the left and right and 40 px above. The Caption input is optional: an empty or whitespace-only caption gives a 40 px bottom border and a 1080 × 1100 px canvas. A nonempty caption wraps naturally, is left-aligned, and has 40 px padding above and below; the canvas height grows to fit. Original image bytes are held in memory for the current session. Choosing another image replaces the preview; cancellation or a loading error preserves the previous image.

Choose a blur button: **No blur**, **Blur 25**, **Blur 50**, **Blur 75**, or **Blur 100**. No blur restores the original image. The preview updates immediately; the original bytes remain unchanged.

Caption has three font-size buttons: 60, 72 (default), and 84. Left (default) and center alignment buttons apply to both preview and PNG export. The footer height follows text wrapping, with 40 px padding above and below the caption.

Use **Add Dialogue** to create independent text overlays. Select a dialogue from its chip (or tap its text when no dialogue is being edited), edit the text, and tap an image grid cell to position its center. **Done editing** hides the guides; the chip's delete button removes that dialogue. Dialogue overlays remain when replacing an image.

The fixed `@beaverly.hills.ua` watermark is added automatically in the first grid cell. It uses smaller, translucent white text with a subtle shadow and no dialogue panel. Select its chip to change its position using the same grid. Its text cannot be edited or deleted, and it stays fully inside the illustration at edge positions. Its appearance and position are shared by preview and PNG export; styling is configured in `lib/dialogue/watermark_appearance.dart`.

The positioning grid is controlled only by `gridSize` in `lib/dialogue/grid_settings.dart`. Both rows and columns use this value. Cell centers are normalized as `(column + 0.5) / gridSize` and `(row + 0.5) / gridSize`. Text wraps at a maximum of 80% of the entire illustration width, spans neighboring cells, and is clipped only at the illustration boundary. The Polaroid crop preserves the photo's proportions without distortion.

All dialogues use the same white rounded panel and centered black Noto Sans text, size 48, semibold, without shadow. The panel follows the text's size and can span multiple grid cells. Appearance is configured only in `lib/dialogue/dialogue_appearance.dart`; there are no per-dialogue style controls or settings. Noto Sans is bundled for offline Ukrainian text, with its OFL license, from the [Google Fonts repository](https://github.com/google/fonts). Preview and export share the same text renderer in the same 1080 px-wide canvas coordinate system. Grid lines, cell highlights, and editing controls are never exported.

**Export PNG** saves the same Polaroid composition at 1080 px wide and the caption-dependent height with the current blur settings. Blur affects only the illustration; the white frame stays sharp. Interface elements are excluded. The suggested filename starts with the original image name and includes the export date and time. Windows opens a Save File dialog; Android opens its system document creation dialog, allowing you to choose an accessible destination without additional storage permissions. Cancelling export leaves the image unchanged.

To limit memory use, images over 25 megapixels or 8192 pixels on either side are rejected with a message rather than resized. PNG encoding and saving show a busy state; failures leave the selected image available for another attempt.

## Run

```sh
flutter pub get
flutter run
```

On Windows, enable **Developer Mode** in Windows Settings so Flutter can create plugin symlinks. Restart the application after adding native plugins; hot reload alone is insufficient.


