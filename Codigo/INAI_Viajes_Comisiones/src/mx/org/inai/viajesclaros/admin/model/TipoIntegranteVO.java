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

public class TipoIntegranteVO implements Serializable{
        private static final long serialVersionUID = 1L;

    private String codigo;
    private String valor;

    public TipoIntegranteVO(String codigo, String valor) {
        this.codigo = codigo;
        this.valor = valor;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }
    
    
}


