# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{semaphore_classification}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mauricio Gomes"]
  s.date = %q{2010-11-01}
  s.description = %q{Ruby wrapper around the Semaphore Classification Server API.}
  s.email = %q{mauricio@geminisbs.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "VERSION",
     "lib/semaphore.rb",
     "lib/semaphore_classification.rb",
     "lib/semaphore_classification/client.rb",
     "lib/semaphore_classification/connection.rb"
  ]
  s.homepage = %q{http://github.com/geminisbs/semaphore_classification}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby wrapper around the Semaphore Classification Server}
  s.test_files = [
    "spec/semaphore_classification_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4.3.1"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.6.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.4.3.1"])
      s.add_dependency(%q<rest-client>, ["~> 1.6.0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.4.3.1"])
    s.add_dependency(%q<rest-client>, ["~> 1.6.0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

