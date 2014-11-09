class PostDecorator < Draper::Decorator
  delegate_all

  def show_url
    h.post_url(model)
  end

  def show_path
    h.post_path(model)
  end

  # 読了時間
  #   500文字/1分換算
  def read_time
    time_min = model.body.length / 500
    case time_min
    when 0
      '< 1 min.'
    when 1..10
      "#{time_min} min."
    else
      '> 10 min.'
    end
  end

  def display_date
    if model.specified_date
      model.specified_date.strftime('%Y-%m-%d')
    else
      model.updated_at.strftime('%Y-%m-%d')
    end
  end

  def created_date
    model.created_at.strftime('%Y-%m-%d')
  end

  def updated_date
    model.updated_at.strftime('%Y-%m-%d')
  end

  def display_specified_date
    if model.specified_date
      model.specified_date.strftime('%Y-%m-%d')
    else
      ''
    end
  end

  def thumbnail_url
    if model.body =~ /!\[.+?\]\((.+?)\)/
      return $1
    end
  end
end
