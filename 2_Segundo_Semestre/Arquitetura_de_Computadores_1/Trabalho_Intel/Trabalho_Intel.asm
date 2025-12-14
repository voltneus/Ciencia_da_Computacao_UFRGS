.model small
.stack 100h

.data ;dados --------------------------

;constantes do codigo
CR EQU 0Dh ;/r
LF EQU 0Ah
EOF EQU 0

EOS EQU 7FFFh 

FlagNumeroNegativo dw 0 ;se for zero é positivo

nomeArquivoDados	db	"DADOS.txt",0
handleArquivoDados dw 0 
mensagemErroAbeturaArquivoDados db	"Erro na abertura do arquivo de dados",0
mensagemErroFechamentoArquivoDados db	"Erro no fechamento do arquivo de dados",0
mensagemErroLeituraArquivoDados db	"Erro na leitura do arquivo de dados",0
stringArquivoDados db 1000 dup (?)
numeroCaracteresArquivoDados dw 0
stringNumeroColunasArquivoDados db 10 dup (?)
NumeroColunasArquivoDados dw 0


nomeArquivoExp	db	"EXP.txt",0
handleArquivoExp dw 0 
mensagemErroAberturaArquivoExp db	"Erro na abertura do arquivo de expressoes",0
mensagemErroFechamentoArquivoExp db	"Erro no fechamento do arquivo de expressoes",0
mensagemErroLeituraArquivoExp db	"Erro na leitura do arquivo de expressoes",0
stringArquivoExp db 10000 dup (?)
numeroCaracteresArquivoExp dw 0
numeroDeExpressoes dw 0


BufferString db 50 dup (?)

;Informações de uma linha do arquivo de expressões
FlagLinhaResultado dw 0 ; caso 0 -> linha não é de resultados ; caso 1 -> linha é de resultados
NumeroResultadoFinal dw 0
FlagNumero1Constante dw 0 ; caso 0 -> numero é constante ; caso 1 -> numero não é uma constante
Numero1 dw 0 ;numero do lado esquerdo da operação 

operacao db 0 ; caractere da operação

FlagNumero2Constante dw 0 ; caso 0 -> numero é constante ; caso 1 -> numero não é uma constante
Numero2 dw 0 ;numero do lado direito da operação

;erros do arquivo de expressões
mensagemErroNumeroColunaNegativo db	"Numero de uma coluna negativo no arquivo de expressoes",0
mensagemErroNumeroMaiorQuePermitido db	"Numero de uma coluna maior que o permitido no arquivo de expressoes",0
mensagemErroOperacaoInvalida db	"Operacao invalida no arquivo de expressoes",0

;Informações de uma linha do arquivo de dados
MatrizDados dw 100*20 dup(?) ; matriz 100x20
NumeroDeLinhasDados dw 0  ;guarda o numero de linhas encontrado no arquivo de dados
mensagemErroColunaArquivoDados db	"Numero errado de colunas no arquivo de dados",0

mensagemErroDivisaoPorZero db	"Divisao por zero foi executada, programa foi parado",0


nomeArquivoResultados	db	"RESULT.txt",0
handleArquivoResultados dw 0 
mensagemErroCriacaoArquivoResultados db	"Erro na criacao do arquivo de resultados",0
mensagemErroFechamentoArquivoResultados db "Erro no fechamento do arquivo de resultados",0

MensagemErroEscritaExpressao db "Erro na escrita da expressao",0

BufferMatrizArquivoResultado db 1000 dup (?)

EnderecoLinhaAtual dw ?
 
;variaveis para a sprintf_w
sw_n dw ?
sw_m dw ?
sw_f dw ?

MensagemErro db "Erro", LF, 0

.code
.startup ;codigo ---------------------

;Abertura do arquivo do arquivo de dados
call AberturaArquivoDados

;Le os dados dos arquivos de dados e coloca na string
call LeituraArquivoDados

;coloca o numero de colunas na variavel NumeroColunasArquivoDados
call ColunasEmString

;verifica a integridade do arquivo de dados
call VerificacaoArquivoDados

;Se tiver tudo certo, interpreta e coloca na matriz
call InterpretacaoLinhaArquivoDados


;--------------------------------
;abertura e verificação do arquivo de dados completa

;Abertura do arquivo do arquivo de expressões
call AberturaArquivoExp

;Le os dados dos arquivos de expressões e coloca na string
call LeituraArquivoExp

;verifica a integridade do arquivo de expressões
call VerificacaoArquivoExp

;a interpretação da Arquivo dados é feita linha por linha,
;portanto sera chamada em loops até ler o arquivo inteiro

;--------------------------------
;abertura e verificação do arquivo de expressões e de dados completa

;Criação do arquivo de resultados

call CriarArquivoDeResultado

;Com tudo pronto, podemos executar as expressões

lea bx, MatrizDados
add bx, 10
mov ax, [bx]

call ExecutarExpressoes


call FechaTodosOsArquivos

.exit




;--------------------------------------------
;Funções

;==============================================
;FUNÇÕES PARA EXECUÇÃO DAS EXPRESSÕES

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função main para executar todas as expressões de um arquivo
ExecutarExpressoes proc near

mov cx, numeroDeExpressoes
lea si, stringArquivoExp

LoopExecucaoDeExpressoes:

;salvo o endereço da linha para printar depois caso precise
mov EnderecoLinhaAtual, si

