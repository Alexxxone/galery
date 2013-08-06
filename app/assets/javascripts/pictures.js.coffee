# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  current_user_id = gon.current_user || ''
  Pusher.host = '127.0.0.1'
  Pusher.ws_port = 8080
  Pusher.wss_port = 8080

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

#change language
  $("#language").click (event)->
    language = $(event.currentTarget).find('option:selected').val()
    $.ajax(
      url: "/pictures/select_language"
      data:
        language: language
      dataType: "json"
      type: "post"
    ).success (response) ->
      if response.ok
        window.location.reload()
      else
        window.location = ('/')
#tooltip
  $ ->
    $(document).tooltip position:
      my: "center bottom-20"
      at: "center top"
      using: (position, feedback) ->
        $(this).css position
        $("<div>").addClass("arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo this
#check likes
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
      $("#like").css "opacity", response.like
      $(".all_likes span").html response.all_likes
#check subcribed categories
  check_subscribe = ->
    $.ajax(
      url: "/categories/check_subscribe"
      dataType: "json"
      type: "post"
    ).success (response) ->
      $(response).each (index,value) ->
        $('.subscribe[name='+value.category_id+']').attr('src','/assets/subscribed.png')
#channel for new comments
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

#private chat
  all_user_id = []
  $('.show_private_chat').each (index,value) ->
    max = Math.max(current_user_id,value['id'])
    min = Math.min(current_user_id,value['id'])
    all_user_id.push(min+'i'+max)
  pusher = new Pusher('40c797d047b5b2d43e30', { encrypted: false,authTransport: 'jsonp', authEndpoint: '/pusher/auth'})
  privatechannel = pusher.subscribe('private-channel')
  $(all_user_id).each (ind,val) ->
    privatechannel.bind "pri-event"+val,  (response)->
      if parseInt(current_user_id) == parseInt(response.receiver_id)

        $('#new_message_notification').append("<p class='incomming_notification'>New message from :"+response.user.email+"</br>"+response.message+"<p>")
        $('.incomming_notification').delay(1800).slideUp('fast')
        a = [parseInt(current_user_id),parseInt(response.user.id)]
        a.sort (a, b) ->
          a - b
        min_max = a.join('i')
        user_chat = $('.chat_id'+min_max)
        if user_chat.length
          if user_chat.is(':hidden')
            user_chat.show()
          user_chat.find('.message_text').append("<p class='messages_show_all'><span><a href='#' title='"+response.user.email+"'>Opponent</a></span>"+response.message.slice(1,-1)+"</p>")
        else
          $(".show_private_chat##{response.user.id}").click()
          $('.chat_id'+min_max).find('.message_text').append("<p class='messages_show_all'><span>"+response.user.email+"</span>"+response.message.slice(1,-1)+"</p>")
#show chat window
  $(".show_private_chat").click (event)->
    a = [current_user_id,event.currentTarget.id]
    a.sort (a, b) ->
      a - b
    min_max = a.join('i')
    user_chat = $('.chat_id'+min_max)
    if user_chat.length
      user_chat.show()
    else
      create_chat(current_user_id,event.currentTarget.id,event.currentTarget.innerHTML)

# DOCUMENT READY END

#cretig private chat
create_chat = (current_user_id,opponent_id,opponent_email) ->
  max = Math.max(current_user_id,opponent_id)
  min = Math.min(current_user_id,opponent_id)
  user_chat = '.chat_id'+min+'i'+max
  $('.user_chat').after("<div class ='private_chat ui-widget-content chat_id"+min+'i'+max+"' id='draggable'><span class='close_chat' onclick='close_chat(this)'>x</span><span></span>Interlocutor : <div class ='receiver' id='"+opponent_id+"'>"+opponent_email+"</div><div class ='border'></div><div class ='message_text'></div><input id='mess' class='input-medium' type='text' placeholder='Write your text here...' name='mess'><button class='btn btn-small sending_message_button pull-right' data-disable-with = 'Please wait ..' type='button' name='button' onclick = 'send_message(this)'>Send</button></div>")
  $("#draggable").draggable({ cancel: ".message_text, .private_chat input" })
  get_chat_messages(opponent_id,user_chat)

# Get all messages with you and current opponent
get_chat_messages = (opponent_id,user_chat) ->
  $.ajax(
    url: "/pictures/chat_messages"
    data:
      opponent_id: opponent_id
    dataType: "json"
    type: "post"
  ).success (response) ->
    receiver_email = $('.receiver').text()
    opponent_id = parseInt( opponent_id, 10 )
    $.each response.incomming, (i, l) ->
      if l.sender_id is opponent_id
        $(user_chat).find('.message_text').append("<p class='messages_show_all'><span><a href='#' title='"+receiver_email+"'>Opponent</a></span>"+l.text+"</p>")
      else
       $(user_chat).find('.message_text').append("<p class='messages_show_all'><span>Me</span>"+l.text+"</p>")
    $(document).bind "ajaxStop", ->
      height =  $(user_chat).find('.messages_show_all').height() * $('.message_text .messages_show_all').length *10
      $(user_chat).find('.message_text').animate
        scrollTop: height
      , 1000

#Send message
@send_message = (context)->
  this_chat = $(context).parent()
  text = this_chat.find('input').val()
  if text.length >= 1
    opponent_id = this_chat.find('.receiver').attr('id')
    current_user_id = document.getElementById('current_user_id').getAttribute('class')
    max = Math.max(current_user_id,opponent_id)
    min = Math.min(current_user_id,opponent_id)
    event_name = 'pri-event'+min+'i'+max
    $(document).bind("ajaxSend", ->
      this_chat.find('button').prop('disabled', true)
      this_chat.find('button').html('Wait..')
      this_chat.find('input').val('')
    ).bind "ajaxComplete", ->
      this_chat.find('button').html('Send')
      this_chat.find('button').prop('disabled', false)
    $.ajax(
      url: "/messages/send"
      data:
        text: text
        receiver_id: opponent_id
        event_name: event_name
      dataType: "json"
      type: "post"
    )
    this_chat.find('.message_text').append("<p class='messages_show_all'><span>Me</span>"+text+"</p>")
    false

#close chat window
@close_chat =(context) ->
  $(context).parent().hide()







