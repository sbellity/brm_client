# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{brm_client}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephane Bellity"]
  s.date = %q{2011-04-07}
  s.description = %q{BRM Event logging client library}
  s.email = %q{sbellity@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "brm_client.gemspec",
    "lib/brm_client.rb",
    "lib/brm_client/event.rb",
    "lib/brm_client/gateway.rb",
    "lib/brm_client/gateway/amqp.rb",
    "lib/brm_client/gateway/debug.rb",
    "lib/brm_client/gateway/file.rb",
    "lib/brm_client/gateway/http.rb",
    "lib/brm_client/gateway/mongo.rb",
    "lib/brm_client/gateway/stomp.rb",
    "lib/brm_client/logger.rb",
    "spec/brm_client_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/sbellity/brm_client}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{BRM Event logging client}
  s.test_files = [
    "spec/brm_client_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<bunny>, [">= 0"])
      s.add_runtime_dependency(%q<stomp>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.6.1"])
      s.add_runtime_dependency(%q<mongo>, [">= 0.18.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<bunny>, [">= 0"])
      s.add_dependency(%q<stomp>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 1.6.1"])
      s.add_dependency(%q<mongo>, [">= 0.18.3"])
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<bunny>, [">= 0"])
    s.add_dependency(%q<stomp>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 1.6.1"])
    s.add_dependency(%q<mongo>, [">= 0.18.3"])
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end

