
%option yylineno
%option noyywrap

%{

#include <stdio.h>
#include <string.h>
#include "sintactico.tab.h"
extern int yyparse();

%}
SIMBOLO [ "!#$%&()*+,-./:;<=>?@[\]_{}]
DIGITO [0-9] 
LETRA [a-zA-Z]|\361|\321
CARACTER {LETRA}|{DIGITO}|{SIMBOLO}
IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
NUMERO_ENTERO {DIGITO}+
STRING "'"{CARACTER}+"'"
NUMERO_REAL  {NUMERO_ENTERO}"."{DIGITO}|{NUMERO_ENTERO}"E+"|"E-"|"E"{NUMERO_ENTERO}|{NUMERO_ENTERO}"."{DIGITO}"E+"|"E-"|"E"{NUMERO_ENTERO}

NOBASURA {STRING}|{NUMERO_ENTERO}|{NUMERO_REAL}|{IDENTIFICADOR}|{OPERADOR}|{PUNTUACION}
BASURA [^{NOBASURA}]


%%
"<" {return '<';}
">" {return '<';}
"=" {return '=';}
"+" {return '+';}
"-" {return '-';}
"*" {return '*';}
"/" {return '/';}

"." {return '.';}
":" {return ':';}
"," {return ',';}
";" {return ';';}
"(" {return '(';}
")" {return ')';}

"ABS" {return ABS;}
"BAJAR" {return BAJAR;}
"CARACTER" {return CARACTER;}
"CONST" {return CONST;}
"CUADR" {return CUADR;}
"CUANDO" {return CUANDO;}
"DIV" {return DIV;}
"ENTERO" {return ENTERO;}
"ENTONCES" {return ENTONCES;}
"ESCRIB" {return ESCRIB;}
"ESCRIBL" {return ESCRIBL;}
"FALSO" {return FALSO;}
"FIN" {return FIN;}
"HACER" {return HACER;}
"HASTA" {return HASTA;}
"IMPAR" {return IMPAR;}
"INICIO" {return INICIO;}
"LEER" {return LEER;}
"LOGICO" {return LOGICO;}
"MIENTRAS" {return MIENTRAS;}
"NO" {return NO;}
"O" {return O;}
"PROGRAMA" {return PROGRAMA;}
"REAL" {return REAL;}
"REPITA" {return REPITA;}
"RESTO" {return RESTO;}
"SEA" {return SEA;}
"SI" {return SI;}
"SINO" {return SINO;}
"SUBIR" {return SUBIR;}
"VAR" {return VAR;}
"VERDAD" {return VERDAD;}
"Y" {return Y;}

{IDENTIFICADOR} {return IDENTIFICADOR;}
{STRING} {return STRING;}
{NUMERO_ENTERO} {return NUMERO_ENTERO;}
{NUMERO_REAL} {return NUMERO_REAL;}

{BASURA} {}

%%

void yyerror(char * s) { 
	printf("Error sint%cctico en la l%cnea: %d\n", 160,161,yylineno);
}

int existsFile(char* fileName) 
{
	FILE* file = NULL;
	file = fopen(fileName,"r");
	if (file == NULL)
		return 0;
	else {
		fclose(file);
		return 1;
	}
	return 0;
}

int main(int argc, char** argv){
	int i = 0;
	if(argc == 1){
		printf("Error: Falta par%cmetro en la l%cnea de comandos.\nUso: sintactico.exe archivo\n",160,161);
		return 1;
	}
	else if(argc > 2){
		printf("Error: Demasiados par%cmetros en la l%cnea de comandos.\nUso: sintactico.exe archivo\n",160,161);
		return 1;
	}
	else if(!existsFile(argv[1])){
		printf("Error: El archivo de entrada no existe.\n");
        return 0;
	}
	yyin =fopen(argv[1],"r");
	i = yyparse();
	fclose(yyin);
	if(i==0){
		printf("An%clisis sint%cctico finalizado.\n",160,160);
	}
	return 0;
	
}
  

