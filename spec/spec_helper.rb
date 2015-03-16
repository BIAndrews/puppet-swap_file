require 'puppetlabs_spec_helper/module_spec_helper'

# SimpleCov does not run on Ruby 1.8.7
unless RUBY_VERSION.to_f < 1.9
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

RSpec.configure do |c|
  
end
