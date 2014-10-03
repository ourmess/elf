class MediaType
  def self.all
    @media ||= Messaging::Media.new
    @media.find_all_types do |types, error|
      if (error)
        UIAlertView.alloc.initWithTitle("Error",
          message:error.localizedDescription,
          delegate:nil,
          cancelButtonTitle:nil,
          otherButtonTitles:"OK", nil).show
      else
        return types
      end
    end
  end
end
