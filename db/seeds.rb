# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Tag

_tag_tree = [
  ['Language', 'JavaScript'],
  ['Language', 'HTML'],
  ['Language', 'CSS'],
  ['Language', 'iPhone'],
  ['Language', 'PHP'],
  ['Language', 'Ruby'],
  ['Language', 'Android'],
  ['Language', 'Qiita'],
  [nil, '日報'],
  ['インフラ', 'ネットワーク'],
  ['インフラ', 'サーバ'],
  ['インフラ', 'OS'],
  ['OS', 'CentOS'],
  ['OS', 'Ubuntu'],
  ['OS', 'MacOS'],
  ['OS', 'Windows'],
]

tags = []

_tag_tree.each do |_parent, _child|
  Rails.logger.debug "[Seed Tag] #{_parent} => #{_child}"
  parent = Tag.find_or_create_by(name: _parent) if _parent
  child = Tag.find_or_initialize_by(name: _child)
  child.parent = parent if _parent
  child.save!
  tags << child
end

# User
User.find_or_create_by(name: '山田太郎') do |_u|
  _u.email = "#{Devise.friendly_token[0, 20]}@example.com"
  _u.password = Devise.friendly_token[0, 20]
end

User.find_or_create_by(name: '鈴木二郎') do |_u|
  _u.email = "#{Devise.friendly_token[0, 20]}@example.com"
  _u.password = Devise.friendly_token[0, 20]
end

User.find_or_create_by(name: '田中三郎') do |_u|
  _u.email = "#{Devise.friendly_token[0, 20]}@example.com"
  _u.password = Devise.friendly_token[0, 20]
end

# Post
users = User.all

Dir.glob(Rails.root.join('db', 'seeds').to_s + '/*').each do |file_name|
  Rails.logger.debug "[Post Tag] #{file_name}"
  title = file_name.split('/').last

  post = Post.find_or_initialize_by(title: title)
  post.body = File.read(file_name)
  post.author = users.sample
  post.tags = [tags.sample, tags.sample]
  post.save!
end
