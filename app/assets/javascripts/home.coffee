$(document).on 'turbolinks:load', ->
  $(document).on "change", "#id_sort_name", (event) ->
    $("#id_sort_name").val(event.target.value)
    console.log(event.target.value)
    $("#id_sort_rating").val("")
    handleSortName(event)

  $(document).on "change", "#id_sort_rating", (event) ->
    $("#id_sort_rating").val(event.target.value)
    $("#id_sort_name").val("")
    handleSortRating(event)

  handleSortName = (e) ->
    $("form#id_form_user").submit()
  handleSortRating = (e) ->
    $("form#id_form_user").submit()
