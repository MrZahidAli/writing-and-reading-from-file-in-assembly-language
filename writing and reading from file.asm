INCLUDE Irvine32.inc

.data

filename BYTE "newfile.txt",0
fileHandler dword ?
msg1 byte 13 dup(?)
msg byte "Hello World",0
.code

main PROC
	
	mov edx,OFFSET filename
	
	call CreateOutputFile	;Or OpenInputFile

	mov fileHandler, eax	;File Handler from eax to fileHandler
	mov edx, offset msg	;Msg to be read/write
	mov ecx, sizeof msg	;Size of the Msg
	Call WriteToFile	;writing to file
	mov eax, fileHandler	;after writing to file moving filehandler to eax again 
	Call closefile		;after moving file handler into eax closing file


	mov edx, offset filename	;mov offset of file name wna read
	call OpenInputFile		;open file
	
	mov edx, offset msg1	;to save data from file into msg1
	mov ecx, sizeof msg1	;size of data wana read
	Call ReadFromFile	;reading from file

	mov edx, offset msg1	;for printing moving offset of msg1
	call WriteString	;printing string values

	call crlf		;new line
	call crlf
	call waitmsg		;wait message
	exit
main ENDP
END main
