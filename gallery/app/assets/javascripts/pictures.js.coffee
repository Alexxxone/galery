# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# показываем элемент



#сделать 1 канал по которому user будет слушать входящие
# при входящем канал будет называтся channel- + sender_id +receiver_id

$(document).ready ->
  id = get_user_id()
  id = id.readyState
  pusher = new Pusher('40c797d047b5b2d43e30', { encrypted: false })
  privatechannel = pusher.subscribe('private-'+id)

  privatechannel.bind "pri-event",  (response)->
    $('.private_chat').show()
    $('.receiver').text(response.user.email) if $('.receiver').text()==''
    $('.message_text').append("<p>"+response.message+"</p>")

  #переделать event (отсылку сообщений на кнопку) и сделать приватный чат
  $('.sending_message_button').click (event)->
    $(document).bind("ajaxSend", ->
      $('.private_chat input').prop('disabled', true)
      $('.private_chat input').val('Sending')
    ).bind "ajaxComplete", ->
      $('.private_chat input').prop('disabled', false)
      $('.private_chat input').val('')
    receiver_id = event.currentTarget.id
    text =  $('.private_chat input').val()

    $.ajax(
      url: "messages/send"
      data:
        text: text
        receiver_id: receiver_id
      dataType: "json"
      type: "post"
    )

    false


    #show chat window
  $(".show_private_chat").click (event)->
    $('.private_chat').show()
    $('.receiver').text(event.currentTarget.innerHTML)

  Pusher.host = '127.0.0.1'
  Pusher.ws_port = 8080
  Pusher.wss_port = 8080

  pusher = new Pusher('40c797d047b5b2d43e30', { encrypted: false })
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


get_user_id = ->

  $.ajax(
    url: "/pictures/user"
    dataType: "json"
    type: "post"
  ).success (response) ->
    return response.id























