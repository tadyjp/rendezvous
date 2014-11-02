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
  include HipchatIntegration if Settings.respond_to?(:hipchat)

  ######################################################################
  # Associations
  ######################################################################
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :footprints

  has_many :watches, as: :watchable, dependent: :destroy
  has_many :watchers, through: :watches

  ######################################################################
  # Validations
  ######################################################################
  validates :title, presence: true
  validates :body, presence: true

  ######################################################################
  # Callback
  ######################################################################
  after_save :set_watcher!
  after_save :notify_watchers!
  after_create :notify_hipchat! if Settings.hipchat.token.present? && Settings.hipchat.room.present?

  ######################################################################
  # Named scope
  ######################################################################
  scope :search, (lambda do |query|
    where_list = includes(:author, :tags).order(updated_at: :desc)

    # Convert spaces to one space.
    query_list = query.split(/[\s　]+/)

    query_list.each do |where_query|
      case where_query
      when /\Aid:(.+)/
        where_list = where_list.where(id: Regexp.last_match[1])
      when /\Atitle:(.+)/
        where_list = where_list.where('posts.title LIKE ?', "%#{Regexp.last_match[1]}%")
      when /\Abody:(.+)/
        where_list = where_list.where('posts.body LIKE ?', "%#{Regexp.last_match[1]}%")
      when /\A@(.+)/
        where_list = where_list.where(users: { nickname: Regexp.last_match[1] })
      when /\A#(.+)/
        where_list = where_list.where(tags: { name: Regexp.last_match[1] })
      when /\Adate:(\d+)-(\d+)-(\d+)/
        date = Time.new(Regexp.last_match[1], Regexp.last_match[2], Regexp.last_match[3])
        where_list = where_list.where('posts.updated_at > ? AND posts.updated_at < ?', date, date + 1.day)
      when /\Adraft:1/
        where_list = where_list.where(is_draft: true)
      else
        where_list = where_list.where('posts.title LIKE ? OR posts.body LIKE ?', "%#{where_query}%", "%#{where_query}%")
      end
    end

    where_list
  end)

  # 最新のPostを取得
  scope :recent, (lambda do |limit = 10|
    order(updated_at: :desc).limit(limit)
  end)

  ######################################################################
  # Instance method
  ######################################################################

  # generate forked post (not saved)
  def generate_fork(user)
    # `id`以外をコピーする
    forked_post = Post.new(attributes.except('id'))

    # `%name`をユーザー名に置換
    forked_post.title = forked_post.title.gsub(/%name/, user.name)
    # `%Y`などを日付に変換
    forked_post.title = Time.now.strftime(forked_post.title) # TODO
    forked_post.title = forked_post.title

    forked_post.tag_ids = tag_ids
    forked_post.author = user
    forked_post.specified_date = Date.today

    forked_post
  end

  # slideshow用のbody
  def body_for_slideshow
    body.gsub(/^#/, "---\n\n#")
  end

  def visited_user_count
    footprints.select(:user_id).uniq.count
  end

  # FIXME: 正常に動作しないため動作しないため一時的にメソッドを作成
  #   has_many :watchers, :through => :watches
  #
  # def watchers
  #   watches.map { |watch| watch.watcher }
  # end

  private

  def notify_watchers!
    watchers.each do |watcher|
      next if watcher == author

      watcher.push_notification(decorate.show_path, "#{author.name}さんが「#{title}」を編集しました")
    end
  end

  def set_watcher!
    author.watch!(post: self)
  end
end
