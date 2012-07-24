# -*- encoding: utf-8 -*-

require File.expand_path("../lib/ast", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ast"
  s.version     = AST::VERSION
  s.summary     = "A library that makes parsing Ruby in Ruby easier and code processing the resulting syntax nice and readable"
  s.description = <<-EOT.split("\n").map(&:strip).join(" ")
    A library that makes parsing Ruby in Ruby easier and code processing the
    resulting syntax nice and readable. It does that by bringing Rubinius syntax
    tree representation to all Ruby implementations.
  EOT

  s.author      = "David Majda"
  s.email       = "dmajda@suse.de"
  s.homepage    = "https://github.com/openSUSE/ast"
  s.license     = "MIT"

  s.files       = [
    "LICENSE",
    "README.md",
    "VERSION",
    "lib/ast.rb",
    "lib/ast/version.rb",
    "lib/ast/nodes.rb"
  ]

  s.add_development_dependency "rspec"
end
