# Feature: 検索

#   @javascript2
#   Scenario: 検索 --> Post表示
#     Given login
#     And create post 'ruby is ...'
#     When visit '/posts'
#     And search by 'ruby'
#     And click item
#     Then response code is 200
#     And post 'ruby' shown
