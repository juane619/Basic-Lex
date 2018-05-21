/*DECLARACIONES*/

%{
#include <stdio.h>
#include <stdlib.h>

int nsecmay, nsecmin, nsecmaymin, nent, nrea, sumaent;
float sumarea;
int linea;

void escribir_datos(int nsecmay, int nsecmin, int nsecmaymin, int nent, int nrea, int sumaent, float sumarea);
void imprimir(const char *cad, const char *cad_imp, int linea_p);
/*

*/
%}

digito  [0-9]
entero  [\-]?{digito}+
real    {entero}.{entero}
real2   {real}[eE][\+\-]?{entero}

%%

[a-z]+   {nsecmin++; imprimir("SECUENCIA MINUSCULAS", yytext, linea);}
[A-Z]+      {nsecmay++; imprimir("SECUENCIA MAYUSCYLAS", yytext, linea);}
[a-zA-Z]+   {nsecmaymin++; imprimir("SECUENCIA MINUSCULAS-MAYUSCULAS", yytext, linea);}
{entero}    {nent++; imprimir("ENTERO", yytext, linea); sumaent+=atoi(yytext);}
{real}    {nrea++; imprimir("REAL", yytext, linea); sumarea+=atof(yytext);}
{real2}    {nrea++; imprimir("REAL2", yytext, linea); sumarea+=atof(yytext);}

\n  {linea++;}

%%

/*PROCEDIMIENTOS*/

int main(int argc, char *argv[]){
	if(argc==2){
		yyin = fopen(argv[1], "rt");
		if(yyin==NULL){
			printf("El fichero %s no se puede abrir\n", argv[1]);
			exit(-1);
		}
	}else yyin= stdin;

nsecmay=nsecmin=nsecmaymin=nent=nrea=sumaent= 0;
sumarea=0.0;
linea=0;

yylex ();
escribir_datos(nsecmay, nsecmin, nsecmaymin, nent, nrea, sumaent, sumarea);

return 0;

}

void escribir_datos(int nsecmay, int nsecmin, int nsecmaymin, int nent, int nrea, int sumaent, float sumarea){
	printf("Num secuencias mayusculas=%d\nNum secuencias minusculas=%d\nNum secuencias min-may=%d\nNum enteros=%d\nNum reales=%d\nSuma enteros=%d\nSuma reales=%f\n", nsecmay, nsecmin, nsecmaymin, nent, nrea, sumaent, sumarea);
}

void imprimir(const char *cad, const char *cad_imp, int linea_p){
    printf("%s: \"%s\". Linea %d.\n", cad, cad_imp, linea_p);
}