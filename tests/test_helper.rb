$:.unshift "#{File.dirname(__FILE__)}/../lib"
require "minitest/autorun"
require 'rubygems'

def fixtures_path (path)
  File.join(File.dirname(__FILE__), 'fixtures', path)
end
