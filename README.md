Basic exercises of Lex(scanners)

INSTRUCCIONES PARA SU EJECUCIÓN:

-	lex "ejerX.l" ó flex "ejerX.l"
-	gcc lex.yy.c -o prog -ll ó gcc lex.yy.c -o prog -lfl
-	./prog [file_input]

EJ1)  Plantilla en Lex para encontrar direcciones de correo electrónico, de páginas 
web,  fechas, números de teléfono, matrículas, códigos postales y NIF en un fichero 
texto. 
 
EJ2)  Plantilla  Lex  que  tras  leer  un  texto  nos  diga  el  número  de  caracteres, 
palabras  y  líneas  de  dicho  texto,  entendiéndose  por  palabra  toda  secuencia  de 
caracteres que no posea ni espacios ni tabuladores ni retornos de carro. Se supone que 
toda línea está acabada por un retorno de carro (\n). 
 
EJ3) Plantilla Lex que lea un fichero de texto, realice las siguientes acciones y 
presente los resultados por pantalla: 
 
•      Contar  el  número  de  secuencias  de  caracteres  escritas  completamente  en 
mayúsculas. 
•      Contar  el  número  de  secuencias  de  caracteres  escritas  completamente  en 
minúsculas. 
•      Contar  el  número  de  secuencias  de  caracteres  que  mezclen  mayúsculas  y 
minúsculas. 
•      Contar el número de números enteros. Modelos de computación  
Prácticas     Pag. 12 
•      Contar  el  número  de  números  reales  (Deberá  aceptar  números  reales 
escritos con punto decimal (34.54, 3.00) y números con exponente (1.5E4, 2e-
4, ...)) 
•      Calcular la suma de todos los números enteros encontrados. 
•      Calcular la suma de todos los números reales encontrados. 
 
EJ4) Plantilla Lex, de manera que se cifre el texto de entrada, convirtiendo cada 
palabra en su inversa. El concepto de palabra es el mismo que en el apartado b). 
 
