#include <stdio.h>
#include <stdlib.h>
#include "raylib.h"

#include "definitions.h"
#include "functions.h"
#include "functions.h"

void RespostaErradaTela(Texto TextoRespostaCerta, Imagem RespostaErrada){
  DrawText(TextoRespostaCerta.texto, TextoRespostaCerta.x, TextoRespostaCerta.y, TextoRespostaCerta.fonte, TextoRespostaCerta.cor);

  DrawTextureRec(RespostaErrada.textura, RespostaErrada.retangulo, RespostaErrada.vetor, WHITE);
}

void RespostaCertaTela(Texto TextoRespostaCerta, Imagem RespostaCerta){
  DrawText(TextoRespostaCerta.texto, TextoRespostaCerta.x, TextoRespostaCerta.y, TextoRespostaCerta.fonte, TextoRespostaCerta.cor);

  DrawTextureRec(RespostaCerta.textura, RespostaCerta.retangulo, RespostaCerta.vetor, WHITE);

}



void Jogo(int *Gamescreen){

  //numero da constante é a fase
  int Fase = 1;

  SetTargetFPS(60);
  int contaframe = 0;
  int FlagRespostaErrada = 0;

  //Tela da resposta certa

  Texto TextoRespostaCerta = {"Resposta Certa!;)", FONTSIZETITULO, 450, 100, BLACK};
  Imagem RespostaCerta = {0};
  RespostaCerta.textura = LoadTexture("Extra/Ann.png");
  RespostaCerta.retangulo = (Rectangle){0, 0, 564, 500};
  RespostaCerta.vetor = (Vector2){IMGX, IMGY};


  //Tela da resposta errada
  Texto TextoRespostaErrada = {"Resposta Errada!!!!!", FONTSIZETITULO, 300, 50, BLACK};
  Imagem RespostaErrada = {0};
  RespostaErrada.textura = LoadTexture("Extra/fuuka.png");
  RespostaErrada.retangulo = (Rectangle){0, 0, 500, 500};
  RespostaErrada.vetor = (Vector2){500, 300};

  //Pergunta 1
  Texto TituloP1 = {"Qual a melhor Phantom Thieve?", FONTSIZEGRANDE, 70, 50, BLACK};
  Botao BotaoP1Certo = {150, 300, ALT1X, ALT1Y, RED};
  Botao BotaoP1Errado1 = {150, 300, ALT2X, ALT2Y, RED};
  Botao BotaoP1Errado2 = {150, 300, ALT3X, ALT3Y, RED};
  Botao BotaoP1Errado3 = {150, 300, ALT4X, ALT4Y, RED};
  Texto TextoP1Alt1 = {"Ann", FONTSIZEMEDIA, BotaoP1Certo.x + 30, BotaoP1Certo.y + 40, BLACK};
  Texto TextoP1Alt2 = {"Makoto", FONTSIZEMEDIA, BotaoP1Errado1.x + 30, BotaoP1Errado1.y + 40, BLACK};
  Texto TextoP1Alt3 = {"Futaba", FONTSIZEMEDIA, BotaoP1Errado2.x + 30, BotaoP1Errado2.y + 40, BLACK};
  Texto TextoP1Alt4 = {"Haru", FONTSIZEMEDIA, BotaoP1Errado3.x + 30, BotaoP1Errado3.y + 40, BLACK};

  Imagem Pergunta1 = {0};
  Pergunta1.textura = LoadTexture("Extra/Pergunta1.jpg");
  Pergunta1.retangulo = (Rectangle){0, 0, 319, 250};
  Pergunta1.vetor = (Vector2){IMGX, IMGY};


  while (!WindowShouldClose() && FlagRespostaErrada == 0){

    BeginDrawing();

    ClearBackground(RAYWHITE);
    DesenhaBorda();

    switch(Fase){
      case -1:{
        contaframe++;
        RespostaCertaTela(TextoRespostaCerta, RespostaCerta);
        if(contaframe > 120){
          FlagRespostaErrada = 1;
        }
        break;
      case 0:{
        contaframe++;
        RespostaErradaTela(TextoRespostaErrada, RespostaErrada);
        if(contaframe > 120){
          FlagRespostaErrada = 1;
        }
        break;
      }
      case FASE1:{
        Fase1(TituloP1, BotaoP1Certo, BotaoP1Errado1, BotaoP1Errado2, BotaoP1Errado3
              , TextoP1Alt1, TextoP1Alt2, TextoP1Alt3, TextoP1Alt4, Pergunta1, &Fase);
        if(Fase != FASE1){
          UnloadTexture(Pergunta1.textura);
        }
        break;
      }
      case FASE2:{
        Fase2();
        break;
      }
    }

    EndDrawing();

  }

  *Gamescreen = 0;
}



int main(){

  //0 - Menu, Jogo = 1
  int Gamescreen = 0;

  //Botões
  Botao BotaoJogo = {150, 250, 650, 400, RED};
  Texto TextoBotaoJogo = {"Jogar", FONTSIZEMEDIA, BotaoJogo.x + 30, BotaoJogo.y + 40, BLACK};

  Botao BotaoQuit = {150, 250, 650, 600, RED};
  Texto TextoBotaoQuit = {"Sair", FONTSIZEMEDIA, BotaoQuit.x + 30, BotaoQuit.y + 40, BLACK};


  //Textos avulsos
  Texto Titulo = {"Persona Quiz", FONTSIZETITULO, 450, 100, BLACK};


  InitWindow(LARGURA, ALTURA, "Persona Quiz");

  //Imagens
  Imagem morgana = {0};
  morgana.textura = LoadTexture("Extra/morgana.png");
  morgana.retangulo = (Rectangle){0, 0, 374, 350};
  morgana.vetor = (Vector2){150, 350};


  Imagem joker = {0};
  joker.textura = LoadTexture("Extra/joker.jpg");
  joker.retangulo = (Rectangle){0, 0, 232, 500};
  joker.vetor = (Vector2){1100, 250};


  SetTargetFPS(60);

  while (!WindowShouldClose() && Gamescreen != -1){

    BeginDrawing();

    ClearBackground(RAYWHITE);
    DesenhaBorda();

    switch(Gamescreen){
      case MENU:{
        Menu(&Gamescreen, BotaoJogo, BotaoQuit, morgana, joker, Titulo, TextoBotaoJogo, TextoBotaoQuit);
        break;
      }
      case JOGO:{
        Jogo(&Gamescreen);
        break;
      }
      default: break;
    }

    EndDrawing();
  }

  if(Gamescreen != 0){
  UnloadTexture(morgana.textura);
  UnloadTexture(joker.textura);
  }

  return 0;
}
