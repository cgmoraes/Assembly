.data 
	valores: .space 60 #Vetor que armazenará os valores de valor unitário, quantidade e valor total
	produto: .space 500 #Variável que armazenará o nome inserido do produto
	produtos: .space 500 #Vetor que armazenará os nomes de todos os produtos
	
	zero: .float 0.0
	
	linha: .asciiz "\n"
	entrada1: .asciiz "Digite o nome do produto: "
	entrada2: .asciiz "Insira o valor unitário deste produto: "
	entrada3: .asciiz "Insira a quantidade desejada deste produto: " 
	entrada4: .asciiz "Deseja comprar algo a mais? Se sim, digite 1. Caso contrário, digite 0. Resposta: "
	saida1: .asciiz "Pedido:\n\n"
	saida2: .asciiz "x "
	saida3: .asciiz "Valor unitário: R$ "
	saida4: .asciiz "Valor total do produto: R$ "
	saida5: .asciiz "Valor total do pedido: R$ "
	
.text
main:
	li $t0, -4 #Iniciando ponteiro do vetor "valores"
	li $t1, -4 #Iniciando ponteiro do vetor "produtos"
	li $s0, -100 #Iniciando indicador de tamanho dos nomes inseridos
	
entrada:
	addi $t0, $t0, 4 #Avança o ponteiro para a próxima posição do vetor
	addi $t1, $t1, 4 #Avança o ponteiro para a próxima posição do vetor
	addi $s0, $s0, 100 #Avança o indicador para o próximo espaço onde será inserido o nome

	li $v0, 4 #Imprime o conteúdo de entrada 1
	la $a0, entrada1
	syscall
	
	li $v0, 8 #Faz a leitura do produto
	la $a0, produto
	add $a0, $a0, $s0 #Passa o indicador com a posição para o registrador a0
	la $a1, 100
	syscall
	
	sw $a0, produtos($t1) #Armazena o nome no vetor "produtos"

	li $v0, 4 #Imprime o conteúdo de entrada 2
	la $a0, entrada2
	syscall
	
	li $v0, 6 #Faz leitura do valor unitário em float
	syscall
	
	swc1 $f0, valores($t0) #Passa o valor para o vetor
	
	addi $t0, $t0, 4 #Avança o ponteiro para a próxima posição do vetor
	
	li $v0, 4 #Imprime o conteúdo de entrada 3
	la $a0, entrada3
	syscall
	
	li $v0, 5 #Faz a leitura da quantidade
	syscall
	
	sw $v0, valores($t0) #Passa a quantidade para o vetor
	
	addi $t0, $t0, 4 #Avança o ponteiro para a próxima posição do vetor
	
	mtc1 $v0, $f1 #Passa o valor inteiro em v0 para f1
	cvt.s.w $f1, $f1 #Faz casting do valor inteiro em f1 para float
	
	mul.s $f0, $f0, $f1 #Faz a multiplicação do valor unitário pela sua quantia
	
	swc1 $f0, valores($t0) #Armazena o resultado no vetor "valores"
	
	bgt $t0, 55, final #Analisa se já foram 5 compras

condicao:
				
	li $v0, 4 #Imprime o conteúdo de entrada 4
	la $a0, entrada4
	syscall
	
	li $v0, 5 #Faz a leitura da resposta
	syscall
	
	beq $v0, 1, entrada #Analisa se o resultado é 1, caso seja, retornará ao começo do looping
	beq $v0, $zero, final #Analisa se o resultado é 0, caso seja, o programa irá para o final
	
	j condicao #Necessário caso o valor inserido seja diferente de 0 ou 1
	
final:
	lwc1 $f1, zero #Necessário para que possa imprimir valores em float
	lwc1 $f2, zero #Iniciando um somador que armazenará o valor total de todos os produtos
	li $t1, -4 #Iniciando ponteiro do vetor "produtos" para que possa ser imprimido o vetor
	li $t2, -4 #Iniciando novamente um ponteiro do vetor "valores" que usará o valor do primeiro ponteiro t0 como parâmetro para finalizar
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	li $v0, 4 #Imprime o conteúdo da saída 1
	la $a0, saida1
	syscall

imprime:
	addi $t2, $t2, 8 #Avança duas posições com o ponteiro de "valores"
	addi $t1, $t1, 4 #Avança uma posição com o ponteiro de "produto"

	lw $a0, valores($t2) #Imprime o valor contido no vetor "valores" na posição de t2
	li $v0, 1
	syscall
	
	li $v0, 4 #Imprime o conteúdo da saída 2
	la $a0, saida2
	syscall
	
	li $v0, 4 #Imprime o nome contido no vetor "produtos" na posição de t1
	lw $a0, produtos($t1)
    syscall
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	subi $t2, $t2, 4 #Retorna uma posição com o ponteiro de "valores"
	
	li $v0, 4 #Imprime o conteúdo da saída 3
	la $a0, saida3
	syscall

	li $v0, 2 #Imprime o valor contido no vetor "valores" na posição de t2
	lwc1 $f0, valores($t2) 
	add.s $f12, $f1, $f0
	syscall
	
	li $v0, 4 #Quebra de linha
	la $a0, linha
	syscall
	
	addi $t2, $t2, 8 #Avança duas posições com o ponteiro de "valores"
	
	li $v0, 4 #Imprime o conteúdo da saída 4
	la $a0, saida4
	syscall
	
	li $v0, 2 #Imprime o valor contido no vetor "valores" na posição de t2
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
	
	bne $t2, $t0, imprime #Condição que analisa se o ponteiro t2 já está no final
	
	li $v0, 4 #Imprime o conteúdo da saída 5
	la $a0, saida5
	syscall
	
	li $v0, 2 #Imprime o conteúdo do somador
	add.s $f12, $f1, $f2
	syscall
