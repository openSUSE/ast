require "spec_helper"

module AST
  describe "parsing" do
    # The specs are based on 1.8.x grammar in Rubinius as of this commit:
    #
    #   commit 2539ba92d6a273383578d5a40622ed46472092c6
    #   Author: Dirkjan Bussink <d.bussink@gmail.com>
    #   Date:   Sun Jul 15 14:01:47 2012 -0700
    #
    #       Remove tags for passing specs

    before do
      @i42 = FixnumLiteral.new(1, 42)
      @i43 = FixnumLiteral.new(1, 43)
      @i44 = FixnumLiteral.new(1, 44)
      @i45 = FixnumLiteral.new(1, 45)
      @i46 = FixnumLiteral.new(1, 46)
      @i47 = FixnumLiteral.new(1, 47)

      @sym_a = SymbolLiteral.new(1, :a)
      @sym_b = SymbolLiteral.new(1, :b)
      @sym_c = SymbolLiteral.new(1, :c)

      @s_empty = StringLiteral.new(1, "")
      @s_abcd = StringLiteral.new(1, "abcd")
      @s_efgh = StringLiteral.new(1, "efgh")
      @s_strings = StringLiteral.new(1, "abcdefghijkl")

      @array_empty = EmptyArray.new(1)
      @array_42 = ArrayLiteral.new(1, [@i42])
      @array_424344 = ArrayLiteral.new(1, [@i42, @i43, @i44])
      @array_abc = ArrayLiteral.new(1, [
        StringLiteral.new(1, "a"),
        StringLiteral.new(1, "b"),
        StringLiteral.new(1, "c")
      ])

      @hash_empty = HashLiteral.new(1, [])
      @hash_a42 = HashLiteral.new(1, [@sym_a, @i42])
      @hash_a42b43c44 = HashLiteral.new(1, [
        @sym_a,
        @i42,
        @sym_b,
        @i43,
        @sym_c,
        @i44
      ])

      @to_s = ToString.new(1, GlobalVariableAccess.new(1, :$a))

      @ds = DynamicString.new(1, "abcd", [@to_s, @s_efgh])

      @not42 = Not.new(1, @i42)
      @not43 = Not.new(1, @i43)
      @not44 = Not.new(1, @i44)
      @not = Not.new(1, @not42)

      @and = And.new(1, @not42, @not43)
      @or = Or.new(1, @not42, @not43)

      @defined = Defined.new(2, Not.new(2, FixnumLiteral.new(2, 42)))

      @if_4243 = If.new(1, @i43, @i42, nil)
      @if_4445 = If.new(1, @i45, @i44, nil)
      @if_4647 = If.new(1, @i47, @i46, nil)

      @block2 = Block.new(1, [@if_4243, @if_4445])
      @block3 = Block.new(1, [@if_4243, @if_4445, @if_4647])
    end

    # Canonical program is "42 if 43; 44 if 45; 46 if 47".
    it "parses program" do
      # compstmt
      '42 if 43; 44 if 45; 46 if 47'.to_ast.should == @block3
    end

    it "parses bodystmt" do
      # compstmt opt_rescue opt_else opt_ensure
      # TODO: Spec.
    end

    # Canonical compstmt is "42 if 43; 44 if 45; 46 if 47".
    it "parses compstmt" do
      # stmts opt_terms
      '42 if 43; 44 if 45; 46 if 47;;;'.to_ast.should == @block3
    end

    # Canonical stmts is "42 if 43; 44 if 45; 46 if 47".
    it "parses stmts" do
      # none
      ''.to_ast.should == nil

      # stmt
      '42 if 43'.to_ast.should == @if_4243

      # stmts terms stmt
      '42 if 43;;;44 if 45;;;46 if 47'.to_ast.should == @block3

      # error stmt
      # Not tested.
    end

    it "parses stmt" do
      # kALIAS fitem fitem
      'alias a b'.to_ast.should == Alias.new(1, @sym_a, @sym_b)

      # kALIAS tGVAR tGVAR
      'alias $a $b'.to_ast.should == VAlias.new(1, :$a, :$b)

      # kALIAS tGVAR tBACK_REF
      'alias $a $&'.to_ast.should == VAlias.new(1, :$a, :$&)

      # kALIAS tGVAR tNTH_REF
      # Produces error => not tested.

      # kUNDEF undef_list
      'undef a, b, c'.to_ast.should == Block.new(1, [
        Undef.new(1, @sym_a),
        Undef.new(1, @sym_b),
        Undef.new(1, @sym_c)
      ])

      # stmt kIF_MOD expr_value
      '42 if 43 if 42'.to_ast.should == If.new(1, @i42, @if_4243, nil)
      '42 if 43 if not 42'.to_ast.should == If.new(1, @i42, nil, @if_4243)

      # stmt kUNLESS_MOD expr_value
      '42 if 43 unless 42'.to_ast.should == If.new(1, @i42, nil, @if_4243)
      '42 if 43 unless not 42'.to_ast.should == If.new(1, @i42, @if_4243, nil)

      # stmt kWHILE_MOD expr_value
      '42 if 43 while 42'.to_ast.should == While.new(1, @i42, @if_4243, true)
      '42 if 43 while not 42'.to_ast.should ==
        Until.new(1, @i42, @if_4243, true)

      # stmt kUNTIL_MOD expr_value
      '42 if 43 until 42'.to_ast.should == Until.new(1, @i42, @if_4243, true)
      '42 if 43 until not 42'.to_ast.should ==
        While.new(1, @i42, @if_4243, true)

      # stmt kRESCUE_MOD stmt
      # TODO: Spec.

      # klBEGIN '{' compstmt '}'

      # Ignored because ruby_parser throws the corresponding s-expression away.
      'BEGIN { 42 if 43; 44 if 45; 46 if 47 }'.to_ast.should == nil

      # klEND '{' compstmt '}'
      # TODO: Spec.

      # lhs '=' command_call
      # TODO: Spec.

      # mlhs '=' command_call
      # TODO: Spec.

      # var_lhs tOP_ASGN command_call
      # TODO: Spec.

      # primary_value '[' aref_args ']' tOP_ASGN command_call
      # TODO: Spec.

      # primary_value '.' tIDENTIFIER tOP_ASGN command_call
      # TODO: Spec.

      # primary_value '.' tCONSTANT tOP_ASGN command_call
      # TODO: Spec.

      # primary_value tCOLON2 tIDENTIFIER tOP_ASGN command_call
      # TODO: Spec.

      # backref tOP_ASGN command_call
      # TODO: Spec.

      # lhs '=' mrhs
      # TODO: Spec.

      # mlhs '=' arg_value
      # TODO: Spec.

      # mlhs '=' mrhs
      # TODO: Spec.

      # expr
      # TODO: Spec.
    end

    it "parses expr" do
      # command_call
      # TODO: Spec.

      # expr kAND expr
      'not 42 and not 43'.to_ast.should == @and

      # expr kOR expr
      'not 42 or not 43'.to_ast.should == @or

      # kNOT expr
      'not not 42'.to_ast.should == @not

      # '!' command_call
      # TODO: Spec.

      # arg
      # TODO: Spec.
    end

    # Canonical expr_value is "not 42".
    it "parses expr_value" do
      # expr
      'not 42'.to_ast.should == @not42
    end

    it "parses command_call" do
      # command
      # TODO: Spec.

      # block_command
      # TODO: Spec.

      # kRETURN call_args
      # TODO: Spec.

      # kBREAK call_args
      # TODO: Spec.

      # kNEXT call_args
      # TODO: Spec.
    end

    it "parses block_command" do
      # block_call
      # TODO: Spec.

      # block_call '.' operation2 command_args
      # TODO: Spec.

      # block_call tCOLON2 operation2 command_args
      # TODO: Spec.
    end

    it "parses cmd_brace_block" do
      # tLBRACE_ARG opt_block_var compstmt '}'
      # TODO: Spec.
    end

    it "parses command" do
      # operation command_args %prec tLOWEST
      # TODO: Spec.

      # operation command_args cmd_brace_block
      # TODO: Spec.

      # primary_value '.' operation2 command_args %prec tLOWEST
      # TODO: Spec.

      # primary_value '.' operation2 command_args cmd_brace_block
      # TODO: Spec.

      # primary_value tCOLON2 operation2 command_args %prec tLOWEST
      # TODO: Spec.

      # primary_value tCOLON2 operation2 command_args cmd_brace_block
      # TODO: Spec.

      # kSUPER command_args
      # TODO: Spec.

      # kYIELD command_args
      # TODO: Spec.
    end

    it "parses mlhs" do
      # mlhs_basic
      # TODO: Spec.

      # tLPAREN mlhs_entry ')'
      # TODO: Spec.
    end

    it "parses mlhs_entry" do
      # mlhs_basic
      # TODO: Spec.

      # tLPAREN mlhs_entry ')'
      # TODO: Spec.
    end

    it "parses mlhs_basic" do
      # mlhs_head
      # TODO: Spec.

      # mlhs_head mlhs_item
      # TODO: Spec.

      # mlhs_head tSTAR mlhs_node
      # TODO: Spec.

      # mlhs_head tSTAR
      # TODO: Spec.

      # tSTAR mlhs_node
      # TODO: Spec.

      # tSTAR
      # TODO: Spec.
    end

    it "parses mlhs_item" do
      # mlhs_node
      # TODO: Spec.

      # tLPAREN mlhs_entry ')'
      # TODO: Spec.
    end

    it "parses mlhs_head" do
      # mlhs_item ','
      # TODO: Spec.

      # mlhs_head mlhs_item ','
      # TODO: Spec.
    end

    it "parses mlhs_node" do
      # variable
      # TODO: Spec.

      # primary_value '[' aref_args ']'
      # TODO: Spec.

      # primary_value '.' tIDENTIFIER
      # TODO: Spec.

      # primary_value tCOLON2 tIDENTIFIER
      # TODO: Spec.

      # primary_value '.' tCONSTANT
      # TODO: Spec.

      # primary_value tCOLON2 tCONSTANT
      # TODO: Spec.

      # tCOLON3 tCONSTANT
      # TODO: Spec.

      # backref
      # TODO: Spec.
    end

    # Canonical lhs is "@a".
    it "parses lhs" do
      # variable
      'a = 42'.to_ast.should == LocalVariableAssignment.new(1, :a, @i42)
      '@a = 42'.to_ast.should == InstanceVariableAssignment.new(1, :@a, @i42)
      '$a = 42'.to_ast.should == GlobalVariableAssignment.new(1, :$a, @i42)
      '@@a = 42'.to_ast.should == ClassVariableDeclaration.new(1, :@@a, @i42)
      # TODO: Test inside def, should build ClassVariableAssignment there.

      # primary_value '[' aref_args ']'
      '(42)[42, 43, 44] = 42'.to_ast.should == ElementAssignment.new(
        1,
        @i42,
        ArrayLiteral.new(1, [@i42, @i43, @i44, @i42])
      )

      # primary_value '.' tIDENTIFIER
      '(42).a = 42'.to_ast.should == AttributeAssignment.new(
        1,
        @i42,
        :a,
        @array_42
      )

      # primary_value tCOLON2 tIDENTIFIER
      '(42)::a = 42'.to_ast.should == AttributeAssignment.new(
        1,
        @i42,
        :a,
        @array_42
      )

      # primary_value '.' tCONSTANT
      '(42).A = 42'.to_ast.should == AttributeAssignment.new(
        1,
        @i42,
        :A,
        @array_42
      )

      # primary_value tCOLON2 tCONSTANT
      '(42)::A = 42'.to_ast.should == ConstantAssignment.new(
        1,
        ScopedConstant.new(1, @i42, :A),
        @i42
      )

      # tCOLON3 tCONSTANT
      '::A = 42'.to_ast.should == ConstantAssignment.new(
        1,
        ToplevelConstant.new(1, :A),
        @i42
      )

      # backref
      # Produces error => not tested.
    end

    it "parses cname" do
      # tIDENTIFIER
      # TODO: Spec.

      # tCONSTANT
      # TODO: Spec.
    end

    it "parses cpath" do
      # tCOLON3 cname
      # TODO: Spec.

      # cname
      # TODO: Spec.

      # primary_value tCOLON2 cname
      # TODO: Spec.
    end

    # Canonical fname is "a".
    it "parses fname" do
      # tIDENTIFIER
      ':a'.to_ast.should == SymbolLiteral.new(1, :a)

      # tCONSTANT
      ':A'.to_ast.should == SymbolLiteral.new(1, :A)

      # tFID
      ':a?'.to_ast.should == SymbolLiteral.new(1, :a?)

      # op
      ':+'.to_ast.should == SymbolLiteral.new(1, :+)

      # reswords
      ':class'.to_ast.should == SymbolLiteral.new(1, :class)
    end

    # Canonical fsym is "a".
    it "parses fsym" do
      # fname
      'undef a'.to_ast.should == Undef.new(1, @sym_a)

      # symbol
      'undef :a'.to_ast.should == Undef.new(1, @sym_a)
    end

    # Canonical fitem is "a".
    it "parses fitem" do
      # fsym
      'undef a'.to_ast.should == Undef.new(1, @sym_a)

      # dsym
      'undef :"a"'.to_ast.should == Undef.new(1, @sym_a)
    end

    # Canonical undef_list is "a, b, c".
    it "parses undef_list" do
      # fitem
      'undef a'.to_ast.should == Undef.new(1, @sym_a)

      # undef_list ',' fitem
      'undef a, b, c'.to_ast.should == Block.new(1, [
        Undef.new(1, @sym_a),
        Undef.new(1, @sym_b),
        Undef.new(1, @sym_c)
      ])
    end

    # Canonical op is "+".
    it "parses op" do
      # '|'
      ':|'.to_ast.should == SymbolLiteral.new(1, :|)

      # '^'
      ':^'.to_ast.should == SymbolLiteral.new(1, :^)

      # '&'
      ':&'.to_ast.should == SymbolLiteral.new(1, :&)

      # tCMP
      ':<=>'.to_ast.should == SymbolLiteral.new(1, :<=>)

      # tEQ
      ':=='.to_ast.should == SymbolLiteral.new(1, :==)

      # tEQQ
      ':==='.to_ast.should == SymbolLiteral.new(1, :===)

      # tMATCH
      ':=~'.to_ast.should == SymbolLiteral.new(1, :=~)

      # '>'
      ':>'.to_ast.should == SymbolLiteral.new(1, :>)

      # tGEQ
      ':>='.to_ast.should == SymbolLiteral.new(1, :>=)

      # '<'
      ':<'.to_ast.should == SymbolLiteral.new(1, :<)

      # tLEQ
      ':<='.to_ast.should == SymbolLiteral.new(1, :<=)

      # tLSHFT
      ':<<'.to_ast.should == SymbolLiteral.new(1, :<<)

      # tRSHFT
      ':>>'.to_ast.should == SymbolLiteral.new(1, :>>)

      # '+'
      ':+'.to_ast.should == SymbolLiteral.new(1, :+)

      # '-'
      ':-'.to_ast.should == SymbolLiteral.new(1, :-)

      # '*'
      ':*'.to_ast.should == SymbolLiteral.new(1, :*)

      # tSTAR
      ':*'.to_ast.should == SymbolLiteral.new(1, :*)

      # '/'
      ':/'.to_ast.should == SymbolLiteral.new(1, :/)

      # '%'
      ':%'.to_ast.should == SymbolLiteral.new(1, :%)

      # tPOW
      ':**'.to_ast.should == SymbolLiteral.new(1, :**)

      # '~'
      ':~'.to_ast.should == SymbolLiteral.new(1, :~)

      # tUPLUS
      ':+@'.to_ast.should == SymbolLiteral.new(1, :+@)

      # tUMINUS
      ':-@'.to_ast.should == SymbolLiteral.new(1, :-@)

      # tAREF
      ':[]'.to_ast.should == SymbolLiteral.new(1, :[])

      # tASET
      ':[]='.to_ast.should == SymbolLiteral.new(1, :[]=)

      # '`'
      ':`'.to_ast.should == SymbolLiteral.new(1, :`)
    end

    # Canonical reswords is "class".
    it "parses reswords" do
      # k__LINE__
      ':__LINE__'.to_ast.should == SymbolLiteral.new(1, :__LINE__)

      # k__FILE__
      ':__FILE__'.to_ast.should == SymbolLiteral.new(1, :__FILE__)

      # klBEGIN
      ':BEGIN'.to_ast.should == SymbolLiteral.new(1, :BEGIN)

      # klEND
      ':END'.to_ast.should == SymbolLiteral.new(1, :END)

      # kALIAS
      ':alias'.to_ast.should == SymbolLiteral.new(1, :alias)

      # kAND
      ':and'.to_ast.should == SymbolLiteral.new(1, :and)

      # kBEGIN
      ':begin'.to_ast.should == SymbolLiteral.new(1, :begin)

      # kBREAK
      ':break'.to_ast.should == SymbolLiteral.new(1, :break)

      # kCASE
      ':case'.to_ast.should == SymbolLiteral.new(1, :case)

      # kCLASS
      ':class'.to_ast.should == SymbolLiteral.new(1, :class)

      # kDEF
      ':def'.to_ast.should == SymbolLiteral.new(1, :def)

      # kDEFINED
      ':defined?'.to_ast.should == SymbolLiteral.new(1, :defined?)

      # kDO
      ':do'.to_ast.should == SymbolLiteral.new(1, :do)

      # kELSE
      ':else'.to_ast.should == SymbolLiteral.new(1, :else)

      # kELSIF
      ':elsif'.to_ast.should == SymbolLiteral.new(1, :elsif)

      # kEND
      ':end'.to_ast.should == SymbolLiteral.new(1, :end)

      # kENSURE
      ':ensure'.to_ast.should == SymbolLiteral.new(1, :ensure)

      # kFALSE
      ':false'.to_ast.should == SymbolLiteral.new(1, :false)

      # kFOR
      ':for'.to_ast.should == SymbolLiteral.new(1, :for)

      # kIN
      ':in'.to_ast.should == SymbolLiteral.new(1, :in)

      # kMODULE
      ':module'.to_ast.should == SymbolLiteral.new(1, :module)

      # kNEXT
      ':next'.to_ast.should == SymbolLiteral.new(1, :next)

      # kNIL
      ':nil'.to_ast.should == SymbolLiteral.new(1, :nil)

      # kNOT
      ':not'.to_ast.should == SymbolLiteral.new(1, :not)

      # kOR
      ':or'.to_ast.should == SymbolLiteral.new(1, :or)

      # kREDO
      ':redo'.to_ast.should == SymbolLiteral.new(1, :redo)

      # kRESCUE
      ':rescue'.to_ast.should == SymbolLiteral.new(1, :rescue)

      # kRETRY
      ':retry'.to_ast.should == SymbolLiteral.new(1, :retry)

      # kRETURN
      ':return'.to_ast.should == SymbolLiteral.new(1, :return)

      # kSELF
      ':self'.to_ast.should == SymbolLiteral.new(1, :self)

      # kSUPER
      ':super'.to_ast.should == SymbolLiteral.new(1, :super)

      # kTHEN
      ':then'.to_ast.should == SymbolLiteral.new(1, :then)

      # kTRUE
      ':true'.to_ast.should == SymbolLiteral.new(1, :true)

      # kUNDEF
      ':undef'.to_ast.should == SymbolLiteral.new(1, :undef)

      # kWHEN
      ':when'.to_ast.should == SymbolLiteral.new(1, :when)

      # kYIELD
      ':yield'.to_ast.should == SymbolLiteral.new(1, :yield)

      # kIF_MOD
      ':if'.to_ast.should == SymbolLiteral.new(1, :if)

      # kUNLESS_MOD
      ':unless'.to_ast.should == SymbolLiteral.new(1, :unless)

      # kWHILE_MOD
      ':while'.to_ast.should == SymbolLiteral.new(1, :while)

      # kUNTIL_MOD
      ':until'.to_ast.should == SymbolLiteral.new(1, :until)

      # kRESCUE_MOD
      ':rescue'.to_ast.should == SymbolLiteral.new(1, :rescue)
    end

    # Canonical arg is "!42".
    it "parses arg" do
      # lhs '=' arg
      '@a = !42'.to_ast.should == InstanceVariableAssignment.new(1, :@a, @not42)

      # lhs '=' arg kRESCUE_MOD arg
      # TODO: Spec.

      # var_lhs tOP_ASGN arg
      '@a += !42'.to_ast.should == InstanceVariableAssignment.new(
        1,
        :@a,
        SendWithArguments.new(
          1,
          InstanceVariableAccess.new(1, :@a),
          :+,
          ArrayLiteral.new(1, [@not42])
        )
      )

      # primary_value '[' aref_args ']' tOP_ASGN arg
      # TODO: Spec.

      # primary_value '.' tIDENTIFIER tOP_ASGN arg
      # TODO: Spec.

      # primary_value '.' tCONSTANT tOP_ASGN arg
      # TODO: Spec.

      # primary_value tCOLON2 tIDENTIFIER tOP_ASGN arg
      # TODO: Spec.

      # primary_value tCOLON2 tCONSTANT tOP_ASGN arg
      # TODO: Spec.

      # tCOLON3 tCONSTANT tOP_ASGN arg
      # TODO: Spec.

      # backref tOP_ASGN arg
      # TODO: Spec.

      # arg tDOT2 arg
      '!42..!43'.to_ast.should == Range.new(1, @not42, @not43)

      # arg tDOT3 arg
      '!42...!43'.to_ast.should == RangeExclude.new(1, @not42, @not43)

      # arg '+' arg
      '!42 + !43'.to_ast.should == SendWithArguments.new(1, @not42, :+, @not43)

      # arg '-' arg
      '!42 - !43'.to_ast.should == SendWithArguments.new(1, @not42, :-, @not43)

      # arg '*' arg
      '!42 * !43'.to_ast.should == SendWithArguments.new(1, @not42, :*, @not43)

      # arg '/' arg
      '!42 / !43'.to_ast.should == SendWithArguments.new(1, @not42, :/, @not43)

      # arg '%' arg
      '!42 % !43'.to_ast.should == SendWithArguments.new(1, @not42, :%, @not43)

      # arg tPOW arg
      '!42 ** !43'.to_ast.should ==
        SendWithArguments.new(1, @not42, :**, @not43)

      # tUMINUS_NUM tINTEGER tPOW arg
      '-42 ** !43'.to_ast.should == Send.new(
        1,
        SendWithArguments.new(1, @i42, :**, @not43),
        :-@
      )

      # tUMINUS_NUM tFLOAT tPOW arg
      '-42.0 ** !43'.to_ast.should == Send.new(
        1,
        SendWithArguments.new(1, FloatLiteral.new(1, 42.0), :**, @not43),
        :-@
      )

      # tUPLUS arg
      '+!42'.to_ast.should == Send.new(1, @not42, :+@)

      # tUMINUS arg
      '-!42'.to_ast.should == Send.new(1, @not42, :-@)

      # arg '|' arg
      '!42 | !43'.to_ast.should == SendWithArguments.new(1, @not42, :|, @not43)

      # arg '^' arg
      '!42 ^ !43'.to_ast.should == SendWithArguments.new(1, @not42, :^, @not43)

      # arg '&' arg
      '!42 & !43'.to_ast.should == SendWithArguments.new(1, @not42, :&, @not43)

      # arg tCMP arg
      '!42 <=> !43'.to_ast.should == SendWithArguments.new(1, @not42, :<=>, @not43)

      # arg '>' arg
      '!42 > !43'.to_ast.should == SendWithArguments.new(1, @not42, :>, @not43)

      # arg tGEQ arg
      '!42 >= !43'.to_ast.should == SendWithArguments.new(1, @not42, :>=, @not43)

      # arg '<' arg
      '!42 < !43'.to_ast.should == SendWithArguments.new(1, @not42, :<, @not43)

      # arg tLEQ arg
      '!42 <= !43'.to_ast.should == SendWithArguments.new(1, @not42, :<=, @not43)

      # arg tEQ arg
      '!42 == !43'.to_ast.should == SendWithArguments.new(1, @not42, :==, @not43)

      # arg tEQQ arg
      '!42 === !43'.to_ast.should == SendWithArguments.new(1, @not42, :===, @not43)

      # arg tNEQ arg
      '!42 != !43'.to_ast.should == Not.new(1, SendWithArguments.new(1, @not42, :==, @not43))

      # arg tMATCH arg
      '!42 =~ !43'.to_ast.should == SendWithArguments.new(1, @not42, :=~, @not43)

      # arg tNMATCH arg
      '!42 !~ !43'.to_ast.should == Not.new(1, SendWithArguments.new(1, @not42, :=~, @not43))

      # '!' arg
      '!!42'.to_ast.should == @not

      # '~' arg
      '~!42'.to_ast.should == Send.new(1, @not42, :~)

      # arg tLSHFT arg
      '!42 << !43'.to_ast.should == SendWithArguments.new(1, @not42, :<<, @not43)

      # arg tRSHFT arg
      '!42 >> !43'.to_ast.should == SendWithArguments.new(1, @not42, :>>, @not43)

      # arg tANDOP arg
      '!42 && !43'.to_ast.should == @and

      # arg tOROP arg
      '!42 || !43'.to_ast.should == @or

      # kDEFINED opt_nl arg
      "defined?\n!42".to_ast.should == @defined

      # arg '?' arg ":" arg
      '!42 ? !43 : !44'.to_ast.should == If.new(1, @not42, @not43, @not44)

      # primary
      # TODO: Spec.
    end

    # Canonical arg_value is "!42".
    it "parses arg_value" do
      # arg
      '!42'.to_ast.should == @not42
    end

    it "parses aref_args" do
      # none
      '[]'.to_ast.should == @array_empty

      # command opt_nl
      # TODO: Spec.

      # args trailer
      '[42, 43, 44,]'.to_ast.should == @array_424344

      # args ',' tSTAR arg opt_nl

      # In Rubinius, all the nodes are at line 1, but ruby_parses does not think
      # so.
      "[42, 43, 44, *!45\n]".to_ast.should ==
        ConcatArgs.new(1, @array_424344, Not.new(2, @i45))

      # assocs trailer
      '[:a => 42, :b => 43, :c => 44,]'.to_ast.should ==
        ArrayLiteral.new(1, [@hash_a42b43c44])

      # tSTAR arg opt_nl

      # In Rubinius, all the nodes are at line 1, but ruby_parses does not think
      # so.
      "[*!42\n]".to_ast.should == SplatValue.new(2, Not.new(2, @i42))
    end

    it "parses paren_args" do
      # '(' none ')'
      # TODO: Spec.

      # '(' call_args opt_nl ')'
      # TODO: Spec.

      # '(' block_call opt_nl ')'
      # TODO: Spec.

      # '(' args ',' block_call opt_nl ')'
      # TODO: Spec.
    end

    it "parses opt_paren_args" do
      # none
      # TODO: Spec.

      # paren_args
      # TODO: Spec.
    end

    it "parses call_args" do
      # command
      # TODO: Spec.

      # args opt_block_arg
      # TODO: Spec.

      # args ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # assocs opt_block_arg
      # TODO: Spec.

      # assocs ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # args ',' assocs opt_block_arg
      # TODO: Spec.

      # args ',' assocs ',' tSTAR arg opt_block_arg
      # TODO: Spec.

      # tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # block_arg
      # TODO: Spec.
    end

    it "parses call_args2" do
      # arg_value ',' args opt_block_arg
      # TODO: Spec.

      # arg_value ',' block_arg
      # TODO: Spec.

      # arg_value ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # arg_value ',' args ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # assocs opt_block_arg
      # TODO: Spec.

      # assocs ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # arg_value ',' assocs opt_block_arg
      # TODO: Spec.

      # arg_value ',' args ',' assocs opt_block_arg
      # TODO: Spec.

      # arg_value ',' assocs ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # arg_value ',' args ',' assocs ',' tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # tSTAR arg_value opt_block_arg
      # TODO: Spec.

      # block_arg
      # TODO: Spec.
    end

    it "parses command_args" do
      # open_args
      # TODO: Spec.
    end

    it "parses open_args" do
      # call_args
      # TODO: Spec.

      # tLPAREN_ARG ')'
      # TODO: Spec.

      # tLPAREN_ARG call_args2 ')'
      # TODO: Spec.
    end

    it "parses block_arg" do
      # tAMPER arg_value
      # TODO: Spec.
    end

    it "parses opt_block_arg" do
      # ',' block_arg
      # TODO: Spec.

      # none
      # TODO: Spec.
    end

    it "parses args" do
      # arg_value
      # TODO: Spec.

      # args ',' arg_value
      # TODO: Spec.
    end

    it "parses mrhs" do
      # args ',' arg_value
      # TODO: Spec.

      # args ',' tSTAR arg_value
      # TODO: Spec.

      # tSTAR arg_value
      # TODO: Spec.
    end

    it "parses primary" do
      # literal
      '42'.to_ast.should == @i42

      # strings
      '"abcd" "efgh" "ijkl"'.to_ast.should == @s_strings

      # xstring
      '`abcd`'.to_ast.should == ExecuteString.new(1, "abcd")

      # regexp
      '/abcd/'.to_ast.should == RegexLiteral.new(1, "abcd", 0)

      # words
      '%W(a b c)'.to_ast.should == @array_abc

      # qwords
      '%w(a b c)'.to_ast.should == @array_abc

      # var_ref
      '@a'.to_ast.should == InstanceVariableAccess.new(1, :@a)

      # backref
      '$&'.to_ast.should == BackRef.new(1, :&)

      # tFID
      'a?'.to_ast.should == Send.new(1, Self.new(1), :a?, true)

      # kBEGIN bodystmt kEND
      # TODO: Spec.

      # tLPAREN_ARG expr opt_nl ')'
      "((42)\n)".to_ast.should == @i42

      # tLPAREN compstmt ')'
      # TODO: Spec.

      # primary_value tCOLON2 tCONSTANT
      '(42)::A'.to_ast.should == ScopedConstant.new(1, @i42, :A)

      # tCOLON3 tCONSTANT
      '::A'.to_ast.should == ToplevelConstant.new(1, :A)

      # primary_value '[' aref_args ']'
      '(42)[42, 43, 44]'.to_ast.should ==
        SendWithArguments.new(1, @i42, :[], @array_424344)

      # tLBRACK aref_args ']'
      '[42, 43, 44]'.to_ast.should == @array_424344

      # tLBRACE assoc_list '}'
      '{ :a => 42, :b => 43, :c => 44 }'.to_ast.should == @hash_a42b43c44

      # kRETURN
      'return'.to_ast.should == Return.new(1, nil)

      # kYIELD '(' call_args ')'
      # TODO: Spec.

      # kYIELD '(' ')'
      # TODO: Spec.

      # kYIELD
      # TODO: Spec.

      # kDEFINED opt_nl '(' expr ')'
      "defined?\n(not 42)".to_ast.should == @defined

      # operation brace_block
      # TODO: Spec.

      # method_call
      # TODO: Spec.

      # method_call brace_block
      # TODO: Spec.

      # kIF expr_value then compstmt if_tail kEND
      # TODO: Spec.

      # kUNLESS expr_value then compstmt opt_else kEND
      # TODO: Spec.

      # kWHILE expr_value do compstmt kEND
      # TODO: Spec.

      # kUNTIL expr_value do compstmt kEND
      # TODO: Spec.

      # kCASE expr_value opt_terms case_body kEND
      # TODO: Spec.

      # kCASE opt_terms case_body kEND
      # TODO: Spec.

      # kCASE opt_terms kELSE compstmt kEND
      # TODO: Spec.

      # kFOR for_var kIN expr_value do compstmt kEND
      # TODO: Spec.

      # kCLASS cpath superclass bodystmt kEND
      # TODO: Spec.

      # kCLASS tLSHFT expr term bodystmt kEND
      # TODO: Spec.

      # kMODULE cpath bodystmt kEND
      # TODO: Spec.

      # kDEF fname f_arglist bodystmt kEND
      # TODO: Spec.

      # kDEF singleton dot_or_colon fname f_arglist bodystmt kEND
      # TODO: Spec.

      # kBREAK
      'break'.to_ast.should == Break.new(1, nil)

      # kNEXT
      'next'.to_ast.should == Next.new(1, nil)

      # kREDO
      'redo'.to_ast.should == Redo.new(1)

      # kRETRY
      'retry'.to_ast.should == Retry.new(1)
    end

    # Canonical primary_value is "(42)".
    it "parses primary_value" do
      # primary
      '(42)'.to_ast.should == @i42
    end

    it "parses then" do
      # term
      # TODO: Spec.

      # ':'
      # TODO: Spec.

      # kTHEN
      # TODO: Spec.

      # term kTHEN
      # TODO: Spec.
    end

    it "parses do" do
      # term
      # TODO: Spec.

      # ':'
      # TODO: Spec.

      # kDO_COND
      # TODO: Spec.
    end

    it "parses if_tail" do
      # opt_else
      # TODO: Spec.

      # kELSIF expr_value then compstmt if_tail
      # TODO: Spec.
    end

    it "parses opt_else" do
      # none
      # TODO: Spec.

      # kELSE compstmt
      # TODO: Spec.
    end

    it "parses for_var" do
      # lhs
      # TODO: Spec.

      # mlhs
      # TODO: Spec.
    end

    it "parses block_par" do
      # mlhs_item
      # TODO: Spec.

      # block_par ',' mlhs_item
      # TODO: Spec.
    end

    it "parses block_var" do
      # block_par
      # TODO: Spec.

      # block_par ','
      # TODO: Spec.

      # block_par ',' tAMPER lhs
      # TODO: Spec.

      # block_par ',' tSTAR lhs ',' tAMPER lhs
      # TODO: Spec.

      # block_par ',' tSTAR ',' tAMPER lhs
      # TODO: Spec.

      # block_par ',' tSTAR lhs
      # TODO: Spec.

      # block_par ',' tSTAR
      # TODO: Spec.

      # tSTAR lhs ',' tAMPER lhs
      # TODO: Spec.

      # tSTAR ',' tAMPER lhs
      # TODO: Spec.

      # tSTAR lhs
      # TODO: Spec.

      # tSTAR
      # TODO: Spec.

      # tAMPER lhs
      # TODO: Spec.
    end

    it "parses opt_block_var" do
      # none
      # TODO: Spec.

      # '|' /* none */ '|'
      # TODO: Spec.

      # tOROP
      # TODO: Spec.

      # '|' block_var '|'
      # TODO: Spec.
    end

    it "parses do_block" do
      # kDO_BLOCK opt_block_var compstmt kEND
      # TODO: Spec.
    end

    it "parses block_call" do
      # command do_block
      # TODO: Spec.

      # block_call '.' operation2 opt_paren_args
      # TODO: Spec.

      # block_call tCOLON2 operation2 opt_paren_args
      # TODO: Spec.
    end

    it "parses method_call" do
      # operation paren_args
      # TODO: Spec.

      # primary_value '.' operation2 opt_paren_args
      # TODO: Spec.

      # primary_value tCOLON2 operation2 paren_args
      # TODO: Spec.

      # primary_value tCOLON2 operation3
      # TODO: Spec.

      # primary_value '\\' operation2
      # TODO: Spec.

      # tUBS operation2
      # TODO: Spec.

      # kSUPER paren_args
      # TODO: Spec.

      # kSUPER
      # TODO: Spec.
    end

    it "parses brace_block" do
      # '{' opt_block_var compstmt '}'
      # TODO: Spec.

      # kDO opt_block_var compstmt kEND
      # TODO: Spec.
    end

    it "parses case_body" do
      # kWHEN when_args then compstmt cases
      # TODO: Spec.
    end

    it "parses when_args" do
      # args
      # TODO: Spec.

      # args ',' tSTAR arg_value
      # TODO: Spec.

      # tSTAR arg_value
      # TODO: Spec.
    end

    it "parses cases" do
      # opt_else
      # TODO: Spec.

      # case_body
      # TODO: Spec.
    end

    it "parses opt_rescue" do
      # kRESCUE exc_list exc_var then compstmt opt_rescue
      # TODO: Spec.

      # none
      # TODO: Spec.
    end

    it "parses exc_list" do
      # arg_value
      # TODO: Spec.

      # mrhs
      # TODO: Spec.

      # none
      # TODO: Spec.
    end

    it "parses exc_var" do
      # tASSOC lhs
      # TODO: Spec.

      # none
      # TODO: Spec.
    end

    it "parses opt_ensure" do
      # kENSURE compstmt
      # TODO: Spec.

      # none
      # TODO: Spec.
    end

    # Canonical literal is "42".
    it "parses literal" do
      # numeric
      '42'.to_ast.should == @i42

      # symbol
      ':a'.to_ast.should == @sym_a

      # dsym
      ':"a"'.to_ast.should == @sym_a
    end

    # Canonical strings is "\"abcd\" \"efgh\" \"ijkl\"".
    it "parses strings" do
      # string
      '"abcd" "efgh" "ijkl"'.to_ast.should == @s_strings
    end

    # Canonical string is "\"abcd\" \"efgh\" \"ijkl\"".
    it "parses string" do
      # string1
      '"abcd"'.to_ast.should == @s_abcd

      # string string1
      '"abcd" "efgh" "ijkl"'.to_ast.should == @s_strings
    end

    # Canonical string1 is "\"abcd\"".
    it "parses string1" do
      # tSTRING_BEG string_contents tSTRING_END
      '"abcd"'.to_ast.should == @s_abcd
      '"abcd#{$a}efgh"'.to_ast.should == @ds
    end

    # Canonical xstring is "`abcd`".
    it "parses xstring" do
      # tXSTRING_BEG xstring_contents tSTRING_END
      '`abcd`'.to_ast.should == ExecuteString.new(1, "abcd")
      '`abcd#{$a}efgh`'.to_ast.should ==
        DynamicExecuteString.new(1, "abcd", [@to_s, @s_efgh])
    end

    # Canonical regexp is "/abcd/".
    it "parses regexp" do
      # tREGEXP_BEG xstring_contents tREGEXP_END
      '/abcd/'.to_ast.should == RegexLiteral.new(1, "abcd", 0)
      '/abcd#{$a}efgh/'.to_ast.should ==
        DynamicRegex.new(1, "abcd", [@to_s, @s_efgh], 0)
      '/abcd#{$a}efgh/m'.to_ast.should ==
        DynamicRegex.new(1, "abcd", [@to_s, @s_efgh], 4)
      '/abcd#{$a}efgh/o'.to_ast.should ==
        DynamicOnceRegex.new(1, "abcd", [@to_s, @s_efgh], 0)
      '/abcd#{$a}efgh/om'.to_ast.should ==
        DynamicOnceRegex.new(1, "abcd", [@to_s, @s_efgh], 4)
    end

    # Canonical words is "%W(a b c)".
    it "parses words" do
      # tWORDS_BEG ' ' tSTRING_END
      '%W( )'.to_ast.should == @array_empty

      # tWORDS_BEG word_list tSTRING_END
      '%W(a b c)'.to_ast.should == @array_abc
    end

    # Canonical word_list is "a b c".
    it "parses word_list" do
      # /* none */
      '%W()'.to_ast.should == @array_empty

      # word_list word ' '
      '%W(a b c)'.to_ast.should == @array_abc
    end

    # Canonical word is "abcd".
    it "parses word" do
      # string_content
      '%W(abcd)'.to_ast.should == ArrayLiteral.new(1, [@s_abcd])

      # word string_content
      '%W(abcd#{$a}efgh)'.to_ast.should == ArrayLiteral.new(1, [@ds])
    end

    # Canonical qwords is "%w(a b c)".
    it "parses qwords" do
      # tQWORDS_BEG ' ' tSTRING_END
      '%w( )'.to_ast.should == @array_empty

      # tQWORDS_BEG qword_list tSTRING_END
      '%w(a b c)'.to_ast.should == @array_abc
    end

    # Canonical qword_list is "a b c".
    it "parses qword_list" do
      # /* none */
      '%w()'.to_ast.should == @array_empty

      # qword_list tSTRING_CONTENT ' '
      '%w(a b c)'.to_ast.should == @array_abc
    end

    # Canonical string_contents is "abcd#{$a}efgh".
    it "parses string_contents" do
      # /* none */
      '""'.to_ast.should == @s_empty

      # string_contents string_content
      '"abcd#{$a}efgh"'.to_ast.should == @ds
    end

    # Canonical xstring_contents is " #$a ".
    it "parses xstring_contents" do
      # /* none */
      '``'.to_ast.should == ExecuteString.new(1, "")

      # xstring_contents string_content
      '`abcd#{$a}efgh`'.to_ast.should ==
        DynamicExecuteString.new(1, "abcd", [@to_s, @s_efgh])
    end

    # Canonical string_content is "abcd".
    it "parses string_content" do
      # tSTRING_CONTENT
      '"abcd"'.to_ast.should == @s_abcd

      # tSTRING_DVAR string_dvar
      '"#$a"'.to_ast.should == DynamicString.new(1, "", [@to_s])

      # tSTRING_DBEG compstmt '}'
      # TODO: Spec regular case.
      # Special case -- see Processor#process_evstr.
      '"#{}"'.to_ast.should == DynamicString.new(1, "", [@s_empty])
    end

    # Canonical string_dvar is "$a".
    it "parses string_dvar" do
      # tGVAR
      '"#$a"'.to_ast.should == DynamicString.new(1, "", [@to_s])

      # tIVAR
      '"#@a"'.to_ast.should == DynamicString.new(1, "", [
        ToString.new(1, InstanceVariableAccess.new(1, :@a))
      ])

      # tCVAR
      '"#@@a"'.to_ast.should == DynamicString.new(1, "", [
        ToString.new(1, ClassVariableAccess.new(1, :@@a))
      ])

      # backref
      '"#$&"'.to_ast.should == DynamicString.new(1, "", [
        ToString.new(1, BackRef.new(1, :&))
      ])
    end

    # Canonical symbol is ":a".
    it "parses symbol" do
      # tSYMBEG sym
      ':a'.to_ast.should == @sym_a
    end

    # Canonical sym is ":a".
    it "parses sym" do
      # fname
      ':a'.to_ast.should == @sym_a

      # tIVAR
      ':@a'.to_ast.should == SymbolLiteral.new(1, :@a)

      # tGVAR
      ':$a'.to_ast.should == SymbolLiteral.new(1, :$a)

      # tCVAR
      ':@@a'.to_ast.should == SymbolLiteral.new(1, :@@a)
    end

    # Canonical dsym is ":\"a\"".
    it "parses dsym" do
      # tSYMBEG xstring_contents tSTRING_END
      ':"abcd"'.to_ast.should == SymbolLiteral.new(1, :abcd)
      ':"abcd#{$a}efgh"'.to_ast.should ==
        DynamicSymbol.new(1, "abcd", [@to_s, @s_efgh])
    end

    # Canonical numeric is "42".
    it "parses numeric" do
      # tINTEGER
      '42'.to_ast.should == @i42
      '42_000_000_000_000_000_000'.to_ast.should ==
        NumberLiteral.new(1, 42_000_000_000_000_000_000)

      # tFLOAT
      '42.0'.to_ast.should == FloatLiteral.new(1, 42.0)

      # tUMINUS_NUM tINTEGER %prec tLOWEST
      '-42'.to_ast.should == FixnumLiteral.new(1, -42)
      '-42_000_000_000_000_000_000'.to_ast.should ==
        NumberLiteral.new(1, -42_000_000_000_000_000_000)

      # tUMINUS_NUM tFLOAT %prec tLOWEST
      '-42.0'.to_ast.should == FloatLiteral.new(1, -42.0)
    end

    it "parses variable" do
      # tIDENTIFIER
      # TODO: Spec.

      # tIVAR
      '@a'.to_ast.should == InstanceVariableAccess.new(1, :@a)

      # tGVAR
      '$a'.to_ast.should == GlobalVariableAccess.new(1, :$a)

      # tCONSTANT
      'A'.to_ast.should == ConstantAccess.new(1, :A)

      # tCVAR
      '@@a'.to_ast.should == ClassVariableAccess.new(1, :@@a)

      # kNIL
      'nil'.to_ast.should == NilLiteral.new(1)

      # kSELF
      'self'.to_ast.should == Self.new(1)

      # kTRUE
      'true'.to_ast.should == TrueLiteral.new(1)

      # kFALSE
      'false'.to_ast.should == FalseLiteral.new(1)

      # k__FILE__

      # Rubinius parses __FILE__ as Rubinius::AST::File but AST parses it as
      # AST::StringLiteral with the file name already substituted. This is
      # because the substitution is done by ruby_parser already and AST can't
      # influence it.
      '__FILE__'.to_ast.should == StringLiteral.new(1, "(string)")

      # k__LINE__
      '__LINE__'.to_ast.should == FixnumLiteral.new(1, 1)
    end

    # Canonical var_ref is "@a".
    it "parses var_ref" do
      # variable
      '@a'.to_ast.should == InstanceVariableAccess.new(1, :@a)
    end

    it "parses var_lhs" do
      # variable
      # TODO: Spec.
    end

    # Canonical backref is "$~".
    it "parses backref" do
      # tNTH_REF
      '$1'.to_ast.should == NthRef.new(1, 1)

      # tBACK_REF
      '$&'.to_ast.should == BackRef.new(1, :&)
    end

    it "parses superclass" do
      # term
      # TODO: Spec.

      # '<' expr_value term
      # TODO: Spec.

      # error term
      # TODO: Spec.
    end

    it "parses f_arglist" do
      # '(' f_args opt_nl ')'
      # TODO: Spec.

      # f_args term
      # TODO: Spec.
    end

    it "parses f_args" do
      # f_arg ',' f_optarg ',' f_rest_arg opt_f_block_arg
      # TODO: Spec.

      # f_arg ',' f_optarg opt_f_block_arg
      # TODO: Spec.

      # f_arg ',' f_rest_arg opt_f_block_arg
      # TODO: Spec.

      # f_arg opt_f_block_arg
      # TODO: Spec.

      # f_optarg ',' f_rest_arg opt_f_block_arg
      # TODO: Spec.

      # f_optarg opt_f_block_arg
      # TODO: Spec.

      # f_rest_arg opt_f_block_arg
      # TODO: Spec.

      # f_block_arg
      # TODO: Spec.

      # /* none */
      # TODO: Spec.
    end

    it "parses f_norm_arg" do
      # tCONSTANT
      # TODO: Spec.

      # tIVAR
      # TODO: Spec.

      # tGVAR
      # TODO: Spec.

      # tCVAR
      # TODO: Spec.

      # tIDENTIFIER
      # TODO: Spec.
    end

    it "parses f_arg" do
      # f_norm_arg
      # TODO: Spec.

      # f_arg ',' f_norm_arg
      # TODO: Spec.
    end

    it "parses f_opt" do
      # tIDENTIFIER '=' arg_value
      # TODO: Spec.
    end

    it "parses f_optarg" do
      # f_opt
      # TODO: Spec.

      # f_optarg ',' f_opt
      # TODO: Spec.
    end

    it "parses restarg_mark" do
      # '*'
      # TODO: Spec.

      # tSTAR
      # TODO: Spec.
    end

    it "parses f_rest_arg" do
      # restarg_mark tIDENTIFIER
      # TODO: Spec.

      # restarg_mark
      # TODO: Spec.
    end

    it "parses blkarg_mark" do
      # '&'
      # TODO: Spec.

      # tAMPER
      # TODO: Spec.
    end

    it "parses f_block_arg" do
      # blkarg_mark tIDENTIFIER
      # TODO: Spec.
    end

    it "parses opt_f_block_arg" do
      # ',' f_block_arg
      # TODO: Spec.

      # none
      # TODO: Spec.
    end

    it "parses singleton" do
      # var_ref
      # TODO: Spec.

      # '(' expr opt_nl ')'
      # TODO: Spec.
    end

    # Canonical assoc_list is ":a => 42, :b => 43, :c => 44".
    it "parses assoc_list" do
      # none
      '{}'.to_ast.should == @hash_empty

      # assocs trailer
      '{ :a => 42, :b => 43, :c => 44, }'.to_ast.should == @hash_a42b43c44

      # args trailer
      '{ :a, 42, :b, 43, :c, 44, }'.to_ast.should == @hash_a42b43c44
    end

    # Canonical assocs is ":a => 42, :b => 43, :c => 44".
    it "parses assocs" do
      # assoc
      '{ :a => 42 }'.to_ast.should == @hash_a42

      # assocs ',' assoc
      '{ :a => 42, :b => 43, :c => 44 }'.to_ast.should == @hash_a42b43c44
    end

    # Canonical assoc is ":a => 42".
    it "parses assoc" do
      # arg_value tASSOC arg_value
      '{ !42 => !43 }'.to_ast.should == HashLiteral.new(1, [@not42, @not43])
    end

    it "parses operation" do
      # tIDENTIFIER
      # TODO: Spec.

      # tCONSTANT
      # TODO: Spec.

      # tFID
      # TODO: Spec.
    end

    it "parses operation2" do
      # tIDENTIFIER
      # TODO: Spec.

      # tCONSTANT
      # TODO: Spec.

      # tFID
      # TODO: Spec.

      # op
      # TODO: Spec.
    end

    it "parses operation3" do
      # tIDENTIFIER
      # TODO: Spec.

      # tFID
      # TODO: Spec.

      # op
      # TODO: Spec.
    end

    it "parses dot_or_colon" do
      # '.'
      # TODO: Spec.

      # tCOLON2
      # TODO: Spec.
    end

    # Canonical opt_terms is ";;;".
    it "parses opt_terms" do
      # /* none */
      '42 if 43'.to_ast.should == @if_4243

      # terms
      '42 if 43;;;'.to_ast.should == @if_4243
    end

    it "parses opt_nl" do
      # /* none */
      # TODO: Spec.

      # '\n'
      # TODO: Spec.
    end

    # Canonical trailer is ",".
    it "parses trailer" do
      # /* none */
      '[42, 43, 44]'.to_ast.should == @array_424344

      # '\n'
      "[42, 43, 44\n]".to_ast.should == @array_424344

      # ','
      '[42, 43, 44,]'.to_ast.should == @array_424344
    end

    # Canonical term is ";".
    it "parses term" do
      # ';'
      '42 if 43;44 if 45'.to_ast.should == @block2

      # '\n'
      "42 if 43\n44 if 45".to_ast.should == Block.new(1, [
        @if_4243,
        If.new(2, FixnumLiteral.new(2, 45), FixnumLiteral.new(2, 44), nil)
      ])
    end

    # Canonical terms is ";;;".
    it "parses terms" do
      # term
      '42 if 43;44 if 45'.to_ast.should == @block2

      # terms ';'
      '42 if 43;;;44 if 45'.to_ast.should == @block2
    end

    # Canonical none is "".
    it "parses none" do
      # /* none */
      ''.to_ast.should == nil
    end
  end
end
