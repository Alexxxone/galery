class UserMailer < ActionMailer::Base
  default from: AdminUser.first.email


  def category_email(recipients,categories)
    @users = []
     recipients.each{|u| @users << u.email}
    @url  = 'http://example.com/login'
    mail(to: @users, subject: "Gallery/ies :#{categories.map { |cat| cat.name }} you are subscribed to, were updated with new pictures !")
  end

  def receive(email)
    page = Page.find_by_address(email.to.first)
    page.emails.create(
        subject: email.subject
    )
  end
end
