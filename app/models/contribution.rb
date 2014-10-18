class Contribution
  def self.create(asset,&block)
    BW::Location.get_once() do |result|
      asset[:lat] = "#{result.coordinate.latitude}"
      asset[:lon] = "#{result.coordinate.longitude}"
      NSLog("Successfully obtained current location: lat#{asset[:lat]} lon#{asset[:lon]}")
      NSLog("Preparing to submit asset: #{BW::JSON.generate(asset)}")
      AFMotion::JSON.post("<domain>/api/v1/contributions/create_asset", { data: BW::JSON.generate(asset) } ) do |response|
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
end
