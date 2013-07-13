# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(document).ready ->

  Pusher.host = '127.0.0.1'
  Pusher.ws_port = 8080
  Pusher.wss_port = 8080

  pusher = new Pusher('1c81fd8f32b04884c7ac10a7df682973', { encrypted: false })
  channel = pusher.subscribe('test-channel')
  channel.bind "test-event",  (response)->
    $('.last_comments:first').before("<p class='last_comments'><a href=' "+response.picture+" '>"+response.comment.slice(1,-1)+"</a></p>")
    $('.last_comments:last').remove()
  check_like()
  check_subscribe()
  $("#like").click ->
    pic_id = $("#like").attr("name")
    $.ajax(
      url: "/pictures/like"
      data:
        pic_id: pic_id
      dataType: "json"
      type: "post"
    )
      .success (response) ->
        $("#like").css "opacity", response.like
        $(".all_likes span").text(response.all_likes)
      .fail (response) ->
        window.location = "/users/sign_in"
  $('.subscribe').click (event) ->
    $.ajax(
      url: "/categories/subscribe"
      data:
        cat_id: event.currentTarget.name
      dataType: "json"
      type: "post"
    )
      .success (response) ->
        if response.res == 1
          event.currentTarget.src ='/assets/subscribed.png'
        else
          event.currentTarget.src ='/assets/subscribe.png'
      .fail (response) ->
        window.location = "/users/sign_in"

check_like = ->
  pic_id = $("#like").attr("name")
  $.ajax(
    url: "/pictures/like"
    data:
      check: "check",
      pic_id: pic_id
    dataType: "json"
    type: "post"
  ).success (response) ->
    console.log response
    $("#like").css "opacity", response.like
    $(".all_likes span").html response.all_likes

check_subscribe = ->
  $.ajax(
    url: "/categories/check_subscribe"
    dataType: "json"
    type: "post"
  ).success (response) ->
    $(response).each (index,value) ->
      $('.subscribe[name='+value.category_id+']').attr('src','/assets/subscribed.png')


























