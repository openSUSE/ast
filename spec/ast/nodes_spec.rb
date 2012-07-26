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
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ConstantAccess.new(1, :A)

        node.line.should == 1
        node.name.should == :A
      end
    end
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
    describe "#initialize" do
      it "sets attributes correctly" do
        value = FixnumLiteral.new(1, 42)
        node = Break.new(1, value)

        node.line.should == 1
        node.value.should == value
      end

      it "sets \"value\" to a NilLiteral instance when passed nil \"expr\" param" do
        node = Break.new(1, nil)

        node.value.should == NilLiteral.new(1)
      end
    end
  end

  describe Next do
    describe "#initialize" do
      it "sets attributes correctly" do
        value = FixnumLiteral.new(1, 42)
        node = Next.new(1, value)

        node.line.should == 1
        node.value.should == value
      end
    end
  end

  describe Redo do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Redo.new(1)

        node.line.should == 1
        node.value.should == nil
      end
    end
  end

  describe Retry do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Retry.new(1)

        node.line.should == 1
        node.value.should == nil
      end
    end
  end

  describe Return do
    it "sets attributes correctly" do
      value = FixnumLiteral.new(1, 42)
      node = Return.new(1, value)

      node.line.should == 1
      node.value.should == value
    end
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
    # Nothing to spec.
  end

  # ===== File: literals.rb =====

  describe ArrayLiteral do
    describe "#initialize" do
      it "sets attributes correctly" do
        body = [
          FixnumLiteral.new(1, 42),
          FixnumLiteral.new(1, 43),
          FixnumLiteral.new(1, 44),
        ]
        node = ArrayLiteral.new(1, body)

        node.line.should == 1
        node.body.should == body
      end
    end
  end

  describe EmptyArray do
    # Nothing to spec.
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
    describe "#initialize" do
      it "sets attributes correctly" do
        array = [
          SymbolLiteral.new(1, :a),
          FixnumLiteral.new(1, 42),
          SymbolLiteral.new(1, :b),
          FixnumLiteral.new(1, 43),
          SymbolLiteral.new(1, :c),
          FixnumLiteral.new(1, 44)
        ]
        node = HashLiteral.new(1, array)

        node.line.should == 1
        node.array.should == array
      end
    end
  end

  describe SymbolLiteral do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SymbolLiteral.new(1, :a)

        node.line.should == 1
        node.value.should == :a
      end
    end
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
    describe "#initialize" do
      it "sets attributes correctly" do
        node = RegexLiteral.new(1, "abcd", 4)

        node.line.should == 1
        node.source.should == "abcd"
        node.options.should == 4
      end
    end
  end

  describe StringLiteral do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = StringLiteral.new(1, "abcd")

        node.line.should == 1
        node.string.should == "abcd"
      end
    end
  end

  describe DynamicString do
    describe "#initialize" do
      it "sets attributes correctly" do
        array = [
          ToString.new(1, GlobalVariableAccess.new(1, :$a)),
          StringLiteral.new(1, "efgh")
        ]
        node = DynamicString.new(1, "abcd", array)

        node.line.should == 1
        node.string.should == "abcd"
        node.array.should == array
        node.options.should == nil
      end
    end
  end

  describe DynamicSymbol do
    # Nothing to spec.
  end

  describe DynamicExecuteString do
    # Nothing to spec.
  end

  describe DynamicRegex do
    describe "#initialize" do
      before do
        @array = [
          ToString.new(1, GlobalVariableAccess.new(1, :$a)),
          StringLiteral.new(1, "efgh")
        ]
      end

      it "sets attributes correctly" do
        node = DynamicRegex.new(1, "abcd", @array, 4)

        node.line.should == 1
        node.string.should == "abcd"
        node.array.should == @array
        node.options.should == 4
      end

      it "sets \"options\" to 0 when passed nil \"flags\" param" do
        node = DynamicRegex.new(1, "abcd", @array, nil)

        node.options.should == 0
      end
    end
  end

  describe DynamicOnceRegex do
    # Nothing to spec.
  end

  describe ExecuteString do
    # Nothing to spec.
  end

  # ===== File: operators.rb =====

  describe And do
    # TODO: Spec.
  end

  describe Or do
    # TODO: Spec.
  end

  describe Not do
    describe "#initialize" do
      it "sets attributes correctly" do
        value = FixnumLiteral.new(1, 42)
        node = Not.new(1, value)

        node.line.should == 1
        node.value.should == value
      end
    end
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
    describe "#initialize" do
      before do
        @receiver = FixnumLiteral.new(1, 42)
      end

      it "sets attributes correctly" do
        node = Send.new(1, @receiver, :foo, true, true)

        node.line.should == 1
        node.receiver.should == @receiver
        node.name.should == :foo
        node.privately.should == true
        node.block.should == nil
        node.check_for_local.should == false
        node.vcall_style.should == true
      end

      it "sets \"privately\" to false when not passed the corresonding param" do
        node = Send.new(1, @receiver, :foo)

        node.privately.should == false
      end

      it "sets \"vcall_style\" to false when not passed the corresonding param" do
        node = Send.new(1, @receiver, :foo, true)

        node.vcall_style.should == false
      end
    end
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
    describe "#initialize" do
      it "sets attributes correctly" do
        parts = [
          FixnumLiteral.new(1, 42),
          FixnumLiteral.new(1, 43),
          FixnumLiteral.new(1, 44),
          FixnumLiteral.new(1, 45),
          FixnumLiteral.new(1, 46)
        ]
        node = CollectSplat.new(1, *parts)

        node.line.should == 1
        node.splat.should == parts[0]
        node.last.should == parts[-1]
        node.array.should == parts[1..-2]
      end
    end
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
    describe "#initialize" do
      it "sets attributes correctly" do
        value = FixnumLiteral.new(1, 42)
        node = SplatValue.new(1, value)

        node.line.should == 1
        node.value.should == value
      end
    end
  end

  describe ConcatArgs do
    describe "#initialize" do
      it "sets attributes correctly" do
        array = ArrayLiteral.new(1, [
          FixnumLiteral.new(1, 42),
          FixnumLiteral.new(1, 43),
          FixnumLiteral.new(1, 44)
        ])
        rest = FixnumLiteral.new(1, 45)
        node = ConcatArgs.new(1, array, rest)

        node.line.should == 1
        node.array.should == array
        node.rest.should == rest
      end
    end

    describe "#peel_lhs" do
      before do
        @body = [
          FixnumLiteral.new(1, 42),
          FixnumLiteral.new(1, 43),
          FixnumLiteral.new(1, 44)
        ]
      end

      describe "when \"array\" is a ConcatArgs instance" do
        it "calls itself recursively and returns the result" do
          node = ConcatArgs.new(
            1,
            ConcatArgs.new(
              1,
              ArrayLiteral.new(1, @body),
              FixnumLiteral.new(1, 45)
            ),
            FixnumLiteral.new(1, 46)
          )

          node.peel_lhs.should == @body
        end
      end

      describe "when \"array\" is an ArrayLiteral instance" do
        before do
          @node = ConcatArgs.new(
            1,
            ArrayLiteral.new(1, @body),
            FixnumLiteral.new(1, 45)
          )
        end

        it "returns \"array\"'s body" do
          @node.peel_lhs.should == @body
        end

        it "sets \"array\" to nil" do
          @node.peel_lhs

          @node.array.should == nil
        end
      end

      describe "when \"array\" is something else" do
        it "returns nil" do
          node = ConcatArgs.new(
            1,
            FixnumLiteral.new(1, 42),
            FixnumLiteral.new(1, 43)
          )

          node.peel_lhs.should == nil
        end
      end
    end
  end

  describe PushArgs do
    describe "#initialize" do
      it "sets attributes correctly" do
        arguments = ConcatArgs.new(
          1,
          ArrayLiteral.new(1, [
            FixnumLiteral.new(1, 42),
            FixnumLiteral.new(1, 43),
            FixnumLiteral.new(1, 44)
          ]),
          FixnumLiteral.new(1, 45)
        )
        value = FixnumLiteral.new(1, 46)
        node = PushArgs.new(1, arguments, value)

        node.line.should == 1
        node.arguments.should == arguments
        node.value.should == value
      end
    end
  end

  describe SValue do
    # TODO: Spec.
  end

  describe ToArray do
    # TODO: Spec.
  end

  describe ToString do
    describe "#initialize" do
      it "sets attributes correctly" do
        value = FixnumLiteral.new(1, 42)
        node = ToString.new(1, value)

        node.line.should == 1
        node.value.should == value
      end
    end
  end

  # ===== File: variables.rb =====

  describe BackRef do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = BackRef.new(1, :&)

        node.line.should == 1
        node.kind.should == :&
      end
    end
  end

  describe NthRef do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = NthRef.new(1, 42)

        node.line.should == 1
        node.which.should == 42
      end
    end
  end

  describe VariableAccess do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = VariableAccess.new(1, :a)

        node.line.should == 1
        node.name.should == :a
      end
    end
  end

  describe VariableAssignment do
    # TODO: Spec.
  end

  describe ClassVariableAccess do
    # Nothing to spec.
  end

  describe ClassVariableAssignment do
    # TODO: Spec.
  end

  describe ClassVariableDeclaration do
    # TODO: Spec.
  end

  describe CurrentException do
    # Nothing to spec.
  end

  describe GlobalVariableAccess do
    describe ".for_name" do
      it "returns correct AST node" do
        GlobalVariableAccess.for_name(1, :$!).should ==
          CurrentException.new(1)
        GlobalVariableAccess.for_name(1, :$~).should ==
          BackRef.new(1, :~)
        GlobalVariableAccess.for_name(1, :$LAST_MATCH_INFO).should ==
          BackRef.new(1, :~)
        GlobalVariableAccess.for_name(1, :$MATCH).should ==
          BackRef.new(1, :&)
        GlobalVariableAccess.for_name(1, :$PREMATCH).should ==
          BackRef.new(1, :`)
        GlobalVariableAccess.for_name(1, :$POSTMATCH).should ==
          BackRef.new(1, :"'")
        GlobalVariableAccess.for_name(1, :$LAST_PAREN_MATCH).should ==
          BackRef.new(1, :+)
        GlobalVariableAccess.for_name(1, :$a).should ==
          GlobalVariableAccess.new(1, :$a)
      end
    end
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
    # Nothing to spec.
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
