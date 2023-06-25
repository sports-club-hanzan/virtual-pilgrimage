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
$ fvm install 3.10.0
$ fvm use 3.10.0
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

- 必要に応じて `schema.yaml` に追加を想定しているデータ構造を追記する
- `firestore.rules` または `storage.rules` にルールを記述
- `tests/**.test.ts` にルールのテストをできるだけ網羅的に書く
- `npm test` でテストがパスするようにする
- PR を出す

__TODO: github actions で CI/CD を構築して機能追加の Firebase の反映を自動化する__

### デプロイ

```shell
# 開発環境であれば `default`, 本番環境であれば `production` を引数に与える
firebase use (default|production)
firebase deploy
```

### ユーザ側がデータを追加しないケースについて

お寺の画像についてはユーザ側がデータを追加するユースケースはない。

このユースケースの場合、このディレクトリの中で必要なデータとデータをアップロードするスクリプトを開発する

### CloudStoreの更新について

CloudStoreに画像をアップロードする場合、下記のコマンドを実行する

#### gsutil のセットアップ

初回のみ実行する

```shell
brew install --cask google-cloud-sdk
# 以下を.zshrcなどに追加。brewの実行時に inc ファイルのパスが出力されるので適宜置き換える
# m2macだと以下のようなパスだった
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/opt/homebrew/share/zsh/site-functions/_google-cloud-sdk'

source ~/.zshrc
# 共用のgoogleアカウントでログイン
gcloud config create <設定の名称>
gcloud auth login
```

#### アップロードの実行

```shell
# 画像をアップロードしたいCloudStorageがあるプロジェクトを探す
gcloud projects list
PROJECT_ID              NAME                    PROJECT_NUMBER
modular-rex-362205      My First Project        ***
...
# プロジェクトをセット
# 新しいプロジェクトに向けた設定を作成したい場合、gcloud config create から実施し直して新しいプロジェクトをセットする
gcloud config set project <プロジェクト名>
# 状況に応じて下記のようなコマンドを使う
## 設定一覧の確認
## gcloud config configurations list
## 設定の切り替え
## gcloud config configurations activate <設定名>
PROJECT_NAME=<プロジェクト名> npm run upload_temple_images
```

### temples/temple_info.csvの経路情報の更新について

お寺の経路情報（エンコードされた経路情報）を更新する場合は下記のコマンドを実行する

```shell
cd ./firebase
# API_KEY は Direction API の権限を持ったKey
API_KEY="AIzaSyAyPFAJTNbCbvIqyv....." npm run csv_append_temple_points
```
