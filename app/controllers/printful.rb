class Printful

  API_HOST = 'api.theprintful.com'

  def list()
    printful = HTTParty.get("https://api.theprintful.com/products/3")
    @results = JSON.parse(printful.body)
  end

end