package model;

public class Articolo {

    private String titolo;
    private String email_vend;
    private String email_acq;
    private String descrizione;
    private Double prezzo;
    private String luogo;


    public Articolo(String titolo, String email_vend, String email_acq, String descrizione, Double prezzo, String luogo) {
        this.titolo = titolo;
        this.email_vend = email_vend;
        this.email_acq = email_acq;
        this.descrizione = descrizione;
        this.prezzo = prezzo;
        this.luogo = luogo;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getEmail_vend() {
        return email_vend;
    }

    public void setEmail_vend(String email_vend) {
        this.email_vend = email_vend;
    }

    public String getEmail_acq() {
        return email_acq;
    }

    public void setEmail_acq(String email_acq) {
        this.email_acq = email_acq;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
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
}
