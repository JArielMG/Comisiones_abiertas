/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.org.inai.viajesclaros.admin.model;

import java.io.Serializable;

/**
 *
 * @author DACEVEDO
 */
public class TipoIntegranteVista implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer id;
    private String valor;

    public TipoIntegranteVista() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }
    
}
