# sample_google_maps_flutter

2つのパッケージを比較するためのプロジェクトです。\
ここでは「google_maps_flutter」パッケージのサンプルアプリを公開します。\
[公式Documentを参照したい方はこちら](https://pub.dev/documentation/google_maps_flutter/latest/)

## 前提条件
- API-KEYの設定が行われていること
- ポップアップ表示された位置情報の許可を行うこと

----
## API-KEY設定
1. project配下に「map_api_key.env」という名前でファイルを生成してください。
2. 生成したファイルに`MAP_API_KEY=使用するAPI-KEY`の形式で記載してください。
![API-KEY1](https://user-images.githubusercontent.com/102897585/183320130-b25ca973-9387-4c51-8476-ef6ee64912e9.png)
3. 次にsample_google_maps_flutter/android/app/src/main/res/values/の配下に「keys.xml」という名前でファイルを生成してください。
4. 下記の<string...string>の間に使用するAPI-KEYを記載してください。
```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="google_maps_key" translatable="false"    templateMergeStrategy="preserve">
        
    </string>
</resources>
```
![API-KEY2](https://user-images.githubusercontent.com/102897585/183526980-07bafee2-b991-4366-aa72-8788f9934e3c.png)

5. 読み込みが正しく行われている場合、Blackベースの地図が表示されます。


※iOSの読み込みが不具合の場合、[こちらの記事](https://www.rect-angle.com/tech/flutter/flutter-env/)を参照しビルドスクリプトが正しく動作しているかを確認してください。

※Androidの読み込みが不具合の場合、[こちらの記事](https://medium.com/@ykaito21/flutter-from-zero-to-one-how-to-ignore-google-map-api-key-from-source-control-18e119ff5a47)を参照し、keys.xmlが生成されているか確認してください。

その他の不具合は、原因が別にある可能性が高いです。

----
## 比較基準
- 現在地を表示できるか
- 現在地の表示アイコンを変更できるか
- 現在向いている方角を表示できるか
- 任意の場所にピンを立てることができるか
- ピンのアイコンは変更可能か
- ピンの大きさは変更可能か
- 地図そのものの見た目を柔軟に変更できるか
    - 夜の雰囲気を出せる色合いに変更可能か
    - 地形などの表示内容をデフォルメ可能か
    - 地形情報などをできるだけ削ぎ落とした白地図のような形にできるか
- 料金がどのくらいかかるか
- ピンを立てることや地図利用そのものに料金は発生するか
- パッケージのAPIは使いやすいか

## 現在地を表示できるか
iOS実機でビルド行い、端末内で位置情報の許可を行うと現在地に青色のマーカーが配置されます。

----
## 現在地の表示アイコンを変更できるか
現在地マーカーの上に自作のマーカーを重ねることで、表示アイコンが変化したように見せることは可能です。
現在位置が移動した場合に、マーカーも移動し描画を行うため、重い処理になると思います。

----
## 現在向いている方角を表示できるか
iOS実機でビルドを行うと、向いている方角を取得し、追尾してくれます。

※シュミレーター上では向いている方角が表示されませんでした。

----
## 任意の場所にピンを立てることができるか
地図上をタップすることで任意の場所にピンを配置することが可能です。
マーカー作成にはCanvasを使用しています。

----
## ピンのアイコンは変更可能か
ピンアイコンは変更可能です。
CanvasとAssetの２種類で生成が確認できています。

----
## ピンの大きさは変更可能か
ピン生成方法によって大きさの変更は異なりますが、可能です。

----
## 地図そのものの見た目を柔軟に変更できるか
Map StyleはGoogle Maps Platform内で柔軟に生成可能です。\
・Roads\
・Landmarks\
・Labels\
・Select theme\
などの要素から選択が可能です。

----
## 料金がどのくらいかかるか
GoogleMapsPlatformは 1 か月 200 ドル分まで無料で利用できます。\
地図の読み込みは 1 か月あたり 28,500 回まで無料です。\
GoogleMapsPlatformは従量課金制を採用しており、
その範囲を超える場合は使用した分だけ料金が発生します。\
インスタンス化されるたびに、地図の読み込みが 1 回発生します。

----
## ピンを立てることや地図利用そのものに料金は発生するか
ピンを立てることには発生しません。\
地図料金はGoogleMapsPlatformの利用で料金が発生します。\
地図そのものは背景としてアプリ内に配置し、ピンはその上に重ねる構造になっています。

----
## パッケージのAPIは使いやすいか
Google maps platform内に備わっている機能が多くあり、そのほとんどの機能をDartで使えるため使いやすいです。
https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/google_maps_flutter-library.html
