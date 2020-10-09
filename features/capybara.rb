require 'capybara/cucumber'
require 'webdrivers'

Capybara.default_driver = :firefox
Capybara.default_max_wait_time = 5

Capybara.register_driver :headless_firefox do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Firefox::Options.new
  browser_options.args << '-headless'
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: browser_options)
end

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Firefox::Options.new
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: browser_options)
end