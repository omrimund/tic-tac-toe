IDEAL
model small
stack 100h
DATASEG
turnwho db 0
num_1 db 0
num_2 db 0
num_4 db 0
num_3 db 0
num_5 db 0
num_6 db 0
num_7 db 0
num_8 db 0
num_9 db 0
the_chosen_one db 0
game_draw	db "_|_|_", 13, 10
			db "_|_|_", 13, 10
			db "_|_|_", 13, 10
			db "pick a number between 1 to 9",'$'
game_num 	db "1|2|3", 13, 10
			db "4|5|6", 13, 10
			db "7|8|9", 13, 10
			db 'pick a number between 1 to 9','$'

CODESEG
proc print_1
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_1
proc print_2
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_2
proc print_3
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_3
proc print_4
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_4
proc print_5
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_5
proc print_6
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_6
proc print_7
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_7
proc print_8
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_8
proc print_9
;somehow pick a cetein place to draw
call print ;at the certin point somehow
endp print_9
proc printing number
call reciving_number
cmp [the_chosen_one],1
je print_1
cmp [the_chosen_one],2
je print_2
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
cmp [the_chosen_one],8
je print_8
cmp [the_chosen_one],9
je print_9
proc reciving_number
mov ah,1h
int 21h
sub al , 30h
mov al , the_chosen_one
ret
endp reciving_number
proc turnwho_


endp turnwho_
proc print_board
	mov ah, 9h
	mov dx,offset game_draw
	int 21h
	mov ah, 0h
	int 16h
	ret
endp print_board
proc print
cmp turnwho , 0
jg L2
L1:inc turnwho
mov dl ,'X'
mov ah,2
int 21h
ret
L2:dec turnwho
mov dl ,'O'
mov ah,2
int 21h
ret
endp print
start:
mov ax,@data
mov ds,ax
mov ah, 9h
mov dx,offset game_num
int 21h
mov ah, 0h
int 16h
call reciving_number
exit :
 mov ax, 4C00h
 int 21h
end start
