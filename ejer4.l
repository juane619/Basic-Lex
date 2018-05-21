/*DECLARACIONES*/

%{
#include <stdio.h>

void escribir_datos(int nsecmay, int nsecmin, int nsecmaymin, int nent, int nrea, int sumaent, float sumarea);
void cifrar(const char *cad, int l);
/*

*/
%}

digito  [0-9]
entero  [\-]?{digito}+
real    {entero}.{entero}
real2   {real}[eE][\+\-]?{entero}


%%

[a-zA-z0-9\_\-@\+\%]+   {cifrar(yytext, yyleng);}
.   {}

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


yylex ();

return 0;

}

void cifrar(const char *cad, int l){
    for(int i=l-1; i>=0; i--){
        printf("%c", cad[i]);
}
    printf("\n");
}