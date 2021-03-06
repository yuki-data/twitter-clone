# twitter clone
ツイッターのクローンアプリです。
Herokuでデプロイ中です。
Basic認証をかけていますので、ご覧になりたい場合には、[twitterアカウント](https://twitter.com/__yuki_ito__)までご一報ください。

![twitter clone](https://gyazo.com/728f9d12bb14d7fcf9f5294a5219b200.png)

## 機能
以下の機能があります。
- ログイン機能: ログインすることで投稿、フォロー、ブックマークを使えます
- メッセージや画像を投稿する
- 他の人をフォローする
- 投稿をブックマークする（いいね機能）
- フォローやフォロワー一覧、ブックマーク一覧をマイページで確認
- ブックマーク、フォローは非同期通信で実行するのでページ再読み込みはありません
- プロフィール画像の設定と変更

## 使い方
初めにユーザー登録をしてください。

![ログイン機能](https://gyazo.com/2c232068d38ceafe4456b48288bd7597.gif)

トップページのタイムラインにて、自分の投稿とフォローした相手の投稿を閲覧できます。

![タイムライン](https://gyazo.com/e9fa91f7ff11fee18a36cf009de747c7.gif)

メッセージ投稿ができます。非同期通信で実行するので、ページの再読み込みはありません（ブックマークとフォローも同様）。

![メッセージ投稿](https://gyazo.com/6ebef7769a56c37aabfb10377869c1e6.gif)

画像も投稿できます。

![画像投稿](https://gyazo.com/cb273ec72b2026f24c2467a38997b34a.gif)

記事の検索やフォローもできます。
![検索機能とフォロー機能](https://gyazo.com/0ae1385c2e589f9488d89d41b0efd3dd.gif)

マイページで、ブックマークやフォロワーの一覧を確認できます。
![マイページでフォロー、フォロワー、いいね一覧を表示](https://gyazo.com/ac9fce4139d188cba71cf66f0c79efd7.gif)

## 使用した技術、言語、ツールなど
- 言語
    - サーバーサイド: Ruby
    - フロント: SASS, HTML (ERB), JavaScript (jQuery)
- アプリケーションフレームワーク: Ruby on rails
- CSSフレームワーク: Bootstrap
- インフラ: Heroku, AWS(S3)
- ソースコード管理: Github
- データベース: PostgreSQL

## 実装内容
- ERBとSASSでフロント実装
- CSSフレームワークとしてBootstrapを使用
    - Bootstrapでモーダルウィンドウを実装し、記事投稿・編集をモーダルウィンドウで行えるようにした
- 非同期通信時に、jQueryにより記事やブックマークをビューに反映
- devise (認証用gem)によるユーザー登録・ログイン機能
- carrierwaveによる画像のアップロード
- kaminari (ページネーション用gem)で記事数が多い際のページの切り替えを実装
- data-confirm-modal (モーダルダイアログ用gem)により、モーダルウィンドウでの記事削除を実装
- fogによるAWS S3への画像のアップロード
- Herokuへのデプロイ

## データベース設計

![データベース設計](https://gyazo.com/5a9619f8a07eefc7ae84568ad8103d05.png)
