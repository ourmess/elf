module Provider
  class Cleaning
    def self.form
       {
         title: "SSO",
         sections: [{
           rows: [{
             title: "Submit",
             type: :submit,
           }]
         }]
       }
    end
  end
end

