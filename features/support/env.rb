@browser = nil

Before do |scenario|
  @browser = Capybara.current_session
end