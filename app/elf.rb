module Elf
  module Messaging
    class Media

      # userid
      # waste_image_type_id
      # waste_image_body
      # waste_image_lat
      # waste_image_lon
      # waste_image_location_accuracy
      def send_image
        #send new image up to server
      end

      def annonate_image(uuid,annotation)
        #send image tags/annotations up to server
      end

      def find_image_by_uiid(uiid)
        #returns image blob
      end

      def find_image_by_location(search)
        #returns image blob
      end

      def find_image_by_coordinates(lat,lon,distance)
        #returns image blob
      end

      def find_s3_path_by_uiid(uiid)
        #api returns s3 path, create a new UIImage and return that
      end

      def find_all_types(&callback)
        #returns array of waste types
        AFMotion::SessionClient.shared.get("api/v1/snaps/find_all_types") do |result|
          if result.success?
            types = []
            result.object["data"].each do |attributes|
              types << attributes
            end
            callback.call(types, nil)
          else
            callback.call([], result.error)
          end
        end
      end

    end

    class User

      def new
      end

    end

  end
end
