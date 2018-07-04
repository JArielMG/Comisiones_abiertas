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
public class GraficaDependenciaModel implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer idGrafica;
    private Integer idDependencia;
    private String grafica;
    private Boolean enabled;

    /**
     * @return the idGrafica
     */
    public Integer getIdGrafica() {
        return idGrafica;
    }

    /**
     * @param idGrafica the idGrafica to set
     */
    public void setIdGrafica(Integer idGrafica) {
        this.idGrafica = idGrafica;
    }

    /**
     * @return the idDependencia
     */
    public Integer getIdDependencia() {
        return idDependencia;
    }

    /**
     * @param idDependencia the idDependencia to set
     */
    public void setIdDependencia(Integer idDependencia) {
        this.idDependencia = idDependencia;
    }

    /**
     * @return the grafica
     */
    public String getGrafica() {
        return grafica;
    }

    /**
     * @param grafica the grafica to set
     */
    public void setGrafica(String grafica) {
        this.grafica = grafica;
    }

    /**
     * @return the enabled
     */
    public Boolean getEnabled() {
        return enabled;
    }

    /**
     * @param enabled the enabled to set
     */
    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
