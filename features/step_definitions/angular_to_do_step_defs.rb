require 'pry'

MAIN_URL = 'http://todomvc.com/examples/angular2/'.freeze
INPUT_TEST_TEXT = 'Get milk at the store'.freeze

INPUT_SELECTOR = '.new-todo'.freeze
TODO_LIST_SELECTOR = '.todo-list'.freeze
CHECKBOX_SELECTOR = '.toggle'.freeze
DELETE_BUTTON_SELECTOR = '.destroy'.freeze

Before do |scenario|
  clear_todo_list!
end

Given('I am on the Angular2 Todo list page') do
  @browser.visit(MAIN_URL)
end

When('I add a todo item') do
  input_box = @browser.find(INPUT_SELECTOR)
  # The following send keys is being used due to the Capybara fill-in method not working
  # My suspicion is because of the Angular interfering with it in some fashion.
  input_box.native.send_keys(INPUT_TEST_TEXT)
  # Because of us having to use the send keys above.
  # Capybara is not smart enough to wait for the send keys action to actually finish
  # As such, add a fluent wait to wait until the actual action completes
  wait_until_value(input_box, INPUT_TEST_TEXT)
  input_box.native.send_keys(:return)
end

Then('my todo item is added to my todo list') do
  todo_list = @browser.find(TODO_LIST_SELECTOR)
  expect(todo_list).to have_text(INPUT_TEST_TEXT)
end

When('I click the complete checkbox for my todo item') do
  # For whatever reason, the checkbox is considered invisible by selenium
  # I have no idea why, it is a thing though.
  checkbox = @browser.find('label', text: INPUT_TEST_TEXT)
                    .sibling(CHECKBOX_SELECTOR, visible: false)
  checkbox.click
end

Then('my todo item is marked completed') do
  todo_list_item = @browser.find('li', text: INPUT_TEST_TEXT)
  expect(todo_list_item['class']).to eq('completed')
end

When('I click the delete button on my todo item') do
  todo_list_item = @browser.find('label', text: INPUT_TEST_TEXT).ancestor('div')
  todo_list_item.hover
  delete_button = todo_list_item.find(DELETE_BUTTON_SELECTOR, visible: false)
  delete_button.hover.click
end

Then('my todo item is removed from the list') do
  expect(@browser).to have_no_css('li')
end


def clear_todo_list!
  @browser.visit(MAIN_URL) unless @browser.current_url == MAIN_URL
  @browser.all(DELETE_BUTTON_SELECTOR, visible: false).each(&:click)
end