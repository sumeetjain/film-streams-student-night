class StudentChangeColumnType < ActiveRecord::Migration
	def change
	    change_column :students, :school, 'integer USING CAST(school AS integer)'
	end
end
