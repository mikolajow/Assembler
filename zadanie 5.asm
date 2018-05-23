.data
zapytanie: .asciiz "Czy powtorzyc dzialanie? 0 - nie 1 - tak \n"
podajx: .asciiz "Podaj wspolrzedna X : \n"
podajy: .asciiz "Podaj wspolrzedna Y : \n"


Zpierwsza: .asciiz "Punkt znajduje sie w pierwszej cwiartce \n"
Zdruga: 	  .asciiz "Punkt znajduje sie w drugiej cwiartce \n"
Ztrzecia:  .asciiz "Punkt znajduje sie w trzeciej cwiartce \n"
Zczwarta:  .asciiz "Punkt znajduje sie w czwartej cwiartce \n"
punktWpoczatku: .asciiz "Punkt jest poczatkiem ukladu \n"
punktNaOsiOX: .asciiz "Punkt jest na osi X \n"
punktNaOsiOY: .asciiz "Punkt jest na osi Y \n"

pamiec: .space 100

.text
main:

# w t8 index nastepnego pustego pola
#zapisujemy 1-x 2-y 3-numer cwiartki od jeden do cztery

li $v0 4
la $a0 podajx	#prosze o x
syscall

li $v0 5
syscall		#laduje x do t1
move $t1 $v0
sb $t1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 podajy	#prosze o y
syscall

li $v0 5
syscall		#laduje y do t2
move $t2 $v0
sb $t2 pamiec($t8)
addi $t8 $t8 1

# w t1 mam x w t2 mam y

beq $t2 0 naOX
beq $t1 0 naOY

bgt $t1 0 pierwszaLubCzwarta # jak x > 0 to w pierwszej lub czwartej
b drugaLubTrzecia

naOX:
beq $t1 0 srodek

li $s1 6
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 punktNaOsiOX
syscall
j koniec
srodek:
li $s1 5
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 punktWpoczatku	#wyswietlam ze srodek ukladu
syscall
j koniec
naOY:
li $s1 7
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 punktNaOsiOY
syscall
j koniec

pierwszaLubCzwarta:
bgt $t2 0 pierwsza
j czwarta
drugaLubTrzecia:
bgt $t2 0 druga
j  trzecia

pierwsza:
li $s1 1
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 Zpierwsza
syscall
j koniec
druga:
li $s1 2
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 Zdruga
syscall
j koniec
trzecia:
li $s1 3
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 Ztrzecia
syscall
j koniec
czwarta:
li $s1 4
sb $s1 pamiec($t8)
addi $t8 $t8 1

li $v0 4
la $a0 Zczwarta
syscall
j koniec

koniec:
li $v0 4
la $a0 zapytanie
syscall

li $v0 5
syscall
beq $v0 1 main

wyswietlam:
#Wyswietlam wszystkie punkty
# t6 index aktualny


li $v0 11
addi $a0 $zero 40	#lewy nawias
syscall

lb $s2 pamiec($t6)

li $v0 1
add $a0 $zero $s2
syscall

li $v0 11
addi $a0 $zero 44	#przecinek
syscall

addi $t6 $t6 1

lb $s2 pamiec($t6)

li $v0 1
add $a0 $zero $s2
syscall

li $v0 11
addi $a0 $zero 41	#prawy nawias
syscall

li $v0 11
addi $a0 $zero 9	#tabulator
syscall


addi $t6 $t6 1

lb $s2 pamiec($t6)

beq $s2 1 wyswietlPier
beq $s2 2 wyswietlDrug
beq $s2 3 wyswietlTrze
beq $s2 4 wyswietlCzwa
beq $s2 5 wyswietlPocz
beq $s2 6 wyswietlOX
beq $s2 7 wyswietlOY

banan:

addi $t6 $t6 1
beq $t6 $t8 end
j wyswietlam
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

end:
li $v0 10
syscall



wyswietlPier:
li  $v0 4
la $a0 Zpierwsza
syscall
j banan
wyswietlDrug:
li  $v0 4
la $a0 Zdruga
syscall
j banan
wyswietlTrze:
li  $v0 4
la $a0 Ztrzecia
syscall
j banan
wyswietlCzwa:
li  $v0 4
la $a0 Zczwarta
syscall
j banan
wyswietlPocz:
li  $v0 4
la $a0 punktWpoczatku
syscall
j banan
wyswietlOX:
li  $v0 4
la $a0 punktNaOsiOX
syscall
j banan
wyswietlOY:
li  $v0 4
la $a0 punktNaOsiOY
syscall
j banan






