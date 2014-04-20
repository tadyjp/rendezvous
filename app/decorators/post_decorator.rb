class PostDecorator < Draper::Decorator
  delegate_all

  def show_path
    h.post_path(model)
  end

  # 読了時間
  #   500文字/1分換算
  def read_time
    _time_min = model.body.length / 500
    case _time_min
    when 0
      '< 1 min.'
    when 1..10
      "#{_time_min} min."
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

  def display_specified_date
    if model.specified_date
      model.specified_date.strftime('%Y-%m-%d')
    else
      ''
    end
  end

end
