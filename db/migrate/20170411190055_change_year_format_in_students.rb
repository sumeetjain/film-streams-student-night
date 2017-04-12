class ChangeYearFormatInStudents < ActiveRecord::Migration

  def up
    change_column :students, :year, :string
  end

  def down
    change_column :students, :year, :integer
  end
end

