Feature: ログインしていないユーザーのアクセス

  Scenario: TOPページにアクセス
    When visit '/'
    Then response code is '200'

  Scenario: TOP以外にアクセス
    When visit '/posts'
    Then response code is '999'
