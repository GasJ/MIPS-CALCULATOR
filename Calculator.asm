.data
############ datas for choosing an option ############
	display: .asciiz "Now, you are in our Calulator,  with the instructions, you can put your equation into our program, and we will give you an answer.\n"
#	instruction: .asciiz "Following the instruction to do right thing, you can exit with the butten cancel."
#	easyOrNot: .asciiz "Do you want to doEasyCalulate an easy equation with only two digits and one operator?"
#	advancedOrNot: .asciiz "Do you want to calculate trigonometric functions?"
	choosepart: .asciiz "\nChoose the calculation you want: \n1. Easy calculation(+, -, *, /)\n2. Trigonometric function calculation\n3. Expression calculation\n4. Convert\n5. Quit\nPlease enter the part number: "
	exit: .asciiz "you are exiting"
########### datas for choosing an option ends #########


############ datas for easy equations ###############
	welcomeeasy: .asciiz "Welcome to EasyCalulator"
	firstvalue: .asciiz "\nEnter the first value: "
	theoperator: .asciiz "Please enter operator(+, -, /, *): "
	secondvalue: .asciiz "\nEnter second value: "
	wronginput: .asciiz "\nInvalid Operator! Please enter valid operator. "
	theresult: .asciiz "Result is: "
	anothereasy: .asciiz "\nDo you want to do easy calculation again?(y, n): "
	wronginput2: .asciiz "\nInvalid input option! Please enter valid option."
	endeasy: .asciiz "\nEasyCalulator Terminated."
############ datas for easy equations ###############

	

############ datas for normal equations ###############
 	nextLine: .asciiz "\n"
 	whiteblock: .asciiz " "
	getFloat: .asciiz "please type a float."
	wrongFloat: .asciiz "the input of float is wrong, please type again."
	getOperator: .asciiz "please type a operator (+ - * / =), you can only type one charactor"
	wrongOpeator: .asciiz "this is not a correct opeator, please type again."
	print_result: .asciiz "The result is: "
	operator: .space 2
	MAX: .word 20 #the max capacity of postfiStack
	postfixStack: .space 256 #array will hold 20 integers
	opeStack: .space 40 #array will hold 20 operator
	calcStack: .space 84 #array will hold 20 integers
	post_overflow: .asciiz "the number stack is overflow"
	post_underflow: .asciiz "the number stack is underflow"
	ope_overflow: .asciiz "the operator stack is overflow"
	ope_underflow: .asciiz "the operator stack is underflow"
	Rover: .asciiz "the calculate stack is overflow"
	Runder: .asciiz "the calculate stack is underflow"
	empty: .asciiz "due to the stack problem, stacks are emptied now, and you can start a new calculation"
	printPostfix: .asciiz "\nyour equation is (in postfix): "
	noItem: .asciiz "there is no item in the postfix stack."
	zero_divide: .asciiz "\nyou cannot divid zero"
	zero: .float 0.0
############ datas for normal equations ###############



############ datas for trigonometric functions ###############
	Welcome: .asciiz "\nWelcom to the trigonometric functions part, please enter the operator number. \n1. Sine \n2. Cosine \n3. Tangent \n4. Back\n"
	showfriendly: .asciiz "Welcom to the trigonometric functions part"
	operatorNum: .asciiz "\nPlease enter the operator number: "
	error: .asciiz "Please enter a validate operator number"
	Sin: .asciiz "Sin("
	Cos: .asciiz "Cos("
	Tan: .asciiz "Tan("
	endbraket: .asciiz ") is: "
	enterAngle: .asciiz "Please enter the radian you want to calculate: "
	anotherTri: .asciiz "\nAnother trigonometric function?(y/n)"
	numberZero: .float 0.0
	One: .float 1.0
	#these are used to calculate sin
	threeFactorial:	.float 6.0
	fiveFactorial:	.float 120.0
	sevenFactorial:	.float 5040.0
	nineFactorial:	.float 362880.
	elevenFactorial:.float 39916800.0
	#these are used to calculate cosine
	twoFactorial:	.float 2.0
	fourFactorial:	.float 24.0
	sixFactorial:	.float 720.0
	eightFactorial:	.float 40320.0
	tenFactorial:	.float 3628800.0
############ datas for trigonometric functions ###############

