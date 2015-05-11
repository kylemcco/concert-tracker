# concert-tracker
A simple application for recording concerts attended to a database.

## Project vision
This will be a small command-line program that asks the user to record details about concerts he or she has attended. Users will be able to add/edit/delete concert entries, as well as get statistics about their concert history.

## Features

### Adding a concert
In order to catalog concerts attended I want to add concert data.

Usage example:
<pre><code>
&gt; ./concert_tracker
1. Add a concert  
2. Manage concerts
3. View statistics
4. Exit
&gt; 1  
Answer the following questions about the concert:  
Who was the headlining act?  
&gt; Wilco  
Do you want to add a genre? (y/n)  
&gt; y  
1. Rock  
2. Folk  
3. Jazz  
4. Other (add a genre)  
&gt; 1  
Were there any noteworthy openers? (y/n)  
&gt; y  
List the opening act(s), seperated by commas (KISS,Meatloaf)  
&gt; Nick Lowe  
Do you want to add a genre for Nick Lowe?  
&gt; n  
When was the concert? (mm/dd/yyyy)  
&gt; 10/02/2011  
What was the name of the venue?  
&gt; The Ryman  
Where is the venue located? (city, ST)  
&gt; Nashville, TN  
Rate your experience on a scale of one to ten (1-10)  
&gt; 10  
Cool! You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 10/10. Is that correct? (y/n)  
&gt; y  
Concert saved.  
</pre></code>

Acceptance criteria:  
1. Program prints confirmation that concert was added  
2. Concert is added to the database  
3. After being added, the concert will be visible via "View statistics" once that feature is implemented  
4. After the addition the user is taken back to the main menu  

### Editing an existing concert
In order to correct mistakes in previously recorded concerts I want to edit existing concert entries.

Usage example:
<pre><code>
&gt; ./concert_tracker  
1. Add a concert  
2. Manage concerts  
3. View statistics  
4. Exit  
&gt; 2  
1. List chronologically  
2. List alphabetically  
&gt; 2  
1. Animal Collective  
2. My Morning Jacket  
3. St. Vincent  
4. Wilco  
&gt; 4  
You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 10/10.  
1. Edit headliner  
2. Edit opening act(s)  
3. Edit venue  
4. Edit city/state  
5. Edit rating  
6. Delete concert  
7. Exit  
&gt; 5  
Rate your experience on a scale of one to ten (1-10)  
&gt; 7  
Concert saved.  
You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 6/10.  
1. Edit headliner  
2. Edit opening act(s)  
3. Edit venue  
4. Edit city/state  
5. Edit rating  
6. Exit  
&gt; 6
</pre></code>

Acceptance criteria:  
1. Program prints confirmation that concert was edited  
2. Concert information is edited in the database  
3. After being edited, the new concert data will be visible via "View statistics" once that feature is implemented  
4. After the edit the user is taken back to the main menu  

### Deleting a concert
In order to remove incorrect entries or unmemorable concerts I want to delete existing concert entries.

Usage example:
<pre><code>
&gt; ./concert_tracker  
1. Add a concert  
2. Manage concerts  
3. View statistics  
4. Exit  
&gt; 2  
1. List chronologically  
2. List alphabetically  
&gt; 2  
1. Andrew Bird  
2. My Morning Jacket  
3. St. Vincent  
4. Wilco  
&gt; 4  
You saw Wilco play The Ryman in Nashville, TN on 10/02/2011. Nick Lowe opened. You gave this show a 10/10.  
1. Edit headliner  
2. Edit opening act(s)  
3. Edit venue  
4. Edit city/state  
5. Edit rating  
6. Delete concert  
7. Exit  
&gt; 6  
Are you sure you want to delete this concert? (y/n)  
&gt; y  
Concert deleted.  
</pre></code>

Acceptance criteria:  
1. Program prints confirmation that concert was deleted  
2. Concert information is deleted from the database  
3. After being deleted, the concert data will not be visible via "View statistics" once that feature is implemented  
4. After the deletion the user is taken back to the main menu  

### Viewing statistics based on existing concert data
In order to view my concert-going habits and retrieve memories I want to view useful information derived from existing concert entries.

Usage example:
<pre><code>
&gt; ./concert_tracker  
1. Add a concert  
2. Manage concerts  
3. View statistics  
4. Exit  
&gt; 3  
1. General stats  
2. Artist stats  
3. Venue stats  
4. Year stats  
5. Exit  
&gt; 1  
You have tracked 32 concerts. You've seen Andrew Bird play more than any other artist. Your most visited venue is The Ryman in Nashville, TN.
1. General stats  
2. Artist stats  
3. Venue stats  
4. Year stats  
5. Exit  
&gt; 2  
Select artist:  
1. Andrew Bird  
2. My Morning Jacket  
3. St. Vincent  
4. Wilco  
&gt; 1  
You have seen Andrew Bird 5 times. Based on your concert ratings Andew Bird ranks &#35;2 of all the artists you've seen.
</pre></code>

Acceptance criteria:  
1. Program prints statistics based on database data  
2. After viewing statistics the user is taken back to the main menu  
