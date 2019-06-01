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
