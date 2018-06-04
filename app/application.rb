class Application
  @@items = [Item.new("iPhoneX", 999.99), Item.new("AppleTV", 149.99),
    Item.new("Backpack", 50.0)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item_result = @@items.find { |item| item.name == item_name }
      if item_result
        resp.write item_result.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
