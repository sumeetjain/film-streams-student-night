class ChangeSchoolToSchoolIdInStudents < ActiveRecord::Migration
  def change
    rename_column :students, :school, :school_id
  end
end
