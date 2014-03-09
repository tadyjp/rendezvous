Feature: アクセス制限

  Scenario: 非ログイン --> TOPページ
    When visit '/'
    Then response code is 200
    Then response includes '<!-- view:home/login -->'

  Scenario: 非ログイン --> postsページ
    When visit '/posts'
    Then response code is 200
    Then response includes '<!-- view:home/login -->'

  # Scenario: 禁止ユーザーログイン --> TOPページ
  #   Given login via google with 'taro@example.com'
  #   Then response code is 200
  #   Then page includes 'Your email address is not permitted'

  # Scenario: 禁止ユーザーログイン --> postsページ
  #   Given login via google with 'taro@example.com'
  #   When visit '/posts'
  #   Then response code is 200
  #   Then response includes '<!-- view:home/login -->'

  Scenario: ログイン --> TOPページ
    Given user login
    When visit '/'
    Then response code is 200
    Then response includes '<!-- view:post/index -->'

  Scenario: ログイン --> postsページ
    Given user login
    When visit '/posts'
    Then response code is 200
    Then response includes '<!-- view:post/index -->'
