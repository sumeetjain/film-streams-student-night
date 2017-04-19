task :import_schools => :environment do
  schools_list = File.join(Rails.root, 'lib', 'schools.txt')

  File.readlines(schools_list).each do |school|
    puts "Importing school: #{school}"
    s = School.find_or_create_by(name: school.chomp)

    puts "Created school #{s.id} with name '#{s.name}'"
  end
end
