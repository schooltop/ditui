class Admin::AreasController < ActionController::Base

  def search

    if params[:country]
      @areas = Area.where(nation_cn: params[:country]).select(:province_cn).distinct
      results = @areas.map { |x| { value: x.province_cn, text: x.province_cn, name: x.province_cn } }
      options = results.inject(""){|options_str, c| options_str += "<option value='#{c[:value]}'>#{c[:name]}</option>"}
    elsif params[:province]
      @areas = Area.where(province_cn: params[:province]).select(:city_cn, :id).distinct
      results = @areas.map { |x| { value: x.city_cn, text: x.city_cn, name: x.city_cn } }
      options = results.inject(""){|options_str, c| options_str += "<option value='#{c[:value]}'>#{c[:name]}</option>"}
    else
      results = []
      options = []
    end

    render json: { values: results, options: options }
  end

end
