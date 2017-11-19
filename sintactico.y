%{
  #include <stdio.h>
  extern int yylex(void);
  extern char *yytext;
  void yyerror(char *s);
%}

%token IDENTIFICADOR
%token STRING
%token NUMERO_ENTERO
%token NUMERO_REAL
%token ABS
%token BAJAR
%token CARACTER
%token CONST
%token CUADR
%token CUANDO
%token DIV
%token ENTERO
%token ENTONCES
%token ESCRIB
%token ESCRIBL
%token FALSO
%token FIN
%token HACER
%token HASTA
%token IMPAR
%token INICIO
%token LEER
%token LOGICO
%token MIENTRAS
%token NO
%token O
%token PROGRAMA
%token REAL
%token REPITA
%token RESTO
%token SEA
%token SI
%token SINO
%token SUBIR
%token VAR
%token VERDAD
%token Y


%left '*' '/'
%left '+' '-'
%right NOT
%left AND OR
%right '='


%%
programa : PROGRAMA IDENTIFICADOR ';' declaraciones cuerpo '.' ;
cuerpo : sentencia_compuesta ;
identificador_de_tipo : ENTERO | REAL | CARACTER | LOGICO ;
sentencia : sentencia_compuesta | llamada_de_proceso | sentencia_asignacion | sentencia_selectiva | sentencia_repetitiva | ;
sentencia_asignacion : IDENTIFICADOR ':''=' expresion ;
sentencia_selectiva : sentencia_si | sentencia_cuando ;
sentencia_repetitiva : sentencia_mientras | sentencia_para | sentencia_repita ;
sentencia_mientras : MIENTRAS expresion HACER sentencia ;
expresion : expresion_simple | 
			expresion_simple '<' expresion_simple | 
			expresion_simple '<''=' expresion_simple | 
			expresion_simple '=' expresion_simple |
			expresion_simple '<''>' expresion_simple | 
			expresion_simple '>' expresion_simple | 
			expresion_simple '>''=' expresion_simple ;
factor : constante_sin_signo | IDENTIFICADOR | llamada_funcion | '(' expresion ')' | NO factor ;
llamada_funcion : identificador_funcion '(' parametro ')' ;
parametro : expresion | IDENTIFICADOR ;
identificador_de_proceso : ESCRIB | ESCRIBL | LEER ;
identificador_funcion : ABS | CUADR | IMPAR ;
constante : constante_sin_signo | '+' constante_sin_signo | '-' constante_sin_signo;
constante_sin_signo : identificador_constante | NUMERO_ENTERO | NUMERO_REAL | STRING ;
identificador_constante : IDENTIFICADOR | FALSO | VERDAD ;
sentencia_si : SI expresion ENTONCES sentencia | SI expresion ENTONCES sentencia SINO sentencia ;
etiqueta : constante ;
sentencia_para : SUBIR IDENTIFICADOR ':''=' expresion ',' expresion HACER | BAJAR IDENTIFICADOR ':''=' expresion ',' expresion HACER ;


declaraciones : d8 d9
d8 : CONST d10 | ; 
d10 : IDENTIFICADOR '=' constante ';' d10 | IDENTIFICADOR '=' constante ';' ;
d9 : VAR d11 | ; 
d11 : IDENTIFICADOR ':' identificador_de_tipo ';' d11 | IDENTIFICADOR ':' identificador_de_tipo ';' ;

sentencia_compuesta : INICIO d1 FIN ;
d1 :  sentencia ';' d1 | sentencia ;

sentencia_repita : REPITA d1 HASTA expresion ;

termino : factor d2 ;
d2 : '*' factor d2 | '/' factor d2 | Y factor d2 | DIV factor d2 | RESTO factor d2 | ;

llamada_de_proceso : identificador_de_proceso '(' d3 ')' ;
d3: parametro ',' d3 | parametro  ;

sentencia_cuando : CUANDO expresion SEA d4 FIN ;
d4 : d5 ':' sentencia ';' d4 | d5 ':' sentencia ;
d5 : etiqueta ',' d5| etiqueta ;

expresion_simple : d6 termino d7 ;
d6 : '+' | '-' | ;
d7 : '+' termino d7 | '-' termino d7 | O termino d7 | ;




%%