############ datas for convert ###############
	# texts
	base_in: .asciiz "Please choose your number base that you wish to enter(1~4):\n"
	base: .asciiz " 1: Binary\n 2: Octal\n 3: Hexadecimal\n"
	in_num: .asciiz  "\nPlease enter your number:\n"
	base_out: .asciiz  "Please choose your number type that you wish convert to(1~4):\n"
	invalid: .asciiz "Base invalid.\n"
	showfriend: .asciiz "Welcome to convert part!"
	
	hex_table: .ascii   "0123456789ABCDEF"
	Hexa_result: .ascii    "Hexadecimal value: 0x"
	hex_digits: .asciiz  "XXXXXXXX"
	
	bin_table: .ascii   "01"
	bin_result: .ascii    "Binary value: "
	bin_digits: .asciiz  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	
	oct_table: .ascii   "01234567"
	oct_result: .ascii    "Octal value: "
	oct_digits: .asciiz  "XXXXXXXXXXXXXXX"
	
	inArray:   .space  33
	outArray:  .space  33
	
	doitagain: .asciiz "\nAnother number converter?(y/n)"
	
############ datas for convert ###############
	

.text

	#print a welcome interface for users
	la $a0, display
	li $v0, 4
	syscall


start:




	#choose the option whether they calculate an easy equation, expression or trigonometric function
	la $a0, choosepart
	li $v0, 4
	syscall
	
	#detemine their coose
	li $v0, 5 #read the input number 
	syscall
	beq $v0, 1, Easy #operator number is 1
	beq $v0, 2, Advanced #operator number is 2
	#beq $v0, 3,  #operator number is 3
	beq $v0, 4, converter #operator number is 4
	beq $v0, 5, Exit #operator number is 5



####for normal part
	#postfiStack counter = $s6
	addi $s6, $zero, 0
	addi $t8, $zero, 0
	#opeStack counter = $s7
	addi $s7, $zero, 0
	addi $t9, $zero, 0
##############
#this is the start of Normal part
#############
Normal: #now, they are choosing a normal equation to calculate

	jal inputFloat
	jal inputOperator

	j Normal

##getting input float part starts##
inputFloat:
	addi $sp, $sp, -4
	sw $ra, 4($sp)

	la $a0, getFloat
	li $v0, 52
	syscall

	beq $a1, -2, Exit
	beq $a1, -1, Error_Float_Input
	beq $a1, -3, Error_Float_Input

	jal pushNum
	
	
	la $a0, nextLine
	li $v0, 4
	syscall
	

	lw $ra, 4($sp)#get address to the main normal part
	addi $sp, $sp, 4
	jr $ra

##getting wrong number
Error_Float_Input: #tell the user the input of float is wrong, please type again.
	la $a0, wrongFloat
	li $a1, 0
	li $v0, 55
	syscall
	j inputFloat
##getting input float part ends##


##getting operator part starts##
inputOperator:#getting input operator
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to the main normal part

	la $a0, getOperator
	la $a1, operator
	la $a2, 2
	li $v0, 54
	syscall

	beq $a1, -2, Exit
	beq $a1, -1, Error_Operator_Input
	beq $a1, -3, Error_Operator_Input
	beq $a1, -4, Error_Operator_Input

	jal	is_operator	
	
	lw $ra, 4($sp)#get address to the main normal part
	addi $sp, $sp, 4
	jr $ra
#determine whether the input character is an operator
is_operator:
	la $s1, operator #buffer = $s1
	#li $s6, -1 # counter
	#addi $s6, $s6, 1  # counter ++
	
	# get buffer[counter]
	add $s1, $s1, $0
	lb $t1, 0($s1)
	
	li $s1, '='
	beq $t1, 61, resultPostfix # char is =, to calculate the result


	#determine whether is an opeator
	li $s2, '+'
    li $s3, '-'
    li $s4, '*'
    li $s5, '/'    
	beq $t1, $s2, Isoperator # '+'
	beq $t1, $s3, Isoperator # '-'
	beq $t1, $s4, Isoperator # '*'
	beq $t1, $s5, Isoperator # '/'
	
	li $v0, 4
	syscall
	

	#if not an operator
	j inputOperator #restart the operator type 

