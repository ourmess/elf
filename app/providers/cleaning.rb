module Provider
  class Cleaning
    def self.record_form
      {
        title: "Cleaning Record",
        sections: [{
          title: "Pipe Segment Reference",
          key: :psr,
          select_one: true,
          rows: Asset::Mainline.find_all_by_coordinates()
         },{
          rows:[{
            title: "Hours",
            key: :hours,
            type: :number,
            auto_correction: :no,
            auto_capitalization: :none,
            input_accessory: :done,
            placeholder: "0"
          },{
          title: "Comments",
          key: :comments,
          type: :text,
          row_height: 100
          }]
         },{
          rows: [{
            title: "Submit PSR Cleaning Activity",
            type: :submit,
          }]
         }]
       }
    end
    def self.general_form
      {
        title: "General Information",
        sections: [
            {
            title: 'System settings',
            rows: [
                {
                    title: "#{Time.now.strftime("%m/%d/%Y %I:%M%p")}",
                    type: :static,
                }
            ]
            },
            {
            title: 'Field Crew',
            rows: [{
                title: "Add member",
                key: :field_crew,
                type: :template,
                value: ['Steve'],
                template: {
                    title: 'Member',
                    type: :string,
                    placeholder: 'Enter here',
                    indented: true,
                    deletable: true
                }
            }]
            },
            {
            title: "Task Setup",
            footer: "General information about the cleaning activities planned for the day.",
            rows: [
                {
                    title: "Vehicle Number",
                    key: :vehicle_number,
                    type: :number,
                    auto_correction: :no,
                    auto_capitalization: :none,
                    input_accessory: :done,
                    placeholder: "1"
                },
                {
                    title: "Cleaning Area",
                    key: :cleaning_area,
                    type: :number,
                    auto_correction: :no,
                    auto_capitalization: :none,
                    input_accessory: :done,
                    placeholder: "16"
                },
            ]
            },
            {
            title: "Cleaning Priority",
            key: :cleaning_priority,
            select_one: true,
            rows: [
              {
                value: true,
                title: "30 day",
                key: "30-day",
                type: :check,
              }, {
                title: "90 day",
                key: "90-day",
                type: :check,
              }, {
                title: "120 day",
                key: "120-day",
                type: :check,
              }, {
                title: "Annual",
                key: "Annual",
                type: :check,
              }, {
                title: "Emergency",
                key: "Emergency",
                type: :check,
              }
            ]
            },
            {
                rows: [{
                    title: "Start",
                    type: :submit,
                }]
            }
        ]
       }
    end
    def self.follow_up_form
      {
        title: "Follow up",
        sections: [
            {
            title: "Follow up Activity",
            key: :follow_up_cleaning_priority,
            select_one: true,
            rows: [
              {
                value: true,
                title: "30 day",
                key: "30-day-followup",
                type: :check,
              }, {
                title: "90 day",
                key: "90-day-followup",
                type: :check,
              }, {
                title: "120 day",
                key: "120-day-followup",
                type: :check,
              }, {
                title: "Annual",
                key: "Annual-followup",
                type: :check,
              }
            ]
            },
            {
                rows: [{
                    title: "Done",
                    type: :submit,
                }]
            }
        ]
       }
    end
  end
end
