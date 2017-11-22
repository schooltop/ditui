class Gps

  def self.like_vendor(latitude,longitude)
    latitude = latitude.to_i
    longitude = longitude.to_i
  	Vendor.find_by_sql("select *, abs(latitude-#{latitude}) as min_latitude , abs(longitude-#{longitude}) as min_longitude  
  		from vendors  
  		order by min_latitude, min_longitude 
  		limit 10 ")
  end


  def self.show_gps(latitude,longitude)
  	# 度
  	latitude_degree = latitude.to_i
  	longitude_degree = longitude.to_i
    # 分
  	latitude_branch = ( (latitude - latitude_degree) * 60 ).to_i
  	longitude_branch = ( (longitude - longitude_degree) * 60 ).to_i
    # 秒
  	latitude_second = ( (latitude - latitude_degree) * 60 ) - latitude_branch
  	longitude_second = ( (longitude - longitude_degree) * 60 ) - longitude_branch
    return "#{latitude_degree}.#{latitude_branch}.#{latitude_second}","#{longitude_degree}.#{longitude_branch}.#{longitude_second}"
  end

end