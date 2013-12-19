module PostsHelper

  # @param {ActiveRecord::Relation} node
  def h_display_tree(node)
    _html = '<ul>'
    _html << %Q{<li><a href="#{ root_path(q: '#' + node.name) }">#{node.name}</a></li>}
    node.children.each do |_child|
      _html << h_display_tree(_child)
    end
    _html << '</ul>'
    _html.html_safe
  end


  def sample_body
    text = <<-'EOF'
昨日、[RailsでOmniauthを使ってTwitterログインする](http://qiita.com/hilotter/items/628fd54785d3c892d048)方法をまとめました。

今回はログイン後に定型文をつぶやいたり、特定アカウントをフォローできるようにしたいと思います。

[詳細記事はこちらをご参照ください](http://blog.hello-world.jp.net/?p=867)

## 初期設定

* Gemfile記述

[注意書き] [先日の記事](http://qiita.com/hilotter/items/1fab4e284b1211738880)でご紹介したtweetstream gemでStreamingAPIも一緒に使用したい場合、twitter gemの最新バージョン(version 5)だとエラーになってしまうので4.8以上5未満を使用するようにGemfileを修正しました。

tweetstreamを使用しない場合は最新のtwitter gemを使用して問題ないと思います。

今回はtwitter gemバージョン4.8を使用したやり方を書いていますが、バージョン5以降は初期化処理のパラメータ名等が変わっているので注意が必要です。

詳しくは[twitter gem](https://github.com/sferik/twitter)のページを参照ください。

```Gemfile
gem 'tweetstream' # streaming api用に使用
gem 'mongoid', git: 'git://github.com/mongoid/mongoid.git' # streaming api用に使用

gem 'omniauth'
gem 'omniauth-twitter'
gem 'settingslogic'
gem 'twitter', "~> 4.8"
```

* bundle install

```
./bin/bundle install
```

* twitter initializer設定

```config/initializers/twitter.rb
Twitter.configure do |config|
  config.consumer_key       = Settings.twitter.consumer_key
  config.consumer_secret    = Settings.twitter.consumer_secret
end
```

* lib以下をautoloadするようapplication.rbに追記

```config/application.rb

class Application < Rails::Application
  # lib以下をautoloadする
  config.autoload_paths += %W(#{config.root}/lib)
  config.autoload_paths += Dir["#{config.root}/lib/**/"]
end
```

* routing追加

```config/routes.rb
root 'home#index'
get "home/index"
get "/tweet", :to => 'home#tweet', :as => 'tweet'
get "/follow", :to => 'home#follow', :as => 'follow'
get "/follow_check", :to => 'home#follow_check', :as => 'follow_check'
```

## controller更新

[前回の記事](http://qiita.com/hilotter/items/628fd54785d3c892d048)ではUserモデルにユーザ情報を保存するようにしていましたが、今回はモデルは使わずsessionで管理することにします。

* SessionsController修正

```app/controllers/sessions_controller.rb
class SessionsController < BaseController
  def callback
    auth = request.env['omniauth.auth']

    # sessionに保持するように変更
    session[:user_id] = auth['uid']
    session[:name] = auth['info']['name']
    # 投稿に必要なauth_token, secret_tokenも取得する
    session[:oauth_token] = auth['credentials']['token']
    session[:oauth_token_secret] = auth['credentials']['secret']

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
```

* BaseController修正

```app/controllers/base_controller.rb
class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  def login_required
    @current_user = current_user
    unless @current_user
      redirect_to root_path
    end
  end

  private
  def current_user
    # SessionUserクラスからユーザ情報を取得するように
    @current_user ||= SessionUser.new(session) if session[:user_id]
  end
end
```

* SessionUserクラス作成

```
mkdir lib/user
```

```lib/user/session_user.rb
class SessionUser
  def initialize(session)
    @name = session[:name]
    @uid = session[:user_id]
    @token = session[:oauth_token]
    @secret = session[:oauth_token_secret]
  end

  attr_reader :name, :uid, :token, :secret
end
```

* HomeController更新

```app/controllers/home_controller.rb
class HomeController < BaseController
  before_action :login_required, only: [:tweet, :follow, :follow_check]

  def index
  end

  # 定型文をつぶやく
  def tweet
    text = sprintf(Settings.tweet_setting.text, Time.now)
    twitter_client.update(text)
    flash[:notice] = "tweet: #{text}"
    redirect_to root_path
  end

  # 特定ユーザをフォローする
  def follow
    twitter_client.follow(Settings.tweet_setting.follow_target_name)
    flash[:notice] = "follow done"
    redirect_to root_path
  end

  # 特定ユーザをフォローしているかどうかチェックする
  def follow_check
    follow_info = twitter_client.friendships(Settings.tweet_setting.follow_target_name).first
    flash[:notice] = "follow check: #{follow_info['connections'].include?('following')}"
    redirect_to root_path
  end

  private
  def twitter_client
    Twitter::Client.new(
      :oauth_token        => @current_user.token,
      :oauth_token_secret => @current_user.secret
    )
  end

end
```

## view更新

* layoutにflash[:notice]追加

```app/views/layouts/application.html.erb
<% if current_user %>
  <%= "#{current_user.uid} #{current_user.name}" %> <%= link_to 'ログアウト', logout_path %>
<% else %>
  <%= link_to 'ログイン', '/auth/twitter' %>
<% end %>

<%= flash[:notice] %>

<%= yield %>
```

* home/index.html.erb更新

```app/views/home/index.html.erb
<%= link_to 'tweet', tweet_path %>

<%= link_to 'follow', follow_path %>

<%= link_to 'follow check', follow_check_path %>
```

## 設定ファイル更新

* 設定ファイルにつぶやき文言等を設定

```config/settings.yml
defaults: &defaults

development:
  <<: *defaults
  twitter:
    consumer_key: ConsumerKey
    consumer_secret: ConsumerSecret
  tweet_setting:
    text: "ただ今の時間は%sです" # つぶやき文言
    follow_target_name: 'hilotter' # フォローしたいアカウント名

test:
  <<: *defaults

production:
  <<: *defaults
```

## 確認

* rails server起動

```
./bin/rails s
```

ブラウザから [http://127.0.0.1:3000](http://127.0.0.1:3000) にアクセスするとtweetリンクとfollowリンクが表示されます。

ログイン済みの場合は投稿、フォローができます。

### 参考
* [OmniAuthで認証した後に、tweetしたりfollowしたりする](http://blog.hello-world.jp.net/?p=867)
* [sferik / twitter](https://github.com/sferik/twitter)
* [omniauthで認証してtwitterにupdateする。](http://hai3.net/blog/2011/05/13/omniauth-twitter-update/)
* [Railsアプリから twitterにつぶやいてみた](http://d.hatena.ne.jp/Nunocky/20110127/p1)
* [OmniAuthで認証機能を作る](http://tech.hatenadiary.jp/entry/2013/05/01/OmniAuth%E3%81%A7%E8%AA%8D%E8%A8%BC%E6%A9%9F%E8%83%BD%E3%82%92%E4%BD%9C%E3%82%8B)
* [tsupo / Twitter_API_1.1_rate_limit.txt](https://gist.github.com/tsupo/5597066)
* [REST API v1.1 Limits per window by resource](https://dev.twitter.com/docs/rate-limiting/1.1/limits)
* [結局、Twitter API 1.1で何が変わる？ 5つのポイント](http://www.atmarkit.co.jp/ait/articles/1209/26/news120.html)
* [【保存版】TwitterAPI1.1 REST API 全項目解説](http://dx.24-7.co.jp/twitterapi1-1-rest-api/)
* [twitter gemを使ったruby一行野郎（ツイート・トレンド・検索・フォロー＆フォロワー一覧・リスト一覧＆操作…）](http://d.hatena.ne.jp/riocampos+tech/20130616/p1)
* [[Ruby on Rails 3.1] lib ディレクトリ以下に自作ライブラリを置いて autoload を有効にする設定方法](http://codenote.net/ruby/rails/827.html)

    EOF
  end
end
