

%%

%public
%class NanoMorphoLexer
%byaccj
%line
%column
%unicode

%{

public NanoMorphoParser yyparser;

public int getLine() { return yyline+1; }
public int getColumn() { return yycolumn+1; }

public NanoMorphoLexer(java.io.Reader r, NanoMorphoParser yyparser )
{
	this(r);
	this.yyparser = yyparser;
}

%}

  /* Reglulegar skilgreiningar */

  /* Regular definitions */

_DIGIT=[0-9]
_FLOAT={_DIGIT}+\.{_DIGIT}+([eE][+-]?{_DIGIT}+)?
_INT={_DIGIT}+
_STRING=\"([^\"\\]|\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\|(\\[0-3][0-7][0-7])|\\[0-7][0-7]|\\[0-7])*\"
_CHAR=\'([^\'\\]|\\b|\\t|\\n|\\f|\\r|\\\"|\\\'|\\\\|(\\[0-3][0-7][0-7])|(\\[0-7][0-7])|(\\[0-7]))\'
_DELIM=[(){},;=]
_NAME=(_|[:jletter:])(_|[:jletter:]|{_DIGIT})*
_OPNAME=[\+\-*/!%&=><\:\^\~&|?]+

%%

  /* Lesgreiningarreglur */

  /* Scanner rules */

{_DELIM} {
   	yyparser.yylval = new NanoMorphoParserVal(yytext());
	return yycharat(0);
}

{_STRING} | {_FLOAT} | {_CHAR} | {_INT} | null | true | false {
	yyparser.yylval = new NanoMorphoParserVal(yytext());
	return NanoMorphoParser.LITERAL;
}

"if" {
  	 return NanoMorphoParser.IF;
}

"else" {
 	return NanoMorphoParser.ELSE;
}

"elseif" {
   	 return NanoMorphoParser.ELSIF;
}

"while" {
	return NanoMorphoParser.WHILE;

}

"var" {
	return NanoMorphoParser.VAR;
}

"return" {
    return NanoMorphoParser.RETURN;
}

{_NAME} {
	yyparser.yylval = new NanoMorphoParserVal(yytext());
	return NanoMorphoParser.NAME;
}

{_OPNAME} {
yyparser.yylval = new NanoMorphoParserVal(yytext());

    if(yyparser.yylval.equals("&&")){
        return NanoMorphoParser.AND;
    } else if(yyparser.yylval.equals("||")){
        return NanoMorphoParser.OR;
    }   else if(yyparser.yylval.equals("!")){
        return NanoMorphoParser.NOT;
    }

    switch( yycharat(0) )
    {
    case '?':
    case '~':
    case '^':
        return NanoMorphoParser.OP1;
    case ':':
        return NanoMorphoParser.OP2;
    case '|':
        return NanoMorphoParser.OP3;
    case '&':
        return NanoMorphoParser.OP4;
    case '<':
    case '>':
    case '=':
    case '!':
        return NanoMorphoParser.OP5;
    case '+':
    case '-':
        return NanoMorphoParser.OP6;
    case '*':
    case '/':
    case '%':
        return NanoMorphoParser.OP7;
    }
    throw new Error("Wrong OPNAME");
}

";;;".*$ {
}

[ \t\r\n\f] {
}

. {
    return NanoMorphoParser.YYERRCODE;
}
