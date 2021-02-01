class MentionMailer < ApplicationMailer
  def mention_to(user, comment)
    @comment = comment
    @user = user
    mail to: user.email, subject: '【お知らせ】メンションされました'
  end
end