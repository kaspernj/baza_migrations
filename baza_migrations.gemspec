Gem::Specification.new do |s|
  s.name = "baza_migrations".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["kaspernj".freeze]
  s.date = "2017-01-27"
  s.description = "Migrations support for the Baza database framework in Ruby.".freeze
  s.email = "k@spernj.org".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.homepage = "http://github.com/kaspernj/baza_migrations".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Migrations support for the Baza database framework in Ruby.".freeze

  s.add_runtime_dependency(%q<baza>.freeze, ["~> 0.0.20"])
  s.add_runtime_dependency(%q<string-cases>.freeze, ["~> 0.0.1"])
  s.add_runtime_dependency(%q<auto_autoloader>.freeze, [">= 0"])
  s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, ["= 3.5.0"])
  s.add_development_dependency "rdoc"
  s.add_development_dependency(%q<bundler>.freeze, ["2.3.4"])
  s.add_development_dependency(%q<jdbc-sqlite3>.freeze, [">= 0"])
  s.add_development_dependency(%q<sqlite3>.freeze, ["1.4.4"])
  s.add_development_dependency(%q<wref>.freeze, ["= 0.0.8"])
  s.add_development_dependency "rubocop", "1.41.1"
  s.add_development_dependency "rubocop-performance"
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency(%q<best_practice_project>.freeze, ["= 0.0.10"])
end