Isoperator:
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to inputOperator

	beq $s7, $0, directlyPushOpe #stack2 is empty now

	###
	#Algorithm:
	# + < -(new) < -(old) < * < /(new) < /(old)

	#$t1=x(new one) $a3=y(old one)
	#if the autority of x >= y, push them back to the stack2
	#if the autority of y > x, push y and before y to the stack1, x to the stack2
	
	
	
	#pop an operator(y) from the stack2 to campare with x(new one)
	jal popOpeTostack2


	lw $ra, 4($sp)#reset address to inputOperator
	addi $sp, $sp, 4

	#if x = '/'
	beq $t1, $s5, newDivid # x = '/' the highest one

	#if x = '*'
	beq $t1, $s4, newMul # x = '*' the highest one

	#if x = '-' or '+'
	beq $a3, $s4, releaseY #if y = '*', y > x
	beq $a3, $s5, releaseY #if y = '/', y > x


	#now, x = '-' or '+' and y = '-' or '+' 
	#if x = '-', y = '+', x > y push back
	#if x = '-'(new), y = '-'(old), y > x releaseY
	#if x = '+', y = '-', y > x releaseY
	#if x = '+', y = '+', x = y push back

	#this means that if y = '-', releaseY, else,pushback
	beq $a3, $s3, releaseY

	#if this is not ,push all of x and y back to stack2
	jal pushBack

	lw $ra, 4($sp)#get address to inputOperator
	addi $sp, $sp, 4
	jr $ra #back to inputOperator(then will back to the normal part)

newDivid:
	#x = '/'(new), only when y = '/'(old), y < x, releaseY, and push x
	beq $t1, $a3, releaseY
	#or, pushthem back
	j pushBack

newMul:
	#x = '*', if y = '/', releaseY, and push x
	beq $a3, $s5, releaseY
	#or, pushthem back
	j pushBack

#y>x, push y and before y to the stack1, x to the stack2, link to inputOperator
releaseY:
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to inputOperator

	move $a0, $a3
	jal pushOpe

	#check if there is still operator in stack2
	bgt $s7, $0, releaseHelper

	#now it $s7 = 0, push x to the stack2
	move $a3, $t1
	jal pushOpeTostack2

	#go back

	lw $ra, 4($sp)#get address to inputOperator
	addi $sp, $sp, 4
	jr $ra #back to inputOperator(then will back to the normal part)
releaseHelper:
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to releaseY

	#get next operator from stack2 to a3
	jal popOpeTostack2
	move $a0, $a3
	jal pushOpe

	bgt $s7, $0, releaseHelper


	lw $ra, 4($sp)#get address to inputOperator
	addi $sp, $sp, 4
	jr $ra #back to inputOperator(then will back to the normal part)





#push all of x and y back into stack2,this link is to the procedure, Isoperator
pushBack:
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to inputOperator

	jal pushOpeTostack2

	move $a3, $t1
	jal pushOpeTostack2

	lw $ra, 4($sp)#get address to inputOperator
	addi $sp, $sp, 4
	jr $ra #back to inputOperator(then will back to the normal part)

#push x into stack2 without determine y,link to inputOperator
directlyPushOpe:
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to inputOperator

	move $a3, $t1
	jal pushOpeTostack2

	lw $ra, 4($sp)#get address to inputOperator
	addi $sp, $sp, 4
	jr $ra 

##getting wrong operator
Error_Operator_Input:
	la $a0, wrongOpeator
	li $a1, 0
	li $v0, 55
	syscall
	j inputOperator

##getting operator part ends##

########## infix to postfix stack part ##########
####
#number stack#
#push nums to post stack
pushNum:
   	lw $t0,MAX #the max value of the stack
   	beq $s6, $t0, post_overflow_Error
   	swc1 $f0, postfixStack($t8)
   	addi $t8, $t8, 4  #go to space for next int
   	addi $s6, $s6, 1 # i++
   	jr $ra
#pop nums to post stack
popNum:
   	addi $t8, $t8, -4
   	beq $s6, $zero, post_underflow_Error
   	lwc1 $f12, postfixStack($t8)
   	addi $s6, $s6, -1 # i--
   	jr $ra
#push opes to post stack
pushOpe:
   	lw $t0,MAX #the max value of the stack
   	beq $s6, $t0, post_overflow_Error
   	sw $a0, postfixStack($t8)#store the operator into the stack
   	addi $t8, $t8, 4  #go to space for next int
   	addi $s6, $s6, 1 # i++
   	jr $ra
#pop opes to post stack
popOpe:
   	addi $t8, $t8, -4
   	beq $s6, $zero, post_underflow_Error
   	lw $a0, postfixStack($t8)#pop the operator into the stack
   	addi $s6, $s6, -1 # i--
   	jr $ra
#postfStack overflow
post_overflow_Error:
   	#Print error
   	li $v0, 4
   	la $a0, post_overflow
   	syscall
   	j empty_stack
#postfStack underflow  		
post_underflow_Error:
   	#Print error
   	li $v0, 4
   	la $a0, post_underflow
   	syscall
   	j empty_stack


