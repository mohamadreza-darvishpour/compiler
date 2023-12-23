

/* Reverse Polish Notation calculator. */

%{
  #include <stdio.h>
  #include <math.h>
  int yylex (void);
  void yyerror (char const *);
%}

%union {
    int ival;
    double fval;
}

%token <ival> NUM 
%token <fval> FLOAT 
%type <ival> exp

%% /* Grammar rules and actions follow. */



input:
  '\n' {printf("\nstart program\n");}
| input line
;



exp:
  NUM
| exp exp '+'   { $$ = $1 + $2;      }
| exp exp '-'   { $$ = $1 - $2;      }
| exp exp '*'   { $$ = $1 * $2;      }
| exp exp '/'   { $$ = $1 / $2;      }
| exp exp '^'   { $$ = pow ($1, $2); }  /* Exponentiation */
| exp 'n'       { $$ = -$1;          }  /* Unary minus   */
;


line:
  '\n'
| exp '\n'      { printf ("%d\n", $1); }
;


%%



#include <stdio.h>

/* Called by yyparse on error. */
void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}


int main (void)
{
  return yyparse ();
}