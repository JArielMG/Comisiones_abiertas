/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

/**
 *
 * @author JOTREJO
 */
public class ListaValoresVO implements Serializable{
    
    private static final long serialVersionUID = 1L;
    
    private int idLista;
    private String nombreLista;
    private boolean habilitada;

    public ListaValoresVO() {
    }
    
    public ListaValoresVO(int idLista, String nombreLista, boolean habilitada) {
        this.idLista = idLista;
        this.nombreLista = nombreLista;
        this.habilitada = habilitada;
    }
    
    public int getIdLista() {
        return idLista;
    }

    public void setIdLista(int idLista) {
        this.idLista = idLista;
    }

    public String getNombreLista() {
        return nombreLista;
    }

    public void setNombreLista(String nombreLista) {
        this.nombreLista = nombreLista;
    }

    public boolean isHabilitada() {
        return habilitada;
    }

    public void setHabilitada(boolean habilitada) {
        this.habilitada = habilitada;
    }
    
    
}
