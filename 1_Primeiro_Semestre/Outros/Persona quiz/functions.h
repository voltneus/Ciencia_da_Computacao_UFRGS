#ifndef FUNCOES_H
#define FUNCOES_H

#include "raylib.h"   // Se você estiver usando tipos da raylib como Rectangle e Color
#include "definitions.h"


bool MouseNoBotao(Botao *botao);
void TrocaCorBotao(Botao *botao, int x, int y);
void TesteBotao(Botao botao, int *Gamescreen, int troca);

void TesteBotaoCerto(Botao botao, int *Fase, int troca);
void TesteBotaoErrado(Botao botao, int *Fase);

void DesenhaButton(Botao botao, int x, int y);
void DesenhaButton2(Botao botao, int x, int y);
void DesenhaButton3(Botao botao, int x, int y);

void DesenhaBorda();

void Menu(int *Gamescreen, Botao botaojogo, Botao botaoquit, Imagem morgana, Imagem joker
          , Texto titulo, Texto textobotaojogo, Texto textobotaoquit);

void Jogo();

void Fase1(Texto titulo, Botao BotaoCerto, Botao BotaoErrado1, Botao BotaoErrado2, Botao BotaoErrado3
           , Texto TextoAlt1, Texto TextoAlt2, Texto TextoAlt3, Texto TextoAlt4, Imagem Pergunta, int *Fase);

void Fase2();


#endif
