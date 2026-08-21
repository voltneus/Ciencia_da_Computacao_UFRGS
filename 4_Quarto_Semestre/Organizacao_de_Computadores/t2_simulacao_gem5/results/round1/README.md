README — Round 1 Results

Resumo:
- Alteração na configuração da cache L1 de dados: agora há definições com tamanho de 16kB e 64kB. Valor original usado anteriormente: 32kB.

Detalhes da alteração:
- Classe modificada (ou variante definida): `BasicL1DCache`.
- Parâmetros mantidos: `assoc = 8`, `tag_latency = 1`, `data_latency = 2`, `response_latency = 2`, `mshrs = 4`, `tgts_per_mshr = 16`.

Exemplos de definição:

Versão com 16kB:

```
class BasicL1DCache(Cache):
    size = '16kB'
    assoc = 8
    tag_latency = 1
    data_latency = 2
    response_latency = 2
    mshrs = 4
    tgts_per_mshr = 16
```

Versão com 64kB:

```
class BasicL1DCache(Cache):
    size = '64kB'
    assoc = 8
    tag_latency = 1
    data_latency = 2
    response_latency = 2
    mshrs = 4
    tgts_per_mshr = 16
```

Observações:
- Se desejar reverter ou ajustar o tamanho, altere o atributo `size` na definição da cache usada pelo seu script/configuração do gem5.
- Consulte os arquivos de configuração em `t2/base_config/` para localizar a definição original e os pontos onde a classe é instanciada.

Autor: alterações registradas para a rodada 1

