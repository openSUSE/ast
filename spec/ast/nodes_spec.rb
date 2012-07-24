require "spec_helper"

module AST

  # ===== File: node.rb =====

  describe Node do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Node.new(1)

        node.line.should == 1
      end
    end

    describe "#==" do
      class MyNode < Node
        attr_accessor :foo, :bar, :baz, :qux

        def initialize(line, foo = nil, bar = nil, baz = nil, qux = nil)
          @line = line
          @foo = foo if foo
          @bar = bar if bar
          @baz = baz if baz
          @qux = baz if qux
        end
      end

      class MySubclassedNode < MyNode
      end

      before do
        @node = MyNode.new(42, :a, :b, :c)
      end

      it "returns true when passed the same object" do
        @node.should == @node
      end

      it "returns true when passed a MyNode with the same instance variables" do
        @node.should == MyNode.new(42, :a, :b, :c)
      end

      it "returns false when passed some random object" do
        @node.should_not == Object.new
      end

      it "returns false when passed a subclass of MyNode with the same instance variables" do
        @node.should_not == MySubclassedNode.new(42, :a, :b, :c)
      end

      it "returns false when passed a MyNode with different instance variables" do
        @node.should_not == MyNode.new(42, :a, :b)
        @node.should_not == MyNode.new(42, :a, :b, :c, :d)

        @node.should_not == MyNode.new(42, :e, :b, :c)
        @node.should_not == MyNode.new(42, :a, :f, :c)
        @node.should_not == MyNode.new(42, :a, :b, :g)
      end
    end
  end

  # ===== File: self.rb =====

  describe Self do
    # Nothing to spec.
  end

  # ===== File: constants.rb =====

  describe TypeConstant do
    # TODO: Spec.
  end

  describe ScopedConstant do
    # TODO: Spec.
  end

  describe ToplevelConstant do
    # TODO: Spec.
  end

  describe ConstantAccess do
    # TODO: Spec.
  end

  describe ConstantAssignment do
    # TODO: Spec.
  end

  # ===== File: control_flow.rb =====

  describe Case do
    # TODO: Spec.
  end

  describe ReceiverCase do
    # TODO: Spec.
  end

  describe When do
    # TODO: Spec.
  end

  describe SplatWhen do
    # TODO: Spec.
  end

  describe Flip2 do
    # TODO: Spec.
  end

  describe Flip3 do
    # TODO: Spec.
  end

  describe If do
    # TODO: Spec.
  end

  describe While do
    # TODO: Spec.
  end

  describe Until do
    # TODO: Spec.
  end

  describe Match do
    # TODO: Spec.
  end

  describe Match2 do
    # TODO: Spec.
  end

  describe Match3 do
    # TODO: Spec.
  end

  describe Break do
    # TODO: Spec.
  end

  describe Next do
    # TODO: Spec.
  end

  describe Redo do
    # TODO: Spec.
  end

  describe Retry do
    # TODO: Spec.
  end

  describe Return do
    # TODO: Spec.
  end

  # ===== File: data.rb =====

  describe EndData do
    # TODO: Spec.
  end

  # ===== File: definitions.rb =====

  describe Alias do
    # TODO: Spec.
  end

  describe VAlias do
    # TODO: Spec.
  end

  describe Undef do
    # TODO: Spec.
  end

  describe Block do
    # TODO: Spec.
  end

  describe ClosedScope do
    # TODO: Spec.
  end

  describe Define do
    # TODO: Spec.
  end

  describe DefineSingleton do
    # TODO: Spec.
  end

  describe DefineSingletonScope do
    # TODO: Spec.
  end

  describe FormalArguments do
    # TODO: Spec.
  end

  describe FormalArguments19 do
    # TODO: Spec.
  end

  describe PatternArguments do
    # TODO: Spec.
  end

  describe DefaultArguments do
    # TODO: Spec.
  end

  describe BlockArgument do
    # TODO: Spec.
  end

  describe Class do
    # TODO: Spec.
  end

  describe ClassScope do
    # TODO: Spec.
  end

  describe ClassName do
    # TODO: Spec.
  end

  describe ToplevelClassName do
    # TODO: Spec.
  end

  describe ScopedClassName do
    # TODO: Spec.
  end

  describe Module do
    # TODO: Spec.
  end

  describe EmptyBody do
    # TODO: Spec.
  end

  describe ModuleName do
    # TODO: Spec.
  end

  describe ToplevelModuleName do
    # TODO: Spec.
  end

  describe ScopedModuleName do
    # TODO: Spec.
  end

  describe ModuleScope do
    # TODO: Spec.
  end

  describe SClass do
    # TODO: Spec.
  end

  describe SClassScope do
    # TODO: Spec.
  end

  describe Container do
    # TODO: Spec.
  end

  describe EvalExpression do
    # TODO: Spec.
  end

  describe Snippet do
    # TODO: Spec.
  end

  describe Script do
    # TODO: Spec.
  end

  describe Defined do
    # TODO: Spec.
  end

  # ===== File: encoding.rb =====

  describe Encoding do
    # TODO: Spec.
  end

  # ===== File: exceptions.rb =====

  describe Begin do
    # TODO: Spec.
  end

  describe Ensure do
    # TODO: Spec.
  end

  describe Rescue do
    # TODO: Spec.
  end

  describe RescueCondition do
    # TODO: Spec.
  end

  describe RescueSplat do
    # TODO: Spec.
  end

  # ===== File: file.rb =====

  describe File do
    # TODO: Spec.
  end

  # ===== File: literals.rb =====

  describe ArrayLiteral do
    # TODO: Spec.
  end

  describe EmptyArray do
    # TODO: Spec.
  end

  describe FalseLiteral do
    # Nothing to spec.
  end

  describe TrueLiteral do
    # Nothing to spec.
  end

  describe FloatLiteral do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = FloatLiteral.new(1, "42.0")

        node.line.should == 1
        node.value.should == 42.0
      end
    end
  end

  describe HashLiteral do
    # TODO: Spec.
  end

  describe SymbolLiteral do
    # TODO: Spec.
  end

  describe NilLiteral do
    # Nothing to spec.
  end

  describe NumberLiteral do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = NumberLiteral.new(1, 42)

        node.line.should == 1
        node.value.should == 42
      end
    end
  end

  describe FixnumLiteral do
    # Nothing to spec.
  end

  describe Range do
    # TODO: Spec.
  end

  describe RangeExclude do
    # TODO: Spec.
  end

  describe RegexLiteral do
    # TODO: Spec.
  end

  describe StringLiteral do
    # TODO: Spec.
  end

  describe DynamicString do
    # TODO: Spec.
  end

  describe DynamicSymbol do
    # TODO: Spec.
  end

  describe DynamicExecuteString do
    # TODO: Spec.
  end

  describe DynamicRegex do
    # TODO: Spec.
  end

  describe DynamicOnceRegex do
    # TODO: Spec.
  end

  describe ExecuteString do
    # TODO: Spec.
  end

  # ===== File: operators.rb =====

  describe And do
    # TODO: Spec.
  end

  describe Or do
    # TODO: Spec.
  end

  describe Not do
    # TODO: Spec.
  end

  describe OpAssign1 do
    # TODO: Spec.
  end

  describe OpAssign2 do
    # TODO: Spec.
  end

  describe OpAssignAnd do
    # TODO: Spec.
  end

  describe OpAssignOr do
    # TODO: Spec.
  end

  describe OpAssignOr19 do
    # TODO: Spec.
  end

  # ===== File: sends.rb =====

  describe Send do
    # TODO: Spec.
  end

  describe SendWithArguments do
    # TODO: Spec.
  end

  describe AttributeAssignment do
    # TODO: Spec.
  end

  describe ElementAssignment do
    # TODO: Spec.
  end

  describe PreExe do
    # TODO: Spec.
  end

  describe PreExe19 do
    # TODO: Spec.
  end

  describe PushActualArguments do
    # TODO: Spec.
  end

  describe BlockPass do
    # TODO: Spec.
  end

  describe BlockPass19 do
    # TODO: Spec.
  end

  describe CollectSplat do
    # TODO: Spec.
  end

  describe ActualArguments do
    # TODO: Spec.
  end

  describe Iter do
    # TODO: Spec.
  end

  describe Iter19 do
    # TODO: Spec.
  end

  describe IterArguments do
    # TODO: Spec.
  end

  describe For do
    # TODO: Spec.
  end

  describe For19Arguments do
    # TODO: Spec.
  end

  describe For19 do
    # TODO: Spec.
  end

  describe Negate do
    # TODO: Spec.
  end

  describe Super do
    # TODO: Spec.
  end

  describe Yield do
    # TODO: Spec.
  end

  describe ZSuper do
    # TODO: Spec.
  end

  # ===== File: values.rb =====

  describe SplatValue do
    # TODO: Spec.
  end

  describe ConcatArgs do
    # TODO: Spec.
  end

  describe PushArgs do
    # TODO: Spec.
  end

  describe SValue do
    # TODO: Spec.
  end

  describe ToArray do
    # TODO: Spec.
  end

  describe ToString do
    # TODO: Spec.
  end

  # ===== File: variables.rb =====

  describe BackRef do
    # TODO: Spec.
  end

  describe NthRef do
    # TODO: Spec.
  end

  describe VariableAccess do
    # TODO: Spec.
  end

  describe VariableAssignment do
    # TODO: Spec.
  end

  describe ClassVariableAccess do
    # TODO: Spec.
  end

  describe ClassVariableAssignment do
    # TODO: Spec.
  end

  describe ClassVariableDeclaration do
    # TODO: Spec.
  end

  describe CurrentException do
    # TODO: Spec.
  end

  describe GlobalVariableAccess do
    # TODO: Spec.
  end

  describe GlobalVariableAssignment do
    # TODO: Spec.
  end

  describe SplatAssignment do
    # TODO: Spec.
  end

  describe SplatArray do
    # TODO: Spec.
  end

  describe SplatWrapped do
    # TODO: Spec.
  end

  describe EmptySplat do
    # TODO: Spec.
  end

  describe InstanceVariableAccess do
    # TODO: Spec.
  end

  describe InstanceVariableAssignment do
    # TODO: Spec.
  end

  describe LocalVariableAccess do
    # TODO: Spec.
  end

  describe LocalVariableAssignment do
    # TODO: Spec.
  end

  describe PostArg do
    # TODO: Spec.
  end

  describe MultipleAssignment do
    # TODO: Spec.
  end

  describe PatternVariable do
    # TODO: Spec.
  end

end
