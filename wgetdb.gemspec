# encoding: utf-8

Gem::Specification.new do |gem|
  gem.add_dependency 'repository'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.authors = ["Alban Scholer"]
  gem.description = %q{A utility for downloading files directly to my dropbox}
  gem.summary = 'Download resources into a dropbox'
  gem.name = 'wgetdb'
  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README.md']
  gem.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if gem.respond_to? :required_rubygems_version=
  gem.version = '0.0.1'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end

