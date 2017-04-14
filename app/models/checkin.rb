class Checkin
  include ActiveModel::Model

  attr_accessor :email

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
end