;interpreta a linha do arquivo de expressões
push cx
call InterpretacaoLinhaArquivoExp 
pop cx

;realiza a operação
push cx
push si 
call RealizarOperacao
pop si
pop cx 

;caso a flag FlagLinhaResultado seja 1 escreve no arquivo de resultados
mov ax, FlagLinhaResultado
or ax, ax
jz LinhaNaoEhDeResultado
push cx
push si 
call EscreverResultadoSeNecessario
pop si 
pop cx
LinhaNaoEhDeResultado:

;coloca o ponteiro para a proxima linha
call PonteiroProximaLinha 

;loopa caso o numero de expressões não tenha acabado(cx)
loop LoopExecucaoDeExpressoes

ret 
ExecutarExpressoes endp

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função para escrever as expressoes no arquivo de resultado
EscreverResultadoSeNecessario proc near

mov si, EnderecoLinhaAtual
mov cx, 0

;vamos colocar tudo em um buffer novo
call LimpaBufferMatrizArquivoResultado

lea bx, BufferMatrizArquivoResultado

NaoAcabouAStringDaExpressaoASerEscrita:

mov al, [si]
mov [bx], al

;avança os ponteiros
inc bx
inc si

inc cx ;contador

cmp byte ptr [si], LF
jnz NaoAcabouAStringDaExpressaoASerEscrita

;move o ultimo LF para a string
mov al, [si]
mov [bx], al

inc cx ;e incrementa o cx

;começa a escrita no arquivo

mov ah, 40h
mov bx, handleArquivoResultados
lea dx, BufferMatrizArquivoResultado
int 21h

jnc EscritaCorretaDaExpressao

call FechaTodosOsArquivos

lea bx, MensagemErroEscritaExpressao
call printf_s

.exit

EscritaCorretaDaExpressao:


;ESCREVER AS LINHAS DA MATRIZ
;vamos colocar tudo em um buffer novo

call LimpaBufferMatrizArquivoResultado

lea bx, BufferMatrizArquivoResultado
lea si, MatrizDados

mov bp, NumeroDeLinhasDados ;variavel de controle
cmp bp, 0
jz FimDaEscritaNoBufferDeDados

loopLinha:
push bp

mov cx, NumeroColunasArquivoDados

loopColuna:

mov ax, [si]
push cx
call sprintf_w
pop cx

add si, 2

cmp cx, 1
jz UltimaColuna

mov byte ptr [bx], ";"
inc bx

UltimaColuna:

loop LoopColuna

mov byte ptr [bx], CR
inc bx
mov byte ptr [bx], LF
inc bx

pop bp
dec bp
jnz LoopLinha

FimDaEscritaNoBufferDeDados:

;começa a escrita no arquivo

;primeira coisa = numero de caracteres
mov ax, bx
lea bx, BufferMatrizArquivoResultado
sub ax, bx 
mov cx, ax ; move para cx a diferença dos endereços

;depois escreve

mov ah, 40h
mov bx, handleArquivoResultados
lea dx, BufferMatrizArquivoResultado
int 21h

jnc EscritaCorretaDaMatriz

call FechaTodosOsArquivos

lea bx, MensagemErroEscritaExpressao
call printf_s

.exit

EscritaCorretaDaMatriz:


ret 
EscreverResultadoSeNecessario endp


;----------------------------------------------------------------------
;função para escrever as expressoes no arquivo de resultado
LimpaBufferMatrizArquivoResultado proc near

mov cx, 1000
lea bx, BufferMatrizArquivoResultado

LimpaBuffer:

mov byte ptr [bx], 0
inc bx
loop LimpaBuffer

ret 
LimpaBufferMatrizArquivoResultado endp


;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função main para realizar a operação de uma linha
RealizarOperacao proc near

mov al, operacao


;SOMA
cmp al, "+"
jnz NaoEhSoma

call OperacaoSoma

jmp FimDasOperacoes
NaoEhSoma:

;SUBTRAÇÃO
cmp al, "-"
jnz NaoEhSubtracao

call OperacaoSubtracao

jmp FimDasOperacoes
NaoEhSubtracao:

;MULTIPLICAÇÃO
cmp al, "*"
jnz NaoEhMultiplicacao

call OperacaoMultiplicacao

jmp FimDasOperacoes
NaoEhMultiplicacao:

;DIVISÃO
cmp al, "/"
jnz NaoEhDivisao

call OperacaoDivisao

jmp FimDasOperacoes
NaoEhDivisao:

;RESTO
cmp al, "%"
jnz NaoEhResto

call OperacaoResto

jmp FimDasOperacoes
NaoEhResto:

;AND
cmp al, "&"
jnz NaoEhAND

call OperacaoAND

jmp FimDasOperacoes
NaoEhAND:

;OR
cmp al, "|"
jnz NaoEhOR

call OperacaoOR

jmp FimDasOperacoes
NaoEhOR:

;XOR
cmp al, "^"
jnz NaoEhXOR

call OperacaoXOR

jmp FimDasOperacoes
NaoEhXOR:

FimDasOperacoes:

ret 
RealizarOperacao endp

;----------------------------------------------------------------------
;funções auxiliares da RealizarOperacao

;-------------------------------------------------------
;função auxiliar para realizar o calculo do endereço 
;dos Operandos e resultado
;calculo do endereço da matriz
; endereço da matriz + ((NumeroColunasArquivoDados * operando) * 2(tamanho da palavra))
CalculaEndereco proc near

