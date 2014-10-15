class AssetTypeController < UIViewController
  def viewDidLoad
  	@view = self.view
    @view.backgroundColor = Provider::Color.ui_color("50E3C2")
    @asset_types = AssetType.all

    choice
  end

  def choice
  	@asset_types.each do |type|
  	  NSLog("Setting up #{type}")
  	  #onclick
  	  Contribution.create( asset(type) ) do |c|
  	  	NSLog("Successfully contributed: #{c}")
  	  end
    end
  end

 private
  def asset(type)
  	{
  	  :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/dd_test_points/FeatureServer/0",
  	  :type => type, #what type of asset are you contributing data for
  	  :lat => "42.459239", #your current lat
  	  :lon => "-72.850087" #your current lon
  	}
  end
end
