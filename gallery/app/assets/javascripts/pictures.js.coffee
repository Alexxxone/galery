# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# показываем элемент



#сделать 1 канал по которому user будет слушать входящие
# при входящем канал будет называтся channel- + sender_id +receiver_id

$(document).ready ->
  #test of creating a private channel
  create_chat(22,33)

  current_user_id = $('#current_user_id').attr('class')
  Pusher.host = '127.0.0.1'
  Pusher.ws_port = 8080
  Pusher.wss_port = 8080
  $ ->
    $("#draggable").draggable({ cancel: ".message_text, .private_chat input" })
  $ ->
    $(document).tooltip position:
      my: "center bottom-20"
      at: "center top"
      using: (position, feedback) ->
        $(this).css position
        $("<div>").addClass("arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo this

  pusher = new Pusher('40c797d047b5b2d43e30', { encrypted: false,authTransport: 'jsonp', authEndpoint: '/pusher/auth'})
  privatechannel = pusher.subscribe('private-channel')
  privatechannel.bind "pri-event"+current_user_id,  (response)->
    if current_user_id != response.user.id
      $('#new_message_notification').append("<p class='incomming_notification'>New message from :"+response.user.email+"</br>"+response.message+"<p>")
      $('.incomming_notification').delay(800).slideUp('fast')
      $(".user_chat #"+response.user.id).click()
      $('.message_text').append("<p class='messages_show_all'><span>"+response.user.email+"</span>"+response.message.slice(1,-1)+"</p>")


# ПЕРЕДЕЛАТЬ НА СОЗДАНИЕ ПРИВАТНОГО ОКНА НА JS APPEND -ом и то что на листочке

# show chat window
  receiver_id = $(".show_private_chat").click (event)->
    $('.private_chat').show()
    $('.receiver').text(event.currentTarget.innerHTML)
    get_chat_messages(event.currentTarget.id)
    return event.currentTarget.id







# отправка
  $('.sending_message_button').click (event6)->
    $(document).bind("ajaxSend", ->
      $('.sending_message_button').prop('disabled', true)
      $('.sending_message_button').html('Wait..')
      $('.private_chat input').val('')
    ).bind "ajaxComplete", ->
      $('.sending_message_button').html('Send')
      $('.sending_message_button').prop('disabled', false)
    text =  $('.private_chat input').val()
    $.ajax(
      url: "messages/send"
      data:
        text: text
        receiver_id: receiver_id['0']['id']
      dataType: "json"
      type: "post"
    )
    $('.message_text').append("<p class='messages_show_all'><span>Me</span>"+text+"</p>")

    false






  pusher = new Pusher('40c797d047b5b2d43e30', { encrypted: false })
  channel = pusher.subscribe('test-channel')

  channel.bind "test-event",  (response)->
    console.log 'asdasd'
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



# Выборка всех сообщений с собеседником
get_chat_messages = (opponent_id) ->
  $.ajax(
    url: "/pictures/chat_messages"
    data:
      opponent_id: opponent_id
    dataType: "json"
    type: "post"
  ).success (response) ->
    receiver_email = $('.receiver').text()
    opponent_id = parseInt( opponent_id, 10 );
    $.each response.incomming, (i, l) ->
      if l.sender_id is opponent_id
        $('.message_text').append("<p class='messages_show_all'><span><a href='#' title='"+receiver_email+"'>Opponent</a></span>"+l.text+"</p>")
      else
        $('.message_text').append("<p class='messages_show_all'><span>Me</span>"+l.text+"</p>")
    $(document).bind "ajaxStop", ->
      height = $('.messages_show_all').height() * $('.message_text .messages_show_all').length *10
      $('.message_text').animate
        scrollTop: height
      , 1000




  #создание приват чата на js
create_chat = (my_id, opponent_id) ->

  max =  Math.max(my_id,opponent_id)
  min =   Math.min(my_id,opponent_id)

  channel_name = "private-channel"+min+max
  console.log channel_name

