####
#operator stack#
#push opes to operator stack
pushOpeTostack2:
   	lw $t0,MAX #the max value of the stack
   	beq $s7, $t0, ope_overflow_Error
   	sw $a3, opeStack($t9)
   	addi $t9, $t9, 4  #go to space for next int
   	addi $s7, $s7, 1 # i++
   	jr $ra
#pop opes to operator stack
popOpeTostack2:
   	addi $t9, $t9, -4
   	beq $s7, $zero, ope_underflow_Error
   	lw $a3, opeStack($t9)
   	addi $s7, $s7, -1 # i--
   	jr $ra
#opeStack overflow
ope_overflow_Error:
   	#Print error
   	li $v0, 4
   	la $a0, ope_overflow
   	syscall
   	j empty_stack
#opeStack underflow  		
ope_underflow_Error:
   	#Print error
   	li $v0, 4
   	la $a0, ope_underflow
   	syscall
   	j empty_stack
#empty stacks
empty_stack:
	move $s6, $zero
   	move $t8, $zero
   	move $s7, $zero
   	move $t9, $zero
   	j start

printPostfixStack:
	#this procedure is for testing errors and understand what is happenning.
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to inputOperator
	
   	
	lw $a0, postfixStack($s2)
	jal whetherNum #determine whether this item is number
	
	addi $s1,$s1,1
	addi $s2,$s2,4

	la $a0, whiteblock
	li $v0, 4
	syscall

	#still have item if $s1 < $s6
	blt $s1, $s6, printPostfixStack
	

	#or, go back
	lw $ra, 4($sp)#get address to inputOperator
	addi $sp, $sp, 4
	jr $ra #back to inputOperator(then will back to the normal part)

whetherNum:
	li $s3, '+'
	beq $a0, $s3, notNumber
	li $s3, '-'
	beq $a0, $s3, notNumber
	li $s3, '*'
	beq $a0, $s3, notNumber
	li $s3, '/'
	beq $a0, $s3, notNumber

	sw $a0, -20($fp)
	lwc1 $f12, -20($fp)
	li $v0, 2
	syscall
	jr $ra
notNumber:

	li $v0, 11
	syscall
	jr $ra

#####
########## infix to postfix stack part ends##########


	


##printing result part starts##
resultPostfix:	
	#now, you get a '=', then you need to move all operator in stack1 to stack2
	jal moveOperators

	

	#tell you how many items in stack1 now
	move $a0, $s6
	li $v0, 1
	syscall
	
	la $a0, printPostfix
	li $v0, 4
	syscall
	
	li $s2, 0
	li $s1, 0
	jal printPostfixStack


	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	j calculate_part

	#la $a0, print_result
	#li $v0, 55
	#syscall

	#j empty_stack
	#j start

moveOperators:#emptye the operator stack (stack2), then the stack1 will be a complete postfix stack
	addi $sp, $sp, -4
	sw $ra, 4($sp) #store address to resultPostfix

	jal popOpeTostack2
	move $a0, $a3
	jal pushOpe

	#check if there is still operator in stack2
	bgt $s7, $0, moveOperators

	#go back

	lw $ra, 4($sp)#get address to resultPostfix
	addi $sp, $sp, 4
	jr $ra #back to resultPostfix
##printing result part ends##

##calculating result part starts##
calculate_part:	
	beq $s1, $s6, gotResult
	jal readPost

	li $s3, '+'
	beq $a0, $s3, cal
	li $s3, '-'
	beq $a0, $s3, cal
	li $s3, '*'
	beq $a0, $s3, cal
	li $s3, '/'
	beq $a0, $s3, cal

	sw $a0, -20($fp)
	lwc1 $f12, -20($fp)
	jal pushResult

	j calculate_part

cal:
	#get x2
	jal popResult
	mov.s $f4, $f12

	#get x1
	jal popResult
	mov.s $f3, $f12

	jal compute

	jal pushResult
	j calculate_part

compute:
	li $s3, '+'
	beq $a0, $s3, add #x1 + x2
	li $s3, '-'
	beq $a0, $s3, sub #x1 - x2
	li $s3, '*'
	beq $a0, $s3, mul #x1 * x2
	li $s3, '/'
	beq $a0, $s3, div #x1 / x2
	#$f3 = x1, $f4 = x2
	add:	
		add.s $f12, $f3, $f4 
		jr $ra
	
	sub:
   		sub.s $f12, $f3, $f4
   		jr $ra
   
   	mul:
   		mul.s $f12, $f3,$f4
		jr $ra	
	
   	div: 
    	#$f4(x2) = 0, error, because you cannot divide 0
    		lwc1 $f0, zero
   		c.eq.s $f4, $f0
   		bc1t error_divideByZero

		div.s $f12,$f3,$f4
		jr $ra	
	error_divideByZero:
		la $a0, zero_divide
		li $v0, 4
		syscall
		j empty_stack







