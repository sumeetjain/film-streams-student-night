class Csvdata
	include ActiveModel::Model
	require 'CSV'

	EVENT_DATES = ["1/5/2009", "2/2/2009", "3/2/2009", "4/6/2009", "5/4/2009", "6/1/2009", "7/6/2009", "8/3/2009", "9/7/2009", "10/5/2009", "11/2/2009", "12/7/2009", "1/4/2010", "2/1/2010", "3/1/2010", "4/5/2010", "5/3/2010", "6/7/2010", "7/5/2010", "8/2/2010", "9/6/2010", "10/4/2010", "11/1/2010", "12/6/2010", "1/3/2011", "2/7/2011", "3/7/2011", "4/4/2011", "5/2/2011", "6/6/2011", "7/4/2011", "8/1/2011", "9/5/2011", "10/3/2011", "11/7/2011", "12/4/2011", "1/2/2012", "2/6/2012", "3/5/2012", "4/2/2012", "5/7/2012", "6/4/2012", "7/2/2012", "8/6/2012", "9/3/2012", "10/1/2012", "11/5/2012", "12/3/2012", "1/7/2013", "2/4/2013", "3/4/2013", "4/1/2013", "5/6/2013", "6/3/2013", "7/1/2013", "8/5/2013", "9/2/2013", "10/7/2013", "11/4/2013", "12/2/2013", "1/6/2014", "2/3/2014", "3/3/2014", "4/7/2014", "5/5/2014", "6/2/2014", "7/7/2014", "8/4/2014", "9/1/2014", "10/6/2014", "11/3/2014", "12/1/2014", "1/5/2015", "2/2/2015", "3/2/2015", "4/6/2015", "5/4/2015", "6/1/2015", "7/6/2015", "8/3/2015", "9/7/2015", "10/5/2015", "11/2/2015", "12/7/2015", "1/4/2016", "2/1/2016", "3/7/2016", "4/4/2016", "5/2/2016", "6/6/2016", "7/4/2016", "8/1/2016", "9/5/2016", "10/3/2016", "11/1/2016", "12/5/2016", "1/2/2017", "2/6/2017"]
	EVENT_DATES_FIXED = ["5/1/2009", "2/2/2009", "2/3/2009", "6/4/2009", "4/5/2009", "1/6/2009", "6/7/2009", "3/8/2009", "7/9/2009", "5/10/2009", "2/11/2009", "7/12/2009", "4/1/2010", "1/2/2010", "1/3/2010", "5/4/2010", "3/5/2010", "7/6/2010", "5/7/2010", "2/8/2010", "6/9/2010", "4/10/2010", "1/11/2010", "6/12/2010", "3/1/2011", "7/2/2011", "7/3/2011", "4/4/2011", "2/5/2011", "6/6/2011", "4/7/2011", "1/8/2011", "5/9/2011", "3/10/2011", "7/11/2011", "4/12/2011", "2/1/2012", "6/2/2012", "5/3/2012", "2/4/2012", "7/5/2012", "4/6/2012", "2/7/2012", "6/8/2012", "3/9/2012", "1/10/2012", "5/11/2012", "3/12/2012", "7/1/2013", "4/2/2013", "4/3/2013", "1/4/2013", "6/5/2013", "3/6/2013", "1/7/2013", "5/8/2013", "2/9/2013", "7/10/2013", "4/11/2013", "2/12/2013", "6/1/2014", "3/2/2014", "3/3/2014", "7/4/2014", "5/5/2014", "2/6/2014", "7/7/2014", "4/8/2014", "1/9/2014", "6/10/2014", "3/11/2014", "1/12/2014", "5/1/2015", "2/2/2015", "2/3/2015", "6/4/2015", "4/5/2015", "1/6/2015", "6/7/2015", "3/8/2015", "7/9/2015", "5/10/2015", "2/11/2015", "7/12/2015", "4/1/2016", "1/2/2016", "7/3/2016", "4/4/2016", "2/5/2016", "6/6/2016", "4/7/2016", "1/8/2016", "5/9/2016", "3/10/2016", "1/11/2016", "5/12/2016", "2/1/2017", "6/2/2017"]

	# Saves all previous Events based on the hard coded values from Excel
	#
	# run it one time to populate the PG database with these events
	def Csvdata.seedEvents
		EVENT_DATES_FIXED.each do |date|
			event = Event.new(date: date, title: "Free Movie Night", created_at: date, updated_at: date)
			event.save
		end
	end

	# Looks through the CSV and saves a Student and their attendances based on their column values
	#
	# Run this to populate the CSV with all previus students and their attendances on dates.
	def Csvdata.seedStudents
		saves = 0
		fails = 0
		error_list = []
		file_path = File.join(Rails.root, 'lib', 'student_night.csv')
		CSV.foreach(file_path, {headers: true, return_headers: false}) do |row|

			student = Student.new(
			email: row["E-MAIL"].to_s.downcase,
			name: "#{row["FIRST NAME"]} #{row["LAST NAME"]}",
			school_id: Csvdata.set_valid_school(row["SCHOOL"]),
			year: Csvdata.set_valid_year(row["YR"]),
			zip: row["zip"],
			referral: 999
			)

			student = Csvdata.make_valid(student)

			if student.save
				Csvdata.save_student_attendances(row, student)
				saves += 1
			else
				error_list << student.errors.messages
				fails += 1
			end					
		end
		puts "student saves: #{saves}"
		puts "student fails: #{fails}"
		puts error_list
	end

	# Give a student object and row, records all their attendances into database
	#
	# student - Student , row - csv row
	#
	# Regex makes sure column header in the form DD/MM/YY is being examined.
	#
	# saves all attendances to an event, returns first attendance
	def Csvdata.save_student_attendances(row, student)

			attendances = Csvdata.attendanceDates(row)

			attendances.each do |attendance|
				if !/\d+\/\d+\/\d{2}/.match(attendance).nil?
					event =  Event.find_by(date: Csvdata.convert(attendance))
					new_att = Attendance.new(student_id: student.id,
														 			 event_id: event.id,
														 			 created_at: event.created_at,
														 			 updated_at: event.updated_at)
					new_att.save
				end
			end
	end

	# Given a row looks through each header value to see if value is 1
	#
	# 1 is the indication within a column whether a student attended
	#
	# returns an array of dates on which a student attended Student Film Night
	def Csvdata.attendanceDates(row)
		dates = []
		row.headers.each do |header|
				dates << header if row[header] == "1"
		end
		return dates
	end

	# Takes a date that looks like "3/4/10" and transforms it "2010-04-10"
	def Csvdata.convert(attendance)
			attendance = attendance.split("/")

			attendance = Time.new("20" + attendance[2],
																	 attendance[0],
																	 attendance[1])
			attendance = attendance.strftime("%F")
	end

	# Creates the school if needed. Then returns the school's ID.
	def Csvdata.set_valid_school(school)
		puts "Setting valid school for #{school}"
		if school.nil?
			school = "Other School"
		end
		
		saved_school = School.find_or_create_by(name: school.chomp)
		saved_school.id
	end

	# Takes a year unformatted. If valid, returns, checks for capitalization errors, containing keywords
	#
	# Returns a valid Enum for year
	def Csvdata.set_valid_year(year)
		year.nil? ? "" : year
		if Csvdata.year_compare(year)
			return year
		elsif Csvdata.year_compare(year.to_i)
			return year.to_i
		elsif Csvdata.year_compare(year.to_s.downcase.capitalize)
			return year.to_s.downcase.capitalize
		elsif !Csvdata.year_contains(year.to_s).nil?
			return Csvdata.year_contains(year.to_s)
		else
			return 999
		end
	end

	# Takes a string (year) and checks if the array of proper year Enums contains it
	#
	# Returns Boolean
	def Csvdata.year_compare(year)
		(Student.years.values.include? year) || (Student.years.keys.include? year)
	end

	# Takes a string year, and checks each element of Year Enum Array whether it contains that string
	#
	# returns proper form of year, or nil
	def Csvdata.year_contains(year)
		Student.years.keys.each do |year_key|
			if (year_key.include? year)
				return year_key
			elsif (year_key.downcase.capitalize.include? year)
				return year_key.downcase.capitalize
			end
		end
		return nil
	end

	# Big ugly filter conditional. Takes a student, and for each error, fixes (most) errors.
	#
	# Recursive - calls itself again until all errors are fixed.
	#
	# - If email has been take, finds identical record
	# - If email is blank OR invalid, creates invalid email with random digit appended 
	# - If zip is blank, fills in with 00000
	# - If name is blank, fills with "none given"
	#
	# Returns a saveable student.
	def Csvdata.make_valid(student)
		if student.valid?
			return student
		elsif !student.errors.messages[:email].nil?
			if student.errors.messages[:email].include? "has already been taken"
				student = Student.find_by(email: student.email.downcase)
			elsif student.errors.messages[:email].include?("is invalid") || student.errors.messages[:email].include?("can't be blank")
				student.email = "invalid" + rand(9999).to_s + "@invalid.com"
				student.valid? ? student : Csvdata.make_valid(student)
			end
		elsif !student.errors.messages[:zip].nil?
			student.zip = "00000"
			student.valid? ? student : Csvdata.make_valid(student)
		elsif !student.errors.messages[:name].nil?
			student.name = "none given"
			student.valid? ? student : Csvdata.make_valid(student)
		else
			return student
		end
	end

	# Creates an admin account
	def Csvdata.seedAdmin
		User.create(name: "admin", password: "studentnight", password_confirmation: "studentnight", email: "kate@filmstreams.org")
	end

end

task :legacy_import => :environment do
	Csvdata.seedEvents
	Csvdata.seedStudents
	Csvdata.seedAdmin
end