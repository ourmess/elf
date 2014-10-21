class Contribution
  def self.create_sso(asset,&block)
    BW::Location.get_once() do |result|
      asset[:lat] = "#{result.coordinate.latitude}"
      asset[:lon] = "#{result.coordinate.longitude}"
      NSLog("Successfully obtained current location: lat#{asset[:lat]} lon#{asset[:lon]}")
      NSLog("Preparing to submit asset: #{BW::JSON.generate(asset)}")
      AFMotion::JSON.post("http://www.idiotmenus.com:3000/api/v1/contributions/create_sso", { data: BW::JSON.generate(asset) } ) do |response|
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
  def self.create_cleaning_record(asset,&block)
    BW::Location.get_once() do |result|
      asset[:lat] = "#{result.coordinate.latitude}"
      asset[:lon] = "#{result.coordinate.longitude}"
      NSLog("Successfully obtained current location: lat#{asset[:lat]} lon#{asset[:lon]}")
      NSLog("Preparing to submit asset: #{BW::JSON.generate(asset)}")
      AFMotion::JSON.post("http://www.idiotmenus.com:3000/api/v1/contributions/create_cleaning_record", { data: BW::JSON.generate(asset) } ) do |response|
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
