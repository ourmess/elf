class MediaTypeController < UIViewController
  def viewDidLoad
    puts MediaType.all
  end
end
