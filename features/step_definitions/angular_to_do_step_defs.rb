INPUT_TEST_TEXT = 'Get milk at the store'.freeze

Given('I am on the Angular2 Todo list page') do
  @browser.visit('http://todomvc.com/examples/angular2/')
end

When('I add a todo item') do
  input_selector = '.new-todo'
  # The following send keys is being used due to the Capybara fill-in method not working
  # My suspicion is because of the Angular interfering with it in some fashion.
  @browser.find(input_selector).native.send_keys(INPUT_TEST_TEXT)
  @browser.find(input_selector).native.send_keys(:return)
end

Then('my todo item is added to my todo list') do
  todo_list = find('.todo-list')
  expect(todo_list).to have_text(INPUT_TEST_TEXT)
end

