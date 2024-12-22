import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:holo_card_effect/holo_card_effect.dart';

void main() {
  testWidgets('HoloCard - 基本的なレンダリングテスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: HoloCard(
              imageUrl: 'test/assets/test_image.png',
              showGlitter: false,
              showHolo: false,
              showRainbow: false,
              showGloss: false,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(HoloCard), findsOneWidget);

    // メインの画像のみを検証
    final mainImageFinder = find.descendant(
      of: find.byType(HoloCard),
      matching: find.byType(Image),
    );
    expect(mainImageFinder, findsOneWidget);
  });

  testWidgets('HoloCard - エフェクトの表示/非表示テスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: HoloCard(
              imageUrl: 'test/assets/test_image.png',
              showGlitter: false,
              showHolo: false,
              showRainbow: false,
              showShadow: false,
              showGloss: false,
            ),
          ),
        ),
      ),
    );

    final holoCardFinder = find.byType(HoloCard);
    final holoCard = tester.widget<HoloCard>(holoCardFinder);

    expect(holoCard.showGlitter, false);
    expect(holoCard.showHolo, false);
    expect(holoCard.showRainbow, false);
    expect(holoCard.showShadow, false);
    expect(holoCard.showGloss, false);
  });

  testWidgets('HoloCard - サイズ指定テスト', (WidgetTester tester) async {
    const double testWidth = 200.0;
    const double testHeight = 300.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: HoloCard(
              imageUrl: 'test/assets/test_image.png',
              width: testWidth,
              height: testHeight,
            ),
          ),
        ),
      ),
    );

    final container =
        find.byType(Container).evaluate().first.widget as Container;
    expect(container.constraints?.maxWidth, testWidth);
    expect(container.constraints?.maxHeight, testHeight);
  });

  test('HoloCard - isNetworkImage メソッドのテスト', () {
    const holoCard = HoloCard(imageUrl: 'https://example.com/image.jpg');
    expect(holoCard.isNetworkImage, true);

    const localHoloCard = HoloCard(imageUrl: 'test/assets/test_image.png');
    expect(localHoloCard.isNetworkImage, false);

    const dataUrlHoloCard = HoloCard(imageUrl: 'data:image/png;base64,xyz');
    expect(dataUrlHoloCard.isNetworkImage, true);
  });

  testWidgets('HoloCard - ジェスチャー処理テスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              height: 420,
              child: HoloCard(
                imageUrl: 'test/assets/test_image.png',
              ),
            ),
          ),
        ),
      ),
    );

    // ジェスチャーの開始位置を中心に設定
    final center = tester.getCenter(find.byType(HoloCard));

    // ジェスチャーをシミュレート
    final gesture = await tester.createGesture();
    await gesture.down(center); // ジェスチャーの開始を明示的に設定
    await gesture.moveTo(center + const Offset(100, 100));
    await tester.pump();

    // HoloCardウィジェット内のTransformを検証
    final transformFinder = find.descendant(
      of: find.byType(HoloCard),
      matching: find.byType(Transform),
    );
    expect(transformFinder, findsWidgets); // 1つ以上のTransformが存在することを確認

    await gesture.up();
    await tester.pumpAndSettle(); // アニメーションが完了するまで待機
  });
}
