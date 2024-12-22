# holo_card_effect

ホログラムカードのような光沢効果を実装するFlutterパッケージです。

## 概要

このパッケージは、トレーディングカードやメンバーシップカードなどのUIに、美しいホログラム効果を簡単に実装できるようにします。デバイスの傾きに応じて変化する光沢効果により、リアルなホログラムカードの見た目を実現します。

## 特徴

- 傾きに応じて変化するホログラム効果
- カスタマイズ可能な光沢エフェクト
- シンプルな実装で美しい視覚効果を実現
- パフォーマンスを考慮した設計

## インストール

`pubspec.yaml`に以下を追加してください：

```yaml
dependencies:
    holo_card_effect: ^0.0.1
```

## 使い方

基本的な使用例：

```dart
import 'package:holo_card_effect/holo_card_effect.dart';

HoloCard(
    imageUrl: 'assets/card_image.png',
    width: 300,
    height: 420,
)
```

カスタマイズ例：

```dart
HoloCard(
    imageUrl: 'assets/card_image.png',
    width: 300,
    height: 420,
    showGlitter: true,
    showHolo: true,
    showRainbow: true,
    showShadow: true,
    showGloss: true,
)
```

## プロパティ

| プロパティ | 型 | デフォルト値 | 説明 |
|------------|------|---------|------|
| imageUrl | String | 必須 | カード画像のパス |
| width | double | 300 | カードの幅 |
| height | double | 420 | カードの高さ |
| showGlitter | bool | true | キラキラエフェクトの表示 |
| showHolo | bool | true | ホログラムエフェクトの表示 |
| showRainbow | bool | true | 虹色エフェクトの表示 |
| showShadow | bool | true | 影の表示 |
| showGloss | bool | true | 光沢エフェクトの表示 |

## 使用例

トレーディングカード、会員証、チケットなど、様々なカード型UIに適用可能です：

- コレクションカード
- デジタルチケット
- メンバーシップカード
- ギフトカード
など

## デモ

[デモ動画やGIFを追加予定]

## 貢献

バグ報告や機能リクエストは[GitHubのIssues](https://github.com/oh-yeah-sea-kit2/holo_card_effect/issues)にお願いします。
