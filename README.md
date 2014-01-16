rendezvous
==========

A simple markdown-based wiki system for term.

## Badge
[![Build Status](https://travis-ci.org/tadyjp/rendezvous.png)](https://travis-ci.org/tadyjp/rendezvous)
[![Coverage Status](https://coveralls.io/repos/tadyjp/rendezvous/badge.png)](https://coveralls.io/r/tadyjp/rendezvous)
[![Code Climate](https://codeclimate.com/github/tadyjp/rendezvous.png)](https://codeclimate.com/github/tadyjp/rendezvous)
[![Dependency Status](https://gemnasium.com/tadyjp/rendezvous.png)](https://gemnasium.com/tadyjp/rendezvous)

# How to install and use.

Get code and install gems.

```
$ git clone git@github.com:tadyjp/rendezvous.git
$ cd rendezvous
$ bundle install
```

Create YOUR .ENV file.

```
$ cp .env.example .env
$ vim .env
```

Setup DB (Default: mysql).

```
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

Set ENV before start server.

```
$ source .env
$ bundle exec rails s
```

And have fun with your team !
