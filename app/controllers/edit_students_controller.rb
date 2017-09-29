class EditStudentsController < ApplicationController

def index
	@student = Student.all
end

end
