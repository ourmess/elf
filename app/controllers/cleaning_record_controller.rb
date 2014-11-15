class CleaningRecordController < UIViewController
  def viewDidLoad
    @self = self
  	@view = self.view
    @view.backgroundColor = Provider::Color.ui_color("F18239")
    form
  end

  def form
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

    if @form_ctrl && @child_form_controller && @completion_form_controller then @self.navigationController.pushViewController(@form_ctrl, animated: true) end
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
end
