package model;

public class Utente {

    private String email;
    private String pwd;
    private String nome;
    private String cognome;
    private String telefono;
    private boolean admin;

    public Utente(String email, String pwd, String nome, String cognome, String telefono, boolean admin) {
        this.email = email;
        this.pwd = pwd;
        this.nome = nome;
        this.cognome = cognome;
        this.telefono = telefono;
        this.admin = admin;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }
}
