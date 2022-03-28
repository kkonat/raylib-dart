import 'package:raylib/raylib.dart';

void main() {
  var raylibPath = '.\\raylib.dll';

  initLibrary(windows: raylibPath);

  const screenWidth = 1280 ~/ 2;
  const screenHeight = 720 ~/ 2;
  const minFontSize = 20;
  const maxFontSize = 25;

  initWindow(screenWidth, screenHeight, 'Hello Raylib!');
  setTargetFPS(60);

  const text = 'Welcome to Raylib-Dart!';
  // Some allocation and casting to convert dart string into native c-string.
  // final utf8Text = text.toNativeUtf8();
  // final int8Text = utf8Text.cast<Int8>();

  var fontSize = minFontSize;
  var reverse = false;
  var time = 0.0;

  final camera = Camera2D();
  //var offset = Vector2(screenWidth / 2, screenHeight / 2);
  //var target = Vector2(0, 0);
  Camera2D();

  while (!windowShouldClose()) {
    if (fontSize > maxFontSize) {
      reverse = true;
    } else if (fontSize < minFontSize) {
      reverse = false;
    }

    time += getFrameTime();
    if (time > 0.06) {
      fontSize += reverse ? -1 : 1;
      time -= 0.06;
    }

    if (isKeyDown(KeyboardKey.up)) {
      camera.zoom += 0.1;
    } else if (isKeyDown(KeyboardKey.down)) {
      camera.zoom -= 0.1;
    }

    camera.zoom = camera.zoom.clamp(0.5, 2.5);

    beginDrawing();
    clearBackground(Color.black);

    drawFPS(32, 32);

    beginMode2D(camera);

    drawText(
      text,
      (screenWidth - measureText(text, fontSize)) ~/ 2,
      screenHeight ~/ 2,
      fontSize,
      Color.yellow,
    );

    endMode2D();

    endDrawing();
  }

  closeWindow();
}
