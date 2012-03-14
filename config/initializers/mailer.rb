if Rails.env == 'development' || Rails.env == 'test' 
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
else
  ActionMailer::Base.default_url_options[:host] = "marcaexpress.herokuapp.com"
end
