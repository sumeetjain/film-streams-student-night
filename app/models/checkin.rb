class Checkin
  attr_reader :email

  def initialize(params)
    @email = params[:email]
    @email_confirmation = params[:email_confirmation]
  end

  def valid?
    is_a_valid_email? and emails_match?
  end

  def student
    Student.find_by(email: @email)
  end

  def student_id
    student.id
  end

  private 

    def is_a_valid_email?
      (@email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    end

    def emails_match?
      @email == @email_confirmation
    end

end