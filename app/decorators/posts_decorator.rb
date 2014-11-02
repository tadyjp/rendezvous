class PostsDecorator < Draper::CollectionDecorator
  def related_tags
    _tags = map(&:tags).flatten.uniq

    TagDecorator.decorate_collection(_tags)
  end

  def related_authors
    map(&:author).flatten.uniq.map(&:decorate)
  end
end
