class PostsDecorator < Draper::CollectionDecorator

  def related_tags
    _tags = self.map do |_post|
      _post.tags
    end.flatten.uniq

    TagDecorator.decorate_collection(_tags)
  end

  def related_authors
    _authors = self.map do |_post|
      _post.author
    end.flatten.uniq

    UserDecorator.decorate_collection(_authors)
  end
end
