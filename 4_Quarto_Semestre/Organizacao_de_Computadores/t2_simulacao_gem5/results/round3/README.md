README — Round 3 Results

Alterações aplicadas
--------------------

1) Redução de `count` de 2 para 1

Original:

```python
class MyIntALU(FUDesc):
    opList = [ OpDesc(opClass='IntAlu') ]
    count = 2
```

Alterado para:

```python
class MyIntALU(FUDesc):
    opList = [ OpDesc(opClass='IntAlu') ]
    count = 1
```

2) Aumento de `count` de 2 para 4

Original (exemplo):

```python
class MyIntALU(FUDesc):
    opList = [ OpDesc(opClass='IntAlu') ]
    count = 2
```

Alterado para:

```python
class MyIntALU(FUDesc):
    opList = [ OpDesc(opClass='IntAlu') ]
    count = 4
```
