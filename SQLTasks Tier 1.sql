/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 1 of the case study, which means that there'll be more guidance for you about how to 
setup your local SQLite connection in PART 2 of the case study. 

The questions in the case study are exactly the same as with Tier 2. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

SELECT membercost
FROM Facilities
WHERE membercost>0

membercost	
5.0	
5.0	
9.9	
9.9	
3.5	


/* Q2: How many facilities do not charge a fee to members? */

4

/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost>0 AND membercost<.2*(monthlymaintenance)

facid	name	membercost	monthlymaintenance	
0	Tennis Court 1	5.0	200
1	Tennis Court 2	5.0	200
4	Massage Room 1	9.9	3000
5	Massage Room 2	9.9	3000
6	Squash Court	3.5	80


/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

SELECT *
FROM Facilities
WHERE facid IN (1, 5)


facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
5	Massage Room 2	9.9	80.0	4000	3000
1	Tennis Court 2	5.0	25.0	8000	200

/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance, 
CASE  WHEN monthlymaintenance < 100 THEN 'cheap' 
ELSE 'expensive'
END AS maintenancelabel
FROM Facilities;


name	monthlymaintenance	maintenancelabel	
Tennis Court 1	200	expensive	
Tennis Court 2	200	expensive	
Badminton Court	50	cheap	
Table Tennis	10	cheap	
Massage Room 1	3000	expensive	
Massage Room 2	3000	expensive	
Squash Court	80	cheap	
Snooker Table	15	cheap	
Pool Table	15	cheap	


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

SELECT firstname, surname 
FROM Members

firstname	surname	
GUEST	GUEST	
Darren	Smith	
Tracy	Smith	
Tim	Rownam	
Janice	Joplette	
Gerald	Butters	
Burton	Tracy	
Nancy	Dare	
Tim	Boothe	
Ponder	Stibbons	
Charles	Owen	
David	Jones	
Anne	Baker	
Jemima	Farrell	
Jack	Smith	
Florence	Bader	
Timothy	Baker	
David	Pinker	
Matthew	Genting	
Anna	Mackenzie	
Joan	Coplin	
Ramnaresh	Sarwin	
Douglas	Jones	
Henrietta	Rumney	
David	Farrell	
Henry	Worthington-Smyth	
Millicent	Purview	
Hyacinth	Tupperware	
John	Hunt	
Erica	Crumpet	
Darren	Smith	

/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT CONCAT_WS(', ', surname, firstname) AS membername, name
FROM Members AS m
INNER JOIN Bookings AS b
ON m.memid = b.memid
INNER JOIN Facilities AS f
ON b.facid = f.facid
WHERE name = 'TENNIS COURT 1' OR name = 'TENNIS COURT 2'
ORDER BY membername DESC;

membername   	name	
Tracy, Burton	Tennis Court 1	
Tracy, Burton	Tennis Court 2	
Stibbons, Ponder	Tennis Court 1	
Stibbons, Ponder	Tennis Court 2	
Smith, Tracy	Tennis Court 1	
Smith, Tracy	Tennis Court 2	
Smith, Jack	Tennis Court 2	
Smith, Jack	Tennis Court 1	
Smith, Darren	Tennis Court 2	
Sarwin, Ramnaresh	Tennis Court 2	
Sarwin, Ramnaresh	Tennis Court 1	
Rumney, Henrietta	Tennis Court 2	
Rownam, Tim	Tennis Court 2	
Rownam, Tim	Tennis Court 1	
Purview, Millicent	Tennis Court 2	
Pinker, David	Tennis Court 1	
Owen, Charles	Tennis Court 2	
Owen, Charles	Tennis Court 1	
Joplette, Janice	Tennis Court 1	
Joplette, Janice	Tennis Court 2	
Jones, Douglas	Tennis Court 1	
Jones, David	Tennis Court 2	
Jones, David	Tennis Court 1	
Hunt, John	Tennis Court 2	
Hunt, John	Tennis Court 1	
GUEST, GUEST	Tennis Court 1	
GUEST, GUEST	Tennis Court 2	
Genting, Matthew	Tennis Court 1	
Farrell, Jemima	Tennis Court 2	
Farrell, Jemima	Tennis Court 1	
Farrell, David	Tennis Court 1	
Farrell, David	Tennis Court 2	
Dare, Nancy	Tennis Court 1	
Dare, Nancy	Tennis Court 2	
Crumpet, Erica	Tennis Court 1	
Coplin, Joan	Tennis Court 1	
Butters, Gerald	Tennis Court 1	
Butters, Gerald	Tennis Court 2	
Boothe, Tim	Tennis Court 1	
Boothe, Tim	Tennis Court 2	
Baker, Timothy	Tennis Court 2	
Baker, Timothy	Tennis Court 1	
Baker, Anne	Tennis Court 2	
Baker, Anne	Tennis Court 1	
Bader, Florence	Tennis Court 2	
Bader, Florence	Tennis Court 1	

