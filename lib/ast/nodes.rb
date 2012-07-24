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
    # TODO: Implement.
  end

  class ToplevelConstant < Node
    # TODO: Implement.
  end

  class ConstantAccess < Node
    # TODO: Implement.
  end

  class ConstantAssignment < Node
    # TODO: Implement.
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
    # TODO: Implement.
  end

  class While < Node
    # TODO: Implement.
  end

  class Until < While
    # TODO: Implement.
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
    # TODO: Implement.
  end

  class Next < Break
    # TODO: Implement.
  end

  class Redo < Break
    # TODO: Implement.
  end

  class Retry < Break
    # TODO: Implement.
  end

  class Return < Node
    # TODO: Implement.
  end

  # ===== File: data.rb =====

  class EndData < Node
    # TODO: Implement.
  end

  # ===== File: definitions.rb =====

  class Alias < Node
    # TODO: Implement.
  end

  class VAlias < Alias
    # TODO: Implement.
  end

  class Undef < Node
    # TODO: Implement.
  end

  class Block < Node
    # TODO: Implement.
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
    # TODO: Implement.
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
    # TODO: Implement.
  end

  # ===== File: literals.rb =====

  class ArrayLiteral < Node
    # TODO: Implement.
  end

  class EmptyArray < Node
    # TODO: Implement.
  end

  class FalseLiteral < Node
  end

  class TrueLiteral < Node
  end

  class FloatLiteral < Node
    # TODO: Implement.
  end

  class HashLiteral < Node
    # TODO: Implement.
  end

  class SymbolLiteral < Node
    # TODO: Implement.
  end

  class NilLiteral < Node
  end

  class NumberLiteral < Node
    # TODO: Implement.
  end

  class FixnumLiteral < NumberLiteral
    # TODO: Implement.
  end

  class Range < Node
    # TODO: Implement.
  end

  class RangeExclude < Range
    # TODO: Implement.
  end

  class RegexLiteral < Node
    # TODO: Implement.
  end

  class StringLiteral < Node
    # TODO: Implement.
  end

  class DynamicString < StringLiteral
    # TODO: Implement.
  end

  class DynamicSymbol < DynamicString
    # TODO: Implement.
  end

  class DynamicExecuteString < DynamicString
    # TODO: Implement.
  end

  class DynamicRegex < DynamicString
    # TODO: Implement.
  end

  class DynamicOnceRegex < DynamicRegex
    # TODO: Implement.
  end

  class ExecuteString < StringLiteral
    # TODO: Implement.
  end

  # ===== File: operators.rb =====

  class And < Node
    # TODO: Implement.
  end

  class Or < And
    # TODO: Implement.
  end

  class Not < Node
    # TODO: Implement.
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
    # TODO: Implement.
  end

  class SendWithArguments < Send
    # TODO: Implement.
  end

  class AttributeAssignment < SendWithArguments
    # TODO: Implement.
  end

  class ElementAssignment < SendWithArguments
    # TODO: Implement.
  end

  class PreExe < Node
    # TODO: Implement.
  end

  class PreExe19 < PreExe
    # TODO: Implement.
  end

  class PushActualArguments
    # TODO: Implement.
  end

  class BlockPass < Node
    # TODO: Implement.
  end

  class BlockPass19 < BlockPass
    # TODO: Implement.
  end

  class CollectSplat < Node
    # TODO: Implement.
  end

  class ActualArguments < Node
    # TODO: Implement.
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
    # TODO: Implement.
  end

  class ConcatArgs < Node
    # TODO: Implement.
  end

  class PushArgs < Node
    # TODO: Implement.
  end

  class SValue < Node
    # TODO: Implement.
  end

  class ToArray < Node
    # TODO: Implement.
  end

  class ToString < Node
    # TODO: Implement.
  end

  # ===== File: variables.rb =====

  class BackRef < Node
    # TODO: Implement.
  end

  class NthRef < Node
    # TODO: Implement.
  end

  class VariableAccess < Node
    # TODO: Implement.
  end

  class VariableAssignment < Node
    # TODO: Implement.
  end

  class ClassVariableAccess < VariableAccess
    # TODO: Implement.
  end

  class ClassVariableAssignment < VariableAssignment
    # TODO: Implement.
  end

  class ClassVariableDeclaration < ClassVariableAssignment
    # TODO: Implement.
  end

  class CurrentException < Node
    # TODO: Implement.
  end

  class GlobalVariableAccess < VariableAccess
    # TODO: Implement.
  end

  class GlobalVariableAssignment < VariableAssignment
    # TODO: Implement.
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
    # TODO: Implement.
  end

  class InstanceVariableAssignment < VariableAssignment
    # TODO: Implement.
  end

  class LocalVariableAccess < VariableAccess
    # TODO: Implement.
  end

  class LocalVariableAssignment < VariableAssignment
    # TODO: Implement.
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
