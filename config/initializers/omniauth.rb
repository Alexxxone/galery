Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook,'192149350947007','353adf01ce05ae79aac9b049b54f2e91'
end
