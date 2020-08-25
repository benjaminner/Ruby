class Human
  def method_missing(method_name, *args)
    if method_name.to_s.end_with?('dollar_footlong')
      how_long = method_name.to_s.gsub('_footlong','').gsub('_',' ')
      puts "#{how_long}, #{how_long}, #{how_long} footlong"
    else
      raise NoMethodError.new("undefined method `#{method_name}' for Human:Class
")
    end
  end
  
  def respond_to?(method_name)
    if method_name.to_s.end_with?('dollar_footlong')
      true
    else
      super
    end
  end
end