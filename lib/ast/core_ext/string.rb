require "ruby_parser"

class String
  def to_ast
    AST::Processor.new.process(RubyParser.new.parse(self))
  end
end
