# Base Configuration Changes

## Principais alterações

- **Largura do pipeline aumentada de 2 para 4**
  - Permite que a CPU processe até 4 instruções por ciclo em vez de 2.
- **Número de entradas do reorder buffer aumentado**
  - Suporta mais instruções fora de ordem antes da confirmação.
- **Cache L2 aumentada**
  - Maior capacidade de cache para reduzir falhas em memória intermediária.

## Código modificado

### Pipeline widths
```python
fetchWidth    = 4  # Fetch width
decodeWidth   = 4  # Decode width
renameWidth   = 4  # Rename width
dispatchWidth = 4  # Dispatch width
issueWidth    = 4  # Issue width
wbWidth       = 4  # Writeback width
commitWidth   = 4  # Commit width
```

### Reorder buffer
```python
numROBEntries = 128  # Number of reorder buffer entries
```

### Cache L2
```python
class BasicL2Cache(Cache):
    size = '512kB'
```
