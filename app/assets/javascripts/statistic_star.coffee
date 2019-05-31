$ ->
  $('#id_date_range').daterangepicker
    "autoApply": true,
    timePicker: true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    locale:
      format: 'MM/DD/YYYY hh:mm A',
    showDropdowns: true,
    maxYear: moment().year(),
    maxDate: moment().date(),
    showWeekNumbers: true,
    opens: 'center'
