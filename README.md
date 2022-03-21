# Student Enrollment System

Deployed Application: https://project-2-team-2679-3.herokuapp.com/

Repository Link: https://github.ncsu.edu/amundra/Student-Enrollment-System

Admin Credentials:

**Email**: admin@example.com

**Password**: admin123

This repo is for a Student Enrollment System that can be used in schools. It provides the following features:
- Student, Instructor log in
- Students can enroll in, drop courses
- Instructors can create and delete courses
- Instructors can view the students enrolled and waitlisted in their course.
- Students can be added to the waitlist for a course if there is space on the waitlist(provided instructor has enabled waitlist).
- Students are automatically enrolled from the waitlist into the course if another enrolled student drops the course.

### Team members
Ankur Mundra (amundra@ncsu.edu)

Shruti Satish Magai (smagai@ncsu.edu)

Sri Athithya Kruth Babu (sbabu@ncsu.edu)

### Rails Model Dependency Diagram

![admin](https://media.github.ncsu.edu/user/22729/files/01337b6b-5373-40e8-b655-21c51f2c72f3)

### Database Schema
![development](https://media.github.ncsu.edu/user/22729/files/0e2ebb1c-a911-4600-9277-c69dbd54e2a5)


## Instructors

The instructor page allows instructors to log in using their credentials or sign up by providing their information. 

Once they sign in, they have the following capabilities in the system:
- Creating a new course with a time and room number of their choice, and other options like capacity of the course, number of waitlisted seats etc
- Adding students to their course 
- Viewing enrolled and waitlisted students in their courses
- Removing students from their course
- Edit their personal information apart from email address
- Instructors can remove the courses they have created, and this causes all the students enrolled in the course to drop the course automatically.

## Students

The student page allows students to log in using their credentials or sign up by providing their information. 

Once they sign in, they have the following capabilities in the system:
- Students can enroll for open courses, or get themselves waitlisted for certain courses with the option to do so
- Students can drop courses they are no longer interested in
- Students dropping courses with a waitlist option means the waitlisted students automatically get enrolled in the order they joined the waitlist
- Students can update their personal information apart from email address and student ID. 

## Administrator(Admin)

The admin can log in to the application with following information:
Admin Credentials:

**Email**: admin@example.com

**Password**: admin123

Admins have the following capabilities in the system:

- Admins can add new students or instructors.
- Admins can remove students or instructors.
- Admins can view all students, courses, enrollments, instructors in the system.
- Admins can add/edit/delete courses created by instructors, in which the courses created by the instructor are also removed, and enrollments for their courses and cancelled.
- Admins can add students to courses, or remove them. 

## How to Test Features

Please go to the deployed web application. You can create both instructors and users there, and both require passwords to log in to the application.

Please create instructors first by clicking on "Instructor" on the top of the web app. Using the instructor, you can create courses for the application.

Then create students who can be enrolled in the courses, and dropped later depending on the requirements.

## Edge-cases 
- Admin deletes course taken by several students.
Cascading delete will remove all of the students from the course in question. The course will of course be deleted.

- Instructor deletes course taken by several students.
Cascading delete will remove all of the students from the course in question. The course will of course be deleted.

- Admin deletes an Instructor with courses taken by several students.
Cascading delete will remove all of the students from all of the courses created by the instructor in question, and the courses will also be deleted.

- Students can only be added to the waitlist for a course when the capacity of the course has been fully used. 

- If a student who is enrolled in a course drops the course, the student who joined the waitlist first will be enrolled in their place.

- If the capacity of the course is full i.e all the seats have been taken by students, then the status of the course changes to "WAITLIST" if the instructor has allowed a waitlist for the course. 

- If the capacity of the course is full and there is not waitlist capcaity allocated for the course, the course is moved to the "CLOSED" state.

- If an enrolled student drops a course with a waitlist, then the earliest student on the waitlist is enrolled.

- Student cannot see the instructor profiles, or the profiles of other students.

- Students cannot enroll in courses, or drop courses without being authenticated. 

- Instructors can see only the courses they have created, and cannot see the courses created by other instructors. They also cannot view the lists of students of courses from other instructors.

- Admin email cannot be edited.