gotResult:
	jal popResult
	li $v0, 57
	la $a0, print_result
	syscall

	j empty_stack





###
#this is the stack part for calculate:

#read from the postfix stack (stack1)
readPost:
	beq $s1, $s6, nothingToread
	lw $a0, postfixStack($s2)
	addi $s1,$s1,1
	addi $s2,$s2,4
	jr $ra
nothingToread:
	la $a0, noItem
	li $v0, 4
	jr $ra

#push and pop numbers in the calcStack(storing the result)
pushResult:
   	lw $t0,MAX #the max value of the stack
   	beq $s3, $t0, result_overflow
   	swc1 $f12, calcStack($s4)
   	addi $s4, $s4, 4  #go to space for next int
   	addi $s3, $s3, 1 # i++
   	jr $ra
popResult:
   	addi $s4, $s4, -4
   	beq $s3, $zero, result_underflow
   	lwc1 $f12, calcStack($s4)
   	addi $s3, $s3, -1 # i--
   	jr $ra
result_overflow:
	la $a0, Rover
	li $v0, 4
	jr $ra
result_underflow:
	la $a0, Runder
	li $v0, 4
	jr $ra




	





##calculating result part endss##

##############
#this is the start of Advanced part
#############
Advanced: #this is the part to calculate trigonometric functions
	#but we don't have actually
	#la $a0, advancedAlert
	#li $a1, 1
	#li $v0, 55
	#syscall
	

	#now we finished it
	li $v0, 55
	la $a0, showfriendly 
	li $a1, 1
	syscall #printing "Welcome function part"
	
	la $a0, Welcome
	li $v0, 4
	syscall

chooseoperator:
	la $a0 operatorNum
	li $v0, 4
	syscall
	
	li $v0, 5 #read the operator number 
	syscall
	move $t1, $v0
	beq $t1, 1, ComputeSin #operator number is 1
	beq $t1, 2, ComputeCos #operator number is 2
	beq $t1, 3, ComputeTan #operator number is 3
	beq $t1, 4, Back #operator number is 3
	
	la $a0, error
	li $v0, 4
	syscall #error that wrong operator number 
	j Advanced	
	
	

Back:
	j start
	
	
	

	

# use Taylor series to calculate Sin Cos and Tan
ComputeSin:
#store the sin number in $f4

	la $a0, enterAngle #show the intrduction
	li $v0, 4
	syscall
	
	li $v0, 6 #read a float number from console the float number store in $f0
	syscall
	mov.s $f1, $f0 # move the input floating number x into $f1
	
	
	#l.s $f2, numberZero
	mul.s $f2, $f1, $f1 # $f2 = x^2
	mul.s $f2, $f2, $f1 # $f2 = x^3 store x^3 in $f2
	
	# now $f2 = x^3, $f1 = x
	
	l.s $f11, threeFactorial # use $f11 to store the factorial number we need
	div.s $f3, $f2, $f11 # now $f3 = x^3/3!
	sub.s $f4, $f1, $f3 # $f4 = x - x^3/3!
	
	# now $f1 = x, $f2 = x^3, $f3 = x^3/3!, $f4 = x - x^3/3!
	
	mul.s $f5, $f2, $f1
	mul.s $f5, $f5, $f1 # make $f5 = x^5
	
	l.s $f11, fiveFactorial # use $f11 to store the factorial number we need
	div.s $f6, $f5, $f11 # now $f6 = x^5/5!
	add.s $f4, $f4, $f6 # now $f4 = x - x^3/3! + x^5/5!
	
	mul.s $f5, $f5, $f1 # now $f5 = x^6
	mul.s $f5, $f5, $f1 # now $f5 = x^7
	
	l.s $f11, sevenFactorial # use $f11 to store the factorial number we need
	div.s $f7, $f5, $f11 # now $f7 = x^7/7!
	sub.s $f4, $f4, $f7 # now $f4= x - x^3/3! + x^5/5! - x^7/7!
	
	mul.s $f5, $f5, $f1 # now $f5 = x^8
	mul.s $f5, $f5, $f1 # now $f5 = x^9
	
	l.s $f11, nineFactorial # use $f11 to store the factorial number we need
	div.s $f8, $f5, $f11 # now $f8 = x^9/9!
	add.s $f4, $f4, $f8 # now $f4= x - x^3/3! + x^5/5! - x^7/7! + x^9/9!
	
	mul.s $f5, $f5, $f1 # now $f5 = x^10
	mul.s $f5, $f5, $f1 # now $f5 = x^11
	
	l.s $f11, elevenFactorial # use $f11 to store the factorial number we need
	div.s $f9, $f5, $f11 # now $f9 = x^11/11!
	sub.s $f4, $f4, $f9 # now $f4= x - x^3/3! + x^5/5! - x^7/7! + x^9/9! - x^11/11!
	
	#mul.s $f5, $f5, $f1 # now $f5 = x^12
	#mul.s $f5, $f5, $f1 # now $f5 = x^13
	
	#l.s $f11, thirteenFactorial # use $f11 to store the factorial number we need
	#div.s $f10, $f5, $f11 # now $f10 = x^13/13!
	#add.s $f4, $f4, $f11 # now $f4= x - x^3/3! + x^5/5! - x^7/7! + x^9/9! - x^11/11! + x^13/13!
	
	

	
	
	
	la $a0, Sin 
	li $v0, 4
	syscall
	
	mov.s $f12, $f1
	li $v0, 2 
	syscall
	
	la $a0, endbraket
	li $v0, 4
	syscall
	
	mov.s $f12, $f4
	li $v0, 2
	syscall
	
	j doAnotherfunction
	
	
