module Provider
  class Sso
    def self.form
      {
        title: "SSO",
        sections: [
          {
            title: "General Information",
            rows: [{
               title: "Vallecitos Water District",
               type: :static,
             },{
               title: "Regional Water Board",
               type: :number,
               auto_correction: :no,
               auto_capitalization: :none,
               input_accessory: :done,
               placeholder: "4"
             },{
               title: "Spill Location",
               key: :spill_poc_name,
               type: :text,
               row_height: 100
             }]
           },
           {
             footer: "Estimated spill volume?",
             rows: [{
               title: "Estimate",
               key: :spill_vol,
               type: :number,
               auto_correction: :no,
               auto_capitalization: :none,
               input_accessory: :done,
               placeholder: "0"
             }]
           },
          #  {
          #    footer: "Estimated spill volume recovered from the separate storm drain that flows to a surface water body? (Do not include water used for clean-up)",
          #    rows: [{
          #      title: "Estimate",
          #      key: :spill2,
          #      type: :number,
          #      auto_correction: :no,
          #      auto_capitalization: :none,
          #      input_accessory: :done,
          #      placeholder: "0"
          #    }]
          #  },
           {
             footer: "Estimated spill volume that reached a drainage channel that flows to a surface water body?",
             rows: [{
               title: "Estimate",
               key: :spill_vol_reach_surf,
               type: :number,
               auto_correction: :no,
               auto_capitalization: :none,
               input_accessory: :done,
               placeholder: "0"
             }]
           },{
             footer: "Estimated spill volume recovered from a drainage channel that flows to a surface water body?",
             rows: [{
               title: "Estimate",
               key: :spill_vol_recover,
               type: :number,
               auto_correction: :no,
               auto_capitalization: :none,
               input_accessory: :done,
               placeholder: "0"
             }]
           },
          #  {
          #    footer: "Estimated spill volume discharged directly to a surface water body?",
          #    rows: [{
          #      title: "Estimate",
          #      key: :spill2,
          #      type: :number,
          #      auto_correction: :no,
          #      auto_capitalization: :none,
          #      input_accessory: :done,
          #      placeholder: "0"
          #    }]
          #  },
          #  {
          #    footer: "Estimated spill volume recovered from surface water body?",
          #    rows: [{
          #      title: "Estimate",
          #      key: :spill2,
          #      type: :number,
          #      auto_correction: :no,
          #      auto_capitalization: :none,
          #      input_accessory: :done,
          #      placeholder: "0"
          #    }]
          #  },
          #  {
          #    footer: "Estimated spill volume discharged to land? (Includes discharges directly to land, and discharges to a storm drain system or drainage channel that flows to a storm water infiltration/retention structure, field, or other non-surface water location.)",
          #    rows: [{
          #      title: "Estimate",
          #      key: :spill2,
          #      type: :number,
          #      auto_correction: :no,
          #      auto_capitalization: :none,
          #      input_accessory: :done,
          #      placeholder: "0"
          #    }]
          #  },{
          #    footer: "Estimated spill volume recovered from the discharge to land? (Do not include water used for clean-up)",
          #    rows: [{
          #      title: "Estimate",
          #      key: :spill2,
          #      type: :number,
          #      auto_correction: :no,
          #      auto_capitalization: :none,
          #      input_accessory: :done,
          #      placeholder: "0"
          #    }]
          #  },
           {
           rows: [{
             title: "Submit",
             type: :submit,
           }]
         }]
       }
    end
  end
end
