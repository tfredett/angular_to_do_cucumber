require_relative '../pages/todo_page.rb'

INPUT_TEST_TEXT = 'Get milk at the store'.freeze

@todo_page = nil

Before do |scenario|
  @todo_page = TodoPage.new
  @todo_page.clear_todo_list!
end

Given('I am on the Angular2 Todo list page') do
  @todo_page.goto_page
end

When('I add a todo item') do
  @todo_page.add_todo_item(INPUT_TEST_TEXT)
end

Then('my todo item is added to my todo list') do
  expect(@todo_page.todo_list).to have_text(INPUT_TEST_TEXT)
end

When('I click the complete checkbox for my todo item') do
  @todo_page.complete_todo_item!(INPUT_TEST_TEXT)
end

Then('my todo item is marked completed') do
  todo_item_classes = @todo_page.todo_item(INPUT_TEST_TEXT)['class']
  expect(todo_item_classes).to eq('completed')
end

When('I click the delete button on my todo item') do
  @todo_page.delete_todo_item!(INPUT_TEST_TEXT)
end

Then('my todo item is removed from the list') do
  expect(@todo_page.todo_list?).to be false
end
