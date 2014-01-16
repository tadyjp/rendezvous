class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :author, class_name: 'User'
  has_many :comments

  # Named scope
  scope :search, (lambda do |query|
    _where_list = includes(:author, :tags)

    # Convert spaces to one space.
    query_list = query.gsub(/[\s　]+/, ' ').split(' ')

    query_list.each do |_query|
      case _query
      when /^id:(.+)/
        _where_list = _where_list.where(id: Regexp.last_match[1])
      when /^title:(.+)/
        _where_list = _where_list.where('title LIKE ?', "%#{Regexp.last_match[1]}%")
      when /^body:(.+)/
        _where_list = _where_list.where('body LIKE ?', "%#{Regexp.last_match[1]}%")
      when /^@(.+)/
        _where_list = _where_list.where(users: { name: Regexp.last_match[1] })
      when /^#(.+)/
        _where_list = _where_list.where(tags: { name: Regexp.last_match[1] })
      when /^date:(\d+)-(\d+)-(\d+)/
        _date = Time.new(Regexp.last_match[1], Regexp.last_match[2], Regexp.last_match[3])
        _where_list = _where_list.where('updated_at > ? AND updated_at < ?', _date, _date + 1.day)
      else
        _where_list = _where_list.where('title LIKE ? OR body LIKE ?', "%#{_query}%", "%#{_query}%")
      end
    end

    _where_list
  end)

  # generate forked post (not saved)
  def generate_fork(user)

    forked_post = Post.new(self.attributes.except(:id))
    forked_post.title = forked_post.title.gsub(/%Name/, user.name)
    forked_post.title = Time.now.strftime(forked_post.title) # TODO
    forked_post.tag_ids = self.tag_ids
    forked_post.author = user

    forked_post
  end
end
