# concert-tracker
A simple application for recording concerts attended to a database.

## Project vision
This will be a small command-line program that asks the user to record details about concerts he or she has attended.

Users will be able to add/edit/delete concert entries, as well as get statistics about their concert history.

## Features

### Adding a concert
In order to catalog concerts attended  
I want to add concert data.

### Editing an existing concert
In order to correct mistakes in previously recorded concerts  
I want to edit existing concert entries.

### Deleting a concert
In order to remove incorrect entries or unmemorable concerts  
I want to delete existing concert entries.

### Viewing statistics based on existing concert data
In order to view my concert-going habits and retrieve memories  
I want to view useful information derived from existing concert entries.

## Usage example:
<pre><code>
&gt; ./concert_tracker manage  
1. Add a concert  
2. List all concerts  
3. Exit  
&gt; 1  
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
