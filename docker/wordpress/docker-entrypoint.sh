#!/bin/bash

# ホストのユーザーと同じuidを指定するための設定
# - これをしておかないとホストOSから一般ユーザでファイル編集できない
# - wp-sandboxのuidは(ユーザの環境毎に異なるはずなので)ホスト側で取り出し値を環境変数で渡している
useradd -u $WP_SANDBOX_UID wp-sandbox --home-dir /var/www/html -s /bin/bash
chown -R wp-sandbox:wp-sandbox /var/www/html

# Dockerfileで追加したスクリプトに実行権限を付与
chmod 755 /tmp/docker-entrypoint.sh
chown wp-sandbox:wp-sandbox /tmp/setup_wordpress.sh
chmod 755 /tmp/setup_wordpress.sh

# docker-composeのdepends_onはコンテナの起動順序までしか保証してくれないので、接続できるようになるまで待つ
until mysql -h db -u wordpress &> /dev/null
do
        >&2 echo -n "."
        sleep 1
done
echo "Connect MySQL Finished"

# 本来のentrypointを実行してwordpressのインストールと起動を行う
docker-entrypoint.sh apache2-foreground