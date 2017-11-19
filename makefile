all:
	flex lexico.l
	bison -d sintactico.y
	gcc -o analizador lex.yy.c sintactico.tab.c 
	
	
