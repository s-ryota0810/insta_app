// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

document.addEventListener('turbolinks:load', () => {
  $('.profile_info_image').on('click', function(){
    $('#uploader').click()
  })
  $('#uploader').change(function() {
    $('#submit').click()
  })
  
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId
  const likeCountCalculation = (likeCount) => {
    $('.article-heart-count > span').append(
      `${likeCount}`
    )
  }
  
  
  axios.get(`/articles/${articleId}/likes`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      const likeCount = response.data.likeCount
      if (hasLiked) {
        $('.active-heart-logo').removeClass('hidden')
      } else {
        $('.inactive-heart-logo').removeClass('hidden')
      }
      likeCountCalculation(likeCount)
    })
    
  $('.inactive-heart-logo').on('click', () => {
    axios.post(`/articles/${articleId}/likes`)
      .then((response) =>{
        if (response.data.status === 'ok') {
          $('.active-heart-logo').removeClass('hidden')
          $('.inactive-heart-logo').addClass('hidden')
        }
        const likeCount = response.data.likeCount
        $('.article-heart-count > span').html('')
        likeCountCalculation(likeCount)
      })
      .catch((e) => {
        window.alert('Error')
      })
  })
  $('.active-heart-logo').on('click', () => {
    axios.delete(`/articles/${articleId}/likes`)
      .then((response) =>{
        if (response.data.status === 'ok') {
          $('.inactive-heart-logo').removeClass('hidden')
          $('.active-heart-logo').addClass('hidden')
        }
        const likeCount = response.data.likeCount
        $('.article-heart-count > span').html('')
        likeCountCalculation(likeCount)
      })
      .catch((e) => {
        window.alert('Error')
      })
  })
  
  
  axios.post(`/articles/${articleId}/comments`)
    const commentContent = response.data.content
    .then((response) => {
      
    })
})

