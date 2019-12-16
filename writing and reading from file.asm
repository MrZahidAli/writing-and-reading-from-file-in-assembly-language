INCLUDE Irvine32.inc

.data

filename BYTE "newfile.txt",0
fileHandler dword ?
msg1 byte 13 dup(?)
msg byte "Hello World",0
.code

main PROC
	
	mov edx,OFFSET filename
	
	call CreateOutputFile	;	Or OpenInputFile

	mov fileHandler, eax	;	File Handler
	mov edx, offset msg		;	Msg to be read/write
	mov ecx, sizeof msg		;	Size of the Msg
	Call WriteToFile
	mov eax, fileHandler
	Call closefile


	mov edx, offset filename
	call OpenInputFile
	
	mov edx, offset msg1	;to save data from file into msg1
	mov ecx, sizeof msg1	;..
	Call ReadFromFile

	mov edx, offset msg1
	call WriteString




	call readInt
	exit
main ENDP
END main