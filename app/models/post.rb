# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  author_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#  is_draft       :boolean          default(FALSE)
#  specified_date :date
#
#    specified_dateは特定の日付を指定したい場合に使用

require 'date'

class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :author, class_name: 'User'
  has_many :comments

  # default_scope  { where(is_draft: false).order(:updated_at => :desc) }

  ######################################################################
  # validations
  ######################################################################
  validates :title, presence: true
  validates :body, presence: true

  ######################################################################
  # Named scope
  ######################################################################
  scope :search, (lambda do |query|
    _where_list = includes(:author, :tags).order(updated_at: :desc)

    # Convert spaces to one space.
    query_list = query.split(/[\s　]+/)

    query_list.each do |_query|
      case _query
      when /\Aid:(.+)/
        _where_list = _where_list.where(id: Regexp.last_match[1])
      when /\Atitle:(.+)/
        _where_list = _where_list.where('posts.title LIKE ?', "%#{Regexp.last_match[1]}%")
      when /\Abody:(.+)/
        _where_list = _where_list.where('posts.body LIKE ?', "%#{Regexp.last_match[1]}%")
      when /\A@(.+)/
        _where_list = _where_list.where(users: { nickname: Regexp.last_match[1] })
      when /\A#(.+)/
        _where_list = _where_list.where(tags: { name: Regexp.last_match[1] })
      when /\Adate:(\d+)-(\d+)-(\d+)/
        _date = Time.new(Regexp.last_match[1], Regexp.last_match[2], Regexp.last_match[3])
        _where_list = _where_list.where('posts.updated_at > ? AND posts.updated_at < ?', _date, _date + 1.day)
      when /\Adraft:1/
        _where_list = _where_list.where(is_draft: true)
      else
        _where_list = _where_list.where('posts.title LIKE ? OR posts.body LIKE ?', "%#{_query}%", "%#{_query}%")
      end
    end

    _where_list
  end)

  # 最新のPostを取得
  scope :recent, -> (limit = 10) {
    order(updated_at: :desc).limit(limit)
  }

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
    _forked_post.specified_date = Date.today

    _forked_post
  end

  # slideshow用のbody
  def body_for_slideshow
    self.body.gsub(/^#/, "---\n\n#")
  end
end
