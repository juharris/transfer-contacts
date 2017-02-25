/*
; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; AVOID Click SINCE IT WILL BE DIFFICULT TO GET SCRIPTS THAT USE Click
; TO WORK ON OTHER COMPUTERS
; USE Tab, find, etc. INSTEAD

# Win (Windows logo key). In v1.0.48.01+, for Windows Vista and later, hotkeys that include the Windows key (e.g. #a) will wait for the Windows key to be released before sending any text containing an "L" keystroke. This prevents the Send within such a hotkey from locking the PC. This behavior applies to all sending modes except SendPlay (which doesn't need it) and blind mode. 
! Alt 
^ Control 
+ Shift 
& An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey. See below for details. Such hotkeys are ignored (not activated) on Windows 95/98/Me. 
< Use the left key of the pair. e.g. <!a is the same as !a except that only the left Alt key will trigger it. This symbol is ignored on Windows 95/98/ME. 
> Use the right key of the pair. This symbol is ignored on Windows 95/98/ME. 
*/

#SingleInstance force

; /* Use to stop any script */
#a::
Reload
;// Run as administrator.
Run *RunAs %A_WorkingDir%\AutoHotkey.ahk
return

; /* Useful Functions */
copy()
{
	Send {Ctrl Down}c{Ctrl Up}
	ClipWait
}
paste()
{
	Send {Ctrl Down}v{Ctrl Up}
}

editNewFile(filename)
{
	FileDelete %filename%
	Run sublime_text.exe %filename%, , UseErrorLevel
	if (ErrorLevel) {
		Run notepad %filename%
		Sleep 100
		;// Say Yes to creating the file.
		Send y
	}
}

;// Copy Notes.
#q::
notes_dir = %USERPROFILE%\contact_notes
FileCreateDir, %notes_dir%
loop, 2
{
	;// Click on first note.
	;// TODO Don't rely on position on button, use keys instead.
	Click 90, 360
	Sleep 200

	;// Select at most 200 notes.
	Send {Shift Down}{Down 200}{Shift Up}
	Sleep 500
	copy()
	Sleep 500

	;// Save notes a file.
	;// Tried to save text to a file (see below) but it didn't work.
	filename = %notes_dir%\%A_Index%.txt
	editNewFile(filename)
	Sleep 500
	paste()
	Sleep 500
	Send {Ctrl Down}sw{Ctrl Up}
	Sleep 300

	;// Switch back to contact database program.
	Send #8

	/*
	;// Save notes to a file.
	file = FileOpen(filename, "-rwd")
	if !IsObject(file)
	{
		MsgBox Cannot open "%filename%" for writing. %A_LastError%
		return
	}
	file.write(clipboard)
	file.Close()
	*/

	;// Click on next contact.
	Sleep 500
	Click, 141, 69
	Sleep 3000
}
return
