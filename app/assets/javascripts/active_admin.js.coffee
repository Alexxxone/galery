#= require jquery
#= require jquery_ujs
#= require jquery
#= require active_admin/application
#= require pusher.min
$(document).ready ->
  $(".save_img").click (event)->
    selectedCategories = $(event.currentTarget).parent().find("input[type=checkbox]:checked").map( (index, input)-> $(input).val() ).toArray()
    $.ajax(
      url: "/admin/parser/create_picture"
      data:
        file_addr: event.currentTarget.src
        categories: selectedCategories

      dataType: "json"
      type: "POST"
    ).success (response) ->
      $(event.currentTarget).parent().remove()

