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

      @array_empty = EmptyArray.new(1)
      @array_424344 = ArrayLiteral.new(1, [@i42, @i43, @i44])
      @array_abc = ArrayLiteral.new(1, [
        StringLiteral.new(1, "a"),
        StringLiteral.new(1, "b"),
        StringLiteral.new(1, "c")
      ])

      @hash_empty = HashLiteral.new(1, [])
      @hash_a42 = HashLiteral.new(1, [
        SymbolLiteral.new(1, :a),
        @i42
      ])
      @hash_a42b43c44 = HashLiteral.new(1, [
        SymbolLiteral.new(1, :a),
        @i42,
        SymbolLiteral.new(1, :b),
        @i43,
        SymbolLiteral.new(1, :c),
        @i44,
      ])
    end

    it "parses program" do
      # compstmt
      # TODO: Spec.
    end

    it "parses bodystmt" do
      # compstmt opt_rescue opt_else opt_ensure
      # TODO: Spec.
    end

    it "parses compstmt" do
      # stmts opt_terms
      # TODO: Spec.
    end

    it "parses stmts" do
      # none
      # TODO: Spec.

      # stmt
      # TODO: Spec.

      # stmts terms stmt
      # TODO: Spec.

      # error stmt
      # TODO: Spec.
    end

    it "parses stmt" do
      # kALIAS fitem fitem
      # TODO: Spec.

      # kALIAS tGVAR tGVAR
      # TODO: Spec.

      # kALIAS tGVAR tBACK_REF
      # TODO: Spec.

      # kALIAS tGVAR tNTH_REF
      # TODO: Spec.

      # kUNDEF undef_list
      # TODO: Spec.

      # stmt kIF_MOD expr_value
      # TODO: Spec.

      # stmt kUNLESS_MOD expr_value
      # TODO: Spec.

      # stmt kWHILE_MOD expr_value
      # TODO: Spec.

      # stmt kUNTIL_MOD expr_value
      # TODO: Spec.

      # stmt kRESCUE_MOD stmt
      # TODO: Spec.

      # klBEGIN '{' compstmt '}'
      # TODO: Spec.

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
      # TODO: Spec.

      # expr kOR expr
      # TODO: Spec.

      # kNOT expr
      # TODO: Spec.

      # '!' command_call
      # TODO: Spec.

      # arg
      # TODO: Spec.
    end

    it "parses expr_value" do
      # expr
      # TODO: Spec.
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

    it "parses lhs" do
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

    it "parses fname" do
      # tIDENTIFIER
      # TODO: Spec.

      # tCONSTANT
      # TODO: Spec.

      # tFID
      # TODO: Spec.

      # op
      # TODO: Spec.

      # reswords
      # TODO: Spec.
    end

    it "parses fsym" do
      # fname
      # TODO: Spec.

      # symbol
      # TODO: Spec.
    end

    it "parses fitem" do
      # fsym
      # TODO: Spec.

      # dsym
      # TODO: Spec.
    end

    it "parses undef_list" do
      # fitem
      # TODO: Spec.

      # undef_list ',' fitem
      # TODO: Spec.
    end

    it "parses op" do
      # '|'
      # TODO: Spec.

      # '^'
      # TODO: Spec.

      # '&'
      # TODO: Spec.

      # tCMP
      # TODO: Spec.

      # tEQ
      # TODO: Spec.

      # tEQQ
      # TODO: Spec.

      # tMATCH
      # TODO: Spec.

      # '>'
      # TODO: Spec.

      # tGEQ
      # TODO: Spec.

      # '<'
      # TODO: Spec.

      # tLEQ
      # TODO: Spec.

      # tLSHFT
      # TODO: Spec.

      # tRSHFT
      # TODO: Spec.

      # '+'
      # TODO: Spec.

      # '-'
      # TODO: Spec.

      # '*'
      # TODO: Spec.

      # tSTAR
      # TODO: Spec.

      # '/'
      # TODO: Spec.

      # '%'
      # TODO: Spec.

      # tPOW
      # TODO: Spec.

      # '~'
      # TODO: Spec.

      # tUPLUS
      # TODO: Spec.

      # tUMINUS
      # TODO: Spec.

      # tAREF
      # TODO: Spec.

      # tASET
      # TODO: Spec.

      # '`'
      # TODO: Spec.
    end

    it "parses reswords" do
      # k__LINE_
      # TODO: Spec.

      # k__FILE__
      # TODO: Spec.

      # klBEGIN
      # TODO: Spec.

      # klEND
      # TODO: Spec.

      # kALIAS
      # TODO: Spec.

      # kAND
      # TODO: Spec.

      # kBEGIN
      # TODO: Spec.

      # kBREAK
      # TODO: Spec.

      # kCASE
      # TODO: Spec.

      # kCLASS
      # TODO: Spec.

      # kDEF
      # TODO: Spec.

      # kDEFINED
      # TODO: Spec.

      # kDO
      # TODO: Spec.

      # kELSE
      # TODO: Spec.

      # kELSIF
      # TODO: Spec.

      # kEND
      # TODO: Spec.

      # kENSURE
      # TODO: Spec.

      # kFALSE
      # TODO: Spec.

      # kFOR
      # TODO: Spec.

      # kIN
      # TODO: Spec.

      # kMODULE
      # TODO: Spec.

      # kNEXT
      # TODO: Spec.

      # kNIL
      # TODO: Spec.

      # kNOT
      # TODO: Spec.

      # kOR
      # TODO: Spec.

      # kREDO
      # TODO: Spec.

      # kRESCUE
      # TODO: Spec.

      # kRETRY
      # TODO: Spec.

      # kRETURN
      # TODO: Spec.

      # kSELF
      # TODO: Spec.

      # kSUPER
      # TODO: Spec.

      # kTHEN
      # TODO: Spec.

      # kTRUE
      # TODO: Spec.

      # kUNDEF
      # TODO: Spec.

      # kWHEN
      # TODO: Spec.

      # kYIELD
      # TODO: Spec.

      # kIF_MOD
      # TODO: Spec.

      # kUNLESS_MOD
      # TODO: Spec.

      # kWHILE_MOD
      # TODO: Spec.

      # kUNTIL_MOD
      # TODO: Spec.

      # kRESCUE_MOD
      # TODO: Spec.
    end

    it "parses arg" do
      # lhs '=' arg
      # TODO: Spec.

      # lhs '=' arg kRESCUE_MOD arg
      # TODO: Spec.

      # var_lhs tOP_ASGN arg
      # TODO: Spec.

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
      # TODO: Spec.

      # arg tDOT3 arg
      # TODO: Spec.

      # arg '+' arg
      # TODO: Spec.

      # arg '-' arg
      # TODO: Spec.

      # arg '*' arg
      # TODO: Spec.

      # arg '/' arg
      # TODO: Spec.

      # arg '%' arg
      # TODO: Spec.

      # arg tPOW arg
      # TODO: Spec.

      # tUMINUS_NUM tINTEGER tPOW arg
      # TODO: Spec.

      # tUMINUS_NUM tFLOAT tPOW arg
      # TODO: Spec.

      # tUPLUS arg
      # TODO: Spec.

      # tUMINUS arg
      # TODO: Spec.

      # arg '|' arg
      # TODO: Spec.

      # arg '^' arg
      # TODO: Spec.

      # arg '&' arg
      # TODO: Spec.

      # arg tCMP arg
      # TODO: Spec.

      # arg '>' arg
      # TODO: Spec.

      # arg tGEQ arg
      # TODO: Spec.

      # arg '<' arg
      # TODO: Spec.

      # arg tLEQ arg
      # TODO: Spec.

      # arg tEQ arg
      # TODO: Spec.

      # arg tEQQ arg
      # TODO: Spec.

      # arg tNEQ arg
      # TODO: Spec.

      # arg tMATCH arg
      # TODO: Spec.

      # arg tNMATCH arg
      # TODO: Spec.

      # '!' arg
      # TODO: Spec.

      # '~' arg
      # TODO: Spec.

      # arg tLSHFT arg
      # TODO: Spec.

      # arg tRSHFT arg
      # TODO: Spec.

      # arg tANDOP arg
      # TODO: Spec.

      # arg tOROP arg
      # TODO: Spec.

      # kDEFINED opt_nl arg
      # TODO: Spec.

      # arg '?' arg     it "parses '" do' arg
      # TODO: Spec.

      # primary
      # TODO: Spec.
    end

    it "parses arg_value" do
      # arg
      # TODO: Spec.
    end

    it "parses aref_args" do
      # none
      '[]'.to_ast.should == @array_empty

      # command opt_nl
      # TODO: Spec.

      # args trailer
      '[42, 43, 44,]'.to_ast.should == @array_424344

      # args ',' tSTAR arg opt_nl
      # TODO: Spec.

      # assocs trailer
      # TODO: Spec.

      # tSTAR arg opt_nl
      # TODO: Spec.
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
      '"abcd" "efgh"'.to_ast.should == StringLiteral.new(1, "abcdefgh")

      # xstring
      '`abcd`'.to_ast.should == ExecuteString.new(1, "abcd")

      # regexp
      '/abcd/'.to_ast.should == RegexLiteral.new(1, "abcd", 0)

      # words
      '%W(a b c)'.to_ast.should == @array_abc

      # qwords
      '%w(a b c)'.to_ast.should == @array_abc

      # var_ref
      # TODO: Spec.

      # backref
      '$&'.to_ast.should == BackRef.new(1, :&)

      # tFID
      # TODO: Spec.

      # kBEGIN bodystmt kEND
      # TODO: Spec.

      # tLPAREN_ARG expr opt_nl ')'
      # TODO: Spec.

      # tLPAREN compstmt ')'
      # TODO: Spec.

      # primary_value tCOLON2 tCONSTANT
      # TODO: Spec.

      # tCOLON3 tCONSTANT
      # TODO: Spec.

      # primary_value '[' aref_args ']'
      # TODO: Spec.

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
      # TODO: Spec.

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

    it "parses primary_value" do
      # primary
      # TODO: Spec.
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
      ':a'.to_ast.should == SymbolLiteral.new(1, :a)

      # dsym
      ':"a"'.to_ast.should == SymbolLiteral.new(1, :a)
    end

    # Canonical strings is "\"abcd\" \"efgh\"".
    it "parses strings" do
      # string
      '"abcd" "efgh"'.to_ast.should == StringLiteral.new(1, "abcdefgh")
    end

    # Canonical string is "\"abcd\" \"efgh\"".
    it "parses string" do
      # string1
      '"abcd"'.to_ast.should == StringLiteral.new(1, "abcd")

      # string string1
      '"abcd" "efgh" "ijkl"'.to_ast.should == StringLiteral.new(1, "abcdefghijkl")
    end

    # Canonical string1 is "\"abcd\"".
    it "parses string1" do
      # tSTRING_BEG string_contents tSTRING_END
      '"abcd"'.to_ast.should == StringLiteral.new(1, "abcd")
      '"abcd#{$a}efgh"'.to_ast.should == DynamicString.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ])
    end

    # Canonical xstring is "`abcd`".
    it "parses xstring" do
      # tXSTRING_BEG xstring_contents tSTRING_END
      '`abcd`'.to_ast.should == ExecuteString.new(1, "abcd")
      '`abcd#{$a}efgh`'.to_ast.should == DynamicExecuteString.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ])
    end

    # Canonical regexp is "/abcd/".
    it "parses regexp" do
      # tREGEXP_BEG xstring_contents tREGEXP_END
      '/abcd/'.to_ast.should == RegexLiteral.new(1, "abcd", 0)
      '/abcd#{$a}efgh/'.to_ast.should == DynamicRegex.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ], 0)
      '/abcd#{$a}efgh/m'.to_ast.should == DynamicRegex.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ], 4)
      '/abcd#{$a}efgh/o'.to_ast.should == DynamicOnceRegex.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ], 0)
      '/abcd#{$a}efgh/om'.to_ast.should == DynamicOnceRegex.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ], 4)
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
      '%W(abcd)'.to_ast.should == ArrayLiteral.new(1, [
        StringLiteral.new(1, "abcd")
      ])

      # word string_content
      '%W(abcd#{$a}efgh)'.to_ast.should == ArrayLiteral.new(1, [
        DynamicString.new(1, "abcd", [
          ToString.new(1, GlobalVariableAccess.new(1, :$a)),
          StringLiteral.new(1, "efgh")
        ])
      ])
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
      '""'.to_ast.should == StringLiteral.new(1, "")

      # string_contents string_content
      '"abcd#{$a}efgh"'.to_ast.should == DynamicString.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ])
    end

    # Canonical xstring_contents is " #$a ".
    it "parses xstring_contents" do
      # /* none */
      '``'.to_ast.should == ExecuteString.new(1, "")

      # xstring_contents string_content
      '`abcd#{$a}efgh`'.to_ast.should == DynamicExecuteString.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ])
    end

    # Canonical string_content is "abcd".
    it "parses string_content" do
      # tSTRING_CONTENT
      '"abcd"'.to_ast.should == StringLiteral.new(1, "abcd")

      # tSTRING_DVAR string_dvar
      '"#$a"'.to_ast.should == DynamicString.new(1, "", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a))
      ])

      # tSTRING_DBEG compstmt '}'
      # TODO: Spec regular case.
      # Special case -- see Processor#process_evstr.
      '"#{}"'.to_ast.should == DynamicString.new(1, "", [
        StringLiteral.new(1, "")
      ])
    end

    # Canonical string_dvar is "$a".
    it "parses string_dvar" do
      # tGVAR
      '"#$a"'.to_ast.should == DynamicString.new(1, "", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a))
      ])

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
      ':a'.to_ast.should == SymbolLiteral.new(1, :a)
    end

    # Canonical sym is ":a".
    it "parses sym" do
      # fname
      ':a'.to_ast.should == SymbolLiteral.new(1, :a)

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
      ':"abcd#{$a}efgh"'.to_ast.should == DynamicSymbol.new(1, "abcd", [
        ToString.new(1, GlobalVariableAccess.new(1, :$a)),
        StringLiteral.new(1, "efgh")
      ])
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

    it "parses var_ref" do
      # variable
      # TODO: Spec.
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

    it "parses assoc" do
      # arg_value tASSOC arg_value
      # TODO: Spec.
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

    it "parses opt_terms" do
      # /* none */
      # TODO: Spec.

      # terms
      # TODO: Spec.
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

    it "parses term" do
      # ';'
      # TODO: Spec.

      # '\n'
      # TODO: Spec.
    end

    it "parses terms" do
      # term
      # TODO: Spec.

      # terms ';'
      # TODO: Spec.
    end

    it "parses none" do
      # /* none */
      # TODO: Spec.
    end
  end
end
