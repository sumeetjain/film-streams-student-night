module EditStudentsHelper

	def dropYears
		Student.years.map { |wordedYear, numberedYear| [wordedYear, wordedYear] }
	end

	def dropSchools
		options_from_collection_for_select(School.all, :id, :name, selected: @student.school_id)
	end
	
end
