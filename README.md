![](https://i.gyazo.com/ed15b11f4198c80525af1992ad74d8c0.png)

# アプリ名
## STORE_MANUAL 

# 概要

**STORE MANUAL(ストアマニュアル)** は、飲食のoffjt用に作成した動画アップローダーwebアプリケーションです。
#### 出来る事
- 簡単に動画がアップできる
- いつでもスマホからマニュアルを閲覧できる
- 聞きたいことをコメントで質問できる
質問に関しては質問者の名前などが表示されないので気軽に質問することができます。

# 本番環境

# 制作背景

飲食業は人の入れ替わりが多い業種です。その度に同じ事をoffjtで教え、何度もojtを行います。
少しでも新しいスタッフの成長スピードの向上と、指導業務の効率化を早める為には動画のマニュアルが必要でした。
ですが、動画マニュアルの作成には課題があります。
それは店舗によって厨房やホールのレイアウトが違ったり、扱っている食材が違うなど、全て同じマニュアル通りにはいかないという課題です。
そこで店舗ごとに管理する事ができてスタッフがスマートフォンからでも簡単に閲覧できる。そして簡単に動画をアップロードできるアプリを作りたいという事が開発のきっかけでした。

# 工夫したポイント
- 分かりやすさ
- ログインしても名前などは表示されないので新人スタッフでも気軽に閲覧できる
- 動画が増えても見たいマニュアルを検索できるようにタグ検索機能の実装
- 動画の量が増えても大丈夫なようにpagination機能の実装

# 使用技術(開発環境)
### バックエンド
##### Ruby, Ruby on Rails, 

### フロントエンド
##### HTML, CSS, JavaScript

### データベース
##### MySQL, SequelPro

### インフラ
##### AWS(EC2)

### ソース管理
##### GitHub, GitHubDesktop

### エディタ
##### VScode

# 課題や今後実装したい機能

- 少しビューが崩れてしまっている箇所を整えたい
- マイページを作成し、自分の閲覧した動画がリストになり閲覧数に応じてバッジが貰えるような機能を実装した
- 再生速度をあげる機能を取り入れたい

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|------|
|movie_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :movie

## moviesテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|------|
|content|text|------|
### Association
- belongs_to :user, optional: true
- has_many :comments, foreign_key: :movie_id, dependent: :destroy
- has_many :tagmaps, dependent: :destroy
- has_many :tags, through: :tagmaps
  accepts_nested_attributes_for :tags

## active_storage_blobsテーブル
|Column|Type|Options|
|------|----|-------|
|key|string|null: false|
|filename|string|null: false|
|content_type|string|-------|
|metadata|text|-----|
|byte_size|bigint|null: false|
|checksum|string|null: false|

## active_storage_attachments
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|record_id|integer|null: false, polymorphic: true, index: false|
|blob_id|integer|null: false|

## users
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, default: ""|
|encrypted_password|string|null: false, default: ""|
|reset_password_token|string|-----|
|reset_password_sent_at|datetime|-----|
|Name|string|-------|

### Association
- has_many :movies

## tags
|Column|Type|Options|
|------|----|-------|
|tag_name|string|null: false|
### Association
- has_many :tagmaps, dependent: :destroy
- has_many :movies, through: :tagmaps

## tagmaps
|Column|Type|Options|
|------|----|-------|
|movie|integer|null: false, foreign_key: true|
|tag|integer|null: false, foreign_key: true|
### Association
- belongs_to :movie
- belongs_tp :tag

![store](https://user-images.githubusercontent.com/63494238/105035865-07144180-5a9f-11eb-93ed-349c0c76b44c.png)
