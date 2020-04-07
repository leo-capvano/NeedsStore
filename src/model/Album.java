package model;

public class Album {
    private String idAlbum;
    private String path;
    private String idArticolo;

    public String getIdAlbum() {
        return idAlbum;
    }

    public void setIdAlbum(String idAlbum) {
        this.idAlbum = idAlbum;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getIdArticolo() {
        return idArticolo;
    }

    public void setIdArticolo(String idArticolo) {
        this.idArticolo = idArticolo;
    }

    public Album(String idAlbum, String path, String idArticolo) {
        this.idAlbum = idAlbum;
        this.path = path;
        this.idArticolo = idArticolo;
    }
}
