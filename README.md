rendezvous
==========

[![Build Status](https://travis-ci.org/tadyjp/rendezvous.png)](https://travis-ci.org/tadyjp/rendezvous)
[![Coverage Status](https://coveralls.io/repos/tadyjp/rendezvous/badge.png)](https://coveralls.io/r/tadyjp/rendezvous)
[![Code Climate](https://codeclimate.com/github/tadyjp/rendezvous.png)](https://codeclimate.com/github/tadyjp/rendezvous)
[![Dependency Status](https://gemnasium.com/tadyjp/rendezvous.png)](https://gemnasium.com/tadyjp/rendezvous)

A simple markdown-based wiki system for team.


# Supported versions

- Ruby 2.0.0+
- Rails 4.0.0+

# How to install and use.

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


## Create your .env file.

```
$ cp .env.example .env
$ vim .env
```

Set Google API [Client ID] and [Client secret] in `.env`


## Setup DB (Default: mysql).

```
$ (bundle exec) rake db:migrate
$ (bundle exec) rake db:seed
```

## Set ENV before start server.

```
$ source .env
$ (bundle exec) rails s
```

And have fun with your team !
