#!/bin/bash
## 以下の場合に実行する
## - freezed のコード自動生成を使いたい場合
## - テスト用のMockクラスを作成したい場合

fvm flutter pub run build_runner build --delete-conflicting-outputs
