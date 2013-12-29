class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :author, class_name: 'User'

  # Named scope

  def self.build_query(params)
    _where_list = self.includes(:author, :tags)

    # 空白を一つに変換
    query_string = params[:q].gsub(/[\s　]+/, ' ')

    query_list = query_string.split(' ')

    query_list.each do |_query|
      case _query
      when /^post:(.+)/
        _where_list = _where_list.where('id = ?', $1)
      when /^title:(.+)/
        _where_list = _where_list.where('title LIKE ?', "%#{$1}%")
      when /^body:(.+)/
        _where_list = _where_list.where('body LIKE ?', "%#{$1}%")
      when /^@(.+)/
        _where_list = _where_list.where('users.name = ?', $1)
      when /^#(.+)/
        _where_list = _where_list.where('tags.name = ?', $1)
      when /^date:(\d+)-(\d+)-(\d+)/
        _date = Time.new($1, $2, $3)
        _where_list = _where_list.where('updated_at > ? AND updated_at < ?', _date, _date + 1.day)
      else
        _where_list = _where_list.where('title LIKE ? OR body LIKE ?', "%#{_query}%", "%#{_query}%")
      end
    end

    _where_list

  end

  # generate forked post (not saved)
  def generate_fork(user)
    forked_post = self.clone
    forked_post.title = forked_post.title.gsub(/%Name/, user.name)
    forked_post.title = Time.now.strftime(forked_post.title) # TODO
    forked_post.author = user

    forked_post
  end

end
