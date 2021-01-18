![](https://i.gyazo.com/ed15b11f4198c80525af1992ad74d8c0.png)

# アプリ名
## STORE_MANUAL 

# 概要

** STORE MANUAL(ストアマニュアル)**は、飲食のoffjt用に作成した動画アップローダーwebアプリケーションです。
- 簡単に動画がアップできる
- いつでもスマホからマニュアルを閲覧できる
- 聞きたいことをコメントで質問できる
質問に関しては質問者の名前などが表示されないので気軽に質問することができます。
利用する店長はコメントに関するフィードバックを行ってください。

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
- belongs_to :user
- has_many :comments

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
