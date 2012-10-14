# encoding: utf-8

Gem::Specification.new do |gem|
  gem.add_dependency 'repository'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.authors = ["Alban Scholer"]
  gem.description = %q{A utility for downloading files directly to my dropbox}
  gem.name = 'wget-db'
  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README.md']
  gem.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if gem.respond_to? :required_rubygems_version=
  gem.version = '0.0.1'
end

