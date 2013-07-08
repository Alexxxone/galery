# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(document).ready ->
  check()
  $("#like").click ->
    pic_id = $("#like").attr("name")
    $.ajax(
      url: "/pictures/like"
      data:
        pic_id: pic_id

      dataType: "json"
      type: "post"
    ).success (response) ->
      $("#like").css "opacity", response.like
      console.log response.like
      $(".all_likes span").remove()
      $(".all_likes").append "<span>" + response.all_likes + "</span>"
check = ->
  pic_id = $("#like").attr("name")
  $.ajax(
    url: "/pictures/like"
    data:
      check: "check"
      pic_id: pic_id

    dataType: "json"
    type: "post"
  ).success (response) ->
    $("#like").css "opacity", "" + response.like + ""
    console.log response.like
    $(".all_likes span").remove()
    $(".all_likes").append "<span>" + response.all_likes + "</span>"