/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT DISTINCT CONCAT_WS(', ', surname, firstname) AS membername, membercost, guestcost, name
FROM Members AS m
INNER JOIN Bookings AS b
ON m.memid = b.memid
INNER JOIN Facilities AS f
ON b.facid = f.facid
WHERE membercost > 30 OR guestcost > 30
ORDER BY membername DESC

membername   	membercost	guestcost	name	
Worthington-Smyth, Henry	9.9	80.0	Massage Room 1	
Tupperware, Hyacinth	9.9	80.0	Massage Room 1	
Tracy, Burton	9.9	80.0	Massage Room 1	
Stibbons, Ponder	9.9	80.0	Massage Room 1	
Smith, Tracy	9.9	80.0	Massage Room 1	
Smith, Jack	9.9	80.0	Massage Room 2	
Smith, Jack	9.9	80.0	Massage Room 1	
Smith, Darren	9.9	80.0	Massage Room 1	
Sarwin, Ramnaresh	9.9	80.0	Massage Room 2	
Sarwin, Ramnaresh	9.9	80.0	Massage Room 1	
Rownam, Tim	9.9	80.0	Massage Room 1	
Rownam, Tim	9.9	80.0	Massage Room 2	
Pinker, David	9.9	80.0	Massage Room 1	
Owen, Charles	9.9	80.0	Massage Room 2	
Owen, Charles	9.9	80.0	Massage Room 1	
Mackenzie, Anna	9.9	80.0	Massage Room 1	
Joplette, Janice	9.9	80.0	Massage Room 2	
Joplette, Janice	9.9	80.0	Massage Room 1	
Jones, David	9.9	80.0	Massage Room 1	
Jones, David	9.9	80.0	Massage Room 2	
Hunt, John	9.9	80.0	Massage Room 1	
GUEST, GUEST	9.9	80.0	Massage Room 1	
GUEST, GUEST	9.9	80.0	Massage Room 2	
Genting, Matthew	9.9	80.0	Massage Room 1	
Genting, Matthew	9.9	80.0	Massage Room 2	
Farrell, Jemima	9.9	80.0	Massage Room 1	
Dare, Nancy	9.9	80.0	Massage Room 1	
Dare, Nancy	9.9	80.0	Massage Room 2	
Crumpet, Erica	9.9	80.0	Massage Room 1	
Coplin, Joan	9.9	80.0	Massage Room 1	
Coplin, Joan	9.9	80.0	Massage Room 2	
Butters, Gerald	9.9	80.0	Massage Room 1	
Butters, Gerald	9.9	80.0	Massage Room 2	
Boothe, Tim	9.9	80.0	Massage Room 1	
Baker, Timothy	9.9	80.0	Massage Room 1	
Baker, Anne	9.9	80.0	Massage Room 2	
Baker, Anne	9.9	80.0	Massage Room 1	
Bader, Florence	9.9	80.0	Massage Room 2	

/* Q9: This time, produce the same result as in Q8, but using a subquery. */




/* PART 2: SQLite
/* We now want you to jump over to a local instance of the database on your machine. 

Copy and paste the LocalSQLConnection.py script into an empty Jupyter notebook, and run it. 

Make sure that the SQLFiles folder containing thes files is in your working directory, and
that you haven't changed the name of the .db file from 'sqlite\db\pythonsqlite'.

You should see the output from the initial query 'SELECT * FROM FACILITIES'.

Complete the remaining tasks in the Jupyter interface. If you struggle, feel free to go back
to the PHPMyAdmin interface as and when you need to. 

You'll need to paste your query into value of the 'query1' variable and run the code block again to get an output.
 
QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */



/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */


/* Q12: Find the facilities with their usage by member, but not guests */


/* Q13: Find the facilities usage by month, but not guests */

