README — Round 2 Results

Resumo:
- Nesta rodada foram testadas variações do preditor de desvios, substituindo o `TournamentBP` por alternativas: `LocalBP` e `BiModeBP`.

Detalhes da alteração:
- Trechos alterados (exemplo onde o preditor é instanciado):

Versão original (TournamentBP):

```
############################################################
## Preditor de desvios
############################################################
branchPred = TournamentBP()  # Branch Predictor
```

Substituição testada 1 (LocalBP):

```
############################################################
## Preditor de desvios
############################################################
branchPred = LocalBP()  # Branch Predictor
```

Substituição testada 2 (BiModeBP):

```
############################################################
## Preditor de desvios
############################################################
branchPred = BiModeBP()  # Branch Predictor
```

Como reproduzir / onde alterar:
- Localize a definição do preditor em seus scripts de configuração (procure por `branchPred =` ou pela classe `TournamentBP` nos arquivos de configuração em `t2/base_config/` ou na entrada de simulação).
- Substitua a classe conforme o exemplo acima e execute o benchmark para coletar resultados comparativos.

