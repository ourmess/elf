module Provider
  class Cleaning
    def self.form
      {
        title: "Cleaning Record",
        sections: [{
          title: "Pipe Segment Reference",
          key: :psr,
          select_one: true,
          rows: Asset.find_all_by_coordinates()
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
            title: "Submit PSR Clean",
            type: :submit,
          }]
         }]
       }
    end
  end
end
