class Asset
  def self.find_all_by_cordinates(lat,lon,&block)
    asset = {:lat => "#{lat}", :lon => "#{lon}"}
    AFMotion::JSON.post("http://www.idiotmenus.com:3000/api/v1/assets/find_all_by_cordinates", { data: BW::JSON.generate(asset) } ) do |response|
      begin
        #NSLog("response #{response.object}")
        block.send(:retain)
        block.call(response.object)
      rescue NoMethodError
        NSLog("Unable to parse the HTTP response")
        block.call({})
      end
    end
  end
end