mov ax, FlagNumero1Constante
or ax, ax
jz Numero1EhConstante
;ENDEREÇO DO OPERANDO 1
mov ax, Numero1 ;ax = operando
mul NumeroColunasArquivoDados ; ax = NumeroColunasArquivoDados * operando
shl ax, 1
lea si, MatrizDados
add si, ax
jmp Numero1NaoEhConstante

Numero1EhConstante:
;se não da o endereço da constante
lea si, Numero1
Numero1NaoEhConstante:

mov ax, FlagNumero2Constante
or ax, ax
jz Numero2EhConstante
;ENDEREÇO DO OPERANDO 2
mov ax, Numero2 ;ax = operando
mul NumeroColunasArquivoDados ; ax = NumeroColunasArquivoDados * operando
shl ax, 1
lea di, MatrizDados
add di, ax
jmp Numero2NaoEhConstante

Numero2EhConstante:
;se não da o endereço da constante
lea di, Numero2
Numero2NaoEhConstante:

;ENDEREÇO DO RESULTADO
mov ax, NumeroResultadoFinal ;ax = operando
mul NumeroColunasArquivoDados ; ax = NumeroColunasArquivoDados * operando
shl ax, 1
lea bx, MatrizDados
add bx, ax

ret 
CalculaEndereco endp

;Função que incrementa endereços caso necessario
IncrementaEnderecos proc near


mov ax, FlagNumero1Constante
or ax, ax
jz Numero1EhConstante2
add si, 2
Numero1EhConstante2:

mov ax, FlagNumero2Constante
or ax, ax
jz Numero2EhConstante2
add di, 2
Numero2EhConstante2:

add bx, 2


ret 
IncrementaEnderecos endp


;-------------------------------------------------------
;funções auxiliar para realizar a soma
OperacaoSoma proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopSoma:

