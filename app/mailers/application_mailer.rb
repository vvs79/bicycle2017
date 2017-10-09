class ApplicationMailer < ActionMailer::Base
  default from: "place.test.info@gmail.com",
          template_path: 'mailers/bikes'
end
