class AssetTypeController < UIViewController
  def viewDidLoad
  	@view = self.view
    @view.backgroundColor = Provider::Color.ui_color("F18239")
    @asset_types = AssetType.all
    #self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
    @view.addSubview(asset_type_table)
  end

  def form(type)
    case type
    when "Sanitary Sewer Overflow"
      @form_ctrl = Formotion::FormController.alloc.initWithForm( Provider::Sso.form )
      @form_ctrl.form.on_submit do |form|
        NSLog("Successfully submited SSO")
        Contribution.create_sso( sanitary_sewer_overflow ) do |c|
          NSLog("Successfully contributed: #{c}")
        end
        self.navigationController.popViewControllerAnimated(true)
      end
    when "Cleaning Record"
      @form_ctrl = Formotion::FormController.alloc.initWithForm( Provider::Cleaning.form )
      @form_ctrl.form.on_submit do |form|
        NSLog("Successfully submited Cleaning Record")
        Contribution.create_cleaning_record( cleaning_record ) do |c|
          NSLog("Successfully contributed: #{c}")
        end
        self.navigationController.popViewControllerAnimated(true)
      end
    else
      NSLog("Unsupported form type")
      @form_ctrl = nil
    end
    if @form_ctrl then self.navigationController.pushViewController(@form_ctrl, animated: true) end
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
		70
	end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
		NSLog("AssetTypeController > tableView > didSelectRowAtIndexPath")
    form( @asset_types[indexPath.row] )
	end

	def tableView(tableView, cellForRowAtIndexPath: indexPath)
		cell_view = UIView.alloc.initWithFrame [[5,5], [@view.frame.size.width, 50]]
		cell = tableView.dequeueReusableCellWithIdentifier("NORMAL_ASSET_TYPE_CELL") || begin
			UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
		end
    if @asset_types[indexPath.row]
      cell.textLabel.font = UIFont.fontWithName("HelveticaNeue", size:18)
		  cell.textLabel.text = "#{@asset_types[indexPath.row]}"
    end
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
		@asset_types.size
	end

 private
  def sanitary_sewer_overflow
    {
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/sso_event/FeatureServer/0",
      :type => "Sanitary Sewer Overflow", #what type of asset are you contributing data for
      :lat => "42.459239", #default current lat
      :lon => "-72.850087", #default current lon
      :spill_vol => "app spill_vol",
      :spill_vol_recover => "app spill_vol_recover",
      :spill_vol_reach_surf => "app spill_vol_reach_surf"
    }
  end
  def cleaning_record
    {
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/vallecitos_wfs/FeatureServer/0",
      :lat => "42.459239", #default current lat
      :lon => "-72.850087", #default current lon
      :cleaned_2014 => true
    }
  end
  def asset_type_table
    table = UITableView.alloc.initWithFrame([[0,0],[@view.frame.size.width,@view.frame.size.height]])
    table.dataSource = self
    table.delegate = self
    table.backgroundColor = Provider::Color.ui_color("ebebf1")
    table.separatorColor = Provider::Color.ui_color("e0e0e0")
    table
  end
end
