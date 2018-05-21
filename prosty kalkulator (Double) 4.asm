.data
label1: .asciiz "Wprowadz pierwsza wartosc \n"
label2:	.asciiz "Wprowadz numer operacji: 0 add, 1 sub, 2 dev, 3 mult \n"
label3: .asciiz "Wprowadz druga wartosc \n"
label4: .asciiz "Czy powtorzyc dzialanie programu 0 nie, 1 tak \n"
label5: .asciiz "Bledna wartosc \n"
label6: .asciiz "Wynikiem jest \n"
label7: .asciiz "\n"

.text
main:

li $v0 4	#prosze o pierwsza dana
la $a0 label1
syscall

li $v0 7	#wczytuje pierwsz¹ wartoœæ i umieszczam w f2 f3
syscall
mov.d $f2 $f0

li $v0 4	#prosze o numer operacji
la $a0 label2
syscall

li $v0 5	#wczytuje numer operacji i  umieszczam w t1
syscall
move $t1 $v0

li $v0 4
la $a0 label3	#prosze o druga dana 
syscall

li $v0 7	#wczytuje druga dana i umieszczam w f4 f5
syscall
mov.d $f4 $f0

#sprawdzam numer operacji i skacze do odpowiedniego labela

beq $t1 0 dodawanie
beq $t1 1 odejmowanie
beq $t1 2 dzielenie
beq $t1 3 mnozenie
j blad

wynik:
li $v0 4
la $a0 label6	#wyswietlam wynik
syscall

li $v0 3
mov.d $f12 $f4
syscall

li $v0 4
la $a0 label7
syscall

li $v0 4	#zapytanie o powtorzenie operacji
la $a0 label4
syscall

li $v0 5	#sprawdzenie danej z zapytania i
syscall		#skok do mainna gdy 
beq $v0 1 main

#koniec programu
li $v0 10
syscall


dodawanie:
add.d $f4 $f4 $f2
j wynik

odejmowanie:
sub.d $f4 $f2 $f4
j wynik

dzielenie:
c.eq.d $f4 $f30
bc1t blad
div.d $f4 $f2 $f4
j wynik

mnozenie:
mul.d $f4 $f4 $f2
j wynik

blad:
li $v0 4
la $a0 label5
syscall
j main



