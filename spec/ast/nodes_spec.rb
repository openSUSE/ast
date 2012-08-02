require "spec_helper"

module AST
  RSpec.configure do |config|
    config.before(:each, :node => true) do
      @self = Self.new(1)

      @nil = NilLiteral.new(1)

      @i42 = FixnumLiteral.new(1, 42)
      @i43 = FixnumLiteral.new(1, 43)
      @i44 = FixnumLiteral.new(1, 44)
      @i45 = FixnumLiteral.new(1, 45)
      @i46 = FixnumLiteral.new(1, 46)
      @i47 = FixnumLiteral.new(1, 47)

      @sym_a = SymbolLiteral.new(1, :a)
      @sym_b = SymbolLiteral.new(1, :b)
      @sym_c = SymbolLiteral.new(1, :c)

      @array_424344 = ArrayLiteral.new(1, [@i42, @i43, @i44])
    end
  end

  # ===== File: node.rb =====

  describe Node, :node => true do
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

  describe Self, :node => true do
    # Nothing to spec.
  end

  # ===== File: constants.rb =====

  describe TypeConstant, :node => true do
    # TODO: Spec.
  end

  describe ScopedConstant, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ScopedConstant.new(1, @i42, :A)

        node.line.should == 1
        node.parent.should == @i42
        node.name.should == :A
      end
    end
  end

  describe ToplevelConstant, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ToplevelConstant.new(1, :A)

        node.line.should == 1
        node.name.should == :A
      end
    end
  end

  describe ConstantAccess, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ConstantAccess.new(1, :A)

        node.line.should == 1
        node.name.should == :A
      end
    end
  end

  describe ConstantAssignment, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ConstantAssignment.new(1, :a, @i42)

        node.line.should == 1
        node.value.should == @i42
      end

      describe "when passed a symbol as the \"expr\" param" do
        it "sets \"constant\" correctly" do
          node = ConstantAssignment.new(1, :a, @i42)

          node.constant.should == ConstantAccess.new(1, :a)
        end
      end

      describe "when passed something else as the \"expr\" param" do
        it "sets \"constant\" correctly" do
          node = ConstantAssignment.new(1, @i42, @i42)

          node.constant.should == @i42
        end
      end
    end
  end

  # ===== File: control_flow.rb =====

  describe Case, :node => true do
    # TODO: Spec.
  end

  describe ReceiverCase, :node => true do
    # TODO: Spec.
  end

  describe When, :node => true do
    # TODO: Spec.
  end

  describe SplatWhen, :node => true do
    # TODO: Spec.
  end

  describe Flip2, :node => true do
    # TODO: Spec.
  end

  describe Flip3, :node => true do
    # TODO: Spec.
  end

  describe If, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = If.new(1, @i42, @i43, @i44)

        node.line.should == 1
        node.condition.should == @i42
        node.body.should == @i43
        node.else.should == @i44
      end

      it "sets \"body\" to a NilLiteral instance when passed nil \"body\" param" do
        node = If.new(1, @i42, nil, @i44)

        node.body.should == @nil
      end

      it "sets \"else\" to a NilLiteral instance when passed nil \"else_body\" param" do
        node = If.new(1, @i42, @i43, nil)

        node.else.should == @nil
      end
    end
  end

  describe While, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = While.new(1, @i42, @i43, true)

        node.line.should == 1
        node.condition.should == @i42
        node.body.should == @i43
        node.check_first.should == true
      end

      it "sets \"body\" to a NilLiteral instance when passed nil \"body\" param" do
        node = While.new(1, @i42, nil, true)

        node.body.should == @nil
      end
    end
  end

  describe Until, :node => true do
    # Nothing to spec.
  end

  describe Match, :node => true do
    # TODO: Spec.
  end

  describe Match2, :node => true do
    # TODO: Spec.
  end

  describe Match3, :node => true do
    # TODO: Spec.
  end

  describe Break, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Break.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end

      it "sets \"value\" to a NilLiteral instance when passed nil \"expr\" param" do
        node = Break.new(1, nil)

        node.value.should == @nil
      end
    end
  end

  describe Next, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Next.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end
    end
  end

  describe Redo, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Redo.new(1)

        node.line.should == 1
        node.value.should == nil
      end
    end
  end

  describe Retry, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Retry.new(1)

        node.line.should == 1
        node.value.should == nil
      end
    end
  end

  describe Return, :node => true do
    it "sets attributes correctly" do
      node = Return.new(1, @i42)

      node.line.should == 1
      node.value.should == @i42
    end
  end

  # ===== File: data.rb =====

  describe EndData, :node => true do
    # TODO: Spec.
  end

  # ===== File: definitions.rb =====

  describe Alias, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Alias.new(1, @sym_a, @sym_b)

        node.line.should == 1
        node.to.should == @sym_a
        node.from.should == @sym_b
      end
    end
  end

  describe VAlias, :node => true do
    # Nothing to spec.
  end

  describe Undef, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Undef.new(1, @sym_a)

        node.line.should == 1
        node.name.should == @sym_a
      end
    end
  end

  describe Block, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        array = [@i42, @i43, @i44]
        node = Block.new(1, array)

        node.line.should == 1
        node.array.should == array
        node.locals.should == nil
      end
    end
  end

  describe ClosedScope, :node => true do
    # TODO: Spec.
  end

  describe Define, :node => true do
    # TODO: Spec.
  end

  describe DefineSingleton, :node => true do
    # TODO: Spec.
  end

  describe DefineSingletonScope, :node => true do
    # TODO: Spec.
  end

  describe FormalArguments, :node => true do
    # TODO: Spec.
  end

  describe FormalArguments19, :node => true do
    # TODO: Spec.
  end

  describe PatternArguments, :node => true do
    # TODO: Spec.
  end

  describe DefaultArguments, :node => true do
    # TODO: Spec.
  end

  describe BlockArgument, :node => true do
    # TODO: Spec.
  end

  describe Class, :node => true do
    # TODO: Spec.
  end

  describe ClassScope, :node => true do
    # TODO: Spec.
  end

  describe ClassName, :node => true do
    # TODO: Spec.
  end

  describe ToplevelClassName, :node => true do
    # TODO: Spec.
  end

  describe ScopedClassName, :node => true do
    # TODO: Spec.
  end

  describe Module, :node => true do
    # TODO: Spec.
  end

  describe EmptyBody, :node => true do
    # TODO: Spec.
  end

  describe ModuleName, :node => true do
    # TODO: Spec.
  end

  describe ToplevelModuleName, :node => true do
    # TODO: Spec.
  end

  describe ScopedModuleName, :node => true do
    # TODO: Spec.
  end

  describe ModuleScope, :node => true do
    # TODO: Spec.
  end

  describe SClass, :node => true do
    # TODO: Spec.
  end

  describe SClassScope, :node => true do
    # TODO: Spec.
  end

  describe Container, :node => true do
    # TODO: Spec.
  end

  describe EvalExpression, :node => true do
    # TODO: Spec.
  end

  describe Snippet, :node => true do
    # TODO: Spec.
  end

  describe Script, :node => true do
    # TODO: Spec.
  end

  describe Defined, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Defined.new(1, @i42)

        node.line.should == 1
        node.expression.should == @i42
      end
    end
  end

  # ===== File: encoding.rb =====

  describe Encoding, :node => true do
    # TODO: Spec.
  end

  # ===== File: exceptions.rb =====

  describe Begin, :node => true do
    # TODO: Spec.
  end

  describe Ensure, :node => true do
    # TODO: Spec.
  end

  describe Rescue, :node => true do
    # TODO: Spec.
  end

  describe RescueCondition, :node => true do
    # TODO: Spec.
  end

  describe RescueSplat, :node => true do
    # TODO: Spec.
  end

  # ===== File: file.rb =====

  describe File, :node => true do
    # Nothing to spec.
  end

  # ===== File: literals.rb =====

  describe ArrayLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        body = [@i42, @i43, @i44]
        node = ArrayLiteral.new(1, body)

        node.line.should == 1
        node.body.should == body
      end
    end
  end

  describe EmptyArray, :node => true do
    # Nothing to spec.
  end

  describe FalseLiteral, :node => true do
    # Nothing to spec.
  end

  describe TrueLiteral, :node => true do
    # Nothing to spec.
  end

  describe FloatLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = FloatLiteral.new(1, "42.0")

        node.line.should == 1
        node.value.should == 42.0
      end
    end
  end

  describe HashLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        array = [@sym_a, @i42, @sym_b, @i43, @sym_c, @i44]
        node = HashLiteral.new(1, array)

        node.line.should == 1
        node.array.should == array
      end
    end
  end

  describe SymbolLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SymbolLiteral.new(1, :a)

        node.line.should == 1
        node.value.should == :a
      end
    end
  end

  describe NilLiteral, :node => true do
    # Nothing to spec.
  end

  describe NumberLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = NumberLiteral.new(1, 42)

        node.line.should == 1
        node.value.should == 42
      end
    end
  end

  describe FixnumLiteral, :node => true do
    # Nothing to spec.
  end

  describe Range, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        start = NumberLiteral.new(1, 42)
        finish = NumberLiteral.new(1, 43)
        node = Range.new(1, start, finish)

        node.line.should == 1
        node.start.should == start
        node.finish.should == finish
      end
    end
  end

  describe RangeExclude, :node => true do
    # Nothing to spec.
  end

  describe RegexLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = RegexLiteral.new(1, "abcd", 4)

        node.line.should == 1
        node.source.should == "abcd"
        node.options.should == 4
      end
    end
  end

  describe StringLiteral, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = StringLiteral.new(1, "abcd")

        node.line.should == 1
        node.string.should == "abcd"
      end
    end
  end

  describe DynamicString, :node => true do
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

  describe DynamicSymbol, :node => true do
    # Nothing to spec.
  end

  describe DynamicExecuteString, :node => true do
    # Nothing to spec.
  end

  describe DynamicRegex, :node => true do
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

  describe DynamicOnceRegex, :node => true do
    # Nothing to spec.
  end

  describe ExecuteString, :node => true do
    # Nothing to spec.
  end

  # ===== File: operators.rb =====

  describe And, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = And.new(1, @i42, @i43)

        node.line.should == 1
        node.left.should == @i42
        node.right.should == @i43
      end
    end
  end

  describe Or, :node => true do
    # Nothing to spec.
  end

  describe Not, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Not.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end
    end
  end

  describe OpAssign1, :node => true do
    # TODO: Spec.
  end

  describe OpAssign2, :node => true do
    # TODO: Spec.
  end

  describe OpAssignAnd, :node => true do
    # TODO: Spec.
  end

  describe OpAssignOr, :node => true do
    # TODO: Spec.
  end

  describe OpAssignOr19, :node => true do
    # TODO: Spec.
  end

  # ===== File: sends.rb =====

  describe Send, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = Send.new(1, @i42, :foo, true, true)

        node.line.should == 1
        node.receiver.should == @i42
        node.name.should == :foo
        node.privately.should == true
        node.block.should == nil
        node.check_for_local.should == false
        node.vcall_style.should == true
      end

      it "sets \"privately\" to false when not passed the corresonding param" do
        node = Send.new(1, @i42, :foo)

        node.privately.should == false
      end

      it "sets \"vcall_style\" to false when not passed the corresonding param" do
        node = Send.new(1, @i42, :foo, true)

        node.vcall_style.should == false
      end
    end
  end

  describe SendWithArguments, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SendWithArguments.new(1, @i42, :foo, @i42, true)

        node.line.should == 1
        node.receiver.should == @i42
        node.name.should == :foo
        node.privately.should == true
        node.block.should == nil
        node.check_for_local.should == false
        node.vcall_style.should == false
        node.arguments.should == ActualArguments.new(1, @i42)
      end

      it "sets \"privately\" to false when not passed the corresonding param" do
        node = SendWithArguments.new(1, @i42, :foo, @i42)

        node.privately.should == false
      end
    end
  end

  describe AttributeAssignment, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = AttributeAssignment.new(1, @i42, :a, @i42)

        node.line.should == 1
        node.receiver.should == @i42
        node.name.should == :a=
        node.arguments.should == ActualArguments.new(1, @i42)
      end

      describe "when passed a Self instance as the \"receiver\" param" do
        it "sets \"privately\" to true" do
          node = AttributeAssignment.new(1, @self, :a, @i42)

          node.privately.should == true
        end
      end

      describe "when passed something else as the \"receiver\" param" do
        it "sets \"privately\" to false" do
          node = AttributeAssignment.new(1, @i42, :a, @i42)

          node.privately.should == false
        end
      end
    end
  end

  describe ElementAssignment, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ElementAssignment.new(1, @i42, @i42)

        node.line.should == 1
        node.receiver.should == @i42
        node.name.should == :[]=
      end

      describe "when passed a Self instance as the \"receiver\" param" do
        it "sets \"privately\" to true" do
          node = ElementAssignment.new(1, @self, @i42)

          node.privately.should == true
        end
      end

      describe "when passed something else as the \"receiver\" param" do
        it "sets \"privately\" to false" do
          node = ElementAssignment.new(1, @i42, @i42)

          node.privately.should == false
        end
      end

      describe "when passed a PushArgs instance as the \"arguments\" param" do
        it "sets \"arguments\" correctly" do
          arguments = PushArgs.new(
            1,
            ConcatArgs.new(1, @array_424344, @i45),
            @i46
          )
          node = ElementAssignment.new(1, @i42, arguments)

          node.arguments.should == PushActualArguments.new(arguments)
        end
      end

      describe "when passed something else as the \"arguments\" param" do
        it "sets \"arguments\" correctly" do
          node = ElementAssignment.new(1, @i42, @i42)

          node.arguments.should == ActualArguments.new(1, @i42)
        end
      end
    end
  end

  describe PreExe, :node => true do
    # TODO: Spec.
  end

  describe PreExe19, :node => true do
    # TODO: Spec.
  end

  describe PushActualArguments, :node => true do
    before do
      @pa = PushArgs.new(1, ConcatArgs.new(1, @array_424344, @i45), @i46)
    end

    describe "#initialize" do
      it "sets attributes correctly" do
        node = PushActualArguments.new(@pa)

        node.arguments.should == @pa.arguments
        node.value.should == @pa.value
      end
    end

    describe "#==" do
      before do
        @paa = PushActualArguments.new(@pa)
      end

      it "returns true when passed the same object" do
        @paa.should == @paa
      end

      it "returns true when passed a PushActualArguments initialized with the same parameter" do
        @paa.should == PushActualArguments.new(@paa)
      end

      it "returns false when passed some random object" do
        @paa.should_not == Object.new
      end

      it "returns false when passed a subclass of PushActualArguments initialized with the same parameter" do
        class SubclassedPushActualArguments < PushActualArguments
        end

        @paa.should_not == SubclassedPushActualArguments.new(@pa)
      end

      it "returns false when passed a PushActualArguments initialized with a different parameter" do
        pa = PushArgs.new(
          1,
          ConcatArgs.new(
            1,
            ArrayLiteral.new(1, [
              FixnumLiteral.new(1, 84),
              FixnumLiteral.new(1, 86),
              FixnumLiteral.new(1, 88)
            ]),
            FixnumLiteral.new(1, 90)
          ),
          FixnumLiteral.new(1, 92)
        )
        @paa.should_not == PushActualArguments.new(pa)
      end
    end
  end

  describe BlockPass, :node => true do
    # TODO: Spec.
  end

  describe BlockPass19, :node => true do
    # TODO: Spec.
  end

  describe CollectSplat, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        parts = [@i42, @i43, @i44, @i45, @i46]
        node = CollectSplat.new(1, *parts)

        node.line.should == 1
        node.splat.should == parts[0]
        node.last.should == parts[-1]
        node.array.should == parts[1..-2]
      end
    end
  end

  describe ActualArguments, :node => true do
    describe "#initialize" do
      it "sets \"line\" correctly" do
        node = ActualArguments.new(1)

        node.line.should == 1
      end

      describe "when not passed the \"arguments\" param" do
        it "sets \"array\" and \"splat\" correctly" do
          node = ActualArguments.new(1)

          node.array.should == []
          node.splat.should == nil
        end
      end

      describe "when passed a SplatValue instance as the \"arguments\" param" do
        it "sets \"array\" and \"splat\" correctly" do
          arguments = SplatValue.new(1, @i42)
          node = ActualArguments.new(1, arguments)

          node.array.should == []
          node.splat.should == arguments
        end
      end

      describe "when passed a ConcatArgs instance as the \"arguments\" param" do
        describe "and its \"array\" is an ArrayLiteral instance" do
          it "sets \"array\" and \"splat\" correctly" do
            body = [@i42, @i43, @i44]
            node = ActualArguments.new(
              1,
              ConcatArgs.new(1, ArrayLiteral.new(1, body), @i45)
            )

            node.array.should == body
            node.splat.should == SplatValue.new(1, @i45)
          end
        end

        describe "and its \"array\" is an PushArgs instance" do
          it "sets \"array\" and \"splat\" correctly" do
            array = PushArgs.new(1, ConcatArgs.new(1, @array_424344, @i45), @i46)
            node = ActualArguments.new(1, ConcatArgs.new(1, array, @i47))

            node.array.should == []
            node.splat.should ==
              CollectSplat.new(1, array, SplatValue.new(1, @i47))
          end
        end

        describe "and its \"array\" is something else" do
          it "sets \"array\" and \"splat\" correctly" do
            node = ActualArguments.new(1, ConcatArgs.new(1, @i42, @i43))

            node.array.should == []
            node.splat.should == CollectSplat.new(1, @i42, @i43)
          end
        end
      end

      describe "when passed a PushArgs instance as the \"arguments\" param" do
        describe "and its \"arguments\" is a ConcatArgs instance" do
          describe "and calling \"pee_lhs\" on it returns a non-nil value" do
            it "sets \"array\" and \"splat\" correctly" do
              body = [@i42, @i43, @i44]
              arguments = ConcatArgs.new(1, ArrayLiteral.new(1, body), @i45)
              node = ActualArguments.new(1, PushArgs.new(1, arguments, @i46))

              node.array.should == body
              node.splat.should == CollectSplat.new(1, arguments, @i46)
            end
          end

          describe "and calling \"pee_lhs\" on it returns nil" do
            it "sets \"array\" and \"splat\" correctly" do
              arguments = ConcatArgs.new(1, @i42, @i43)
              node = ActualArguments.new(1, PushArgs.new(1, arguments, @i44))

              node.array.should == []
              node.splat.should == CollectSplat.new(1, arguments, @i44)
            end
          end
        end

        describe "and its \"arguments\" is something else" do
          it "sets \"array\" and \"splat\" correctly" do
            node = ActualArguments.new(1, PushArgs.new(1, @i42, @i43))

            node.array.should == []
            node.splat.should == CollectSplat.new(1, @i42, @i43)
          end
        end
      end

      describe "when passed an ArrayLiteral instance as the \"arguments\" param" do
        it "sets \"array\" and \"splat\" correctly" do
          body = [@i42, @i43, @i44]
          node = ActualArguments.new(1, ArrayLiteral.new(1, body))

          node.array.should == body
          node.splat.should == nil
        end
      end

      describe "when passed nil as the \"arguments\" param" do
        it "sets \"array\" and \"splat\" correctly" do
          node = ActualArguments.new(1, nil)

          node.array.should == []
          node.splat.should == nil
        end
      end

      describe "when passed something else as the \"arguments\" param" do
        it "sets \"array\" and \"splat\" correctly" do
          node = ActualArguments.new(1, @i42)

          node.array.should == [@i42]
          node.splat.should == nil
        end
      end
    end
  end

  describe Iter, :node => true do
    # TODO: Spec.
  end

  describe Iter19, :node => true do
    # TODO: Spec.
  end

  describe IterArguments, :node => true do
    # TODO: Spec.
  end

  describe For, :node => true do
    # TODO: Spec.
  end

  describe For19Arguments, :node => true do
    # TODO: Spec.
  end

  describe For19, :node => true do
    # TODO: Spec.
  end

  describe Negate, :node => true do
    # TODO: Spec.
  end

  describe Super, :node => true do
    # TODO: Spec.
  end

  describe Yield, :node => true do
    # TODO: Spec.
  end

  describe ZSuper, :node => true do
    # TODO: Spec.
  end

  # ===== File: values.rb =====

  describe SplatValue, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SplatValue.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end
    end
  end

  describe ConcatArgs, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ConcatArgs.new(1, @array_424344, @i45)

        node.line.should == 1
        node.array.should == @array_424344
        node.rest.should == @i45
      end
    end

    describe "#peel_lhs" do
      before do
        @body = [@i42, @i43, @i44]
      end

      describe "when \"array\" is a ConcatArgs instance" do
        it "calls itself recursively and returns the result" do
          node = ConcatArgs.new(
            1,
            ConcatArgs.new(1, ArrayLiteral.new(1, @body), @i45),
            @i46
          )

          node.peel_lhs.should == @body
        end
      end

      describe "when \"array\" is an ArrayLiteral instance" do
        before do
          @node = ConcatArgs.new(1, ArrayLiteral.new(1, @body), @i45)
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
          node = ConcatArgs.new(1, @i42, @i43)

          node.peel_lhs.should == nil
        end
      end
    end
  end

  describe PushArgs, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        arguments = ConcatArgs.new(1, @array_424344, @i45)
        node = PushArgs.new(1, arguments, @i46)

        node.line.should == 1
        node.arguments.should == arguments
        node.value.should == @i46
      end
    end
  end

  describe SValue, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SValue.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end
    end
  end

  describe ToArray, :node => true do
    # TODO: Spec.
  end

  describe ToString, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = ToString.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end
    end
  end

  # ===== File: variables.rb =====

  describe BackRef, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = BackRef.new(1, :&)

        node.line.should == 1
        node.kind.should == :&
      end
    end
  end

  describe NthRef, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = NthRef.new(1, 42)

        node.line.should == 1
        node.which.should == 42
      end
    end
  end

  describe VariableAccess, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = VariableAccess.new(1, :a)

        node.line.should == 1
        node.name.should == :a
      end
    end
  end

  describe VariableAssignment, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = VariableAssignment.new(1, :a, @i42)

        node.line.should == 1
        node.name.should == :a
        node.value.should == @i42
      end
    end
  end

  describe ClassVariableAccess, :node => true do
    # Nothing to spec.
  end

  describe ClassVariableAssignment, :node => true do
    # Nothing to spec.
  end

  describe ClassVariableDeclaration, :node => true do
    # Nothing to spec.
  end

  describe CurrentException, :node => true do
    # Nothing to spec.
  end

  describe GlobalVariableAccess, :node => true do
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

  describe GlobalVariableAssignment, :node => true do
    # Nothing to spec.
  end

  describe SplatAssignment, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SplatAssignment.new(1, @i42)

        node.line.should == 1
        node.value.should == @i42
      end
    end
  end

  describe SplatArray, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = SplatArray.new(1, @i42, 42)

        node.line.should == 1
        node.value.should == @i42
        node.size.should == 42
      end
    end
  end

  describe SplatWrapped, :node => true do
    # Nothing to spec.
  end

  describe EmptySplat, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = EmptySplat.new(1, 42)

        node.line.should == 1
        node.size.should == 42
      end
    end
  end

  describe InstanceVariableAccess, :node => true do
    # Nothing to spec.
  end

  describe InstanceVariableAssignment, :node => true do
    # Nothing to spec.
  end

  describe LocalVariableAccess, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = LocalVariableAccess.new(1, :a)

        node.line.should == 1
        node.name.should == :a
        node.variable.should == nil
      end
    end
  end

  describe LocalVariableAssignment, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = LocalVariableAssignment.new(1, :a, @i42)

        node.line.should == 1
        node.name.should == :a
        node.value.should == @i42
        node.variable.should == nil
      end
    end
  end

  describe PostArg, :node => true do
    describe "#initialize" do
      it "sets attributes correctly" do
        node = PostArg.new(1, @i42, @array_424344)

        node.line.should == 1
        node.into.should == @i42
        node.rest.should == @array_424344
      end
    end
  end

  describe MultipleAssignment, :node => true do
    # TODO: Spec.
  end

  describe PatternVariable, :node => true do
    # TODO: Spec.
  end

end
