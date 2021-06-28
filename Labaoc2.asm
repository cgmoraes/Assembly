.data
	mensagem: .asciiz "Insira o texto: "
	mensagem1: .asciiz "N�mero total de caracteres: "
	mensagem2: .asciiz "N�mero total de palavras: "
	mensagem3: .asciiz "Palavras repetidas: "
	palavrasrep: .asciiz "                                                               "
	enter: .asciiz "\n"
	texto: .space 500
.text 
	li $v0, 4 #Imprime a primeira mensagem
	la $a0, mensagem
	syscall

	li $v0, 8 #Faz a leitura do texto inicial
	la $a0, texto
	la $a1, 500
	syscall
		
	move $t0, $a0 
	li $t6, -1 #inicia um ponteiro que indica a ultima posi��o dos caracteres inseridos que possivelmente repetem
	li $t7, -1 #inicia um ponteiro que indica a primeira posi��o dos caracteres inseridos que possivelmente repetem
	
caracteres:
	lb $a0, ($t0) #passa a primeira posi��o do texto

	beq $a0, 10, fimC #analisa se est� no final da string
		
	addi $t1, $t1, 1 #contador de caracteres
	add $t0, $t0, 1 #avan�a uma posi��o na string
	j caracteres
      
fimC:  
	sub $t0, $t0, $t1 #retorna a posi��o inicial do texto
   	
palavras: #conta o n�mero de palavras
  	lb $a0, ($t0)
   	
	beq $a0, 10, fimP
	beq $a0, 0, fimP
	bgt $a0, 64, acrescenta
   	
passo: #parte para a pr�xima posi��o do texto
	add $t0,$t0,1
	j palavras
   	
acrescenta: #soma um ao contador e atualiza os ponteiros
	addi $t2, $t2, 1
	addi $t6, $t6, 1
	addi $t7, $t7, 1
   		
espaco:
	lb $t3, ($t0)
	sb $t3, palavrasrep($t6) #copia a palavra encontrada no texto
	lb $a0, ($t0)
	
	beq $a0, 10, limpa #limpa a variavel com essa palavra encontrada
	beq $a0, 32, repeticao #analisa se a palavra se repete
	
	add $t0, $t0, 1
	add $t6, $t6, 1
	
	j espaco
	
repeticao: #atualiza a posi��o referente �s palavras
	la $t4, ($t0) #obt�m a posi��o seguinte a palavra no texto

retorna:
	la $t3, palavrasrep($t7) #passa a primeira posi��o da palavra presente na vari�vel
	lb $a0, ($t3)
	
repeticao1: #analisa se o caracter presente na variavel e no texto s�o iguais
	lb $t5, ($t4)
	beq $t5, 10, limpa
	beq $t5, 32, repeticao2
	addi $t4, $t4, 1
	j repeticao1
	
repeticao2: #caso os caracteres sejam iguais, analisa se o caracter anterior no texto foi um espa�o
	addi $t4, $t4, 1
	lb $t5, ($t4)
	bne $a0, $t5, repeticao1

analisa: #analisa se os demais caracteres s�o iguais para ent�o poder concluir que s�o as mesmas palavras
	addi $t3, $t3, 1
	addi $t4, $t4, 1
	lb $a0, ($t3)
	lb $t5, ($t4)
	beq $t5, 32, atualiza
	beq $t5, 10, atualiza
	bne $a0, $t5, retorna
	
	j analisa
	
atualiza: #atualiza o ponteiro referente a primeira posi��o da palavra a ser inserida
	move $t7, $t6
	j passo
	
limpa: #obt�m a posi��o do primeiro caracter da palavra na vari�vel a ser removida
	move $s1, $t7
	li $s0, 32

limpa1: #limpa a palavra inserida
	sb $s0, palavrasrep($s1)
	add $s1, $s1, 1
	lb $t3, palavrasrep($s1)
	beq $t3, 32, limpa2
	j limpa1
	
limpa2: #atualiza o ponteiro refenrete a primeira posi��o da palavra inserida
	subi $t7, $t7, 1
	move $t6, $t7
	j passo
   		
fimP:
	li $s0, 10
	sb $s0, palavrasrep($t6) #adiciona um \n no final da vari�vel com as palavras repetidas
	
	#imprime o resultado
	
	li $v0, 4
	la $a0, mensagem1
	syscall
		
	li $v0, 1
	move $a0, $t1
	syscall
		
	li $v0, 4
	la $a0, enter
	syscall
	
	li $v0, 4
	la $a0, mensagem2
	syscall
		
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, enter
	syscall
	
	li $v0, 4
	la $a0, mensagem3
	syscall
	
	la $a0, palavrasrep
	syscall
	
	
