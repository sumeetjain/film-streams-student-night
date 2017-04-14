class ChangeYearFormatStudents < ActiveRecord::Migration
	def change
	    change_column :students, :year, 'integer USING CAST(year AS integer)'
	end
end
