require 'git'
require 'logger'

class LibFetcher
  def initialize(options={})
    @repo_name     = options[:repo_name]
    @tmp_path      = options[:tmp_path]
    @repo_uri      = options[:repo_uri]
    set_repo
  end

  def set_repo
    begin 
      @repo = Git.open(path, log: Logger.new(STDOUT))
    rescue ArgumentError
      @repo = Git.clone(@repo_uri, @repo_name, path: @tmp_path, logger: Logger.new(STDOUT))
    end
  end

  def path
    File.join(@tmp_path, @repo_name)
  end

  def checkout(ref)
    @repo.checkout(ref)
  end
end
