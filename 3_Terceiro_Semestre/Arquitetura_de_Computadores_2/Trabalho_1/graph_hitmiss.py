import matplotlib.pyplot as plt


y_values_lru = (10, 40, 30, 20)
x_values_lru = ("LFU hits", "LFU misses", "LRU hits", "LRU misses")

y_values_lfu = (18, 32, 1, 49)
x_values_lfu = ("LFU hits", "LFU misses", "LRU hits", "LRU misses")

y_values_hibrido = (9, 41, 10, 40)
x_values_hibrido = ("LFU hits", "LFU misses", "LRU hits", "LRU misses")


plt.bar(x_values_hibrido, y_values_hibrido, color='skyblue')

plt.xlabel("")
plt.ylabel("Numero de Misses e Hits")
plt.title("")


plt.show()