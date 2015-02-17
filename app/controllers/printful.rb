class Printful

  API_HOST = 'api.theprintful.com'

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

  def option_name()
   options.map{ |x| x['name'] }
  end


end