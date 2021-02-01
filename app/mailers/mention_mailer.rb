class MentionMailer < ApplicationMailer
  def mention_to(to_user, from_user, content)
    @to_user = to_user
    @from_user = from_user
    @content = content
    mail to: to_user.email, subject: '【お知らせ】メンションされました'
  end
end