class Checkin
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks
  
  attr_accessor :email
  before_validation :downcase_email
  validates :email, confirmation: true

  validates :email,
    presence: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  def student
    Student.find_by(email: email)
  end

  def student_id
    student.id
  end

  def downcase_email
    self.email.downcase!
    self.email_confirmation.downcase!
  end
end