Documentation for super_computer.rb pumpkin (1.3.2)

New in scos pumpkin:

Self-updating! Whenever it detects that it is not running the newest version it automatically updates itself!
This happens in the background whenever you open it. In other words, to check for updates, quit and relaunch!

Also, new CommandClass: system! This can currently give you the time, time zone, and allow you to set the prompt(see below)

New in 1.3.0:

New prompt option: *V. Gives current version.
Also, you can now type 'dir cur' for the current directory if you don't already have that in your prompt.

Commands:

Instead of commands, super_computer has CommandClasses. Currently, there are 3, file, dir, and system.
To make a command, type the name of the CommandClass and then what you want to do.
The list of commands are below next to their unix counterpart or description. All caps signifies a variable of the given type.



super_computer command | unix command
-----------------------------------------
dir sw FOLDERNAME      | cd FOLDERNAME
                       |
dir parent             | cd ..
                       |
dir list               | ls
                       |
dir cur                | pwd
                       |
dir create FOLDERNAME  | mkdir FOLDERNAME
                       |
dir delete FOLDERNAME  | rmdir FOLDERNAME
------------------------------------------
file create FILENAME   | touch FILENAME
                       |
file delete FILENAME   | rm FILENAME
                       |
file read FILENAME     | more FILENAME
                       |
file edit FILENAME     | N/A No unix counterpart
                       |
Once you type 'file edit FILENAME', it puts you into a new prompt that has its own set of rules.
                       |
                       |
file:edit command      | description
-------------------------------------------
append STRING          | adds a new line to the file that contains STRING.
                       |
length STRINGorNUMBER  | If you type 'length all' it gives you the length in lines of the file. If length is followed by 'words', it gives the approximent word count of the file.
                       | 'chars' gives the character count of the file.
                       | If you give a number within the length of the file, it gives you the character count of that line of the file.
                       |
read STRINGorNUMBER    | These two work the same way, if you type 'all' after read or delete, it will read the entire file, or delete the content of the entire file.
delete STRINGorNUMBER  | If a number is given, that line will be printed or deleted.


super_computer command | description
--------------------------------------------
                       |
system date            | returns current date, long form. (i.e. Saturday, November 21, 2020)
system date short      | returns current date, short form using yy/mm/dd. (i.e. 2020/11/21)
                       |
system time            | returns current time: 12hr, with meridean marker. (i.e. 8:00:00 PM)
system time 24h        | returns current time: 24 hr. (i.e. 20:00:00)
system time zone       | returns the number of hours from UTC plus the time zone name.. (i.e. -08:00 PST)
                       |
                       |
system prompt STRING   | This follows the rules of strftime: https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/DateTime.html#method-i-strftime.
                       | Along with that, '*D' will be replaced with the current directory, and '*C' with the count of the number of commands.
                       | '*V' is replaced by the version number.
                       |
system current prompt  | Displays the current prompt before the substitutions.
