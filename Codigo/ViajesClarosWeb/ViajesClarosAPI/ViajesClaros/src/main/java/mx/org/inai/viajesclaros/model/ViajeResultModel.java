/*
 * Copyright (C) 2015 Sandro Alejandro
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

import java.util.List;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Sandro Alejandro
 */
@XmlRootElement
public class ViajeResultModel implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private Integer id;
    private List<String> datos;

    public ViajeResultModel() {
        
    }
    
    public ViajeResultModel(List<String> datos) {
        this.datos = datos;
    }
    
    /**
     * @return the datos
     */
    public List<String> getDatos() {
        return datos;
    }

    /**
     * @param datos the datos to set
     */
    public void setDatos(List<String> datos) {
        this.datos = datos;
    }

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Override
    public String toString() {
        String str = "Viaje[id=" + id;
        for (String s : datos) {
            str += ", " + s;
        }
        return str + "]";
    }
}
