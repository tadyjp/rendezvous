class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :author, class_name: 'User'
  has_many :comments

  default_scope  { order(:updated_at => :desc) }


  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments

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

    # `id`以外をコピーする
    _forked_post = Post.new(self.attributes.except('id'))

    # `%Name`をユーザー名に置換
    _forked_post.title = _forked_post.title.gsub(/%Name/, user.name)

    # `%Y`などを日付に変換
    _forked_post.title = Time.now.strftime(_forked_post.title) # TODO

    _forked_post.title = _forked_post.title + ' のコピー'

    _forked_post.tag_ids = self.tag_ids
    _forked_post.author = user

    _forked_post
  end
end
