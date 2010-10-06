require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "finexclub"
    gem.summary = %Q{Little helper to maintain Forex signals and screenshots}
    gem.description = %Q{Finexclub gem stores and retrieves Forex signals and screenshots. It is the heart of the http://trendsonforex.com and http://finexclub.net}
    gem.email = "clubfinex@gmail.com"
    gem.homepage = "http://github.com/alexlevin/finexclub"
    gem.authors = ["Alex Levin"]
    gem.add_development_dependency "bacon", ">= 1.1.0"
    gem.add_development_dependency "facon", ">= 0.4.1"
    gem.add_dependency "mongo", ">= 1.0.8"
    gem.add_dependency "dragonfly", ">= 0.7.6"
    gem.add_dependency "sinatra", ">= 1.0.0"
    gem.add_dependency "awesome_print", ">= 0.2.1"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |spec|
    spec.libs << 'spec'
    spec.pattern = 'spec/**/*_spec.rb'
    spec.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "finexclub #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
