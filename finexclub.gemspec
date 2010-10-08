# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{finexclub}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Levin"]
  s.date = %q{2010-10-08}
  s.default_executable = %q{finexclub_updater}
  s.description = %q{Finexclub gem stores and retrieves Forex signals and screenshots. It is the heart of the http://trendsonforex.com and http://finexclub.net}
  s.email = %q{clubfinex@gmail.com}
  s.executables = ["finexclub_updater"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/finexclub_updater",
     "config.ru",
     "finexclub.gemspec",
     "lib/finexclub.rb",
     "lib/finexclub/app.rb",
     "lib/finexclub/chart.rb",
     "lib/finexclub/core.rb",
     "lib/finexclub/document.rb",
     "lib/finexclub/fabrication.rb",
     "lib/finexclub/images.rb",
     "lib/finexclub/manager.rb",
     "lib/finexclub/signal.rb",
     "lib/finexclub/signals/alpha.rb",
     "lib/finexclub/signals/octopus.rb",
     "lib/finexclub/signals/prognosis.rb",
     "lib/finexclub/signals/zeta.rb",
     "samples/egg.png",
     "spec/finexclub/alpha_spec.rb",
     "spec/finexclub/app_spec.rb",
     "spec/finexclub/chart_spec.rb",
     "spec/finexclub/core_spec.rb",
     "spec/finexclub/document_spec.rb",
     "spec/finexclub/images_spec.rb",
     "spec/finexclub/manager_spec.rb",
     "spec/finexclub/octopus_spec.rb",
     "spec/finexclub/prognosis_spec.rb",
     "spec/finexclub/signal_spec.rb",
     "spec/finexclub/zeta_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/alexlevin/finexclub}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Little helper to maintain Forex signals and screenshots}
  s.test_files = [
    "spec/finexclub/octopus_spec.rb",
     "spec/finexclub/signal_spec.rb",
     "spec/finexclub/manager_spec.rb",
     "spec/finexclub/app_spec.rb",
     "spec/finexclub/alpha_spec.rb",
     "spec/finexclub/core_spec.rb",
     "spec/finexclub/prognosis_spec.rb",
     "spec/finexclub/images_spec.rb",
     "spec/finexclub/chart_spec.rb",
     "spec/finexclub/document_spec.rb",
     "spec/finexclub/zeta_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bacon>, [">= 1.1.0"])
      s.add_development_dependency(%q<facon>, [">= 0.4.1"])
      s.add_runtime_dependency(%q<mongo>, [">= 1.0.8"])
      s.add_runtime_dependency(%q<dragonfly>, [">= 0.7.6"])
      s.add_runtime_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<awesome_print>, [">= 0.2.1"])
    else
      s.add_dependency(%q<bacon>, [">= 1.1.0"])
      s.add_dependency(%q<facon>, [">= 0.4.1"])
      s.add_dependency(%q<mongo>, [">= 1.0.8"])
      s.add_dependency(%q<dragonfly>, [">= 0.7.6"])
      s.add_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_dependency(%q<awesome_print>, [">= 0.2.1"])
    end
  else
    s.add_dependency(%q<bacon>, [">= 1.1.0"])
    s.add_dependency(%q<facon>, [">= 0.4.1"])
    s.add_dependency(%q<mongo>, [">= 1.0.8"])
    s.add_dependency(%q<dragonfly>, [">= 0.7.6"])
    s.add_dependency(%q<sinatra>, [">= 1.0.0"])
    s.add_dependency(%q<awesome_print>, [">= 0.2.1"])
  end
end

