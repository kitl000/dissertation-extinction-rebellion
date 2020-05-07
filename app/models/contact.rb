class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true

  def headers
    {
        :subject => "Contact Form",
        :to => "your_email@your_domain.com",
        :from => %("#{name}" <#{email}>)
    }
  end
end