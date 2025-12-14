#include <stdio.h>
#include "raylib.h"

#ifndef DEFINITIONS_H
#define DEFINITIONS_H

//Definições

//Tela
#define LARGURA 1600
#define ALTURA 900

//Tamanho da fonte
#define FONTSIZETITULO 100
#define FONTSIZEGRANDE 90
#define FONTSIZEMEDIA 70

//Cordenadas
#define ALT1X 300
#define ALT1Y 450

#define ALT2X 900
#define ALT2Y 450

#define ALT3X 300
#define ALT3Y 650

#define ALT4X 900
#define ALT4Y 650

#define IMGX 600
#define IMGY 150

//Constantes
#define SAIRJOGO -1
#define MENU 0
#define JOGO 1

#define FASE1 1
#define FASE2 2
#define FASE3 3
#define FASE4 4
#define FASE5 5
#define FASE6 6
#define FASE7 7
#define FASE8 8
#define FASE9 9
#define FASE10 10


//Estruturas

typedef struct {
  int altura;
  int largura;
  int x;
  int y;
  Color cor;
} Botao;

typedef struct {
  char texto[30];
  int fonte;
  int x;
  int y;
  Color cor;
} Texto;

typedef struct {
  Rectangle retangulo;
  Texture2D textura;
  Vector2 vetor;
} Imagem;

#endif