;ax recebe o operando 1
mov ax, [si]
;ax soma o operando 2
add ax, [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopSoma

ret 
OperacaoSoma endp

;-------------------------------------------------------
;funções auxiliar para realizar a subtração
OperacaoSubtracao proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopSubtracao:

;ax recebe o operando 1
mov ax, [si]
;ax subtrai o operando 2
sub ax, [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopSubtracao


ret 
OperacaoSubtracao endp

;-------------------------------------------------------
;funções auxiliar para realizar a Multiplicação
OperacaoMultiplicacao proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopMultiplicacao:

;ax recebe o operando 1
mov ax, [si]
;ax multiplicado pelo operando 2
imul word ptr [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopMultiplicacao


ret 
OperacaoMultiplicacao endp

;-------------------------------------------------------
;funções auxiliar para realizar a Divisão
OperacaoDivisao proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopDivisao:

mov ax, [di]
cmp ax, 0
jnz NaoEhDivisaoPorZero

call FechaTodosOsArquivos

lea bx, mensagemErroDivisaoPorZero
call printf_s

.exit

NaoEhDivisaoPorZero:

mov dx, 0
;ax recebe o operando 1
mov ax, [si]

cwd      ; -> estende o sinal de ax para dx

;ax é dividido pelo operando 2
idiv word ptr [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopDivisao

ret 
OperacaoDivisao endp

;-------------------------------------------------------
;funções auxiliar para realizar a Divisão por resto
OperacaoResto proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopResto:

mov ax, [di]
cmp ax, 0
jnz NaoEhRestoPorZero

call FechaTodosOsArquivos

lea bx, mensagemErroDivisaoPorZero
call printf_s

.exit

NaoEhRestoPorZero:

mov dx, 0
;ax recebe o operando 1
mov ax, [si]

cwd      ; -> estende o sinal de ax para dx


;ax é dividido pelo operando 2
idiv word ptr [di]
;move o ax para o endereço da linha de destino
mov [bx], dx

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopResto


ret 
OperacaoResto endp

;-------------------------------------------------------
;funções auxiliar para realizar a operação AND
OperacaoAND proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopAND:

;ax recebe o operando 1
mov ax, [si]
;ax é operado com and com operando 2
and ax, [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopAND

ret 
OperacaoAND endp

;-------------------------------------------------------
;funções auxiliar para realizar a operação OR
OperacaoOR proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopOR:

;ax recebe o operando 1
mov ax, [si]
;ax é operado com or com operando 2
or ax, [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopOR

ret 
OperacaoOR endp


;-------------------------------------------------------
;funções auxiliar para realizar a operação XOR
OperacaoXOR proc near

;variavel para condicionar o loop
mov cx, NumeroColunasArquivoDados 

;CALCULO DO ENDEREÇO DOS OPERANDOS E RESULTADOS
push cx
call CalculaEndereco
pop cx

LoopXOR:

;ax recebe o operando 1
mov ax, [si]
;ax é operado com xor com operando 2
xor ax, [di]
;move o ax para o endereço da linha de destino
mov [bx], ax

;avança os ponteiros, caso não sejam constantes
call IncrementaEnderecos

loop LoopXOR

ret 
OperacaoXOR endp




;==============================================
;==============================================
;==============================================
;FUNÇÕES PARA FECHAR OS ARQUIVOS E CRIAR O ARQUIVO DE RESULTADOS


;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função para criar o arquivo de resultados
CriarArquivoDeResultado  proc near

mov cx , 0 ;Atributos do arquivo
lea dx, nomeArquivoResultados
mov ah, 3Ch
int 21h

jnc AberturaCorretaArquivoResultados
;caso haja algum problema na abertura do arquivo

;fechando o arquivo de dados
mov ah, 3eh
mov bx, handleArquivoDados
int 21h

jnc arquivoDadosFechadoCorretamente2

;teve problema no fechamento do arquivo de dados
lea bx, mensagemErroFechamentoArquivoDados     ;bx = mensagem de erro, se ocorrer
call	printf_s

arquivoDadosFechadoCorretamente2:

;fechando o arquivo de expressões
mov ah, 3eh
mov bx, handleArquivoExp
int 21h

jnc arquivoExpressoesFechadoCorretamente2

;teve problema no fechamento do arquivo de dados
lea bx, mensagemErroFechamentoArquivoExp     ;bx = mensagem de erro, se ocorrer
call	printf_s

arquivoExpressoesFechadoCorretamente2:

;mensagem de erro do fechamento do arquivo de resultados
lea bx, mensagemErroCriacaoArquivoResultados    ;bx = mensagem de erro, se ocorrer
call	printf_s


.exit

AberturaCorretaArquivoResultados:
;Caso a abertura aconteça sem problemas

mov handleArquivoResultados, ax

ret 
CriarArquivoDeResultado endp


;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função para fechar os arquivos no final do programa
FechaTodosOsArquivos proc near

;FECHA O ARQUIVO DE DADOS
mov ah, 3eh
mov bx, handleArquivoDados
int 21h

jnc arquivoDadosFechadoCorretamente

;teve problema no fechamento do arquivo de dados
lea bx, mensagemErroFechamentoArquivoDados     ;bx = mensagem de erro, se ocorrer
call	printf_s

arquivoDadosFechadoCorretamente:

;FECHA O ARQUIVO DE EXPRESSÕES
mov ah, 3eh
mov bx, handleArquivoExp
int 21h

jnc arquivoExpressoesFechadoCorretamente

;teve problema no fechamento do arquivo de dados
lea bx, mensagemErroFechamentoArquivoExp     ;bx = mensagem de erro, se ocorrer
call	printf_s

arquivoExpressoesFechadoCorretamente:

;FECHA O ARQUIVO DE RESULTADOS
mov ah, 3eh
mov bx, handleArquivoResultados
int 21h

jnc arquivoResultadosFechadoCorretamente

;teve problema no fechamento do arquivo de dados
lea bx, mensagemErroFechamentoArquivoResultados     ;bx = mensagem de erro, se ocorrer
call	printf_s

arquivoResultadosFechadoCorretamente:


ret 
FechaTodosOsArquivos endp


;==============================================================================
;==============================================================================
;==============================================================================
;==============================================================================
;==============================================================================
; FUNÇÕES DE VERIFICAÇÃO E INTERPRETAÇÃO DOS ARQUIVOS DE DADOS E EXPRESSÕES



;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função para colocar as informações de uma linha de expressões em suas respectivas variaveis
;Entrada:
;-endereço da linha (si)
;-endereço da matriz de dados(di)
;saida:
;matriz de dados pronta
InterpretacaoLinhaArquivoDados proc near

lea si, stringArquivoDados
lea di, MatrizDados
mov NumeroDeLinhasDados, 0

;pula a linha que tem o numero de colunas da matriz
call PonteiroProximaLinha 

ComecoLinhaArquivoDados:

;Testa se acabou o arquivo
cmp byte ptr [si], EOF
jz InterpretacaoCompleta

inc NumeroDeLinhasDados

;COMEÇO DA LEITURA DE UM NUMERO NOVO DO ARQUIVO DE DADOS
ComecoNumeroDoArquivoDados:

call LimpaBufferString
lea bx, BufferString

;continuação do numero
ContinuacaoNumeroDoArquivoDados:

cmp byte ptr [si], ";"
jz TerminouONumero

cmp byte ptr [si], CR
jz TerminouONumero

cmp byte ptr [si], LF
jz TerminouONumero

cmp byte ptr [si], EOF
jz TerminouONumero

mov al, [si]
mov [bx], al

inc si
inc bx

jmp ContinuacaoNumeroDoArquivoDados

TerminouONumero:

mov byte ptr [bx], 0 ;coloquei 0 no fim do numero
lea bx, BufferString
call atoi

mov [di], ax ;coloquei o numero na matriz
add di, 2 ;soma dois por ser dw(word)

cmp byte ptr [si], ";"
jnz FimDaLinha

inc si
jmp ComecoNumeroDoArquivoDados

FimDaLinha:

call PonteiroProximaLinha
jmp ComecoLinhaArquivoDados


InterpretacaoCompleta:


ret
InterpretacaoLinhaArquivoDados endp





;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função de verificação do arquivo de expressões
VerificacaoArquivoExp proc near

call ContaNumeroDeExpressoes
mov cx, numeroDeExpressoes

lea si, stringArquivoExp

VerificacaoExp:

push cx
call InterpretacaoLinhaArquivoExp
pop cx

call PonteiroProximaLinha ;ponteiro vai para a proxima linha

call AuxiliarOperacoesVerificacaoArquivoExp ;testa as operaçoes

call AuxiliarColunasNegativasVerificacaoArquivoExp ;testa colunas negativas

call AuxiliarColunasMaiorVerificacaoArquivoExp ;testa colunas maior que o possivel


loop VerificacaoExp


ret
VerificacaoArquivoExp endp

;---------------------------------------
;Funções auxiliares de VerificacaoArquivoExp
AuxiliarOperacoesVerificacaoArquivoExp proc near

;Primeiro passo: checa se a operação é invalida
cmp operacao, "+"
jz operacaoCorreta

cmp operacao, "-"
jz operacaoCorreta

cmp operacao, "*"
jz operacaoCorreta

cmp operacao, "/"
jz operacaoCorreta

cmp operacao, "%"
jz operacaoCorreta

cmp operacao, "&"
jz operacaoCorreta

cmp operacao, "|"
jz operacaoCorreta

cmp operacao, "^"
jz operacaoCorreta

;se não caiu em nenhum jump, quer dizer que é uma operação invalida

;mensagem de erro
lea bx, mensagemErroOperacaoInvalida     ;bx = mensagem de erro, se ocorrer
call	printf_s

.exit

operacaoCorreta:

ret
AuxiliarOperacoesVerificacaoArquivoExp endp

;---------------------------------------
AuxiliarColunasNegativasVerificacaoArquivoExp proc near

;Segundo passo: se não for constante, deve ser positiva

;teste com resultado que não pode ser constante
;não pode ser negativa
mov ax, NumeroResultadoFinal
or ax, ax
js ErroColunaNegativa

;teste com numero1 se não for constante
mov ax, FlagNumero1Constante
or ax, ax
jz ProximoTesteNumero1

mov ax, Numero1
or ax, ax
js ErroColunaNegativa

ProximoTesteNumero1:

mov ax, FlagNumero2Constante
or ax, ax
jz ProximoTesteNumero2

mov ax, Numero2
or ax, ax
js ErroColunaNegativa

ProximoTesteNumero2:

jmp TesteFinalColunaMaior ;jampa para o proximo teste

ErroColunaNegativa:
lea bx, mensagemErroNumeroColunaNegativo     ;bx = mensagem de erro, se ocorrer
call	printf_s

.exit

TesteFinalColunaMaior:

ret
AuxiliarColunasNegativasVerificacaoArquivoExp endp

;---------------------------------------
AuxiliarColunasMaiorVerificacaoArquivoExp proc near

;terceiro passo: Se for da coluna de dados deve ser menor que o numero de colunas

mov ax, NumeroResultadoFinal
cmp ax, NumeroDeLinhasDados
jae ErroColunaMaiorQueDevido


;teste com o numero1
mov ax, FlagNumero1Constante
or ax, ax
jz ProximoTeste2Numero1 ;jampa se for constante

mov ax, Numero1
cmp ax, NumeroDeLinhasDados
jae ErroColunaMaiorQueDevido

ProximoTeste2Numero1:

;teste com o numero2
mov ax, FlagNumero2Constante
or ax, ax
jz ProximoTeste2Numero2 ;jampa se for constante

mov ax, Numero2
cmp ax, NumeroDeLinhasDados
jae ErroColunaMaiorQueDevido

ProximoTeste2Numero2:

jmp TerminoVerificacaoExp

ErroColunaMaiorQueDevido:
lea bx, mensagemErroNumeroMaiorQuePermitido     ;bx = mensagem de erro, se ocorrer
call	printf_s

.exit

TerminoVerificacaoExp:

ret
AuxiliarColunasMaiorVerificacaoArquivoExp endp

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função qeu conta o numero de expressoes tem no arquivo 
ContaNumeroDeExpressoes proc near

lea si, stringArquivoExp
mov cx, 0

comecoContaNumeroDeExpressoes:

;conta numero de expressoes contando os LF's
cmp byte ptr [si], LF
jnz NaoehLF2
inc cx

NaoehLF2:

inc si 

cmp byte ptr [si], EOF
jz FimContaNumeroDeExpressoes
jmp comecoContaNumeroDeExpressoes

FimContaNumeroDeExpressoes:

mov numeroDeExpressoes, cx

ret
ContaNumeroDeExpressoes endp

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função para colocar as informações de uma linha de expressões em suas respectivas variaveis
;Entrada = endereço da linha = si 
InterpretacaoLinhaArquivoExp proc near

;Primeira verificação : é na coluna de resultados?

cmp byte ptr [si], "*"
jnz NaoEhColunaDeResultados

;incrementa o ponteiro e atualiza a flag
inc si
mov FlagLinhaResultado, 1

jmp ComecoNumero

NaoEhColunaDeResultados:

mov FlagLinhaResultado, 0

ComecoNumero:

;agora estamos no começo da primeira coluna 
inc si ;pulei o "["
;começo do numero (vou coloca-lo em outra string para enviar para a função atoi)

call LimpaBufferString
lea bx, BufferString

ColocandoONumeroResultadoNaString:

mov al, [si]
mov [bx], al

inc si
inc bx

cmp byte ptr [si], "]"
jnz ColocandoONumeroResultadoNaString

;terminou o numero, coloco o 0 no fim
mov al, 0
mov [bx], al


lea		bx, BufferString
call	atoi
mov NumeroResultadoFinal, ax


;Coluna final atualizado
;ponteiro no "]"
inc si
;ponteiro no "="
inc si


;VAMOS PARA A ANALISE DO NUMERO1

;ponteiro no numero ou "["
cmp byte ptr [si], "["
jnz EhConstante1 ;pula se for constante

;É [NUMERO]
;incrementa o ponteiro e atualiza a flag
inc si
mov FlagNumero1Constante, 1

call LimpaBufferString
lea bx, BufferString

ColocandoONumero1NaString:

mov al, [si]
mov [bx], al

inc si
inc bx

cmp byte ptr [si], "]"
jnz ColocandoONumero1NaString

;terminou o numero, coloco o 0 no fim
mov al, 0
mov byte ptr [bx], al

lea		bx, BufferString
call	atoi
mov Numero1, ax

;ponteiro esta no "]"
inc si

jmp ParteOperacao

EhConstante1:

;É CONSTANTE

mov FlagNumero1Constante, 0
call LimpaBufferString
lea bx, BufferString

; verifica sinal
cmp byte ptr [si], '-'
jne LoopDeDigitos1 ; Se não for '-', pula para o loop de dígitos

; Se for '-', copia o sinal e avança os ponteiros
mov al, [si]
mov [bx], al
inc si
inc bx

LoopDeDigitos1:
cmp byte ptr [si], '0'
jl FimDaConstante1
cmp byte ptr [si], '9'
jg FimDaConstante1

mov al, [si]
mov [bx], al
inc si
inc bx
jmp LoopDeDigitos1

FimDaConstante1:

;terminou o numero, coloco o 0 no fim
mov al, 0
mov [bx], al

lea		bx, BufferString
call	atoi
mov Numero1, ax

ParteOperacao: ;estamos com o ponteiro na operação


;OPERAÇÃO

mov al, [si]
mov operacao, al


;ponteiro esta na operação
inc si

;estamos no numero 2 POS OPERAÇÃO

;ponteiro no numero ou "["
cmp byte ptr [si], "["
jnz EhConstante2 ;pula se for constante

;é [numero]
;incrementa o ponteiro e atualiza a flag
inc si
mov FlagNumero2Constante, 1

call LimpaBufferString
lea bx, BufferString

ColocandoONumero2NaString:

mov al, [si]
mov [bx], al

inc si
inc bx

cmp byte ptr [si], "]"
jnz ColocandoONumero2NaString

;terminou o numero, coloco o 0 no fim
mov al, 0
mov [bx], al

lea		bx, BufferString
call	atoi
mov Numero2, ax

jmp FimfuncaoInterpretacao

EhConstante2:
mov FlagNumero2Constante, 0
call LimpaBufferString
lea bx, BufferString

;verifica sinal
cmp byte ptr [si], '-'
jne LoopDeDigitos2 ; Se não for '-', pula para o loop de dígitos

; Se for '-', copia o sinal e avança os ponteiros
mov al, [si]
mov [bx], al
inc si
inc bx

LoopDeDigitos2:
cmp byte ptr [si], '0'
jl FimDaConstante2
cmp byte ptr [si], '9'
jg FimDaConstante2

mov al, [si]
mov [bx], al
inc si
inc bx
jmp LoopDeDigitos2

FimDaConstante2:

; Chegou aqui quando encontrou um caractere que não é dígito.
;terminou o numero, coloco o 0 no fim

mov al, 0
mov [bx], al

lea		bx, BufferString
call	atoi
mov Numero2, ax


FimfuncaoInterpretacao:

ret
InterpretacaoLinhaArquivoExp endp


;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função coloca o ponteiro na proxima linha
PonteiroProximaLinha proc near

LoopDeBusca:

cmp byte ptr [si], EOF
jz FinaldoArquivo

cmp byte ptr [si], LF
jz EncontrouLF

inc si
jmp LoopDeBusca

EncontrouLF:

inc si

FinaldoArquivo:

ret
PonteiroProximaLinha endp



;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função que limpa o buffer de string
LimpaBufferString proc near

lea		bx, BufferString
mov cx, 50


loopbufferstring:

mov byte ptr [bx], 0
inc bx

loop loopbufferstring



ret
LimpaBufferString endp



;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função de leitura do arquivo de dados
;le as informações do arquivo e coloca na string stringArquivoDados
LeituraArquivoExp proc near

mov ah, 3fh
mov bx, handleArquivoExp
mov cx, 1000
lea dx, stringArquivoExp
int 21h

jnc LeituraCorretaExp
;leitura incorreta do arquivo de expressões

lea bx, mensagemErroLeituraArquivoExp  ;bx = mensagem de erro, se ocorrer
call	printf_s

.exit

LeituraCorretaExp:

mov numeroCaracteresArquivoExp, ax

;vou coloca um 0 no final da string para saber ter um EOF na string
lea bx, stringArquivoExp
add bx, ax
mov byte ptr [bx], EOF

ret
LeituraArquivoExp endp



;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função que coloca o numero de colunas da matriz de numeros em uma string
;e depois transforma em um numero
ColunasEmString proc near
lea si, stringArquivoDados
lea bx, stringNumeroColunasArquivoDados

loopColunasNaString:

cmp byte ptr [si], CR ;verifica primeiro o CR
je FimDaCopiaDaLinha
cmp byte ptr [si], LF ;verifica lf também
je FimDaCopiaDaLinha

;se não for, coloca o caractere na string
mov al, [si]
mov [bx], al
inc bx
inc si
jmp loopColunasNaString

FimDaCopiaDaLinha:

mov byte ptr [bx], 0 ; Coloca o \0

lea   bx, stringNumeroColunasArquivoDados
call  atoi
mov NumeroColunasArquivoDados, ax

ret
ColunasEmString endp

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função de verificação do arquivo de dados
VerificacaoArquivoDados proc near

;contar quantos ;'s tem em casa linha(até o LF) e comparar com NumeroColunasArquivoDados
lea bx, stringArquivoDados
and ax, 0

call PonteiroProximaLinhaBX

MainLoopVerificacaoArquivoDados: ;loop para cada linha

cmp byte ptr [bx], EOF
jz FimVerificacaoArquivoDados

xor ax, ax

;loop para contar os ;'s
LoopMenorVerificacaoArquivoDados:

cmp byte ptr [bx], EOF ;verificaçao extra por segurança
jz AcabouLinhaVerificacaoDados

cmp byte ptr [bx], CR ;verifica se acabou a linha, se for recomeça o loop menor
jz AcabouLinhaVerificacaoDados

cmp byte ptr [bx], LF ;verifica se acabou a linha, se for recomeça o loop menor
jz AcabouLinhaVerificacaoDados

cmp byte ptr [bx], ";"
jnz NaoEhPontoEVirgula

inc ax ;incrementa o ax se for ;

NaoEhPontoEVirgula:

inc bx ;incrementa o ponteiro
jmp LoopMenorVerificacaoArquivoDados

AcabouLinhaVerificacaoDados:

inc ax
cmp ax, NumeroColunasArquivoDados
jz NumeroCorretoDeDados

;arquivo está com numero de colunas errado
lea bx, mensagemErroColunaArquivoDados  ;bx = mensagem de erro, se ocorrer
call	printf_s

.exit

NumeroCorretoDeDados:

;vai para a proxima linha
call PonteiroProximaLinhaBX

jmp MainLoopVerificacaoArquivoDados


FimVerificacaoArquivoDados:

ret
VerificacaoArquivoDados endp

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função coloca o ponteiro na proxima linha
PonteiroProximaLinhaBX proc near

LoopDeBuscabx:

cmp byte ptr [bx], EOF
jz FinaldoArquivobx

cmp byte ptr [bx], LF
jz EncontrouLFbx

inc bx
jmp LoopDeBuscabx

EncontrouLFbx:

inc bx

FinaldoArquivobx:


ret
PonteiroProximaLinhaBX endp


;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função de leitura do arquivo de dados
;le as informações do arquivo e coloca na string stringArquivoDados
LeituraArquivoDados proc near

mov ah, 3fh
mov bx, handleArquivoDados
mov cx, 1000
lea dx, stringArquivoDados
int 21h

jnc LeituraCorretaDados
;leitura incorreta dos dados

lea bx, mensagemErroLeituraArquivoDados  ;bx = mensagem de erro, se ocorrer
call	printf_s

.exit

LeituraCorretaDados:

mov numeroCaracteresArquivoDados, ax

;vou coloca um 0 no final da string para saber ter um EOF na string
lea bx, stringArquivoDados
add bx, ax
mov byte ptr [bx], EOF

ret
LeituraArquivoDados endp



;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;Função de abertura de arquivo de dados
;al = modo de acesso do arquivo (0 para read only)
;dx = string do nome do arquivo
;bx = mensagem de erro, se ocorrer
;saida:
;ax = handle do arquivo
AberturaArquivoDados proc near

mov al, 0                  ;al = modo de acesso do arquivo (0 para read only)
lea dx, nomeArquivoDados   ;dx = string do nome do arquivo
mov ah, 3dh              
int 21h

jnc aberturaCorretaDados

;caso de erro

;manda mensagem de erro ao abrir o arquivo
lea bx, mensagemErroAbeturaArquivoDados  ;bx = mensagem de erro, se ocorrer
call	printf_s

;acaba o programa
.exit

aberturaCorretaDados:
mov handleArquivoDados, ax

ret
AberturaArquivoDados endp


;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;Função de abertura de arquivo expressões
;al = modo de acesso do arquivo (0 para read only)
;dx = string do nome do arquivo
;bx = mensagem de erro, se ocorrer
;saida:
;ax = handle do arquivo
AberturaArquivoExp proc near

mov al, 0                   ;al = modo de acesso do arquivo (0 para read only)
lea dx, nomeArquivoExp      ;dx = string do nome do arquivo
mov ah, 3dh
int 21h

jnc AberturaCorretaExp

;caso de erro

;fecha o arquivo de dados
mov ah, 3eh
mov bx, handleArquivoDados
int 21h

jnc arquivoDadosFechadoSemProblema

;teve problema no fechamento do arquivo de dados
lea bx, mensagemErroFechamentoArquivoDados     ;bx = mensagem de erro, se ocorrer
call	printf_s

arquivoDadosFechadoSemProblema:

;manda mensagem de erro ao abrir o arquivo
lea bx, mensagemErroAberturaArquivoExp     ;bx = mensagem de erro, se ocorrer
call	printf_s

;acaba o programa
.exit

AberturaCorretaExp:

mov handleArquivoExp, ax

ret
AberturaArquivoExp endp






;=========================================================================
;Funções pré-prontas

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;----------------------------------------------------------------------
;função printf
printf_s	proc	near		;Escreve uma string na tela

	mov		dl,[bx]				;Move para o registrador DL (que opera como uma extens�o do AX), o endere�o apontado por BX
	cmp		dl,0				;Compara para ver se chegou ao \0
	je		ps_1				;Jump se igual

	push	bx					;Coloca bx na pilha
	mov		ah,2				;Chama o servi�o '2' da int 21H, que funciona espeficiamente para exibir um caracte na tela, sendo que este caractere deve estar no DL
	int		21H					;O servi�o de interrup��o para a execu��o normal do programa e passa o o controle para o sistema operacional
	pop		bx					;Retorna o �ltimo valor colocado na pilha para o bx (isso � feito pois durante a interrup��o pode acontecer do registrador BX ser alterado durante a interrup��o)

	inc		bx					;Incrementa o ponteiro para a posi��o da string
		
	jmp		printf_s			;Volta para o come�o da fun��o
		
ps_1:
	ret
	
printf_s	endp

;------------------------------------------------
;------------------------------------------------
;função string(bx) -> numero(ax)
atoi	proc near		

  mov FlagNumeroNegativo, 0

	cmp byte ptr [bx], "-"
	jnz NaoEhNegativa

	inc bx
	mov FlagNumeroNegativo, 1

  NaoEhNegativa:

		mov		ax,0 	;AX = 0		
		
atoi_2:
		cmp		byte ptr[bx], 0		;[bx] corresponde ao acesso ao endere�o apontado por bx, j� a diretiva byte ptr indica que devemos acessar um byte do endere�o apontado por bx
		jz		atoi_1				;se achou o terminador nulo, sai da fun��o

		mov		cx,10				;CX = 10
		mul		cx					;A * CX(10); mul sempre age sobre o que est� no registrador A

		mov		ch,0				;CH = 0, corresponde a zerar a parte baixa de CX
		mov		cl,[bx]				;Colocamos o caractere apontado pelo registrador BX em CL
		add		ax,cx				;Adiciona esse valor ao AX, que � onde est� sendo constru�do o n�mero

		sub		ax,'0'				;Subtrai o 0 em ascii para converter de fato o n�mero

		inc		bx					;Passa para o pr�ximo byte da string
		
		jmp		atoi_2

atoi_1:

mov cx, FlagNumeroNegativo
or cx, cx
jz EhNumeroPositivo

neg ax

EhNumeroPositivo:

ret
atoi	endp

;------------------------------------------------
;------------------------------------------------
;função int -> string
sprintf_w proc near

;PASSO 1: TRATAR O SINAL
;Testa o sinal de AX (or ax, ax afeta a Sign Flag)
test ax, ax
jns NaoEhNegativo ; Se não for negativo (Jump if Not Sign), pula.

; Se for negativo:
mov byte ptr [bx], '-' ; a. Escreve o sinal '-' na string
inc bx                 ;    e avança o ponteiro.

neg ax                 ; b. Transforma o número em AX para seu positivo equivalente.

NaoEhNegativo:

;PASSO 2: CONVERSÃO DO NÚMERO 
mov		sw_n,ax				;Coloca o n�mero a ser convertido na vari�vel sw_n
mov		cx,5				;Inicializa o CX com 5 para servir como contador da repeti��o
mov		sw_m,10000			;Inicializa com 10000 a vari�vel sw_m para que ela v� divindo o n�mero e convertendo para string
mov		sw_f,0				;Flag que indica se j� come�amos a armazenar d�gitos, serve para garantir que n�o iremos guardar zeros � esquerda
	
sw_do:

mov		dx,0				;DX = 0, pois a divis�o se d� por DX:AX/ sw_m			DX = Resto(para ser usado depois)		Al = D�gito atual
mov		ax,sw_n				;Inicializa o AX, que servir� como divisor na opera��o "DIV", com o valor de sw_n, que cont�m o n�mero a ser convertido
div		sw_m				
	
cmp		al,0				;Compara o digito atual com 0
jne		sw_store			;Se n�o for zero, guarda o n�mero
cmp		sw_f,0				;Se for zero, checa se j� estamos escrevendo o n�mero, se ainda n�o estamos, pula a parte de guardar, pois n�o queremos guardar zeros � esquerda
je		sw_continue			

sw_store:
add		al,'0'				;Adiciona '0' para converter o d�gito para ascii
mov		[bx],al				;Colocamos o d�gito convertido no endere�o apontado por bx
inc		bx					;Incrementamos o ponteiro onde est� segundo guardada a string
	
mov		sw_f,1				;Seta como ativa a flag que indica que j� come�amos a escrever o n�mero
sw_continue:
	
mov		sw_n,dx				;Coloca na vari�vel respons�vel por guardar o n�mero durante a convers�o o resto da divis�o feita anteriormente
	
mov		dx,0				;Zera o resto atual
mov		ax,sw_m				;Divide o sw_m (que come�a em 10000) por 10
mov		bp,10				
div		bp
mov		sw_m,ax				;Guarda no sw_m seu novo valor
	
dec		cx					;Diminui a vari�vel que controla o tamanho do n�mero que estamos convertendo
	
cmp		cx,0				;Verifica se terminamos de converter o n�mero
jnz		sw_do

cmp		sw_f,0				;Verifica se terminamos a convers�o sem ter come�ado alguma escrita e escreve for�adamente um '0' no endere�o da string
jnz		sw_continua2
mov		[bx],'0'
inc		bx
sw_continua2:

mov		byte ptr[bx],0		;Garante o terminador nulo ao final da string
		
ret
sprintf_w	endp

end