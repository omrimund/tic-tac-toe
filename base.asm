IDEAL
model small
stack 100h
DATASEG
turnwho db 0
rules   db "Welcome to the Tic Tac Toe game", 13, 10
		db "each player in turn will choose a slot marked with the numbers", 13, 10
		db " 1-9 as you will see shortly",13,10
		db "this is a game for two players ", 13, 10
		db "the winner is the one who makes three in a row ", 13, 10
		db "pay attention, you must not click on the same slot twice  ", 13, 10
		db "you need to duble click the number you choose, just to make sure(: ", 13, 10
		db "when you win you won't know it , only when your opponent try to play,",13,10
		db "then you recive the massege" ,13,10
		db " ,press any key to start" ,13,10,'$'
drewing db 0
output_1 db '1','2','3'
output_2 db '4','5','6'
output_3 db '7','8','9'
youwin   db 'you won!!!!',13,10,'$'
youwin1   db 'press any key to leave',13,10,'$'
noone   db 'drew,press any key to leave',13,10,'$'
the_chosen_one db 0
game_draw   db " | | |", 13, 10
			db "  | | |", 13, 10
			db "  | | |", 13, 10
			db 'pick a number between 1 to 9',13,10,'$'
game_num 	db "|1|2|3|", 13, 10
			db "|4|5|6|", 13, 10
			db "|7|8|9|", 13, 10
			db 'pick a number between 1 to 9',13,10,'$'
check_iffull_2 db 0
check_iffull_1 db 0
check_iffull_3 db 0
check_iffull_4 db 0
check_iffull_5 db 0
check_iffull_6 db 0
check_iffull_7 db 0
check_iffull_8 db 0
check_iffull_9 db 0
CODESEG

proc drew_massege
	mov dx, offset noone
	mov ah,9h
	int 21h
	mov ah,1h
	int 21h
	sub al , 30h
	jmp exit
endp drew_massege
proc finish_game
	mov dx, offset youwin1
	mov ah,9h
	int 21h
	mov ah,1h
	int 21h
	sub al , 30h
	jmp exit
endp finish_game
proc congrats_you_win
	mov dx, offset youwin
	mov ah,9h
	int 21h
	jmp finish_game
endp congrats_you_win
proc check_winner
	mov cx, 3
	mov bx, 0
jmp check_loop
check_loop:
	mov al, [output_1 + bx]
	cmp  al , 'o' 
	jne check_x
	mov al, [output_2 + bx]
	cmp  al , 'o' 
	jne check_x
	mov al, [output_3 + bx]
	cmp  al , 'o' 
	jmp congrats_you_win
check_x:
	mov al, [output_1 + bx]
	cmp  al , 'x'
	jne next_row
	mov al, [output_2 + bx]
	cmp  al , 'x'
	jne next_row
	mov al, [output_3 + bx]
	cmp  al , 'x'
	je congrats_you_win
next_row:
	add bx, 1
	loop check_loop
	jmp check_diagonal
check_diagonal:
	mov al, [output_1 + 0]
	cmp al, [output_2 + 1]
	jne check_diagonal_2
	cmp al, [output_3 + 2]
	jne check_diagonal_2
	jmp congrats_you_win
check_diagonal_2:
mov al, [output_1 + 2]
cmp al, [output_2 + 1]
jne check_rows_1
cmp al, [output_3 + 0]
jne check_rows_1
jmp congrats_you_win
endp check_winner
proc check_rows_1
	mov ch, [output_1]
    mov dh, [output_1 + 1]
    cmp ch, dh
    jne check_rows_2

    mov ch, [output_1 + 2] 
    cmp ch, dh 
    jne check_rows_2
    jmp congrats_you_win
endp check_rows_1
proc check_rows_2
	mov ch, [output_2]
    mov dh, [output_2 + 1]
    cmp ch, dh 
    jne check_rows_3
    mov dh, [output_2 + 2] 
    cmp ch, dh 
    jne check_rows_3
    jmp congrats_you_win
