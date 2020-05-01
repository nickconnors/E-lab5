# README
CSE 3901 LAB 5 - Final Project

DESCRIPTION

This is a web app built on Ruby on Rails that allows for a more intuative TA assignment process. The Assignment of 
TAs to CSE related classes has always been tricky for administrators. This app allows students to submit TA request 
Forms, Teachers to submit Recommendations and Requests, and administrators to look over all the given material to assign 
a TA to a class. This App also includes a method that will recommend qualified graders to administrators.  

INSTRUCTIONS

Execute the following commands to get the app running
* Bundle install

* rails db:migrate

* rails server (this starts the app)

* go to a web browser and navigate to http://localhost:3000/

* create a username and password by hitting sign up in browser

* Once a user is made you should go to the rails terminal

* in the rails console find this user and update the admin field to true 

    Ex: user = User.where(:email => 'user email address')
    
    user.update(admin: true)

* Now log back into the app and you will have access to all the admin controls
(admins will be able to change the privilages of other users and view all submissions)

* The first thing that is recommended is seeding the database for available courses
(this is done by hitting the "reset database" button on course view in admin page)

* Once all this is done the app is ready for teachers and students to make submissions and 
admins to monitor these forms along with assign graders

SECTIONS

Student:

* When a user makes an account they are only granted access to student privileges 

* They can create a new TA request form or edit one that they have made in the past 

* In this form they are required to give their name, dotnumber, available times, and courses with grades

Teacher:

* Admins must give permissions to an account to be able to access the teacher page

* Here teachers can recommend students, request students and leave reviews of past students

* They can also view the submission they made for verification

Administration:

* Administration can view all pages in the app for test purposes 

* In the Administration page they can view/edit user privileges, teacher submissions, available courses with graders

* When an admin goes to edit a course at the bottom will be a recommended list of students that meet TA requirements 
for that certain class. The list is ranked in order from most qualified to least. 

Presentation link: https://docs.google.com/presentation/d/1rzW_RNlk8W1v3QvbRYSdpbeSHpz9ml-3a30F8VuQEas/edit?usp=sharing
