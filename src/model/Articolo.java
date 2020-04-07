package model;

public class Articolo {

    private String idArticolo;
    private String titolo;
    private String descrizione;
    private String email_vend;
    private Double prezzo;
    private String luogo;

    public String getIdArticolo() {
        return idArticolo;
    }

    public void setIdArticolo(String idArticolo) {
        this.idArticolo = idArticolo;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getEmail_vend() {
        return email_vend;
    }

    public void setEmail_vend(String email_vend) {
        this.email_vend = email_vend;
    }

    public Double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(Double prezzo) {
        this.prezzo = prezzo;
    }

    public String getLuogo() {
        return luogo;
    }

    public void setLuogo(String luogo) {
        this.luogo = luogo;
    }

    public Articolo(String idArticolo, String titolo, String descrizione, String email_vend, Double prezzo, String luogo) {
        this.idArticolo = idArticolo;
        this.titolo = titolo;
        this.descrizione = descrizione;
        this.email_vend = email_vend;
        this.prezzo = prezzo;
        this.luogo = luogo;
    }
}
