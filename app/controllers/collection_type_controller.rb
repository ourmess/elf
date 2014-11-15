class CollectionTypeController < UIViewController
  def viewDidLoad
    @self = self
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
        @self.navigationController.popViewControllerAnimated(true)
      end
    when "Cleaning Record"
      @form_ctrl = Formotion::FormController.alloc.initWithForm( Provider::Cleaning.general_form )
      @completion_form_controller = Formotion::FormController.alloc.initWithForm( Provider::Cleaning.follow_up_form )
      @child_form_controller = Formotion::FormController.alloc.initWithForm( Provider::Cleaning.record_form )

      @form_ctrl.form.on_submit do |form|
        NSLog("general_form #{@child_form_controller.form.sub_render}")
        NSLog("Successfully submited general form: #{form.render}")

        @child_form_controller.form.on_submit do |child_form|
          NSLog("record_form #{@child_form_controller.form.sub_render}")
          NSLog("Successfully submited general form: #{form.render}")
          NSLog("Successfully submited cleaning record form: #{child_form.render}")

          Asset::Mainline.find_object_id_by_psr( asset_record(child_form.render[:psr]) ) do |a|
            NSLog("Successfully discovered: #{a}")
            Contribution.create_cleaning_record(
              cleaning_record.merge! ({
                :object_id => "#{a.first}",
                :comments => child_form.render[:comments],
                :hours => child_form.render[:hours],
                :cleaning_area => form.render[:cleaning_area].to_i,
                :vehicle_number => form.render[:vehicle_number],
                :cleaning_crew => form.render[:field_crew].join(","),
                :cleaning_priority => form.render[:cleaning_priority]
              })
            ) do |c|
              NSLog("Successfully contributed: #{c}")

              @completion_form_controller.form.on_submit do |completion_form|
                NSLog("follow_up_form #{@completion_form_controller.form.sub_render}")
                NSLog("Successfully submited general form: #{form.render}")
                NSLog("Successfully submited cleaning record form: #{child_form.render}")
                NSLog("Successfully submited follow up activity: #{completion_form.render}")

                child_form.reset
                @self.navigationController.popViewControllerAnimated(true)
              end

              @self.navigationController.pushViewController(@completion_form_controller, animated: true)
            end
          end
        end

        @self.navigationController.pushViewController(@child_form_controller, animated: true)
      end
    else
      NSLog("Unsupported form type")
      @form_ctrl = nil
    end
    if @form_ctrl then @self.navigationController.pushViewController(@form_ctrl, animated: true) end
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
  def cleaning_record
    {
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/vallecitos_wfs/FeatureServer/0",
      :date => "#{Time.new}",
      :object_id => "1",
      :clean_flush => "YES",
      :cleaning_area => 2,
      :cleaning_crew => "t4SpatialUser1",
      :vehicle_number => "Vehicle1",
      :hours => "0",
      :comments => "n/a",
      :cleaning_priority => "None"
    }
  end
  def asset_record(psr)
    {
      :feature_service_url => "http://services3.arcgis.com/UyxiNa6T5RHXF0kI/arcgis/rest/services/vallecitos_wfs/FeatureServer/0",
      :psr => "#{psr}"
    }
  end
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
    table.dataSource = @self
    table.delegate = @self
    table.backgroundColor = Provider::Color.ui_color("ebebf1")
    table.separatorColor = Provider::Color.ui_color("e0e0e0")
    table
  end
end
