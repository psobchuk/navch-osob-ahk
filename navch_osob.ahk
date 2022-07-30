#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileEncoding utf-8

#Include .\libraries\files.ahk

; масиви для збереження інформації про отримувача
words := []
symbols := []

insert_into_array(".\words.csv", , , 1, words)
insert_into_array(".\symbols.csv", , , 1, symbols)

; FileName := ".\status.txt"

i := 0
j := 4
k := 304

if WinExist ("ahk_exe winword.exe")
{
	WinActivate ("ahk_exe winword.exe")
}
if WinActive ("ahk_exe winword.exe")
{
	score := 0
	Loop
	{
		; вставляємо слово
		Space::
			FileName := ".\score\" A_DD A_MM A_YYYY ".txt"
			file := FileOpen(FileName, "a")
			Random, rand, i, j
			Random, randsym, 0, 17
			Random, randnum, 1000000, 9999999
			Send, {Tab}
			
			if (score == k)
			{
				i := 0
				j := 9
			}
			else if (score == k * 2)
			{
				i := 0
				j := k
			}
			
			; якщо рахунок більший 250 - вставляти числа
			if (score > k && score <= k * 1.25)
			{
				Send, %	randnum
				Send, {Tab}
			}
			
			; якщо рахунок більший 300 - вставляти слова + символи
			else if (score > k * 1.25)
			{
				Send, %	words[rand] . "" . symbols[randsym]
				Send, {Tab}
			}
			
			; вставляти слова
			else
			{
				Send, %	words[rand]
				Send, {Tab}
			}
			
			score++
			
			if (score < k * 2)
			{
				i++
				j++
			}
			
			file.Write(A_UserName . ": " . score "`r`n")
			file.Close()
			
			break
	}
	!q::
		MsgBox % score
		return
}