# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
ready = ->
  if $('body').hasClass('standings')
    if $('body').hasClass('index')
      $('.modal').on 'show.bs.modal', (e) ->
        setInterval (->
          text =  $('#spinner:visible').html() + "."
          $('#spinner:visible').html(text)
        ), 1000

    # Enable tooltips
    $('.status-tooltip').tooltip()

# Turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
