/*DECLAACIONES*/

%{
#include <stdio.h>

int emails, webs, fechas, telefonos, matriculas, postales, nifs;
int linea;

void escribir_datos(int emails, int webs, int fechas, int telefonos, int matriculas, int postales, int nifs);
void imprimir(const char *cad, const char *cad_imp, int linea_p);
%}

/*ALIAS*/
letrami   [a-z]
letrama     [A-Z]
letras  [a-zA-Z]
digito  [0-9]
alfanumerico    [a-zA-Z0-9]
entero  -?{digito}+
real    {entero}.{entero}
real2   {real}[eE][\+\-]?{entero}
numero  {entero}|{real}|{real2}
dd    [0-2]?[0-9]|"3"[01]
m   "enero"|"febrero"|"marzo"|"abril"|"mayo"|"junio"|"julio"|"agosto"|"septiembre"|"octubre"|"noviembre"|"diciembre"
M   "ene"|"feb"|"mar"|"abr"|"may"|"jun"|"jul"|"ago"|"sep"|"oct"|"nov"|"dic"
mm  "0"?[0-9]|"1"[0-2]
yy      [0-9]{2}
yyyy  [0-9]{4}

/*REGLAS 
printf("%s\n", yytext);
*/

%%

({alfanumerico}+[._]?){1,}@(({alfanumerico}+[-]?){1,}{alfanumerico}+\.){1,}{letras}{2,4} { emails++; imprimir("EMAIL", yytext, linea);}

{digito}{8}[-]?{letras}     {nifs++; imprimir("DNI", yytext, linea);}
[xXyYxX][-]?{digito}{7}[-]?{letras}    {nifs++; imprimir("DNI", yytext, linea);}

("http"{1}[s]?"://")?({letras}+{digito}*[\.\-]?)+\.{letras}{2,4}     {webs++; imprimir("WEB", yytext, linea);}

({dd}[-/.]({mm}|{M})([-/.]({yy}|{yyyy}))?)    {fechas++; imprimir("FECHA", yytext, linea);}
(({mm}|{M})[-/.]({yy}|{yyyy}))    {fechas++; imprimir("FECHA", yytext, linea);}
{dd}" de "({m}|{M})(" de "|" del ")({yy}|{yyyy})    {fechas++; imprimir("FECHA", yytext, linea);}

((\+)?{digito}{1,4})?[" "-]?([6789]{digito}{8})|([6789]{digito}{2}[" "-]?{digito}{6})|([6789]{digito}{2}[" "-]?{digito}{3}[" "-]?{digito}{3})|([6789]{digito}{2}[" "-]?{digito}{2}[" "-]?{digito}{2}[" "-]?{digito}{2})     {telefonos++; imprimir("TELEFONO", yytext, linea);}

0?([1-9](([1-9][0-9]{2})|("00"[1-9])|("0"[1-9][0-9])))  {postales++; imprimir("CODPOSTAL", yytext, linea);}
[1-4](("000"[1-9])|("00"[1-9][0-9])|("0"[1-9][0-9]{2})|([1-9][0-9]{2}[1-9]))    {postales++; imprimir("CODPOSTAL", yytext, linea);}
[5](("000"[1-9])|("00"[1-9][0-9])|("0"[1-9][0-9]{2})|([1-2][0-9]{2}[1-9]))    {postales++; imprimir("CODPOSTAL", yytext, linea);}

{letrama}{1,3}[.-]{digito}{1,6}     {matriculas++; imprimir("MATRICULA", yytext, linea);}
{letrama}{1,3}[.-]{digito}{4}[.-]{letrama}{1,2}     {matriculas++; imprimir("MATRICULA", yytext, linea);}
{digito}{4}[.-]([B-DF-HJ-NP-TV-Z]){3}     {matriculas++; imprimir("MATRICULA", yytext, linea);}

\n  {linea++;}

.   {}

%%

int main(int argc, char *argv[]){
	if(argc==2){
		yyin = fopen(argv[1], "rt");
		if(yyin==NULL){
			printf("El fichero %s no se puede abrir\n", argv[1]);
			exit(-1);
		}
	}else yyin= stdin;

linea=0;
emails=webs=fechas=telefonos=matriculas=postales=nifs= 0;
yylex ();
escribir_datos(emails, webs, fechas, telefonos, matriculas, postales, nifs);

return 0;

}

void escribir_datos(int emails, int webs, int fechas, int telefonos, int matriculas, int postales, int nifs){
	printf("\n\nCONTEO\nEmails=%d\nWebs=%d\nFechas=%d\nTelefonos=%d\nMatriculas=%d\nPostales=%d\nNIFS=%d\n", emails, webs, fechas, telefonos, matriculas, postales, nifs);
}

void imprimir(const char *cad, const char *cad_imp, int linea_p){
    printf("%s: \"%s\". Linea %d.\n", cad, cad_imp, linea_p);
}