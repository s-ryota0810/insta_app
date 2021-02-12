import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const dataset = $('#article-show').data()
const articleId = dataset.articleId

const likeCountCalculation = (likeCount) => {
  $('.article-heart-count > span').append(
    `${likeCount}`
  )
}

const appendNewComment = (comment) => {
  $('.comments_container').append(
    `<div class="comment_area">
    <div class="comment_area_image"><img src="${comment.user.avatar_image}"></div>
    <div class="comment_area_item">
    <div class="comment_area_user_name"><p>${comment.user.account}</p></div>
    <div class="comment_area_content"><p>${comment.content}</p></div>
    </div>
    </div>`
  )
}


document.addEventListener('DOMContentLoaded', () => {
  
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
  
  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        appendNewComment(comment)
      })
    })
    
  $('.comment_btn').on('click', () => {
    $('.comment_btn').addClass('hidden')
    $('.comment_form').removeClass('hidden')
    $('.comment-text-area').removeClass('hidden')
    $('.btn-comment-push').removeClass('hidden')
  })
  
  $('.add-comment-btn').on('click', function(){
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/articles/${articleId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
            
        })
    }
  })

})

