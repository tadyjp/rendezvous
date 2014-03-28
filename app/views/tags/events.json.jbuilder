json.array!(@tag.posts) do |post|
  json.extract! post, :title
  json.url post_url(post)
  json.start post.specified_date || post.created_at
end
