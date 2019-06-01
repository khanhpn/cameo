$(document).on 'turbolinks:load', ->
  $('#id_date_range').daterangepicker
    "autoApply": true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(24, 'hour'),
    locale:
      format: 'DD/MM/YYYY',
    showDropdowns: true,
    maxYear: moment().year(),
    showWeekNumbers: true,
    opens: 'center'

  range_date = $("#id_date_range").data("datetime").split(" - ");
  $("#id_date_range").data('daterangepicker').setStartDate(moment(range_date[0], "DD/MM/YYYY"));
  $("#id_date_range").data('daterangepicker').setEndDate(moment(range_date[1], "DD/MM/YYYY"));
