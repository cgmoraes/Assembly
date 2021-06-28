.data
	entradah: .asciiz "Entre com as horas: "
	entradam: .asciiz "Entre com os minutos: "
	entradas: .asciiz "Entre com os segundos: "
	
	erroh: .asciiz "Valor inválido para as horas. Esperado número entre 0 e 23.\n"
	errom: .asciiz "Valor inválido para os minutos. Esperado número entre 0 e 59.\n"
	erros: .asciiz "Valor inválido para os segundos. Esperado número entre 0 e 59.\n"
	
	caractere: .asciiz ":"
	
	saida: .asciiz "Horário digitado: "

.text
	whileh:
		li $v0, 4 #necessário para imprimir string
		la $a0, entradah #atribui a a0 o valor de entradah
		syscall #imprime entradah
	
		li $v0, 5 #necessário para leitura de inteiro
		syscall #faz a leitura do valor informado
		
		blt $v0, $zero, condicaoh #analisa se o valor inserido é menor que 0
		bgt $v0, 23, condicaoh #analisa se o valor inserido é maior que 23
		j finalh #caso nehuma das duas condições seja verdadeira o loop é encerrado
		
		condicaoh:
			li $v0, 4 #necessário para imprimir string
			la $a0, erroh #atribui a a0 o valor de erroh
			syscall #imprime a mensagem de erro
			
			j whileh #retorna ao começo do loop
	finalh:
		move $t0, $v0 #atribui à t0 o valor de v0
	
	whilem:
		li $v0, 4 #necessário para imprimir string
		la $a0, entradam #atribui a a0 o valor de entradam
		syscall #imprime entradam
	
		li $v0, 5 #necessário para leitura de inteiro
		syscall #faz a leitura do valor informado
		
		blt $v0, $zero, condicaom #analisa se o valor inserido é menor que 0
		bgt $v0, 59, condicaom #analisa se o valor inserido é maior que 59
		j finalm #caso nehuma das duas condições seja verdadeira o loop é encerrado
		
		condicaom:
			li $v0, 4 #necessário para imprimir string
			la $a0, errom #atribui a a0 o valor de errom
			syscall #imprime a mensagem de erro
			
			j whilem #retorna ao começo do loop
	finalm:
		move $t1, $v0 #atribui à t1 o valor de v0
	
	whiles:
		li $v0, 4 #necessário para imprimir string
		la $a0, entradas #atribui a a0 o valor de entradas
		syscall #imprime entradas
	
		li $v0, 5 #necessário para leitura de inteiro
		syscall #faz a leitura do valor informado
		
		blt $v0, $zero, condicaos #analisa se o valor inserido é menor que 0
		bgt $v0, 59, condicaos #analisa se o valor inserido é maior que 59
		j finals #caso nehuma das duas condições seja verdadeira o loop é encerrado
		
		condicaos:
			li $v0, 4 #necessário para imprimir string
			la $a0, erros #atribui a a0 o valor de erros
			syscall #imprime a mensagem de erro
			
			j whiles #retorna ao começo do loop
	finals:
		move $t2, $v0 #atribui à t2 o valor de v0
	
	li $v0, 4 #necessário para imprimir string
	la $a0, saida #atribui a a0 o valor de saida
	syscall #imprime saida
	
	bgt $t0, 9, imprimeh #analisa se o número é maior do que 10
	li $v0,1 #necessário para imprimir valor inteiro
	move $a0, $zero #atribui a a0 o valor de 0
	syscall #imprime 0
	
	imprimeh:
		li $v0, 1 #necessário para imprimir valor inteiro
		move $a0, $t0 #atribui a a0 o valor de t0
		syscall #imprime t0
	
	li $v0, 4 #necessário para imprimir string
	la $a0, caractere #atribui a a0 o valor de caractere
	syscall #imprime caractere
	
	bgt $t1, 9, imprimem #analisa se o número é maior do que 10
	li $v0,1 #necessário para imprimir valor inteiro
	move $a0, $zero #atribui a a0 o valor de 0
	syscall #imprime 0
	
	imprimem:
		li $v0, 1 #necessário para imprimir valor inteiro
		move $a0, $t1 #atribui a a0 o valor de t1
		syscall #imprime t1
	
	li $v0, 4 #necessário para imprimir string
	la $a0, caractere #atribui a a0 o valor de caractere
	syscall #imprime caractere
	
	bgt $t1, 9, imprimes #analisa se o número é maior do que 10
	li $v0,1 #necessário para imprimir valor inteiro
	move $a0, $zero #atribui a a0 o valor de 0
	syscall #imprime 0
	
	imprimes:	
		li $v0, 1 #necessário para imprimir valor inteiro
		move $a0, $t2 #atribui a a0 o valor de t2
		syscall #imprime t2
	