ComputeCos:
# store the cos number in $f6
	la $a0, enterAngle #show the intrduction
	li $v0, 4
	syscall
	
	li $v0, 6 #read a float number from console the float number store in $f0
	syscall
	mov.s $f1, $f0 # move the input floating number x into $f1
	l.s $f14, One
	
	mul.s $f2, $f1, $f1 # $f2 = x^2
	l.s $f11 , twoFactorial # use $f11 to store the factorial number we need
	div.s $f3, $f2, $f11 # $f3 = x^2/2!
	sub.s $f6, $f14, $f3 # $f6 = 1 - x^2/2!
	
	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^4
	l.s $f11 , fourFactorial # use $f11 to store the factorial number we need
	div.s $f4, $f2, $f11 # $f4 = x^4/4!
	add.s $f6, $f6, $f4 # $f6 = 1 - x^2/2! + x^4/4!
	
	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^6
	l.s $f11 , sixFactorial # use $f11 to store the factorial number we need
	div.s $f5, $f2, $f11 # $f5 = x^6/6!
	sub.s $f6, $f6, $f5 # $f6 = 1 - x^2/2! + x^4/4! - x^6/6!

	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^8
	l.s $f11 , eightFactorial # use $f11 to store the factorial number we need	
	div.s $f7, $f2, $f11 #f7 = x^8/8!
	add.s $f6, $f6, $f7 # $f6 = 1 - x^2/2! + x^4/4! - x^6/6! + x^8/8!
	
	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^10
	l.s $f11 , tenFactorial # use $f11 to store the factorial number we need
	div.s $f8, $f2, $f11 #f7 = x^10/10!
	sub.s $f6, $f6, $f8 # $f6 = 1 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10!
	
	la $a0, Cos 
	li $v0, 4
	syscall
	
	mov.s $f12, $f1
	li $v0, 2 
	syscall
	
	la $a0, endbraket
	li $v0, 4
	syscall
	
	mov.s $f12, $f6
	li $v0, 2
	syscall
	j doAnotherfunction
	
		
ComputeTan:
	la $a0, enterAngle #show the intrduction
	li $v0, 4
	syscall
	
	li $v0, 6 #read a float number from console the float number store in $f0
	syscall
	mov.s $f1, $f0 # move the input floating number x into $f1
