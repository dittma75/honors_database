# honors_database
Database for the Rowan University Honors Concentration
This project started as a database for Rowan University's Honors Concentration.
After the project got cut, I augmented the generalization aspects of the
project to make a (hopefully) useful generator for a flexible content-
management system (CMS).  The goal of this project was to make a CMS that
was flexible enough to allow a non-programmer to add their own tables that
"magically" show up in the application when they're done.  The commands were
intended to be very English-like and simple.  For example, one of the rake
tasks is:

add_table table_name regular_attr {name_attr} other_reg_attr ...

This task makes all of the changes to the code and migrations to add a
table named table_name that will be identified by name_attr in menus.
Instructions for using all of the rake tasks are included with the tasks.  To
access the help messages for a rake task, simply run the task with no arguments.

This solution is by no-means tested extensively.  It worked for the simple
tests that I conducted, but I didn't expressly test its limits.  This project
was more-or-less a proof-of-concept to prove that a tool like this could be
made.  I might revisit it if it became more apparently useful, but, for now,
it's just a school project that (hopefully) illustrates my attempt to
generalize a solution in a robust manner.
