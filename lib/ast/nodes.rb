module AST
  # The node definitions are based on the ones in Rubinius as of this commit:
  #
  #   commit 2539ba92d6a273383578d5a40622ed46472092c6
  #   Author: Dirkjan Bussink <d.bussink@gmail.com>
  #   Date:   Sun Jul 15 14:01:47 2012 -0700
  #
  #       Remove tags for passing specs
  #
  # The files are in the same order as in lib/compiler/ast.rb in Rubinius.
  # The nodes are in the same order as in the files in Rubinius.

  # ===== File: node.rb =====

  class Node
    attr_accessor :line

    def initialize(line)
      @line = line
    end

    # This is not defiend in Rubinius but makes our specs easier to write.
    def ==(other)
      other.instance_of?(self.class) &&
        instance_variables.sort == other.instance_variables.sort &&
        instance_variables.all? do |name|
          instance_variable_get(name) == other.instance_variable_get(name)
        end
    end
  end

  # ===== File: self.rb =====

  class Self < Node
  end

  # ===== File: constants.rb =====

  class TypeConstant < Node
    # TODO: Implement.
  end

  class ScopedConstant < Node
    attr_accessor :parent, :name

    def initialize(line, parent, name)
      @line = line
      @parent = parent
      @name = name
    end
  end

  class ToplevelConstant < Node
    attr_accessor :name

    def initialize(line, name)
      @line = line
      @name = name
    end
  end

  class ConstantAccess < Node
    attr_accessor :name

    def initialize(line, name)
      @line = line
      @name = name
    end
  end

  class ConstantAssignment < Node
    attr_accessor :constant, :value

    def initialize(line, expr, value)
      @line = line
      @value = value

      if expr.kind_of? Symbol
        @constant = ConstantAccess.new line, expr
      else
        @constant = expr
      end
    end
  end

  # ===== File: control_flow.rb =====

  class Case < Node
    # TODO: Implement.
  end

  class ReceiverCase < Case
    # TODO: Implement.
  end

  class When < Node
    # TODO: Implement.
  end

  class SplatWhen < Node
    # TODO: Implement.
  end

  class Flip2 < Node
    # TODO: Implement.
  end

  class Flip3 < Flip2
    # TODO: Implement.
  end

  class If < Node
    attr_accessor :condition, :body, :else

    def initialize(line, condition, body, else_body)
      @line = line
      @condition = condition
      @body = body || NilLiteral.new(line)
      @else = else_body || NilLiteral.new(line)
    end
  end

  class While < Node
    attr_accessor :condition, :body, :check_first

    def initialize(line, condition, body, check_first)
      @line = line
      @condition = condition
      @body = body || NilLiteral.new(line)
      @check_first = check_first
    end
  end

  class Until < While
  end

  class Match < Node
    # TODO: Implement.
  end

  class Match2 < Node
    # TODO: Implement.
  end

  class Match3 < Node
    # TODO: Implement.
  end

  class Break < Node
    attr_accessor :value

    def initialize(line, expr)
      @line = line
      @value = expr || NilLiteral.new(line)
    end
  end

  class Next < Break
    def initialize(line, value)
      @line = line
      @value = value
    end
  end

  class Redo < Break
    def initialize(line)
      @line = line
    end
  end

  class Retry < Break
    def initialize(line)
      @line = line
    end
  end

  class Return < Node
    attr_accessor :value

    def initialize(line, expr)
      @line = line
      @value = expr

      # Rubinius also initializes @splat to nil here. Since @splat can't be
      # accessed from the outside, we skip that.
    end
  end

  # ===== File: data.rb =====

  class EndData < Node
    # TODO: Implement.
  end

  # ===== File: definitions.rb =====

  class Alias < Node
    attr_accessor :to, :from

    def initialize(line, to, from)
      @line = line
      @to = to
      @from = from
    end
  end

  class VAlias < Alias
  end

  class Undef < Node
    attr_accessor :name

    def initialize(line, sym)
      @line = line
      @name = sym
    end
  end

  class Block < Node
    attr_accessor :array, :locals

    def initialize(line, array)
      @line = line
      @array = array
      @locals = nil
    end
  end

  class ClosedScope < Node
    # TODO: Implement.
  end

  class Define < ClosedScope
    # TODO: Implement.
  end

  class DefineSingleton < Node
    # TODO: Implement.
  end

  class DefineSingletonScope < Define
    # TODO: Implement.
  end

  class FormalArguments < Node
    # TODO: Implement.
  end

  class FormalArguments19 < FormalArguments
    # TODO: Implement.
  end

  class PatternArguments < Node
    # TODO: Implement.
  end

  class DefaultArguments < Node
    # TODO: Implement.
  end

  module LocalVariable
    attr_accessor :variable
  end

  class BlockArgument < Node
    # TODO: Implement.
  end

  class Class < Node
    # TODO: Implement.
  end

  class ClassScope < ClosedScope
    # TODO: Implement.
  end

  class ClassName < Node
    # TODO: Implement.
  end

  class ToplevelClassName < ClassName
    # TODO: Implement.
  end

  class ScopedClassName < ClassName
    # TODO: Implement.
  end

  class Module < Node
    # TODO: Implement.
  end

  class EmptyBody < Node
    # TODO: Implement.
  end

  class ModuleName < Node
    # TODO: Implement.
  end

  class ToplevelModuleName < ModuleName
    # TODO: Implement.
  end

  class ScopedModuleName < ModuleName
    # TODO: Implement.
  end

  class ModuleScope < ClosedScope
    # TODO: Implement.
  end

  class SClass < Node
    # TODO: Implement.
  end

  class SClassScope < ClosedScope
    # TODO: Implement.
  end

  class Container < ClosedScope
    # TODO: Implement.
  end

  class EvalExpression < Container
    # TODO: Implement.
  end

  class Snippet < Container
    # TODO: Implement.
  end

  class Script < Container
    # TODO: Implement.
  end

  class Defined < Node
    attr_accessor :expression

    def initialize(line, expr)
      @line = line
      @expression = expr
    end
  end

  # ===== File: encoding.rb =====

  class Encoding < Node
    # TODO: Implement.
  end

  # ===== File: exceptions.rb =====

  class Begin < Node
    # TODO: Implement.
  end

  class Ensure < Node
    # TODO: Implement.
  end

  class Rescue < Node
    # TODO: Implement.
  end

  class RescueCondition < Node
    # TODO: Implement.
  end

  class RescueSplat < Node
    # TODO: Implement.
  end

  # ===== File: file.rb =====

  class File < Node
    # Rubinius parses __FILE__ as Rubinius::AST::File but AST parses it as
    # AST::StringLiteral with the file name already substituted. This is because
    # the substitution is done by ruby_parser already and AST can't influence
    # it. As a result, this class is unused and it is implemented only for
    # compatibility.
  end

  # ===== File: literals.rb =====

  class ArrayLiteral < Node
    attr_accessor :body

    def initialize(line, array)
      @line = line
      @body = array
    end
  end

  class EmptyArray < Node
  end

  class FalseLiteral < Node
  end

  class TrueLiteral < Node
  end

  class FloatLiteral < Node
    attr_accessor :value

    def initialize(line, str)
      @line = line
      @value = str.to_f
    end
  end

  class HashLiteral < Node
    attr_accessor :array

    def initialize(line, array)
      @line = line
      @array = array
    end
  end

  class SymbolLiteral < Node
    attr_accessor :value

    def initialize(line, sym)
      @line = line
      @value = sym
    end
  end

  class NilLiteral < Node
  end

  class NumberLiteral < Node
    attr_accessor :value

    def initialize(line, value)
      @line = line
      @value = value
    end
  end

  class FixnumLiteral < NumberLiteral
    # Rubinius defines "initialize" here in the same way as for NumberLiteral.
    # This is useless so we don't do it.
  end

  class Range < Node
    attr_accessor :start, :finish

    def initialize(line, start, finish)
      @line = line
      @start = start
      @finish = finish
    end
  end

  class RangeExclude < Range
    # Rubinius defines "initialize" here in the same way as for Range. This is
    # useless so we don't do it.
  end

  class RegexLiteral < Node
    attr_accessor :source, :options

    def initialize(line, str, flags)
      @line = line
      @source = str
      @options = flags
    end
  end

  class StringLiteral < Node
    attr_accessor :string

    def initialize(line, str)
      @line = line
      @string = str
    end
  end

  class DynamicString < StringLiteral
    attr_accessor :array, :options

    def initialize(line, str, array)
      @line = line
      @string = str
      @array = array
    end
  end

  class DynamicSymbol < DynamicString
  end

  class DynamicExecuteString < DynamicString
  end

  class DynamicRegex < DynamicString
    def initialize(line, str, array, flags)
      super line, str, array
      @options = flags || 0
    end
  end

  class DynamicOnceRegex < DynamicRegex
  end

  class ExecuteString < StringLiteral
  end

  # ===== File: operators.rb =====

  class And < Node
    attr_accessor :left, :right

    def initialize(line, left, right)
      @line = line
      @left = left
      @right = right
    end
  end

  class Or < And
  end

  class Not < Node
    attr_accessor :value

    def initialize(line, value)
      @line = line
      @value = value
    end
  end

  class OpAssign1 < Node
    # TODO: Implement.
  end

  class OpAssign2 < Node
    # TODO: Implement.
  end

  class OpAssignAnd < Node
    # TODO: Implement.
  end

  class OpAssignOr < OpAssignAnd
    # TODO: Implement.
  end

  class OpAssignOr19 < OpAssignOr
    # TODO: Implement.
  end

  # ===== File: sends.rb =====

  class Send < Node
    # Rubinius does not define an accessor for @vcall_style. We do.
    attr_accessor :receiver, :name, :privately, :block, :variable
    attr_accessor :check_for_local, :vcall_style

    def initialize(line, receiver, name, privately=false, vcall_style=false)
      @line = line
      @receiver = receiver
      @name = name
      @privately = privately
      @block = nil
      @check_for_local = false
      @vcall_style = vcall_style
    end
  end

  class SendWithArguments < Send
    attr_accessor :arguments

    def initialize(line, receiver, name, arguments, privately=false)
      super line, receiver, name, privately
      @arguments = ActualArguments.new line, arguments

      # Rubinius also initializes @block to nil here. Since this is already done
      # in the superclass, we skip that.
    end
  end

  class AttributeAssignment < SendWithArguments
    def initialize(line, receiver, name, arguments)
      @line = line

      @receiver = receiver
      @privately = receiver.kind_of?(Self) ? true : false

      @name = :"#{name}="

      @arguments = ActualArguments.new line, arguments
    end
  end

  class ElementAssignment < SendWithArguments
    def initialize(line, receiver, arguments)
      @line = line

      @receiver = receiver
      @privately = receiver.kind_of?(Self) ? true : false

      @name = :[]=

      case arguments
      when PushArgs
        @arguments = PushActualArguments.new arguments
      else
        @arguments = ActualArguments.new line, arguments
      end
    end
  end

  class PreExe < Node
    # Not used because ruby_parser throws the corresponding s-expression away.
  end

  class PreExe19 < PreExe
    # TODO: Implement.
  end

  class PushActualArguments
    # Rubinius does not define accessors for @arguments and @value. We do.
    attr_accessor :arguments, :value

    def initialize(pa)
      @arguments = pa.arguments
      @value = pa.value
    end

    # This is not defiend in Rubinius but makes our specs easier to write.
    def ==(other)
      other.instance_of?(self.class) &&
        @arguments == other.arguments &&
        @value == other.value
    end
  end

  class BlockPass < Node
    # TODO: Implement.
  end

  class BlockPass19 < BlockPass
    # TODO: Implement.
  end

  class CollectSplat < Node
    # Rubinius does not define accessors for @splat, @last and @array. We do.
    attr_accessor :splat, :last, :array

    def initialize(line, *parts)
      @line = line
      @splat = parts.shift
      @last = parts.pop
      @array = parts
    end
  end

  class ActualArguments < Node
    attr_accessor :array, :splat

    def initialize(line, arguments=nil)
      @line = line
      @splat = nil

      case arguments
      when SplatValue
        @splat = arguments
        @array = []
      when ConcatArgs
        case arguments.array
        when ArrayLiteral
          @array = arguments.array.body
          @splat = SplatValue.new line, arguments.rest
        when PushArgs
          @array = []
          node = SplatValue.new line, arguments.rest
          @splat = CollectSplat.new line, arguments.array, node
        else
          @array = []
          @splat = CollectSplat.new line, arguments.array, arguments.rest
        end
      when PushArgs
        if arguments.arguments.kind_of? ConcatArgs
          if ary = arguments.arguments.peel_lhs
            @array = ary
          else
            @array = []
          end
        else
          @array = []
        end

        @splat = CollectSplat.new line, arguments.arguments, arguments.value
      when ArrayLiteral
        @array = arguments.body
      when nil
        @array = []
      else
        @array = [arguments]
      end
    end
  end

  class Iter < Node
    # TODO: Implement.
  end

  class Iter19 < Iter
    # TODO: Implement.
  end

  class IterArguments < Node
    # TODO: Implement.
  end

  class For < Iter
    # TODO: Implement.
  end

  class For19Arguments < Node
    # TODO: Implement.
  end

  class For19 < For
    # TODO: Implement.
  end

  class Negate < Node
    # TODO: Implement.
  end

  class Super < SendWithArguments
    # TODO: Implement.
  end

  class Yield < SendWithArguments
    # TODO: Implement.
  end

  class ZSuper < Super
    # TODO: Implement.
  end

  # ===== File: values.rb =====

  class SplatValue < Node
    attr_accessor :value

    def initialize(line, value)
      @line = line
      @value = value
    end
  end

  class ConcatArgs < Node
    attr_accessor :array, :rest

    def initialize(line, array, rest)
      @line = line
      @array = array
      @rest = rest
    end

    # Dive down and try to find an array of regular values
    # that could construct the left side of a concatination.
    def peel_lhs
      case @array
      when ConcatArgs
        @array.peel_lhs
      when ArrayLiteral
        ary = @array.body
        @array = nil
        ary
      else
        nil
      end
    end
  end

  class PushArgs < Node
    attr_accessor :arguments, :value

    def initialize(line, arguments, value)
      @line = line
      @arguments = arguments
      @value = value
    end
  end

  class SValue < Node
    attr_accessor :value

    def initialize(line, value)
      @line = line
      @value = value
    end
  end

  class ToArray < Node
    # TODO: Implement.
  end

  class ToString < Node
    attr_accessor :value

    def initialize(line, value)
      @line = line
      @value = value
    end
  end

  # ===== File: variables.rb =====

  class BackRef < Node
    attr_accessor :kind

    def initialize(line, ref)
      @line = line
      @kind = ref
    end
  end

  class NthRef < Node
    attr_accessor :which

    def initialize(line, ref)
      @line = line
      @which = ref
    end
  end

  class VariableAccess < Node
    attr_accessor :name

    def initialize(line, name)
      @line = line
      @name = name
    end
  end

  class VariableAssignment < Node
    attr_accessor :name, :value

    def initialize(line, name, value)
      @line = line
      @name = name
      @value = value
    end
  end

  class ClassVariableAccess < VariableAccess
  end

  class ClassVariableAssignment < VariableAssignment
  end

  class ClassVariableDeclaration < ClassVariableAssignment
  end

  class CurrentException < Node
  end

  class GlobalVariableAccess < VariableAccess
    EnglishBackrefs = {
      :$LAST_MATCH_INFO => :~,
      :$MATCH => :&,
      :$PREMATCH => :'`',
      :$POSTMATCH => :"'",
      :$LAST_PAREN_MATCH => :+,
    }

    def self.for_name(line, name)
      case name
      when :$!
        CurrentException.new(line)
      when :$~
        BackRef.new(line, :~)
      else
        if backref = EnglishBackrefs[name]
          BackRef.new(line, backref)
        else
          new(line, name)
        end
      end
    end
  end

  class GlobalVariableAssignment < VariableAssignment
  end

  class SplatAssignment < Node
    # TODO: Implement.
  end

  class SplatArray < SplatAssignment
    # TODO: Implement.
  end

  class SplatWrapped < SplatAssignment
    # TODO: Implement.
  end

  class EmptySplat < Node
    # TODO: Implement.
  end

  class InstanceVariableAccess < VariableAccess
  end

  class InstanceVariableAssignment < VariableAssignment
  end

  class LocalVariableAccess < VariableAccess
    include LocalVariable

    def initialize(line, name)
      @line = line
      @name = name
      @variable = nil
    end
  end

  class LocalVariableAssignment < VariableAssignment
    include LocalVariable

    def initialize(line, name, value)
      @line = line
      @name = name
      @value = value
      @variable = nil
    end
  end

  class PostArg < Node
    # TODO: Implement.
  end

  class MultipleAssignment < Node
    # TODO: Implement.
  end

  class PatternVariable < Node
    # TODO: Implement.
  end

end
