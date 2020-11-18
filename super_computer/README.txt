Documentation for super_computer.rb version 0.6

New in version 0.6:

file:edit length - Allows you to get the length of the file in chars, words, or lines.
It also allows you to get the length in chars of a specific line.

Instead of commands, super_computer has CommandClasses. Currently, there are 2, file, and dir.
List of commands below next to their unix counterpart and description. All caps signifies a variable of the given type.



super_computer command | unix command
-----------------------------------------
dir sw FOLDERNAME      | cd FOLDERNAME
                       |
dir parent             | cd ..
                       |
dir list               | ls
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
Once you type 'file edit FILENAME', it puts you into a new prompt that has it's own set of rules.
                       |
                       |
super_computer command | description
-------------------------------------------
append STRING          | adds a new line to the file that contains STRING.
                       |
length STRINGorNUMBER  | If you type 'length all' it gives you the length in lines of the file. If length is followed by 'words', it gives the approximent word count of the file.
                       | 'chars' gives the character count of the file.
                       | If you give a number within the length of the file, it gives you the character count of that line of the file.
                       |
read STRINGorNUMBER    | These two work the same way, if you type 'all' after read or delete, it will read the entire file, or delete the content of the entire file.
delete STRINGorNUMBER  | If a number is given, that line will be printed or deleted.
