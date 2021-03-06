package model;

public class Articolo {

    private String idArticolo;
    private String titolo;
    private String descrizione;
    private String email_vend;
    private Double prezzo;
    private String luogo;
    private String data_inserimento;
    private boolean venduto;

    public String getData_inserimento() {
        return data_inserimento;
    }

    public void setData_inserimento(String data_inserimento) {
        this.data_inserimento = data_inserimento;
    }

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

    public boolean isVenduto() {
        return venduto;
    }

    public void setVenduto(boolean venduto) {
        this.venduto = venduto;
    }

    public Articolo(String idArticolo, String titolo, String descrizione, String email_vend, Double prezzo, String luogo, String data_inserimento) {
        this.idArticolo = idArticolo;
        this.titolo = titolo;
        this.descrizione = descrizione;
        this.email_vend = email_vend;
        this.prezzo = prezzo;
        this.luogo = luogo;
        this.data_inserimento = data_inserimento;
        this.venduto = false;
    }

    public Articolo(String idArticolo, String titolo, String descrizione, String email_vend, Double prezzo, String luogo, String data_inserimento, boolean venduto) {
        this.idArticolo = idArticolo;
        this.titolo = titolo;
        this.descrizione = descrizione;
        this.email_vend = email_vend;
        this.prezzo = prezzo;
        this.luogo = luogo;
        this.data_inserimento = data_inserimento;
        this.venduto = venduto;
    }
}
