$:.unshift "#{File.dirname(__FILE__)}/../lib"
require "test/unit"
require 'rubygems'
require 'mocha/setup'


def fixtures_path (path)
  File.join(File.dirname(__FILE__), 'fixtures', path)
end
