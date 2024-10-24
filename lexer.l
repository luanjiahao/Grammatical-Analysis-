%{
#include <stdio.h>
#include <ctype.h>
%}

/* 定义保留字、标识符、数字等的正则表达式 */
KEYWORD    "int"|"float"|"return"|"if"|"else"|"for"|"while"|"void"|"char"|"double"
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
CONST      [0-9]+
OPERATOR   "+"|"-"|"*"|"/"|"="|"=="|"!="|"<"|">"|"&&"|"||"|"++"|"--"
SEPARATOR  ";"|","|"{"|"}"|"("|")"

/* 词法规则 */
%%
int   { printf("<KEYWORD, int>\n"); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("<ID, %s>\n", yytext); }
[0-9]+ { printf("<CONST, %s>\n", yytext); }
"+"|"-"|"*"|"/" { printf("<OPERATOR, %s>\n", yytext); }
";"|"{"|"}"|"("|")" { printf("<SEPARATOR, %s>\n", yytext); }

[\n\t ]+ ; // 忽略空白符号
. { printf("Unrecognized token: %s\n", yytext); }
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Unable to open file!");
            return 1;
        }
        yyin = file;
    }
    yylex(); // 调用词法分析函数
    return 0;
}

