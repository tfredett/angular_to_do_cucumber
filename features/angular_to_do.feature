Feature: Angular Todo List

Background:
  Given I am on the Angular2 Todo list page

Scenario: I can add a todo item to my list
  When I add a todo item
  Then my todo item is added to my todo list

Scenario: I can mark complete a todo item on my list
  Given I add a todo item
  When I click the complete checkbox for my todo item
  Then my todo item is marked completed