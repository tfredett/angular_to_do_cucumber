module WaitUtils
  def wait_until_value(element, text)
    Capybara.using_wait_time(Capybara.default_max_wait_time) do
      sleep 0.1 until element.value == text
    end
  end
end