# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


%w(JavaScript HTML CSS iPhone PHP Ruby Android Qiita Java Objective-C Vim Python ShellScript C++ C CoffeeScript Emacs git Perl jQuery
   ).each do |tag|
  puts "[Seed Tag] #{tag}"
  Tag.find_or_create_by(name: tag)
end


Dir.glob(Rails.root.join('db', 'seeds').to_s + '/*').each do |file_name|
  puts "[Post Tag] #{file_name}"
  title = file_name.split('/').last
  Post.find_or_create_by(title: title) do |post|
    post.body = File.read(file_name)
  end
end
