INCLUDE Irvine32.inc

.DATA

filename BYTE "menueItems.txt",0
filename2 BYTE "price.txt", 0
fileHandler dword ?
msg1 dword 13 dup(?)




PRICES   dword 169, 149, 99, 89, 69, 69, 10, 5                   
bill     dword ?                                                 
bool     dword ?                                                  
Start  BYTE "                              "
         BYTE "*************************************",0ah,0dh
		 BYTE "                              "
         BYTE "* !!!  Deans Hotel Food Billing !!! *", 0ah, 0dh 
		 BYTE "                              "
		 BYTE "*************************************",0ah,0dh,0

entering       BYTE " Enter '1':   ", 0ah, 0dh
         BYTE "       For Menu and Billing ", 0ah, 0dh
		 BYTE "                OR  ",0ah, 0dh
	     BYTE " Enter '2':  ", 0ah, 0dh
		 BYTE "       To Exit", 0ah, 0dh,0


options  BYTE "                                                 <***************> ", 0ah, 0dh, 0ah, 0dh
         BYTE " Press <1> -> To show available food items.", 0ah, 0dh
		 BYTE " Press <2> -> For Order.", 0ah, 0dh
		 BYTE " Press <3> -> To Exit.", 0ah, 0dh , 0

		                                                         
Menubar  BYTE "                                                 ", 0ah, 0dh
         BYTE "                         !!!  Our Menu items !!! ", 0ah, 0dh
         BYTE "                                                 ", 0ah, 0dh, 0ah, 0dh
Selection BYTE 5000 dup(?)

saleFileName BYTE "Sales.txt", 0		;;need for other

Quantity   BYTE " Enter the Quantity for that item :  ", 0

caption  BYTE " Invalid Input ", 0
errMsg   BYTE " Please Enter Valid One... ", 0
TotalBill  BYTE "     Total Bill for selected items is:   Rs ", 0
Final  BYTE "   Thanks for coming ", 0ah, 0dh

.CODE

main PROC

	mov edx, offset filename	;mov offset of file name wna read
	call OpenInputFile		;open file
	
	mov edx, offset selection	;to save data from file into msg1
	mov ecx, 1000	;size of data wana read
	Call ReadFromFile	;reading from file



	mov edx, offset filename2	;mov offset of file name wna read
	call OpenInputFile		;open file
	
	mov edx, offset msg1	;to save data from file into msg1
	mov ecx, 5000	;size of data wana read
	Call ReadFromFile	;reading from file












  
	 mov edx, OFFSET Start                                      ; Printing Welcome...
	 call writeString

     op:
	    call crlf

	    mov edx, OFFSET entering                                       ; Printing Id...
		call writeString

		call crlf
		call readInt
		call clrscr

		cmp eax, 1
		je cu

		cmp eax, 2
		je  _exit

		call errorHandling                                                ; calling error Proc...
		jmp  op


		    
		cu:
		   call User
		   jmp op

	 _exit:
		   mov edx, OFFSET Final                                ; Printing Exit Note/Msg...
	       call writeString

	       exit
main ENDP

;-------------------------------------------------------------------
;| For customers only...                                            |
;| Uses: It deals with the customers and take order...              |
;| Note: It only write bill in file with (False) customer name...   |
;-------------------------------------------------------------------

User PROC
          PUSHAD
		  PUSHFD

	      op:                                                     ; Option Tag...  
		     call crlf

			 mov edx, OFFSET options                              ; Printing options...
	         call writeString

			 call crlf
			 call readInt

			 cmp eax, 1
			 je  pm
			 cmp eax, 2
			 je  cm

			 cmp eax, 3
			 je  _exit

			 call errorHandling                                            ; calling error Proc...
			 jmp  op

			 pm:                                                  ; Price Menu Tag...
			    call crlf

		        mov edx, OFFSET Menubar
	            call writeString

				jmp  op

			 cm:                                                  ; Choice Menu Tag...				
				call MenuItems
				jmp op



    _exit:                                                        ; Exit Tag
		  call finalBill
		  mov bill, 0
		  call crlf

		  POPFD
		  POPAD

		  RET
User ENDP

;-------------------------------------------------------------------
;| Print Oriental Menu with Prices for customers to order...        |
;| Updates: Bill ...                                                |
;-------------------------------------------------------------------

MenuItems PROC
			  PUSHAD
			  PUSHFD

			  op:                                                 ; Option Tag...
			     call crlf

		         mov edx, OFFSET Selection
	             call writeString

		         call crlf
		         call readInt

	             cmp eax, 1
		         je  cq
		         cmp eax, 2
		         je  pu
		         cmp eax, 3
		         je  cb
		         cmp eax, 4
		         je  ck 
		         cmp eax, 5
		         je  ct 
				 cmp eax, 6
				 je  mh
				 cmp eax, 7
				 je  na
				 cmp eax, 8
				 je  rt
				 cmp eax, 9
				 je  _exit

		         call errorHandling                                        ; calling error Proc...
		         jmp  op

		         cq:                                              ; Chicken Quorma Tag...
		            mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

  				    mov ebx, [PRICES]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

                 pu:                                              ; Pullao Tag...
	                mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 4]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

                 cb:                                              ; Chicken Briyani Tag...
	                mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 8]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

                 ck:                                              ; Chicken Karahi Tag...
		            mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 12]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

		         ct:                                              ; Chicken Tikka Tag...
	                mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 16]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

			     mh:                                              ; Murgh Haleem Tag...
	                mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 20]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

			     na:                                              ; Naan Tag...
	                mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 24]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

			     rt:                                              ; Roti Tag...
	                mov edx, OFFSET Quantity
	                call writeString

				    call readInt                                  ; Taking input for quantity...

				    mov ebx, [PRICES + 28]
				    mul ebx                                       ; Mul quantity with price...
				    add eax, bill
				    mov bill, eax

		            jmp  op

	    _exit:
			  POPFD
			  POPAD

			  RET
MenuItems ENDP




;-------------------------------------------------------------------
;| Uses: Print the bill for Customers...                            |
;-------------------------------------------------------------------

finalBill PROC
           PUSHAD
		   PUSHFD

		   call crlf

		   mov edx, OFFSET TotalBill
	       call writeString 

		   mov eax, bill
		   call writeInt                                         ; Print the original bill...

		   

		   call crlf

		   call crlf
		   call crlf

		   mov edx, OFFSET Final                                 ; Printing Exit Note/Msg...
	       call writeString

		   POPFD
		   POPAD


	       RET
finalBill ENDP

;-------------------------------------------------------------------
;| Shows an Error Box to customers...                               |
;| Uses:  2 strings for an input   box...                           |
;| Advan: It also works as a pause...                               |
;-------------------------------------------------------------------

errorHandling PROC
       PUSHAD
	   PUSHFD

	   call crlf

       mov ebx, OFFSET caption
	   mov edx, OFFSET errMsg
	   call msgBox

	   POPFD
	   POPAD

	   RET
errorHandling  ENDP

END main
