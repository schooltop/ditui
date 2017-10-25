module ApplicationHelper
  def show_db_time(time)
    if time.present?
      time.localtime.to_s(:db)
    end
  end	
end