endp check_rows_2
proc check_rows_3
	mov ch, [output_3] 
    mov dh, [output_3 + 1] 
    cmp ch, dh 
    jne check_drew
    mov dh, [output_3 + 2]
    cmp ch, dh 
    jne check_drew
    jmp congrats_you_win
endp check_rows_3
proc check_drew
	cmp [drewing],9
	jne start_game
	jmp drew_massege
endp check_drew
proc start_game
call turn
L3:call printing_number
endp start_game
proc turn
cmp [turnwho] , 0
jg L2
inc turnwho
mov bl ,'x'
jmp L3
L2:dec turnwho
mov bl ,'o'
jmp L3
endp turn
proc print_2
	cmp [check_iffull_2] ,0
	jne jmp_exit2
	inc check_iffull_2
	inc drewing
	mov [game_draw+2] , bl
	mov [output_1 + 1] , bl
	call print_board
endp print_2
proc print_1
	cmp [check_iffull_1] ,0
	jne jmp_exit2
	inc check_iffull_1
	inc drewing
	mov [game_draw] , bl
	mov [output_1] , bl
	call print_board
endp print_1
proc print_8
	cmp [check_iffull_8] ,0
	jne jmp_exit2
	inc check_iffull_8
	inc drewing
	mov [game_draw+20], bl
	mov [output_3 + 1] , bl
	call print_board
endp print_8
proc print_9
	cmp [check_iffull_9] ,0
	jne jmp_exit2
	inc check_iffull_9
	inc drewing
	mov [game_draw+22] , bl
	mov [output_3 + 2] , bl
	call print_board
endp print_9
proc jmp_exit2
	jmp exit
endp jmp_exit2
proc reciving_number
	mov ah,1h
	int 21h
	sub al , 30h
	mov [the_chosen_one] , al
	ret
endp reciving_number
proc printing_number
call reciving_number
cmp [the_chosen_one],2
je print_2
cmp [the_chosen_one],1
je print_1

cmp [the_chosen_one],9
je print_9
cmp [the_chosen_one],8
je print_8

cmp [the_chosen_one],3
je print_3
cmp [the_chosen_one],4
je print_4
cmp [the_chosen_one],5
je print_5
cmp [the_chosen_one],6
je print_6
cmp [the_chosen_one],7
je print_7
jmp exit
endp printing_number

proc print_3
	cmp [check_iffull_3] ,0
	jne jmp_exit
	inc check_iffull_3
	inc drewing
	mov [game_draw+4] , bl
	mov [output_1 + 2] , bl
	call print_board
endp print_3
proc print_4
	cmp [check_iffull_4] ,0
	jne jmp_exit
	inc check_iffull_4
	inc drewing
	mov [game_draw+9] , bl
	mov [output_2] , bl
	call print_board
endp print_4
proc jmp_exit
	jmp exit
endp jmp_exit
proc print_5
	cmp [check_iffull_5] ,0
	jne jmp_exit
	inc check_iffull_5
	inc drewing
	mov [game_draw+11] , bl
	mov [output_2 + 1] , bl
	call print_board
endp print_5
proc print_6
	cmp [check_iffull_6] ,0
	jne jmp_exit
	inc check_iffull_6
	inc drewing
	mov [game_draw+13] , bl
	mov [output_2 + 2] , bl
	call print_board
endp print_6
proc print_7
	cmp [check_iffull_7] ,0
	jne jmp_exit
	inc check_iffull_7
	inc drewing
	mov [game_draw+18] , bl
	mov [output_3] , bl
	call print_board
endp print_7

proc print_board
	mov ah, 9h
	mov dx,offset game_draw
	int 21h
	mov ah, 0h
	int 16h
	call check_winner
endp print_board

start:
mov ax,@data
mov ds,ax
mov ah, 9h
mov dx,offset rules
int 21h
mov ah, 0h
int 16h
mov ah, 9h
mov dx,offset game_num
int 21h
mov ah, 0h
int 16h
call start_game
exit :
 mov ax, 4C00h
 int 21h
end start
