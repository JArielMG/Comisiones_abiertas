
package mx.org.inai.viajesclaros.domain;

/**
 *
 * @author Sandro Alejandro
 */
public class CalendarEventDomain implements java.io.Serializable {
    private static final long serialVersionUID = 1L;
    
    private String title;
    private String start;
    private String end;
    private String startShowed;
    private String endShowed;
    private String unidadAdministrativa;
    private String ciudadDestino;
    private String paisDestino;
    private String status;
    private String color;

    /**
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return the start
     */
    public String getStart() {
        return start;
    }

    /**
     * @param start the start to set
     */
    public void setStart(String start) {
        this.start = start;
    }

    /**
     * @return the end
     */
    public String getEnd() {
        return end;
    }

    /**
     * @param end the end to set
     */
    public void setEnd(String end) {
        this.end = end;
    }

    /**
     * @return the unidadAdministrativa
     */
    public String getUnidadAdministrativa() {
        return unidadAdministrativa;
    }

    /**
     * @param unidadAdministrativa the unidadAdministrativa to set
     */
    public void setUnidadAdministrativa(String unidadAdministrativa) {
        this.unidadAdministrativa = unidadAdministrativa;
    }

    /**
     * @return the startShowed
     */
    public String getStartShowed() {
        return startShowed;
    }

    /**
     * @param startShowed the startShowed to set
     */
    public void setStartShowed(String startShowed) {
        this.startShowed = startShowed;
    }

    /**
     * @return the endShowed
     */
    public String getEndShowed() {
        return endShowed;
    }

    /**
     * @param endShowed the endShowed to set
     */
    public void setEndShowed(String endShowed) {
        this.endShowed = endShowed;
    }

    /**
     * @return the ciudadDestino
     */
    public String getCiudadDestino() {
        return ciudadDestino;
    }

    /**
     * @param ciudadDestino the ciudadDestino to set
     */
    public void setCiudadDestino(String ciudadDestino) {
        this.ciudadDestino = ciudadDestino;
    }

    /**
     * @return the paisDestino
     */
    public String getPaisDestino() {
        return paisDestino;
    }

    /**
     * @param paisDestino the paisDestino to set
     */
    public void setPaisDestino(String paisDestino) {
        this.paisDestino = paisDestino;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the color
     */
    public String getColor() {
        return color;
    }

    /**
     * @param color the color to set
     */
    public void setColor(String color) {
        this.color = color;
    }

}
