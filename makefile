all:
	flex lexico.l
	bison -d sintactico.y
	gcc -o sintactico lex.yy.c sintactico.tab.c 
	
	
