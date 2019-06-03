module ApplicationHelper
  def show_db_time(time)
    if time.present?
      time.localtime.to_s(:db)
    end
  end

  def model_str(m)
    "#{m.class.name.underscore}_#{m.id}"
  end

  def set_countries
    if Rails.cache.read(:countries).blank?
      @countries = Area.select("nation_cn").group(:nation_cn).order(:nation_cn)
      Rails.cache.write(:countries, @countries)
    else
      @countries = Rails.cache.fetch(:countries)
    end
    return @countries.pluck(:nation_cn).map{|c| [c, c]}
  end

end