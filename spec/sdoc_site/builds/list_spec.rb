# require File.expand_path '../../../spec_helper.rb', __FILE__
require File.expand_path '../../../../lib/sdoc_site/builds/list.rb', __FILE__
require 'pry'

describe SDocSite::Builds::List do
  before(:each) do
    SDocSite::Builds::List.any_instance.
      stub(:merged_builds_dirs).and_return(merged_builds_dir)

    SDocSite::Builds::List.any_instance.
      stub(:simple_builds_dirs).and_return(simple_builds_dir)
  end

  context 'has_build?' do
    it 'responds true if simple build present' do
      expect(build_list.build_present?("rails-3.2.14")).to be_true
    end

    it 'responds false if simple build is missing' do
      expect(build_list.build_present?("rails-2.3.13")).to be_false
    end

    it 'responds true if merged build present' do
      expect(build_list.build_present?("rails-3.2.14_ruby-1.9.3")).to be_true
    end

    it 'responds false if merged build missing' do
      expect(build_list.build_present?("rails-2.3.14_ruby-1.9.3")).to be_false
    end
  end

  def build_list
    @build_list ||= SDocSite::Builds::List.new('root')
  end

  def merged_builds_dir
    ["rails-3.2.14_ruby-1.9.3",
     "rails-3.2.14_ruby-2.0.0",
     "rails-4.0.0_ruby-1.9.3",
     "rails-4.0.0_ruby-2.0.0"]
  end

  def simple_builds_dir
    ["rails-3.2.14", "rails-4.0.0", "ruby-1.9.3", "ruby-2.0.0"]
  end
end
