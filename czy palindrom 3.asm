.data
tekst1: .asciiz "Podaj ciag znaków "
tak: .asciiz "Podany ciag jest palindronem. Czy powtorzyc dzialanie programu? "
nie: .asciiz "Podany ciag nie jest palindronem. Czy powtorzyc dzialanie programu? "

dana: .space 100
dlugosc: .word 0
.text
main:

li $v0 4	#wyswietlam tekst pierwszy
la $a0 tekst1
syscall

li $v0 8	#zaczytuje podane slowo i zapisuje w pamieci
la $a0 dana
li $a1 100
syscall

li $t0 0
li $t1 0
li $t2 0

while:	#licze dlugosc danej
# w t0 index
# w t1 aktualny char
#w t2 dlugosc

lb $t1 dana($t0)

beq $t1 10 policzona	#sprawdzam czy null

addi $t0 $t0 1	#zwiekszam index
addi $t2 $t2 1	#zwiekszam dlugosc

j while

policzona:
sw $t2 dlugosc	#zapisuje dlugosc w zmiennej

#zeruje wykorzystane indexy
li $t0 0
li $t1 0
li $t2 0
lw $t4 dlugosc
subi $t4 $t4 1

petla:
# t1 char z poczatku
# t2 index poczatku
# t3 char z konca
# t4 index konca

lb $t1 dana($t2)
lb $t3 dana($t4)

bne $t1 $t3 nieJest

addi $t2 $t2 1
subi $t4 $t4 1

bgt $t2 $t4 jest

j petla


jest:
li $v0 4
la $a0 tak
syscall

li $v0 5	#wczytuje 0/1 czy kontynuowac program
syscall

beq $v0 1 main	# jak 1 to skacze do maina

li $v0 10	#jak nie 1 to koncze program
syscall

nieJest:
li $v0 4
la $a0 nie
syscall

li $v0 5	#wczytuje 0/1 czy kontynuowac program
syscall

beq $v0 1 main	# jak 1 to skacze do maina

li $v0 10	#jak nie 1 to koncze program
syscall


