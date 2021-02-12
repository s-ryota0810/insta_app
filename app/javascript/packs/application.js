// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
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


document.addEventListener('DOMContentLoaded', () => {
  $('.profile_info_image').on('click', function(){
    $('#uploader').click()
  })
  $('#uploader').change(function() {
    $('#submit').click()
  })
  



    
  
})

document.addEventListener('turbolinks:load', () => {
  
  const accountDataset = $('#account-show').data()
  const accountId = accountDataset.accountId

  axios.get(`/accounts/${accountId}/follows`)
      .then((res) => {
        const followed = res.data.followStatus
        if (followed) {
          $('.unfollow-btn').removeClass('hidden')
        } else {
          $('.follow-btn').removeClass('hidden')
        }
     })
     
  $('.unfollow-btn').on('click', () => {
    axios.delete(`/accounts/${accountId}/follows`)
      .then((res) => {
        if (res.data.status === 'ok') {
          $('.follow-btn').removeClass('hidden')
          $('.unfollow-btn').addClass('hidden')
        }
      })
  })
  
  $('.follow-btn').on('click', () => {
    axios.post(`/accounts/${accountId}/follows`)
      .then((res) => {
        if (res.data.status === 'ok') {
          $('.unfollow-btn').removeClass('hidden')
          $('.follow-btn').addClass('hidden')
        }
      })
  })

})

