module Provider
  class Sso
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