#first compute the sin:
	#l.s $f2, numberZero
	mul.s $f2, $f1, $f1 # $f2 = x^2
	mul.s $f2, $f2, $f1 # $f2 = x^3 store x^3 in $f2
	
	# now $f2 = x^3, $f1 = x
	
	l.s $f11, threeFactorial # use $f11 to store the factorial number we need
	div.s $f3, $f2, $f11 # now $f3 = x^3/3!
	sub.s $f4, $f1, $f3 # $f4 = x - x^3/3!
	
	# now $f1 = x, $f2 = x^3, $f3 = x^3/3!, $f4 = x - x^3/3!
	
	mul.s $f5, $f2, $f1
	mul.s $f5, $f5, $f1 # make $f5 = x^5
	
	l.s $f11, fiveFactorial # use $f11 to store the factorial number we need
	div.s $f6, $f5, $f11 # now $f6 = x^5/5!
	add.s $f4, $f4, $f6 # now $f4 = x - x^3/3! + x^5/5!
	
	mul.s $f5, $f5, $f1 # now $f5 = x^6
	mul.s $f5, $f5, $f1 # now $f5 = x^7
	
	l.s $f11, sevenFactorial # use $f11 to store the factorial number we need
	div.s $f7, $f5, $f11 # now $f7 = x^7/7!
	sub.s $f4, $f4, $f7 # now $f4= x - x^3/3! + x^5/5! - x^7/7!
	
	mul.s $f5, $f5, $f1 # now $f5 = x^8
	mul.s $f5, $f5, $f1 # now $f5 = x^9
	
	l.s $f11, nineFactorial # use $f11 to store the factorial number we need
	div.s $f8, $f5, $f11 # now $f8 = x^9/9!
	add.s $f4, $f4, $f8 # now $f4= x - x^3/3! + x^5/5! - x^7/7! + x^9/9!
	
	mul.s $f5, $f5, $f1 # now $f5 = x^10
	mul.s $f5, $f5, $f1 # now $f5 = x^11
	
	l.s $f11, elevenFactorial # use $f11 to store the factorial number we need
	div.s $f9, $f5, $f11 # now $f9 = x^11/11!
	sub.s $f4, $f4, $f9 # now $f4= x - x^3/3! + x^5/5! - x^7/7! + x^9/9! - x^11/11!


#then compute the cos:
	l.s $f14, One
	
	mul.s $f2, $f1, $f1 # $f2 = x^2
	l.s $f11 , twoFactorial # use $f11 to store the factorial number we need
	div.s $f3, $f2, $f11 # $f3 = x^2/2!
	sub.s $f6, $f14, $f3 # $f6 = 1 - x^2/2!
	
	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^4
	l.s $f11 , fourFactorial # use $f11 to store the factorial number we need
	div.s $f9, $f2, $f11 # $f9 = x^4/4!
	add.s $f6, $f6, $f9 # $f6 = 1 - x^2/2! + x^4/4!
	
	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^6
	l.s $f11 , sixFactorial # use $f11 to store the factorial number we need
	div.s $f5, $f2, $f11 # $f5 = x^6/6!
	sub.s $f6, $f6, $f5 # $f6 = 1 - x^2/2! + x^4/4! - x^6/6!

	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^8
	l.s $f11 , eightFactorial # use $f11 to store the factorial number we need	
	div.s $f7, $f2, $f11 #f7 = x^8/8!
	add.s $f6, $f6, $f7 # $f6 = 1 - x^2/2! + x^4/4! - x^6/6! + x^8/8!
	
	mul.s $f2, $f2, $f1
	mul.s $f2, $f2, $f1 # $f2 = x^10
	l.s $f11 , tenFactorial # use $f11 to store the factorial number we need
	div.s $f8, $f2, $f11 #f7 = x^10/10!
	sub.s $f6, $f6, $f8 # $f6 = 1 - x^2/2! + x^4/4! - x^6/6! + x^8/8! - x^10/10!
	
	div.s $f13, $f4, $f6 # tan = sin / cos
	
	la $a0, Tan 
	li $v0, 4
	syscall
	
	mov.s $f12, $f1
	li $v0, 2 
	syscall
	
	la $a0, endbraket
	li $v0, 4
	syscall
	
	mov.s $f12, $f13
	li $v0, 2
	syscall
	j doAnotherfunction
	
doAnotherfunction:
	la $a0, anotherTri
	li $v0, 4
	syscall
	
	li $v0, 12
	syscall
	beq $v0, 0x79, Advanced
	beq $v0, 0x6e, start


##############
#this is the end of Advanced part
#############



##############
#this is the start of tools part -- some tool procedures for both normal and advanced part
#############

###the procedure to exit
Exit:
	#tell the user they are leaving
	la $a0, exit
	li $a1, 1
	li $v0, 55
	syscall

	li $v0, 10 
	syscall # Exit main subroutine.


