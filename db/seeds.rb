# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Tag
tags = []
%w(JavaScript HTML CSS iPhone PHP Ruby Android Qiita Java Objective-C Vim Python ShellScript C++ C CoffeeScript Emacs git Perl jQuery
  ).each do |tag|
    puts "[Seed Tag] #{tag}"
    tags << Tag.find_or_create_by(name: tag)
end

# User
user = User.find_or_initialize_by(name: '山田太郎')
user.update_attributes!(email: "#{Devise.friendly_token[0,20]}@example.com", password: Devise.friendly_token[0,20])

user = User.find_or_initialize_by(name: '鈴木二郎')
user.update_attributes!(email: "#{Devise.friendly_token[0,20]}@example.com", password: Devise.friendly_token[0,20])

user = User.find_or_initialize_by(name: '田中三郎')
user.update_attributes!(email: "#{Devise.friendly_token[0,20]}@example.com", password: Devise.friendly_token[0,20])

# Post
users = User.all
Dir.glob(Rails.root.join('db', 'seeds').to_s + '/*').each do |file_name|
  puts "[Post Tag] #{file_name}"
  title = file_name.split('/').last

  post = Post.find_or_initialize_by(title: title)
  post.body = File.read(file_name)
  post.author = users.sample
  post.tags = [tags.sample, tags.sample]
  post.save!
end

