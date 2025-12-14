A,B
a,b
@
-
q0,q1,q2,qf1,q3,q4,q5,q6,q7,q8,q9,qf
q0
qf
q0,-,,qf1, -, E,,,q0,@,,q0, @, D,,,q0,A,,q0, A, D ,,,q0,B,,q1, a, D ,,,q0,a,, ,,,q0,b,, ,,,q1,-,,qf1, -, E,,,q1,A,,q2, B, E,,,q1,B,,q1, B, D,,,q2,B,,q2, B, E,,,q2,a,,q0, A, D,,,q3,-,,q7, -, E,,,q3,@,,q3, @, D,,,q3,A,,q4, A, D,,,q3,B,,q5, B, D,,,q4,-,,q7, -, E,,,q4,A,,q4, A, D,,,q4,B,,q9, B, D,,,q5,-,,q7, -, E,,,q5,A,,q9, A, D,,,q5,B,,q5, B, D,,,q6,-,,q6, -, E,,,q6,@,,qf, @, D,,,q6,A,,q6, -, E,,,q6,B,,q6, -, E,,,q7,-,,q7, -, E,,,q7,@,,q8, @, D,,,q7,A,,q7, -, E,,,q7,B,,q7, -, E,,,q8,-,,qf, A, E,,,q9,-,,q6, -, D,,,q9,A,,q9, A, D,,,q9,B,,q9, B, D,,,qf1,@,,q3, @, D,,,qf1,A,,qf1, A, E,,,qf1,B,,qf1, B, E,,,qf1,a,,qf1, B, E,,,,,,qf1,@,,q3, @, D,,,qf1,A,,qf1, A, E,,,qf1,B,,qf1, B, E,,,qf1,a,,qf1, B, E,,,
2a

Primeiro ajustar o par
quando achar um B, verifica se tem um A na frente, se tiver troca, repete até achar o vazio

Identificar se tem um A e B

Caso tenha um A e um B -> limpa a fita

Caso não ache(chegue no vazio) -> Coloca um A na fita


implementação = q0 acha o primeiro simbolo
q1 se achar A primeiro e precisar achar um B
q2 se achar B primeiro e precisar achar um A
q3 -> achou um A e um B e então quer limpar a fita(tem o q6 para limpar a fita antes)
q6 -> vai ate o final da fita
q4 -> chegou no branco em q0,q1 ou q2 e precisa colocar um A(q5) na fita depois de limpar a fita