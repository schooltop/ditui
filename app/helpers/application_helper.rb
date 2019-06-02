module ApplicationHelper
  def show_db_time(time)
    if time.present?
      time.localtime.to_s(:db)
    end
  end

  def model_str(m)
    "#{m.class.name.underscore}_#{m.id}"
  end

end