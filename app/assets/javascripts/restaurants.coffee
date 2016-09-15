document.addEventListener 'turbolinks:load', ->
  $('#restaurant-image-gallery').slick
    autoplay: true
    arrows: false
    variableWidth: true
    autoplaySpeed: 2000
    infinite: true
    centerMode: true
    centerPadding: '60px'
  return

document.addEventListener 'turbolinks:load', ->
  $('.infinite-scroll').infinitePages
    loading: ->
      $(this).text('Loading next page...')
    error: ->
      $(this).button('There was an error, please try again')
  return

