require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "semaphore_classification"
    gem.summary = %Q{Ruby wrapper around the Semaphore Classification Server}
    gem.description = %Q{Ruby wrapper around the Semaphore Classification Server API.}
    gem.email = "mauricio@geminisbs.com"
    gem.homepage = "http://github.com/geminisbs/semaphore_classification"
    gem.authors = ["Mauricio Gomes"]
    
    gem.add_dependency "nokogiri", "~> 1.4.3.1"
    gem.add_dependency "rest-client", "~> 1.6.0"
    
    gem.add_development_dependency "rspec", ">= 1.2.9"
    
    gem.files = FileList['lib/**/*.rb', 'VERSION', 'LICENSE', "README.rdoc"]
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

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "semaphore_classification #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
