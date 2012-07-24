require "sexp_processor"

module AST
  class Processor < SexpProcessor
    # The processing methods are based on the ones in Rubinius as of this
    # commit:
    #
    #   commit 2539ba92d6a273383578d5a40622ed46472092c6
    #   Author: Dirkjan Bussink <d.bussink@gmail.com>
    #   Date:   Sun Jul 15 14:01:47 2012 -0700
    #
    #       Remove tags for passing specs
    #
    # The methods are in the same order as in lib/melbourne/processor.rb in
    # Rubinius.

    def initialize
      super

      self.require_empty = false
      # It would be better to set AST::Node here but that would require it to
      # have a no-arg constructor -- something I'm not going to introduce just
      # because of SexpProcessor.
      self.expected = Object
    end

    def process_false(exp)
      FalseLiteral.new exp.line
    end

    def process_ivar(exp)
      InstanceVariableAccess.new exp.line, exp[1]
    end

    def process_lit(exp)
      case exp[1]
      when Fixnum
        FixnumLiteral.new exp.line, exp[1]
      when Bignum
        NumberLiteral.new exp.line, exp[1]
      when Float
        FloatLiteral.new exp.line, exp[1].to_s
      end
    end

    def process_nil(exp)
      NilLiteral.new exp.line
    end

    def process_self(exp)
      Self.new exp.line
    end

    def process_true(exp)
      TrueLiteral.new exp.line
    end
  end
end
