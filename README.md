# AngularToDoCucumber
This is the UI automation coding example, to demonstrate my ability to do the following.

* Start up a UI automation framework
* Utilize said framework to write working automation
* Show coding style and structure

This utilizes the online test angular service found [here](http://todomvc.com/examples/angular2/)

## Prerequisites
* Install [rbenv](https://github.com/rbenv/rbenv) with [ruby-build](https://github.com/rbenv/ruby-build)

## Install
4. Run `rbenv install`
5. Run `gem install bundler`
6. Run `bundle install`


## Running
* When ready, from a terminal simply run the `bundle exec cucumber` from the root of this repository.
 

# Repository Overiew

## Technologies Used
This makes use of the Selenium framework tool known as [Capybara](https://github.com/teamcapybara/capybara), as well as [Cucumber](https://cucumber.io/) and [RSpec](https://rspec.info/)

## Overall Structure
This project makes use of the page object model to organize concerns into areas that are more maintainable based on sections of the application under test. This can be further expanded on to make use of individual components that may be repeated, or to extract out more complex pieces into their own classes.

### Features
This is where the tests are described in terms of the actions and consequences expected by what we are simulating on behalf of a real user. For now, it is just a features folder, as this expands though, further directories within that directory for organizational purposes can be completed.

### Step Definitions
This is where the glue code connects the Gherkin found in the feature files, to the code being executed. This is also where the page objects are used in order to mimic the actions a real user would take, in a way that is easy to parse for a user, even if they do not know anything about the framework or programming in general.

### Page Objects
This is where we describe the expected types of components on a page, as well as the type of actions we can perform on that page. Utilizing page objects, help reduces code duplication as well as help keep intact the Single Responsibility Principle. Since the page object would be the singular source of truth of what that page represents and what can be done on it.

### Helper Files
These are where various helper classes and methods would go. within the `support` folder, it contains the `env.rb` file, which is automatically loaded and run before `Capybara` runs. As well as the directory `utils`, which contains `wait_utils.rb` This is also where files can be organized and stored that has various helper methods. These can be things such as modified finders, or more specific wait methods that are not built into `Selenium` or `Capybara`, or are insufficent from either.


### Known Places for Improvement
* The `features` folder should have subdirectories created for the various features that are there. In this case, one would be made, simply for the todo list page.
* Due to the limited scope in this area, this one is less crucial. As the project would grow though, doing a full directory glob require may be helpful to avoid the massive amounts of `require` and `require_relative` that would inevitibly begin to happen. An example of what I mean can be found [here](https://stackoverflow.com/a/4528011).
* A spec helper could be added, and used to enable RSpec to enable test shuffling, to help ensure order independance.
