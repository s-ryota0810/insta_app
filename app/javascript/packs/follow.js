import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const accountDataset = $('#account-show').data()
const accountId = accountDataset.accountId

document.addEventListener('DOMContentLoaded', () => {
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
