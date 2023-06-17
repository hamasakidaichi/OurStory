# OurStory
思い出を共有するアプリ
アーキテクチャ
onion architecture

application
  config//設定値 機種　ver
  state//provider notifire
  types//fleverなど
  usecases
domain
  features//
  types
infrastructure//インフラ
  firebase
  log//デバッグなど
presentation//アプリの見た目
  pages//ページ
  router//画面遷移 go-router MaterialAapp
  theme//設定値
  widgets//パーツ

命名規則

UppeCamelCase
クラス
列挙型
typedef
型パラメータ

lowerCamelCase
変数
関数
プロパティ　
メソッド

snake_case
ファイル
ディレクトリ
パッケージ
ライブラリ