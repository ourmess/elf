class CleaningRecordController < UIViewController
  def viewDidLoad
  	@view = self.view
    @view.backgroundColor = Provider::Color.ui_color("F18239")
    #self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
    @view.addSubview(cleaning_record_table)
  end

  def form
    @form_ctrl = Formotion::FormController.alloc.initWithForm( Provider::Cleaning.form )
    NSLog("sub #{@form_ctrl.form.sub_render}")
    @form_ctrl.form.on_submit do |form|
      NSLog("sub1 #{@form_ctrl.form.sub_render}")
      NSLog("Successfully submited Cleaning Record: #{form.render}")
      Asset::Mainline.find_object_id_by_psr( asset_record(form.render[:psr]) ) do |a|
        NSLog("Successfully discovered: #{a}")
        Contribution.create_cleaning_record(
          cleaning_record.merge! ({
            :object_id => "#{a.first}",
            :comments => form.render[:comments],
            :hours => form.render[:hours]
          })
        ) do |c|
          NSLog("Successfully contributed: #{c}")
        end
      end
      self.navigationController.popViewControllerAnimated(true)
    end
    if @form_ctrl then self.navigationController.pushViewController(@form_ctrl, animated: true) end
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
		70
	end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
		NSLog("CleaningRecordController > tableView > didSelectRowAtIndexPath")
    form
	end

	def tableView(tableView, cellForRowAtIndexPath: indexPath)
		cell_view = UIView.alloc.initWithFrame [[5,5], [@view.frame.size.width, 50]]
		cell = tableView.dequeueReusableCellWithIdentifier("NORMAL_ASSET_TYPE_CELL") || begin
			UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
		end
    cell.textLabel.font = UIFont.fontWithName("HelveticaNeue", size:18)
		cell.textLabel.text = "Test"
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
		3
	end

 private
  def cleaning_record
    {
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/vallecitos_wfs/FeatureServer/0",
      :date => "#{Time.new}",
      :object_id => "1",
      :clean_flush => "YES",
      :cleaning_area => 2,
      :cleaning_crew_1 => "t4SpatialUser1",
      :cleaning_crew_2 => "t4SpatialUser2",
      :vehicle_number => "Vehicle1",
      :hours => "0",
      :comments => "n/a"
    }
  end
  def asset_record(psr)
    {
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/vallecitos_wfs/FeatureServer/0",
      :psr => "#{psr}"
    }
  end
  def cleaning_record_table
    table = UITableView.alloc.initWithFrame([[0,0],[@view.frame.size.width,@view.frame.size.height]])
    table.dataSource = self
    table.delegate = self
    table.backgroundColor = Provider::Color.ui_color("ebebf1")
    table.separatorColor = Provider::Color.ui_color("e0e0e0")
    table
  end
end
