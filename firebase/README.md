# Virtual Pilgrimage - firebase

Virtual Pilgrimage の firebase 関連の実装・設定

## Requirements

- [nodejs](https://nodejs.org/ja/download/)
- [firebase cli](https://firebase.google.com/docs/cli?hl=ja)
- [flutterfire](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins)

HomeBrew を使うと以下のようにインストールできる

```shell
$ brew install node
$ npm install -g firebase-tools  # https://formulae.brew.sh/formula/firebase-cli
# 以下は flutterfire を利用する場合のみ導入
$ brew install fvm
$ fvm install 3.0.5
$ fvm use 3.0.5
$ dart pub global activate flutterfire_cli
# .zshrc など利用しているシェルの設定に以下を追加
# export PATH="$PATH":"$HOME/.pub-cache/bin"
```

## Setup

以下のように CLI のセットアップをしていく。

```shell
$ firebase login # ブラウザから firebase を利用する Google アカウントでログインする
$ npm install
```

## 開発の方針について

### 機能追加をしたい場合

- `firestore.rules` または `storage.rules` にルールを記述
- `tests/**.test.ts` にルールのテストをできるだけ網羅的に書く
- PR を出す

__TODO: github actions で CI/CD を構築して機能追加の Firebase の反映を自動化する__

### ユーザ側がデータを追加しないケースについて

お寺の画像についてはユーザ側がデータを追加するユースケースはない。

このユースケースの場合、このディレクトリの中で必要なデータとデータをアップロードするスクリプトを開発する
