module Provider
  class Cleaning
    def self.form
      {
        sections: [
        {
            title: "General Information",
            footer: "This is the footer for the section. It's good for displaying detailed data about the section.",
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
            title: "Cleaning Type",
            key: :cleaning_type,
            select_one: true,
            rows: [
              {
                value: true,
                title: "Cleaning Type 1",
                key: "3776",
                type: :check,
              }, {
                title: "Cleaning Type 2",
                key: "3777",
                type: :check,
              }, {
                title: "Cleaning Type 3",
                key: "3778",
                type: :check,
              }, {
                title: "Cleaning Type 4",
                key: "3779",
                type: :check,
              }
            ]
        },
        {
            rows: [
                {
                    title: "Cleaning Record",
                    type: :subform,
                    key: :subform,
                    display_key: :type,
                    subform: {
                        title: "Cleaning Record",
                        sections: [
                            {
                                title: "Pipe Segment Reference",
                                key: :psr,
                                select_one: true,
                                rows: Asset::Mainline.find_all_by_coordinates()
                            },
                            {
                                rows: [
                                    {
                                        title: "Hours",
                                        key: :hours,
                                        type: :number,
                                        auto_correction: :no,
                                        auto_capitalization: :none,
                                        input_accessory: :done,
                                        placeholder: "0"
                                    },
                                    {
                                        title: "Comments",
                                        key: :comments,
                                        type: :text,
                                        row_height: 100
                                    }
                                ]
                            },
                            {
                                rows: [
                                    {
                                        title: "Add PSR Clean",
                                        type: :back,
                                        
                                    }
                                ]
                            }
                        ]
                      }
                }
            ]
        },
        {
                                rows: [
                                    {
                                        title: "Submit Day",
                                        type: :submit,
                                        
                                    }
                                ]
                            }
        ]
    }
    end
  end
end
