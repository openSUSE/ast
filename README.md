AST
===

The AST library makes parsing Ruby in Ruby easier and code processing the
resulting syntax nice and readable. It does that by bringing Rubinius syntax
tree representation to all Ruby implementations.

**Note: This README is just a spec now, a result of [Readme Driven
Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html).
Nothing described here works yet but it will do soon.**

Example
-------

```ruby
"a = 1".to_ast
# => #<AST::LocalVariableAssignment:0xfbc
#      @variable=nil
#      @name=:a
#      @value=#<AST::FixnumLiteral:0xfc0 @value=1 @line=1>
#      @line=1
#    >
```

Motivation
----------

Most existing solutions for parsing Ruby in Ruby available in all common Ruby
implementations (like [ruby_parser](https://github.com/seattlerb/ruby_parser))
use s-expressions to represent the resulting syntax tree:

```ruby
RubyParser.new.parse "a = 1"
# => s(:lasgn, :a, s(:lit, 1))
```

This makes any code processing the tree unnecessarily ugly because it has to
navigate what is basically a bunch of nested arrays.

[Rubinius](http://rubini.us/) uses a different approach and builds the syntax
tree from proper objects — instances of classes representing different types of
nodes:

```ruby
"a = 1".to_ast
# => #<Rubinius::AST::LocalVariableAssignment:0xfbc
#      @variable=nil
#      @name=:a
#      @value=#<Rubinius::AST::FixnumLiteral:0xfc0 @value=1 @line=1>
#      @line=1
#    >
```

The tree may look more complex but any code processing it will be nicer and more
readable than with s-expressions (mainly because it won't have to navigate the
tree using array indices but it will be able to use more descriptive attribute
names).

So we have ugly syntax trees available everywhere and nice syntax trees
available only in Rubinius. The goal of the AST library is to bridge this gap
and allow to use Rubinius syntax tree representation in all Ruby
implementations. It does that by converting a tree produced by ruby_parser into
Rubinius-like format.

Installation
------------

    $ gem install ast

Usage
-----

First, require the library:

```ruby
require "ast"
```

You can now use `String#to_ast` to parse Ruby code and produce a nice syntax
tree:

```ruby
"a = 1".to_ast
# => #<AST::LocalVariableAssignment:0xfbc
#      @variable=nil
#      @name=:a
#      @value=#<AST::FixnumLiteral:0xfc0 @value=1 @line=1>
#      @line=1
#    >
```

The resulting tree is compatible with the one Rubinius produces. The only
difference is that the nodes are in the `AST` module, not `Rubinius::AST`. If
that is a problem for you, there is an easy fix:

```ruby
require "ast/rubinius"
```

Requiring this file will alias the `AST` to `Rubinius::AST` (if `Rubinius::AST`
is not already defined). This way your code can work with trees produced by AST
and Rubinous without any changes.

Compatibility
-------------

AST should run in any environment where ruby_parser does. It currently parses
only 1.8.x code but support for 1.9.x is coming soon.

=== Differences From Rubinius

  * Rubinius parses `__FILE__` as `Rubinius::AST::File` but `AST` parses it as
    `AST::StringLiteral` with the file name already substituted. This is because
    the substitution is done by ruby_parser already and AST can't influence it.
