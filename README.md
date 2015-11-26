rendezvous
==========

[![Build Status](https://travis-ci.org/tadyjp/rendezvous.png)](https://travis-ci.org/tadyjp/rendezvous)
[![Coverage Status](https://coveralls.io/repos/tadyjp/rendezvous/badge.png)](https://coveralls.io/r/tadyjp/rendezvous)
[![Code Climate](https://codeclimate.com/github/tadyjp/rendezvous.png)](https://codeclimate.com/github/tadyjp/rendezvous)
[![Dependency Status](https://gemnasium.com/tadyjp/rendezvous.png)](https://gemnasium.com/tadyjp/rendezvous)

A simple markdown-based blog & wiki system for team.


# Supported versions

- Ruby 2.2.3

# How to install and use.

## Install dependencies

```
# for PDF processing.
$ brew install imagemagick ghostscript

# for JS test
$ npm install phantomjs -g
$ phantomjs -v
```


## Get code and install gems.

```
$ git clone git@github.com:tadyjp/rendezvous.git
$ cd rendezvous

$ bundle install
```

## Get Google API Key.

Register application on https://code.google.com/apis/console,
and get

1. Access https://code.google.com/apis/console
2. Create New Project
3. Create Client ID ([APIs & auth] > [Credentials] > [CREATE NEW CLIENT ID])
4. Input form
  - `http://localhost:3000` in [Authorized Javascript origins]
  - `http://localhost:3000/users/auth/google_oauth2/callback` in [Authorized redirect URI]
5. Get [Client ID] and [Client secret]
6. Write your Client ID & Secret in config/settings.yml
7. Input form
  -`rendevous` in [Project name] in Consent screen
8. Make sure `Google+ API` and `Gmail API` enabled.


## Dotenv

Fill in your environment in `.env.development`

```
$ cp .env .env.development
$ vim .env.development
```

## Setup DB

```
$ (bundle exec) rake db:migrate
$ (bundle exec) rake db:seed
```

And have fun with your team !



# Test

Before you run test, please setup test environment.

```
$ cp .env .env.test
$ vim .env.test
```

And run

```
$ (bundle exec) rspec
```

Rendezvous uses travis-ci for test.

