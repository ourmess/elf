class Contribution
  def self.create(asset,&block)
  	AFMotion::JSON.post("http://www.idiotmenus.com:3000/api/v1/contributions/create_asset", { data: BW::JSON.generate(asset) } ) do |response|
      begin
        NSLog("response #{response.object}")
        block.send(:retain)
        block.call(response.object)
      rescue NoMethodError
        NSLog("Unable to parse the HTTP response")
        block.call({})
      end
    end
  end
end
