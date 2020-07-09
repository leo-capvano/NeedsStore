package model;

public class Vendita {
    private String idVendita;
    private String idArticolo;
    private double prezzo;
    private String dataVendita;
    private String emailVend;

    public String getEmailVend() {
        return emailVend;
    }

    public void setEmailVend(String emailVend) {
        this.emailVend = emailVend;
    }

    public Vendita(String idVendita, String idArticolo, double prezzo, String dataVendita, String emailVend) {
        this.idVendita = idVendita;
        this.idArticolo = idArticolo;
        this.prezzo = prezzo;
        this.dataVendita = dataVendita;
        this.emailVend = emailVend;
    }

    public String getIdVendita() {
        return idVendita;
    }

    public void setIdVendita(String idVendita) {
        this.idVendita = idVendita;
    }

    public String getIdArticolo() {
        return idArticolo;
    }

    public void setIdArticolo(String idArticolo) {
        this.idArticolo = idArticolo;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public String getDataVendita() {
        return dataVendita;
    }

    public void setDataVendita(String dataVendita) {
        this.dataVendita = dataVendita;
    }
}
