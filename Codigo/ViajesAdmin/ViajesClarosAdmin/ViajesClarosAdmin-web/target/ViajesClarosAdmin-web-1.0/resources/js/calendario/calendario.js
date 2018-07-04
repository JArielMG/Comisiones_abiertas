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

$(document).ready(function () {

    $('#calendar').fullCalendar({
        lang: 'es',
        theme: true,
        eventTextColor: '#555',
        events: JSON.parse($("#jsonEventos").text()),
        eventClick: function (event, jsEvent, view) {
            $("#txEvFuncionario").text(event.title);
            $("#txEvInicio").text(event.startShowed);
            $("#txEvFin").text(event.endShowed);
            $("#txEvUnidad").text(event.unidadAdministrativa);
            $("#txEvDestino").text(event.ciudadDestino + ', ' + event.paisDestino);
            $("#txEvStatus").text(event.status);
            $("#txEvStatus").css('color', event.color);
            $("#modalEvent").modal('show');
        },
        customButtons: {
            custNextYear: {
                text: 'Año >',
                click: function () {
                    siguienteAnio();
                }
            },
            custPrevYear: {
                text: '< Año',
                click: function () {
                    anteriorAnio();
                }
            }
        },
        header: {
            left: 'custPrevYear,custNextYear',
            center: 'title',
            right: 'today,prev,next'
        }
    });

    /* Evento para mes anterior */
    $('.fc-prev-button').on('click', function () {
        cambiarMes();
    });

    /* Evento para mes siguiente */
    $('.fc-next-button').on('click', function () {
        cambiarMes();
    });

    /* Evento para el botón HOY */
    $('.fc-today-button').on('click', function () {
        cambiarMes();
    });

});

function cambiarMes() {
    /* Obtener el mes y el anio que serán usados en el CONTROLLER para consultar los viajes */
    var mes = $('#calendar').fullCalendar('getDate').format('MM');
    var anio = $('#calendar').fullCalendar('getDate').format('YYYY');
    changeMonth([{name: 'mesCalendario', value: mes}, {name: 'anioCalendario', value: anio}]);
}

/* Refrescar los eventos al cambiar de mes (se ejecuta desde la vista) */
function refreshEvents() {
    $("#calendar").fullCalendar('removeEvents');
    $("#calendar").fullCalendar('addEventSource', JSON.parse($("#jsonEventos").text()));
    $("#calendar").fullCalendar('rerenderEvents');
}

function siguienteAnio() {
    $('#calendar').fullCalendar('nextYear');
    cambiarMes();
}

function anteriorAnio() {
    $('#calendar').fullCalendar('prevYear');
    cambiarMes();
}