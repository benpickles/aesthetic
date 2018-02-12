# Aesthetic

[![Build Status](https://travis-ci.org/benpickles/aesthetic.svg?branch=master)](https://travis-ci.org/benpickles/aesthetic)

Aesthetic is a tool to help you regression-test your site's aesthetic and ensure that tiny CSS changes don't have unintentional side effects in other areas of your site. Aesthetic helps you identify visual changes throughout your site to give you the confidence to freely refactor your CSS from the ground up instead of building up layers of hacks that you'll find time to fix one day.

## Usage with RSpec / Rails

Add `require 'aesthetic/rspec'` in `spec/rails_helper` then in Capybara-driven (feature/system) specs use the `screenshot` helper:

```ruby
require 'rails_helper'

describe 'A feature' do
  describe 'Update account settings' do
    it 'works' do
      visit '/'

      click_link 'My Account'

      # Screenshots are numbered and stored in a directory structure that
      # matches the spec's nesting. In this case the file would be:
      #   screenshots/a_feature/update_account_settings-001.png
      screenshot

      fill_in 'Name', with: 'Bob'
      click_button 'Save'

      # Additional screenshots are added to the same directory with an
      # incremented file name.
      #   screenshots/a_feature/update_account_settings-002.png
      screenshot
    end
  end
end
```