##############
#this is the start of easy part which is an independent part
#############
Easy: 	
	addi $v0, $0, 55
	la $a0, welcomeeasy 
	li $a1, 1
	syscall #printing "Welcome to doEasyCalulator"

	doEasyCal:

		addi $v0, $0, 4 
		la $a0, firstvalue 
		syscall  
		li $v0, 6 
		syscall

 
 		mov.s $f1, $f0 #reading and storing first value
		li $v0, 4 
		la $a0, theoperator 
		syscall 
		li $v0, 12 
		syscall #reading operator
		add $a1, $v0, $0 #storing operator 

		li $v0, 4 
		la $a0, secondvalue
		syscall 
		addi $v0, $0, 6 
		syscall
		mov.s $f2, $f0 #reading and storing second value
		addi $9, $0, 0x2b
		beq $a1, $9, addIt #checking if +
		addi $9, $0, 0x2d
		beq $a1, $9, subIt #checking if -
		addi $9, $0, 0x2a
		beq $a1, $9, mulIt #checking if *
		addi $9, $0, 0x2f
		beq $a1, $9, divIt #checking if 
		addi $v0, $0, 4 
		la $a0, wronginput 
		syscall #printing str4
		j doEasyCal
	addIt:
		add.s $f12, $f1, $f2 #adding values
		j	printEasyAns
	subIt:
		sub.s $f12, $f1, $f2 #subtracting values
		j	printEasyAns
	mulIt:
		mul.s $f12, $f1, $f2 #multiplying values
		j	printEasyAns
	divIt:
		div.s $f12, $f1, $f2 #dividing values
		j	printEasyAns
	printEasyAns:
		addi $v0, $0, 4 
		la $a0, theresult 
		syscall 
		
		li $v0, 2
		syscall #printing answer
		j anotherdoEasyCal 
	anotherdoEasyCal:
		addi $v0, $0, 4 
		la $a0, anothereasy 
		syscall  
		
		addi $v0, $0, 12 
		syscall #reading command

		add $a1, $v0, $0 #storing command 

		addi $9, $0, 0x79
		beq $a1, $9, doEasyCal #checking if y

		addi $9, $0, 0x6e
		beq $a1, $9, endEasyCal #checking if n

		li $v0, 4 
		la $a0, wronginput2 
		syscall 
		j anotherdoEasyCal

	endEasyCal:
		li $v0, 4 
		la $a0, endeasy 
		syscall 
		j start

##############
#convert
#############	

converter:
	li $v0, 55
	la $a0, showfriend 
	li $a1, 1
	syscall #printing "Welcome function part"
	
	# Print string to get input number
	li    $v0, 4
	la    $a0, in_num
	syscall
	
	# Get input base
	# t0 = input number
	li    $v0, 5
        syscall
        move  $t0, $v0
#	la   $a0, inArray  # load inputBase address to argument0
#       li   $v0, 8                 # read_string syscall code = 8
#       li   $a1, 32                # space allocated for inputBase
#       syscall
        
        # Print string to get output base
	li    $v0, 4
	la    $a0, base_out
	syscall 

	# Print string output base option
	li    $v0, 4
	la    $a0, base
	syscall
	
	# Get output base
	# t1 = output base
	li    $v0, 5
	syscall
	move  $t1, $v0
	
	j convertStart
	
convertStart:
	# convert to Binary
	la    $t9, 1
	beq   $t9, $t1, convertToBinary
	# convert to Octal
	la    $t9, 2
	beq   $t9, $t1, convertToOctal

	# convert to Hexa
	la    $t9, 3
	beq   $t9, $t1, convertToHexa
	
	# is input invalid
	li $v0, 4
	la $a0, invalid
	syscall
	j end
	
convertToBinary:
	li $t1, 31
	binify:	and   $t2,   $t0,   0x01
		srl   $t0,   $t0,   1
		lb    $t3,   bin_table($t2)
		sb    $t3,   bin_digits($t1)
		sub   $t1,   $t1,   1
		bgez  $t1,   binify
		li    $v0,   4
		la    $a0,   bin_result
		syscall
		j end
		
convertToOctal:
	li $t1, 15
	octify:	and   $t2,   $t0,   0x07
		srl   $t0,   $t0,   3
		lb    $t3,   oct_table($t2)
		sb    $t3,   oct_digits($t1)
		sub   $t1,   $t1,   1
		bgez  $t1,   octify
		li    $v0,   4
		la    $a0,   oct_result
		syscall
		j end
		
convertToHexa:
 	li $t1, 7    
	hexify:	and   $t2,   $t0,   0x0f
		srl   $t0,   $t0,   4
		lb    $t3,   hex_table($t2)
		sb    $t3,   hex_digits($t1)
		sub   $t1,   $t1,   1
		bgez  $t1,   hexify
		li    $v0,   4
		la    $a0,   Hexa_result
		syscall
		j end
	
end:
		li    $v0,   4
		la $a0, doitagain
		syscall
		li $v0, 12
		syscall
		beq $v0, 0x79, converter
		beq $v0, 0x6e, start 
	
	
	
	
	
	
	
