%{
/*
 * Garbage
 */
%}

%%

[\t ]+ { printf("WHITESPACE"); }

[_a-zA-Z][_a-zA-Z0-9]* { printf("Found identifier: %s", yytext); }

\"[a-zA-Z0-9]*\"|\'[a-zA-Z0-9]*\' { printf("Found string: %s", yytext); }

[-+]?[0-9]+ { printf("Found integer: %s", yytext); }

[-+]?[0-9]*\.[0-9]+ { printf("Found float: %s", yytext); }

[\r\n] { ECHO; }

%%

int main(int argc, const char* argv[])
{
    yylex();
}
