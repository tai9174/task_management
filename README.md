Users
|column|data_type|
|---|---|
|name|string|
|email|string|
|password_digest|string|

task
|column|data_type|
|---|---|
|title|string|
|content|string|
|expired_at|date|
|status|string|
|priority|string|

labelling
|column|data_type|
|---|---|
|task_id|string|
|label_id|string|

label
|column|data_type|
|---|---|
|name|string|
---------------------------------------------------------------

# Herokuにデプロイをする手順


## ① $ heroku create
herokuに新しいアプリケーションを作成

## ② $ git remote -v
heroku​ という名前のリモートがアプリに合わせて設定されていることを確認

## ③ $ git add -A 
## ④ $ git commit -m "init"
コミットする

## ⑤ $ git push heroku step2:master
step2ブランチの変更内容をHerokuのmasterブランチに反映する

## ⑥ $ heroku run rails db:migrate
データベースの移行