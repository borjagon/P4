# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "deepopenstruct"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Gough"]
  s.date = "2010-08-23"
  s.description = "DeepOpenStruct is a simple library for creating easy-to-use data structures from complex sets of nested Hashes and Arrays. It is particularly suitable for creating easy-to-use data structures from YAML files, and as such is a useful tool for creating simple reflective API wrappers."
  s.email = "aaron@aarongough.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/aarongough/deepopenstruct"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A simple library for creating easy-to-use data structures from complex sets of nested Hashes and Arrays"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
