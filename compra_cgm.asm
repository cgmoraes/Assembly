.data 
	valores: .space 60 #Vetor que armazenar� os valores de valor unit�rio, quantidade e valor total
	produto: .space 500 #Vari�vel que armazenar� o nome inserido do produto
	produtos: .space 500 #Vetor que armazenar� os nomes de todos os produtos
	
	zero: .float 0.0
	
	linha: .asciiz "\n"
	entrada1: .asciiz "Digite o nome do produto: "
	entrada2: .asciiz "Insira o valor unit�rio deste produto: "
	entrada3: .asciiz "Insira a quantidade desejada deste produto: " 
	entrada4: .asciiz "Deseja comprar algo a mais? Se sim, digite 1. Caso contr�rio, digite 0. Resposta: "
	saida1: .asciiz "Pedido:\n\n"
	saida2: .asciiz "x "
	saida3: .asciiz "Valor unit�rio: R$ "
	saida4: .asciiz "Valor total do produto: R$ "
	saida5: .asciiz "Valor total do pedido: R$ "
	
.text
main:
	li $t0, -4 #Iniciando ponteiro do vetor "valores"
	li $t1, -4 #Iniciando ponteiro do vetor "produtos"
	li $s0, -100 #Iniciando indicador de tamanho dos nomes inseridos
	
entrada:
	addi $t0, $t0, 4 #Avan�a o ponteiro para a pr�xima posi��o do vetor
	addi $t1, $t1, 4 #Avan�a o ponteiro para a pr�xima posi��o do vetor
	addi $s0, $s0, 100 #Avan�a o indicador para o pr�ximo espa�o onde ser� inserido o nome

	li $v0, 4 #Imprime o conte�do de entrada 1
	la $a0, entrada1
	syscall
	
	li $v0, 8 #Faz a leitura do produto
	la $a0, produto
	add $a0, $a0, $s0 #Passa o indicador com a posi��o para o registrador a0
	la $a1, 100
	syscall
	
	sw $a0, produtos($t1) #Armazena o nome no vetor "produtos"

	li $v0, 4 #Imprime o conte�do de entrada 2
	la $a0, entrada2
	syscall
	
	li $v0, 6 #Faz leitura do valor unit�rio em float
	syscall
	
	swc1 $f0, valores($t0) #Passa o valor para o vetor
	
	addi $t0, $t0, 4 #Avan�a o ponteiro para a pr�xima posi��o do vetor
	
	li $v0, 4 #Imprime o conte�do de entrada 3
	la $a0, entrada3
	syscall
	
	li $v0, 5 #Faz a leitura da quantidade
	syscall
	
	sw $v0, valores($t0) #Passa a quantidade para o vetor
	
	addi $t0, $t0, 4 #Avan�a o ponteiro para a pr�xima posi��o do vetor
	
	mtc1 $v0, $f1 #Passa o valor inteiro em v0 para f1
	cvt.s.w $f1, $f1 #Faz casting do valor inteiro em f1 para float
	
	mul.s $f0, $f0, $f1 #Faz a multiplica��o do valor unit�rio pela sua quantia
	
	swc1 $f0, valores($t0) #Armazena o resultado no vetor "valores"
	
	bgt $t0, 55, final #Analisa se j� foram 5 compras

condicao:
				
	li $v0, 4 #Imprime o conte�do de entrada 4
	la $a0, entrada4
	syscall
	
	li $v0, 5 #Faz a leitura da resposta
	syscall
	
	beq $v0, 1, entrada #Analisa se o resultado � 1, caso seja, retornar� ao come�o do looping
	beq $v0, $zero, final #Analisa se o resultado � 0, caso seja, o programa ir� para o final
	
	j condicao #Necess�rio caso o valor inserido seja diferente de 0 ou 1
	
final:
	lwc1 $f1, zero #Necess�rio para que possa imprimir valores em float
	lwc1 $f2, zero #Iniciando um somador que armazenar� o valor total de todos os produtos
	li $t1, -4 #Iniciando ponteiro do vetor "produtos" para que possa ser imprimido o vetor
	li $t2, -4 #Iniciando novamente um ponteiro do vetor "valores" que usar� o valor do primeiro ponteiro t0 como par�metro para finalizar
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	li $v0, 4 #Imprime o conte�do da sa�da 1
	la $a0, saida1
	syscall

imprime:
	addi $t2, $t2, 8 #Avan�a duas posi��es com o ponteiro de "valores"
	addi $t1, $t1, 4 #Avan�a uma posi��o com o ponteiro de "produto"

	lw $a0, valores($t2) #Imprime o valor contido no vetor "valores" na posi��o de t2
	li $v0, 1
	syscall
	
	li $v0, 4 #Imprime o conte�do da sa�da 2
	la $a0, saida2
	syscall
	
	li $v0, 4 #Imprime o nome contido no vetor "produtos" na posi��o de t1
	lw $a0, produtos($t1)
    syscall
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	subi $t2, $t2, 4 #Retorna uma posi��o com o ponteiro de "valores"
	
	li $v0, 4 #Imprime o conte�do da sa�da 3
	la $a0, saida3
	syscall

	li $v0, 2 #Imprime o valor contido no vetor "valores" na posi��o de t2
	lwc1 $f0, valores($t2) 
	add.s $f12, $f1, $f0
	syscall
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	addi $t2, $t2, 8 #Avan�a duas posi��es com o ponteiro de "valores"
	
	li $v0, 4 #Imprime o conte�do da sa�da 4
	la $a0, saida4
	syscall
	
	li $v0, 2 #Imprime o valor contido no vetor "valores" na posi��o de t2
	lwc1 $f0, valores($t2) 
	add.s $f12, $f1, $f0
	syscall
	
	add.s $f2, $f0, $f2 #Adiciona ao somador o valor total de um produto
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	bne $t2, $t0, imprime #Condi��o que analisa se o ponteiro t2 j� est� no final
	
	li $v0, 4 #Imprime o conte�do da sa�da 5
	la $a0, saida5
	syscall
	
	li $v0, 2 #Imprime o conte�do do somador
	add.s $f12, $f1, $f2
	syscall
