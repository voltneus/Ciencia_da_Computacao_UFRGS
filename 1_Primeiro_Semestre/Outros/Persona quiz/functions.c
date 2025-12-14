#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "raylib.h"
#include "functions.h"

void DesenhaButton(Botao botao, int x, int y){
  DrawRectangle(x - 10, y - 10, botao.largura + 20, botao.altura + 20, BLACK);
  DrawRectangle(x, y, botao.largura, botao.altura, botao.cor);
}

void DesenhaButton2(Botao botao, int x, int y){
  DrawRectangle(x - 5, y - 5, botao.largura + 10, botao.altura + 10, BLACK);
  DrawRectangle(x, y, botao.largura, botao.altura, botao.cor);
}

void DesenhaButton3(Botao botao, int x, int y){
  DrawRectangle(x - 7, y - 7, botao.largura + 14, botao.altura + 14, BLACK);
  DrawRectangle(x, y, botao.largura, botao.altura, botao.cor);
}

void DesenhaBorda(){
  DrawRectangle(0,0,1600, 900, BLACK);
  DrawRectangle(20, 20, 1560, 860, LIGHTGRAY);
}

bool MouseNoBotao(Botao *botao){
  return CheckCollisionPointRec(GetMousePosition(), (Rectangle){botao->x, botao->y, botao->largura, botao->altura});
}


void TrocaCorBotao(Botao *botao, int x, int y){
  if(MouseNoBotao(botao)){
    botao->cor = PINK;
  } else {
    botao->cor = RED;
  }
}

void TesteBotao(Botao botao, int *Gamescreen, int troca){
  if(MouseNoBotao(&botao) && IsMouseButtonPressed(MOUSE_BUTTON_LEFT)){
    *Gamescreen = troca;
  }
}

void TesteBotaoCerto(Botao botao, int *Fase, int troca){
  if(MouseNoBotao(&botao) && IsMouseButtonPressed(MOUSE_BUTTON_LEFT)){
    *Fase = troca;
  }
}

void TesteBotaoErrado(Botao botao, int *Fase){
  if(MouseNoBotao(&botao) && IsMouseButtonPressed(MOUSE_BUTTON_LEFT)){
    *Fase = 0;
  }
}

void Menu(int *Gamescreen, Botao botaojogo, Botao botaoquit, Imagem morgana, Imagem joker
          , Texto titulo, Texto textobotaojogo, Texto textobotaoquit){

  DrawText(titulo.texto, titulo.x, titulo.y, titulo.fonte, titulo.cor);


  TrocaCorBotao(&botaojogo, botaojogo.x, botaojogo.y);
  TesteBotao(botaojogo, Gamescreen, JOGO);
  DesenhaButton(botaojogo, botaojogo.x, botaojogo.y);
  DrawText(textobotaojogo.texto, textobotaojogo.x, textobotaojogo.y, textobotaojogo.fonte, textobotaojogo.cor);


  TrocaCorBotao(&botaoquit, botaoquit.x, botaoquit.y);
  TesteBotao(botaoquit, Gamescreen, SAIRJOGO);
  DesenhaButton(botaoquit, botaoquit.x, botaoquit.y);
  DrawText(textobotaoquit.texto, textobotaoquit.x, textobotaoquit.y, textobotaoquit.fonte, textobotaoquit.cor);

  DrawTextureRec(morgana.textura, morgana.retangulo, morgana.vetor, WHITE);
  DrawTextureRec(joker.textura, joker.retangulo, joker.vetor, WHITE);


}

void Fase1(Texto titulo, Botao BotaoCerto, Botao BotaoErrado1, Botao BotaoErrado2, Botao BotaoErrado3
           , Texto TextoAlt1, Texto TextoAlt2, Texto TextoAlt3, Texto TextoAlt4, Imagem Pergunta, int *Fase){

  DrawText(titulo.texto, titulo.x, titulo.y, titulo.fonte, titulo.cor);

  DrawTextureRec(Pergunta.textura, Pergunta.retangulo, Pergunta.vetor, WHITE);

  TrocaCorBotao(&BotaoCerto, BotaoCerto.x, BotaoCerto.y);
  TesteBotaoCerto(BotaoCerto, Fase, FASE2);
  DesenhaButton(BotaoCerto, BotaoCerto.x, BotaoCerto.y);
  DrawText(TextoAlt1.texto, TextoAlt1.x, TextoAlt1.y, TextoAlt1.fonte, TextoAlt1.cor);

  TrocaCorBotao(&BotaoErrado1, BotaoErrado1.x, BotaoErrado1.y);
  TesteBotaoErrado(BotaoErrado1, Fase);
  DesenhaButton(BotaoErrado1, BotaoErrado1.x, BotaoErrado1.y);
  DrawText(TextoAlt2.texto, TextoAlt2.x, TextoAlt2.y, TextoAlt2.fonte, TextoAlt2.cor);

  TrocaCorBotao(&BotaoErrado2, BotaoErrado2.x, BotaoErrado2.y);
  TesteBotaoErrado(BotaoErrado2, Fase);
  DesenhaButton(BotaoErrado2, BotaoErrado2.x, BotaoErrado2.y);
  DrawText(TextoAlt3.texto, TextoAlt3.x, TextoAlt3.y, TextoAlt3.fonte, TextoAlt3.cor);

  TrocaCorBotao(&BotaoErrado3, BotaoErrado3.x, BotaoErrado3.y);
  TesteBotaoErrado(BotaoErrado3, Fase);
  DesenhaButton(BotaoErrado3, BotaoErrado3.x, BotaoErrado3.y);
  DrawText(TextoAlt4.texto, TextoAlt4.x, TextoAlt4.y, TextoAlt4.fonte, TextoAlt4.cor);
}



void Fase2(){


}


