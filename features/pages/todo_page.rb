require_relative '../support/utils/wait_utils'
class TodoPage < Struct.new(:title)
  include Capybara::DSL
  include WaitUtils

  MAIN_URL = 'http://todomvc.com/examples/angular2/'.freeze
  INPUT_SELECTOR = '.new-todo'.freeze
  TODO_LIST_SELECTOR = '.todo-list'.freeze
  CHECKBOX_SELECTOR = '.toggle'.freeze
  DELETE_BUTTON_SELECTOR = '.destroy'.freeze

  def add_todo_item(text)
    input_box = find(INPUT_SELECTOR)
    # The following send keys is being used due to the Capybara fill-in method not working
    # My suspicion is because of the Angular interfering with it in some fashion.
    input_box.native.send_keys(text)
    # Because of us having to use the send keys above.
    # Capybara is not smart enough to wait for the send keys action to actually finish
    # As such, add a fluent wait to wait until the actual action completes
    wait_until_value(input_box, text)
    input_box.native.send_keys(:return)
  end

  def goto_page
    visit(MAIN_URL)
  end

  def todo_list?
    has_css?(TODO_LIST_SELECTOR)
  end

  def todo_list
    find(TODO_LIST_SELECTOR)
  end

  def todo_items
    todo_list.all('li')
  end

  def todo_item(text)
    todo_items.filter{ |item| item.text == text }.first
  end

  def complete_todo_item!(text)
    # For whatever reason, the checkbox is considered invisible by selenium
    # I have no idea why, it is a thing though.
    todo_item(text)
            .find(CHECKBOX_SELECTOR, visible: false)
            .click
  end 

  def delete_todo_item!(text)
    todo_item(text)
            .hover
            .find(DELETE_BUTTON_SELECTOR)
            .click
  end

  def clear_todo_list!
    goto_page unless current_url == MAIN_URL
    todo_items.reverse.each do |item|
      delete_todo_item(item.text)
    end if todo_list?
  end
end