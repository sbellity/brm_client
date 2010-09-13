require 'rubygems'
require 'rake'

begin
  require 'metric_fu' rescue LoadError
  MetricFu::Configuration.run do |config|
    config.metrics = [:flog, :flay, :reek, :saikuro]
    config.graphs = [:flog, :flay, :reek]
    config.graph_engine = :gchart
  end
rescue LoadError
  puts "Metric_fu (or a dependency) not available. Install it with: gem install metric_fu"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "brm_client"
    gem.summary = "BRM Event logging client"
    gem.description = "BRM Event logging client library"
    gem.email = "sbellity@gmail.com"
    gem.homepage = "http://github.com/sbellity/brm_client"
    gem.authors = ["Stephane Bellity"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_dependency "bunny"
    gem.add_dependency "stomp"
    gem.add_dependency "typhoeus", ">= 0.1.31"
    gem.add_dependency "mongo", ">= 0.18.3"
    gem.add_dependency "activesupport"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "brm_client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
