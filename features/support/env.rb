@browser = nil

Before do |scenario|
  @browser = Capybara.current_session
end

def wait_until_value(element, text)
  sleep 0.1 until element.value == text
end