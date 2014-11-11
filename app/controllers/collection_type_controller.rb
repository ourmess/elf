class CollectionTypeController < UIViewController
  def viewDidLoad
  	@view = self.view
    @view.backgroundColor = Provider::Color.ui_color("F18239")
    @collection_types = CollectionType.all
    #self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
    @view.addSubview(collection_type_table)
  end

  def form(type)
    case type
    when "Sanitary Sewer Overflow"
      @form_ctrl = Formotion::FormController.alloc.initWithForm( Provider::Sso.form )
      @form_ctrl.form.on_submit do |form|
        NSLog("Successfully submited SSO")
        Contribution.create_sso(
          sanitary_sewer_overflow.merge! ({
            :spill_poc_name => form.render[:spill_poc_name],
            :spill_vol => form.render[:spill_vol],
            :spill_vol_recover => form.render[:spill_vol_recover],
            :spill_vol_reach_surf => form.render[:spill_vol_reach_surf],
            :spill_zip => "92024",
            :region => "1"
          })
        ) do |c|
          NSLog("Successfully contributed: #{c}")
        end
        self.navigationController.popViewControllerAnimated(true)
      end
    when "Cleaning Record"
      @form_ctrl = CleaningRecordController.alloc.init
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
		NSLog("CollectionTypeController > tableView > didSelectRowAtIndexPath")
    form( @collection_types[indexPath.row] )
	end

	def tableView(tableView, cellForRowAtIndexPath: indexPath)
		cell_view = UIView.alloc.initWithFrame [[5,5], [@view.frame.size.width, 50]]
		cell = tableView.dequeueReusableCellWithIdentifier("NORMAL_COLLECTION_TYPE_CELL") || begin
			UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
		end
    if @collection_types[indexPath.row]
      cell.textLabel.font = UIFont.fontWithName("HelveticaNeue", size:18)
		  cell.textLabel.text = "#{@collection_types[indexPath.row]}"
    end
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
		@collection_types.size
	end

 private
  def sanitary_sewer_overflow
    {
      #:feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/dd_test_points/FeatureServer/0",
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/sso_event/FeatureServer/0",
      :type => "Sanitary Sewer Overflow", #what type of asset are you contributing data for
      :lat => "0.0", #default current lat
      :lon => "0.0", #default current lon
      :spill_vol => "n/a",
      :spill_vol_recover => "n/a",
      :spill_vol_reach_surf => "n/a",
      :spill_zip => "0",
      :region => "0",
      :agency => "Vallecitos Water District",
      :spill_type => "Category 3",
      :responsible_party => "responsible party"
    }
  end
  def collection_type_table
    table = UITableView.alloc.initWithFrame([[0,0],[@view.frame.size.width,@view.frame.size.height]])
    table.dataSource = self
    table.delegate = self
    table.backgroundColor = Provider::Color.ui_color("ebebf1")
    table.separatorColor = Provider::Color.ui_color("e0e0e0")
    table
  end
end
