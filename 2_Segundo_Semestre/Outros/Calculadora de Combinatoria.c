#include <stdio.h>

//funções matematicas
long long int fatorial(long long int numero);
long long int permutacao(long long int n);
long long int arranjo(long long int n, long long int r);
long long int combinacao(long long int n, long long int r);

//funções prestativas
char pergunta(long long int *n, long long int *r);

int main(){

  long long int numero = 0;
  long long int n = 0;
  long long int r = 0;

  char caractere = 0;

  caractere = pergunta(&n, &r);

  if(caractere == 'p'){
    numero = permutacao(n);
  }
  else if(caractere == 'a'){
    numero = arranjo(n, r);
  }
  else{
    numero = combinacao(n, r);
  }


  printf("%lld", numero);

  return 0;

}

char pergunta(long long int *n, long long int *r){

  char caractere = 0;

  do{
    printf("Caso seja uma permutação, digite p\n");
    printf("Caso seja uma ararnjo, digite a\n");
    printf("Caso seja uma combinação, digite c\n");
    printf("Digite o caractere: ");
    scanf(" %c", &caractere);

    if(caractere != 'p' && caractere != 'a' && caractere != 'c'){
      printf("digite um caractere valido: p, a ou c\n");
   }

  } while(caractere != 'p' && caractere != 'a' && caractere != 'c');


  if(caractere == 'p'){
    printf("digite o n: ");
    scanf("%lld", n);
  }
  else if(caractere == 'a'){
    printf("digite o n: ");
    scanf("%lld", n);
    printf("digite o r: ");
    scanf("%lld", r);
  }
  else{
    printf("digite o n: ");
    scanf("%lld", n);
    printf("digite o r: ");
    scanf("%lld", r);
  }

  return caractere;

}



long long int fatorial(long long int numero){

  long long int i = 0;
  long long int total = 1;

  for(i = 1; i < numero + 1; i++){
    total = total * i;
  }

  return total;

}

long long int permutacao(long long int n){

  long long int numero;

  numero = fatorial(n);

  return numero;

}

long long int arranjo(long long int n, long long int r){

  long long int numero;

  numero = fatorial(n) / fatorial(n - r);

  return numero;

}


long long int combinacao(long long int n, long long int r){

  long long int numero;

  numero = fatorial(n) / (fatorial(r) * fatorial(n - r));

  return numero;

}
