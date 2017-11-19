/*****************
  Definiciones
                Se colocan las cabeceras, variables y expresiones regulares

********************/

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "sintactico.tab.h"
  int linea=0;
%}
/*
Creamos todas las expresiones regulares

Creamos la definición llamada DIGITO, podemos acceder esta definición
usando {DIGITO}*/
DIGITO [0-9]
NUMERO {DIGITO}+("."{DIGITO}+)?

%option noyywrap
%%


 /* Creamos las reglas que reconocerán las cadenas que acepte
  Nuestro scanner y retornaremos el token a bison con la
  funcion return. */

{NUMERO} {yylval.real=atof(yytext); return(NUMERO);}
"="         {return(IGUAL);}
"+"         {return(MAS);}
"-"          {return(MENOS);}
";"          {return(PTOCOMA);}
"*"         {return(POR);}
"/"          {return(DIV);}
"("          {return(PAA);}
")"          {return(PAC);}
"\n"       {linea++;}
[\t\r\f] {}
" "                          {}
 /* Si en nuestra entrada tiene algún caracter que no pertenece a
   las reglas anteriores, se genera un error léxico */

.                              {printf("Error lexico en linea %d",linea);}
%%
/*
Código de Usuario

Aquí podemos realizar otras funciones, como por ejemplo ingresar
símbolos a nuestra tabal de símbolos o cualquier otra accione
del usuario. 
Todo lo que el usuario coloque en esta sección se copiara al
archvi lex.yy.c tal y como esta.
*/
