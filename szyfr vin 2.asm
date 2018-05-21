.data
pustePole: .asciiz "	"
tekst1: .asciiz "Szyfrowanie 0 deszyfrowanie 1 "
tekst2: .asciiz "Podaj Klucz "
tekst3: .asciiz "Podaj tekst "
tPustyKlucz: .asciiz "Klucz nie moze byc pusty "

klucz: .space 100
slowo: .space 100

.text
main:
li $v0 4	#wyswietlanm pytanie o rodzaj operacji
la $a0 tekst1
syscall

li $v0 5	#zaczytaj rodzaj operacji
syscall
add $t0 $v0 $zero	## w t0 trzymamy rodzaj operacji

li $v0 4	#wyswietlanm pytanie o klucz
la $a0 tekst2
syscall

li $v0 8	#zaczytaj klucz i zapisz
la $a0 klucz
li $a1 100
syscall

li $v0 4	#wyswietlanm pytanie o slowo
la $a0 tekst3
syscall

li $v0 8	#zaczytaj slowo i zapisz
la $a0 slowo
li $a1 100
syscall

lb $t1 klucz
beq $t1 10 pustyKlucz

addi $t5 $t5 26	#rejestr do dzielenia, nie ma dzielenia na wartosciach, tylko na rejestrach

beq $t0 0 szyfrowanie
beq $t0 1 deszyfrowanie

szyfrowanie:

lb $t1 klucz($s0)	#laduje do t1 litere klucza
lb $t2 slowo($t3)	#laduje do t2 litere slowa

beq $t2 10 exit	#jak nul to koniec, skoczyly sie znaki
beq $t1 10 zerujIndexKluczaSzyfrowanie	#jak skonczy sie klucz to zerujemy index

addi $t3 $t3 1	#zwiekszam adres/index
addi $s0 $s0 1 	#zwiekszam index klucza

subi $t1 $t1 97
subi $t2 $t2 97

add $t4 $t1 $t2	#sumuje znaki

div $t4 $t5	#dziele

mfhi $t6	#biore modulo

addi $t6 $t6 97	#dodaje 97 - ustawiam na alfabet

li $v0 11	#wyswietlam pojedyncza litere
add $a0 $zero $t6
syscall

j szyfrowanie	#zapetlam do nulla

deszyfrowanie:

lb $t1 klucz($s0)	#laduje do t1 litere klucza
lb $t2 slowo($t3)	#laduje do t2 litere slowa

beq $t2 10 exit	#jak nul to koniec, skoczyly sie znaki
beq $t1 10 zerujIndexKluczaDeszyfrowanie	#jak skonczy sie klucz to zerujemy index

addi $t3 $t3 1	#zwiekszam adres/index
addi $s0 $s0 1 	#zwiekszam index klucza

addi $t1 $t1 -97
addi $t2 $t2 -97
sub $t1 $t5 $t1	#modyfikuje klucze ze wzoru ( 26 - klucz + 97 )%26
div $t1 $t5
mfhi $t1

add $t4 $t1 $t2	#sumuje znaki

div $t4 $t5	#dziele

mfhi $t6	#biore modulo

addi $t6 $t6 97	#dodaje 97 - ustawiam na alfabet

li $v0 11	#wyswietlam pojedyncza litere
add $a0 $zero $t6
syscall

j deszyfrowanie	#zapetlam do nulla


exit:
li $v0 10
syscall

pustyKlucz:
li $v0 4
la $a0 tPustyKlucz
syscall

li $v0 4	#wyswietlanm nowa linie
la $a0 pustePole
syscall

j main

zerujIndexKluczaSzyfrowanie:
add $s0 $zero $zero
j szyfrowanie

zerujIndexKluczaDeszyfrowanie:
add $s0 $zero $zero
j deszyfrowanie






