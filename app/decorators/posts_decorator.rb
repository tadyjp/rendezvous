class PostsDecorator < Draper::CollectionDecorator

  def related_tags
    _tags = self.map do |_post|
      _post.tags
    end.flatten.uniq

    TagDecorator.decorate_collection(_tags)
  end

  def related_authors
    self.map do |_post|
      _post.author
    end.flatten.uniq.map do |_author|
      _author.decorate
    end
  end
end
