# ping the user to chose between the two options, after completing the execution ask for further input if any
def program(connection, cursor):
	choice = input("\nSelect one:\n1. Addition of course\t2. Student enrollment\nChoice: ")
	if choice=='1':
		deptId = input("Department ID: ")
		courseId = input("Course ID: ")
		empId = input("Professor ID: ")
		classroom = input("Classroom: ")
		update(cursor, deptId, courseId, empId, classroom)
	elif choice=='2':
		rollNo = input('Roll No.: ')
		courseId = input('Course ID: ')
		enroll(cursor, rollNo, courseId)
	else:
		print('Invalid Choice')
	
	connection.commit()

	res = input('\nAnother Query?(Y/N) ')
	if res=='Y' or res=='y':
		program(connection, cursor)
	else:
		print('\nExiting...\n')
		
# Verify if the course in the given department is present in database
def validCourse(cursor, deptId, courseId):
	cursor.execute("SELECT COUNT(*) FROM course where courseId = %s AND deptNo = %s", [courseId,deptId])
	return cursor.fetchone()[0] != 0

# Verify if the professor is present in database
def validProf(cursor, empId):
	cursor.execute("SELECT COUNT(*) FROM professor where empId = %s", [empId])
	return cursor.fetchone()[0] != 0

# Verify if the student is present in database
def validStud(cursor, rollNo):
	cursor.execute("SELECT COUNT(*) FROM student where rollNo = %s", [rollNo])
	return cursor.fetchone()[0] != 0

# Verify if the course is provided in even sem of year 2006
def coursePresent(cursor, courseId):
	cursor.execute("SELECT COUNT(*) FROM teaching where courseId = %s AND sem = 'even' AND year = 2006", [courseId])
	return cursor.fetchone()[0] != 0

# Verify if the rollNo is enrolled in even sem of year 2006
def studentPresent(cursor, rollNo, courseId):
	cursor.execute("SELECT COUNT(*) FROM enrollment where rollNo = %s AND courseId = %s AND sem = 'even' AND year = 2006", [rollNo, courseId])
	return cursor.fetchone()[0] != 0


# Verify if the student has passed in the prerequisites of the course that he/she wants to enroll in
# return True if student has passed all the prerequisites of the course or if course does not have any prerequisite
# return False otherwise
def verifyPreq(cursor, rollNo, courseId):
	cursor.execute("SELECT preReqCourse FROM prerequisite WHERE courseId = %s", [courseId])
	preReqCoursesList = [x[0] for x in cursor]
	for i in preReqCoursesList:
		sql = "SELECT grade FROM enrollment WHERE rollNo = %s AND courseId = %s AND ((year < 2006) OR (year = 2006 AND sem = 'odd')) ORDER BY year DESC LIMIT 1"
		val = [rollNo, i]
		cursor.execute(sql,val)
		out = next(iter([x[0] for x in cursor]), None)
		if out == None or out == 'U':
			return False
	return True

# update the course details of the even semester of 2006 for a particular department
def update(cursor, deptId, courseId, empId, classroom):
	if not validCourse(cursor,deptId,courseId):
		print("Invalid Course or Department details")
	elif not validProf(cursor,empId):
		print("Invalid Professor details")
	elif coursePresent(cursor, courseId):
		sql = "UPDATE teaching SET teaching.empId = %s, teaching.classroom = %s WHERE teaching.sem = %s and teaching.year = %s and teaching.courseId = %s"
		val = [empId,classroom,"even","2006",courseId]
		cursor.execute(sql,val)
		print(cursor.rowcount, "record(s) updated")
	else:
		sql = "INSERT INTO teaching (empId,courseId,sem,year,classroom) VALUES (%s, %s, %s, %s, %s)"
		val = [empId,courseId,"even","2006",classroom]
		cursor.execute(sql,val)
		print(cursor.rowcount, "record(s) inserted")
	return

# enrollment of students into the courses for even semester of 2006 for a particular department
def enroll(cursor, rollNo, courseId):
	if validStud(cursor, rollNo):
		if coursePresent(cursor, courseId):
			if verifyPreq(cursor, rollNo, courseId):
				if studentPresent(cursor,rollNo, courseId):
					print("Student already enrolled in the course")
				else:
					sql = "INSERT INTO enrollment VALUES (%s, %s, %s, %s, %s)"
					val = [rollNo,courseId,"even","2006",None]
					cursor.execute(sql,val)
					print(cursor.rowcount, "record(s) inserted")
			else:
				print("The student doesn't qualify prerequisite criteria")
		else:
			print("The course is not provided this semester")
	else:
		print("The student is not present in the database")