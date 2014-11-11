module Asset
  class Mainline
    def self.find_object_id_by_psr(asset,&block)
      NSLog("Preparing find record object_id with asset: #{BW::JSON.generate(asset)}")
      AFMotion::JSON.post("http://www.idiotmenus.com:3000/api/v1/assets/find_object_id_by_psr", { data: BW::JSON.generate(asset) } ) do |response|
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
    def self.find_all_by_coordinates()
      BW::Location.get_once() do |result|
        lat = "#{result.coordinate.latitude}" rescue "undefined"
        lon = "#{result.coordinate.longitude}" rescue "undefined"
        asset = {:lat => "#{lat}", :lon => "#{lon}"}
        NSLog("Preparing to submit asset: #{BW::JSON.generate(asset)}")
      end
      [
          {
            value: true,
            title: "PSR 3776",
            key: "3776",
            type: :check,
          }, {
            title: "PSR 3777",
            key: "3777",
            type: :check,
          }, {
            title: "PSR 3778",
            key: "3778",
            type: :check,
          }, {
            title: "PSR 3779",
            key: "3779",
            type: :check,
          }
      ]
    end
  end
end
