$KCODE = 'UTF-8' unless RUBY_VERSION >= '1.9'

$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'rubygems'
require 'rake/testtask'
require "sdoc_site/automation"

task default: :test

desc "Run tests"
Rake::TestTask.new("test") do |t|
  t.libs << 'tests'
  t.pattern = 'tests/**/*_test.rb'
  # t.warning = true
  # t.verbose = true
end

desc "Generate sdoc for all new versions"
task :build_new_docs do
  automation.build_new_docs
  Rake::Task['generate_index'].invoke
end

desc "Rebuild sdoc for ENV[name], ENV[version]"
task :rebuild_version do
  automation.rebuild_version ENV["name"], ENV["version"]
  Rake::Task['generate_index'].invoke
end

desc "Generate index.html"
task :generate_index do
  automation.generate_index
end

desc "Merges ENV[builds]"
task :merge_builds do
  automation.merge_builds SDocSite::Builds::MergedBuild.from_str(ENV["builds"])
  Rake::Task['generate_index'].invoke
end

desc "Remerge all merged builds"
task :remerge_all_builds do
  builds.merged_builds.each do |build|
    begin
      ENV['builds'] = build.to_s
      puts `rake merge_builds`
      # a.merge_builds build
      # a.generate_index
      # GC.start
    rescue Exception => e
      puts e.to_s
      puts e.backtrace.to_s
    end
  end
end

desc "Cleanup oldies"
task :cleanup_oldies do
  automation.cleanup_oldies
  Rake::Task['generate_index'].invoke
end

desc "Remerge all merged builds"
task :rebuild_all_docs do
  builds.simple_builds.each do |build|
    build.versions.each do |version|
      begin
        ENV['name'] = build.name
        ENV['version'] = version.to_s
        puts `rake rebuild_version`
        # a.rebuild_version build.name, version.to_s
        # a.generate_index
        # GC.start
      rescue Exception => e
        puts e.to_s
        puts e.backtrace.to_s
      end
    end
  end
end

def docs_path
  File.join('.', 'public', 'doc')
end

def full_path
  File.expand_path(docs_path)
end

def automation
  @automation ||= SDocSite::Automation.new full_path, {:debug => 1}
end

def builds
  @builds ||= SDocSite::Builds::List.new docs_path
end

# `~/code/sdoc/bin/sdoc -N -o rdoc -x irb/output-method.rb -x ext/win32ole/tests/ -x ext/win32ole/sample/ README *.c *.h lib/ ext/`
