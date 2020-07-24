package model;

public class ArticoloCategoria {
    private String idArticolo;
    private int idCategoria;


    public ArticoloCategoria(String idArticolo, int idArticoli) {
        this.idArticolo = idArticolo;
        this.idCategoria = idArticoli;
    }

    public String getIdArticolo() {
        return idArticolo;
    }

    public void setIdArticolo(String idArticolo) {
        this.idArticolo = idArticolo;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }
}
