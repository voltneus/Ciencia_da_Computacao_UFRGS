import tkinter as tk
from tkinter import ttk, messagebox
import submain

class AppUltra(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Busca por hash")
        self.geometry("900x600")

        #config: "Nome": (Função, [Colunas])
        self.cfg = {
            "Prefixo": (submain.Pesquisa1, ["ID", "Título", "Gêneros", "Ano", "Média", "Count"]),
            "Usuário": (submain.Pesquisa2,["ID", "Título", "Gêneros", "Ano", "Média Global", "Count", "Nota User"]),
            "Gênero": (submain.Pesquisa3, ["ID", "Título", "Gêneros", "Ano", "Média", "Count"]),
            "Tags": (submain.Pesquisa4, ["ID", "Título", "Gêneros", "Ano", "Média", "Count"])
        }

        #carregamento inicial e registro de tempo
        print("--- CARREGANDO ---")
        funcs = [submain.FileReadigs, submain.MovieHashBuild, submain.MovieTrieBuild, submain.RatingHashBuild,
                 submain.TagsHashBuild]
        print(f"--- CONCLUÍDO EM {sum(f() for f in funcs):.2f}s ---")

        #top bar
        top = tk.Frame(self, pady=10)
        top.pack(fill="x")
        tk.Label(top, text="Modo:").pack(side="left", padx=5)

        #combobox
        self.cb = ttk.Combobox(top, values=list(self.cfg.keys()), state="readonly", width=15)
        self.cb.pack(side="left")
        self.cb.current(0)
        self.cb.bind("<<ComboboxSelected>>", self.setup_cols)

        #botão de busca
        tk.Label(top, text="Busca:").pack(side="left", padx=5)
        self.ent = tk.Entry(top, width=30)
        self.ent.pack(side="left")
        self.ent.bind("<Return>", self.buscar)
        tk.Button(top, text="buscar", command=self.buscar, bg="#007acc", fg="white").pack(side="left", padx=5)

        #tabela
        self.tree = ttk.Treeview(self, show="headings")
        self.tree.pack(fill="both", expand=True, padx=10, pady=5)
        self.setup_cols()

    def setup_cols(self, _=None):
        cols = self.cfg[self.cb.get()][1]  #pega lista de colunas da tupla
        self.tree["columns"] = cols

        for c in cols:
            self.tree.heading(c, text=c)
            w = 300 if c == "Título" else (200 if c == "Gêneros" else 80)
            self.tree.column(c, width=w, anchor="w" if c == "Título" else "center")
        self.tree.delete(*self.tree.get_children())

    def buscar(self, _=None):
        self.tree.delete(*self.tree.get_children())
        if not (termo := self.ent.get()): return

        #pega a função da configuração e executa
        if dados := self.cfg[self.cb.get()][0](termo):
            [self.tree.insert("", "end", values=d) for d in dados]
        else:
            messagebox.showinfo("Aviso", "Nenhum resultado.")


if __name__ == "__main__": AppUltra().mainloop()