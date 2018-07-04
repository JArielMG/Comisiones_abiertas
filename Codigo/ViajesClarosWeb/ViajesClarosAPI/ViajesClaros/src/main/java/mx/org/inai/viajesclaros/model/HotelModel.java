/*
 * Copyright (C) 2015 INAI
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package mx.org.inai.viajesclaros.model;

import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Sandro Alejandro
 */
@XmlRootElement
public class HotelModel implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private String nombreHotel;
    private String ciudad;
    private String pais;
    private Integer numeroViajes;

    /**
     * @return the nombreHotel
     */
    public String getNombreHotel() {
        return nombreHotel;
    }

    /**
     * @param nombreHotel the nombreHotel to set
     */
    public void setNombreHotel(String nombreHotel) {
        this.nombreHotel = nombreHotel;
    }

    /**
     * @return the ciudad
     */
    public String getCiudad() {
        return ciudad;
    }

    /**
     * @param ciudad the ciudad to set
     */
    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    /**
     * @return the numeroViajes
     */
    public Integer getNumeroViajes() {
        return numeroViajes;
    }

    /**
     * @param numeroViajes the numeroViajes to set
     */
    public void setNumeroViajes(Integer numeroViajes) {
        this.numeroViajes = numeroViajes;
    }

    /**
     * @return the pais
     */
    public String getPais() {
        return pais;
    }

    /**
     * @param pais the pais to set
     */
    public void setPais(String pais) {
        this.pais = pais;
    }
    
}
