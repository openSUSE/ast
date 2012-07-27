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

    def process_and(exp)
      And.new exp.line, process(exp[1]), process(exp[2])
    end

    def process_arglist(exp)
      ArrayLiteral.new exp.line, exp[1..-1].map { |e| process(e) }
    end

    def process_attrasgn(exp)
      if exp[2] == :[]=
        ElementAssignment.new exp.line, process(exp[1]), process(exp[3])
      else
        name = exp[2].to_s[0..-2].to_sym
        AttributeAssignment.new exp.line, process(exp[1]), name, process(exp[3])
      end
    end

    def process_array(exp)
      if exp.size == 1
        EmptyArray.new exp.line
      else
        items = exp[1..-1].map { |e| process(e) }

        if items.last.is_a?(SplatValue)
          splat = items.pop
          if items.empty?
            splat
          else
            array = ArrayLiteral.new exp.line, items
            ConcatArgs.new exp.line, array, splat.value
          end
        else
          ArrayLiteral.new exp.line, items
        end
      end
    end

    def process_back_ref(exp)
      BackRef.new exp.line, exp[1]
    end

    def process_break(exp)
      Break.new exp.line, nil
    end

    def process_call(exp)
      if exp[3].size == 1
        if exp[1].nil?
          receiver = Self.new exp.line
          privately = true
        else
          receiver = process(exp[1])
          privately = false
        end

        Send.new exp.line, receiver, exp[2], privately
      else
        SendWithArguments.new exp.line, process(exp[1]), exp[2], process(exp[3])
      end
    end

    def process_cdecl(exp)
      ConstantAssignment.new exp.line, process(exp[1]), process(exp[2])
    end

    def process_colon2(exp)
      ScopedConstant.new exp.line, process(exp[1]), exp[2]
    end

    def process_colon3(exp)
      ToplevelConstant.new exp.line, exp[1]
    end

    def process_const(exp)
      ConstantAccess.new exp.line, exp[1]
    end

    def process_cvar(exp)
      ClassVariableAccess.new exp.line, exp[1]
    end

    def process_cvdecl(exp)
      ClassVariableDeclaration.new exp.line, exp[1], process(exp[2])
    end

    def process_defined(exp)
      Defined.new exp.line, process(exp[1])
    end

    def process_dot2(exp)
      Range.new exp.line, process(exp[1]), process(exp[2])
    end

    def process_dot3(exp)
      RangeExclude.new exp.line, process(exp[1]), process(exp[2])
    end

    def process_dregx(exp)
      flags = exp.last.is_a?(Fixnum) ? exp.pop : nil

      DynamicRegex.new exp.line, exp[1], exp[2..-1].map { |e| process(e) }, flags
    end

    def process_dregx_once(exp)
      flags = exp.last.is_a?(Fixnum) ? exp.pop : nil

      DynamicOnceRegex.new exp.line, exp[1], exp[2..-1].map { |e| process(e) }, flags
    end

    def process_dstr(exp)
      DynamicString.new exp.line, exp[1], exp[2..-1].map { |e| process(e) }
    end

    def process_dsym(exp)
      DynamicSymbol.new exp.line, exp[1], exp[2..-1].map { |e| process(e) }
    end

    def process_dxstr(exp)
      DynamicExecuteString.new exp.line, exp[1], exp[2..-1].map { |e| process(e) }
    end

    def process_evstr(exp)
      if exp[1]
        ToString.new exp.line, process(exp[1])
      else
        StringLiteral.new exp.line, ""
      end
    end

    def process_false(exp)
      FalseLiteral.new exp.line
    end

    def process_gasgn(exp)
      GlobalVariableAssignment.new exp.line, exp[1], process(exp[2])
    end

    def process_gvar(exp)
      GlobalVariableAccess.for_name exp.line, exp[1]
    end

    def process_hash(exp)
      HashLiteral.new exp.line, exp[1..-1].map { |e| process(e) }
    end

    def process_if(exp)
      If.new exp.line, process(exp[1]), process(exp[2]), process(exp[3])
    end

    def process_iasgn(exp)
      InstanceVariableAssignment.new exp.line, exp[1], process(exp[2])
    end

    def process_ivar(exp)
      InstanceVariableAccess.new exp.line, exp[1]
    end

    def process_lasgn(exp)
      LocalVariableAssignment.new exp.line, exp[1], process(exp[2])
    end

    def process_lit(exp)
      case exp[1]
      when Fixnum
        FixnumLiteral.new exp.line, exp[1]
      when Bignum
        NumberLiteral.new exp.line, exp[1]
      when Float
        FloatLiteral.new exp.line, exp[1].to_s
      when Symbol
        SymbolLiteral.new exp.line, exp[1]
      when Regexp
        RegexLiteral.new exp.line, exp[1].source, exp[1].options
      end
    end

    def process_next(exp)
      Next.new exp.line, nil
    end

    def process_not(exp)
      Not.new exp.line, process(exp[1])
    end

    def process_nil(exp)
      NilLiteral.new exp.line
    end

    def process_nth_ref(exp)
      NthRef.new exp.line, exp[1]
    end

    def process_or(exp)
      Or.new exp.line, process(exp[1]), process(exp[2])
    end

    def process_redo(exp)
      Redo.new exp.line
    end

    def process_retry(exp)
      Retry.new exp.line
    end

    def process_return(exp)
      Return.new exp.line, exp[1]
    end

    def process_self(exp)
      Self.new exp.line
    end

    def process_splat(exp)
      SplatValue.new exp.line, process(exp[1])
    end

    def process_str(exp)
      StringLiteral.new exp.line, exp[1]
    end

    def process_true(exp)
      TrueLiteral.new exp.line
    end

    def process_xstr(exp)
      ExecuteString.new exp.line, exp[1]
    end
  end
end
