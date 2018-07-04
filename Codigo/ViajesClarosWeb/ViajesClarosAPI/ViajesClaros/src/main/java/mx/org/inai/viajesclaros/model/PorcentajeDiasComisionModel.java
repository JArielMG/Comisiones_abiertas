/*
 * Copyright (C) 2015 sandro
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
 * @author sandro
 */
@XmlRootElement
public class PorcentajeDiasComisionModel implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer totalDiasViaje;
    private Integer totalDiasInstitucion;
    private Float porcentajeViaje;
    private Float porcentajeInstitucion;

    /**
     * @return the totalDiasViaje
     */
    public Integer getTotalDiasViaje() {
        return totalDiasViaje;
    }

    /**
     * @param totalDiasViaje the totalDiasViaje to set
     */
    public void setTotalDiasViaje(Integer totalDiasViaje) {
        this.totalDiasViaje = totalDiasViaje;
    }

    /**
     * @return the totalDiasInstitucion
     */
    public Integer getTotalDiasInstitucion() {
        return totalDiasInstitucion;
    }

    /**
     * @param totalDiasInstitucion the totalDiasInstitucion to set
     */
    public void setTotalDiasInstitucion(Integer totalDiasInstitucion) {
        this.totalDiasInstitucion = totalDiasInstitucion;
    }

    /**
     * @return the porcentajeViaje
     */
    public Float getPorcentajeViaje() {
        return porcentajeViaje;
    }

    /**
     * @param porcentajeViaje the porcentajeViaje to set
     */
    public void setPorcentajeViaje(Float porcentajeViaje) {
        this.porcentajeViaje = porcentajeViaje;
    }

    /**
     * @return the porcentajeInstitucion
     */
    public Float getPorcentajeInstitucion() {
        return porcentajeInstitucion;
    }

    /**
     * @param porcentajeInstitucion the porcentajeInstitucion to set
     */
    public void setPorcentajeInstitucion(Float porcentajeInstitucion) {
        this.porcentajeInstitucion = porcentajeInstitucion;
    }
}
