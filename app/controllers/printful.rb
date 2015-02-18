class Printful


  def list()
    printful = HTTParty.get("https://api.theprintful.com/products/3")
    @results = JSON.parse(printful.body)
  end

  def model_name()
    list['result']['product']['model']
  end

  def options()
    list['result']['variants']
  end

  def option_size()
   options.map{ |x| x['size'] }
  end

  def option_price()
    options.map { |p| p['price']  }
  end


end