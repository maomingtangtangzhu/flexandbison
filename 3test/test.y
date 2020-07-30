%{
#include <stdio.h>
#include <stdlib.h>
extern int yylineno;
struct structmeminfo{
	char *name;
	unsigned int type;
	struct structmeminfo *next;
};

struct structinfo{
	char *flleName;
	unsigned int lineNumber;
	struct structmeminfo *next;
};

struct meminfo simpletest(char *name,unsigned int type){	

}
%}

%union {
	struct structmeminfo smi;
	struct structinfo si;
	char *word;
	unsigned int type;
}
%token <type> STRUCT
%token <type> CONST
%token <type> UNSIGNED
%token <type> LONG
%token <type> INT
%token <type> VOID
%token <word> WORD
%type <sm> declareStruct
%type <type> type
%type <smi> declareVar statements block

%%
declareStruct : STRUCT WORD block ';' {};
block : '{' statements '}' {} ;
statements : declareVar {}
	   | statements statements {};
declareVar : type WORD ';' {}
	   | type '*' WORD ';'{}
	   | STRUCT WORD WORD ';' {}
	   | STRUCT block WORD ';' {};
type : INT { $$.type=$1.type; }
     | CONST { $$.type=$1.type; }
     | LONG { $$.type=$1.type; }
     | VOID { $$.type=$1.type; } 
     | type type { $$.type=$1.type|$2.type };

%%

int main(){
	yylex();
	return 0;
}
