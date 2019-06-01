$(document).on 'turbolinks:load', ->
  $(document).on "change", "#id_sort_name", (event) ->
    $("#id_sort_name").val(event.target.value)
    handleSortName(event)
  $(document).on "change", "#id_sort_rating", (event) ->
    $("#id_sort_rating").val(event.target.value)
    handleSortRating(event)

  handleSortName = (event) ->
    $("form#id_form_user").submit()

  handleSortRating = (event) ->
    $("form#id_form_user").submit()
