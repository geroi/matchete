Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mailru, '743143', '4f015846fcdc25831c7f9abddb512ca9', :callback_url => 'http://matchete.ru/users/auth/mailru/callback'
end