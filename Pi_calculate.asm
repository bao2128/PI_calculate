#Data segment
	.data
#Cac cau nhac nhap du lieu
	str_in:		.asciiz "Tinh so PI, voi tong so diem ban N = 100000"
	str_newline:	.asciiz "\n"
	str_true:	.asciiz "So diem ban vao trong hinh tron: "
	str_out:	.asciiz "Ket qua: PI = "
	double_x:	.double	0.0	#x_A ban dau = 0
	double_y:	.double	0.0	#y_A ban dau = 0
	double_pi:	.double	0.0	#PI ban dau = 0
	double_r:	.double	1.0	#ban kinh R = 1
	double_value4:	.double	4.0	#hang so = 4

#Code segment
	.text
	.globl	main
main:
	la	$a0, str_in
	addi	$v0, $zero, 4
	syscall
	
	la	$a0, str_newline
	addi	$v0, $zero, 4
	syscall
	
#gan gia tri ban dau

	add	$t1, $zero, $zero	#bien lap i = 0
	addi	$t0, $zero, 100000	#tong so diem N = 100000
	add	$t2, $zero, $zero	#so diem ban trung ban dau = 0
	
	ldc1	$f2, double_x		#x_A
	ldc1	$f4, double_y		#y_A
	ldc1	$f6, double_r		#ban kinh
	ldc1	$f8, double_pi		#so PI
	ldc1	$f10, double_value4	#hang so

#vong lap
for:	li 	$v0, 30 		#khoi tao x_A
	syscall	
	li	$v0, 44
	syscall
	mov.d	$f2, $f0	
	
	li	$v0, 30			#khoi tao y_A
	syscall
	li	$v0, 44
	syscall
	mov.d	$f4, $f0

	#so sanh x^2+y^2<=1, neu dung tang so diem trung len 1, sai thi tiep tuc vong lap
	mul.d	$f2, $f2, $f2		#x=x*x
	mul.d	$f4, $f4, $f4		#y=y*y
	add.d	$f2, $f2, $f4		#x=x*x + y*y
	c.le.d	$f2, $f6		#so sanh x^2+y^2<=1
	bc1t	true			#neu dung, nhay toi dk dung
	j	false			#neu sai, tiep tuc vong lap
	
true:	addi	$t2, $t2, 1		#tang so diem trung len 1
	
false:	addi	$t1, $t1, 1		#i++
	slt	$t3, $t1, $t0		#so sanh i<100000, neu sai (i>=100000) thi dung vong lap
	bne	$t3, $zero, for
	
#Tinh so PI
	#chuyen int sang double
	mtc1.d $t2, $f14
	cvt.d.w	$f14, $f14
	
	mtc1.d	$t0, $f16
	cvt.d.w	$f16, $f16
	
	div.d	$f8, $f14, $f16		#xac suat 1 diem o trong hinh tron = so diem trung/tong so diem
	mul.d	$f8, $f8, $f10		#PI = 4*(xac suat 1 diem o trong hinh tron)
	sdc1	$f8, double_pi		#luu gia tri PI vao bo nho
	
#Xuat ket qua
	la	$a0, str_true
	addi	$v0, $zero, 4
	syscall

	la	$a0, ($t2)
	addi	$v0, $zero, 1
	syscall
	
	la	$a0, str_newline
	addi	$v0, $zero, 4
	syscall
	
	la	$a0, str_out
	addi	$v0, $zero, 4
	syscall
	
	mov.d	$f12, $f8
	addi	$v0, $zero, 3
	syscall
	
	la	$a0, str_newline
	addi	$v0, $zero, 4
	syscall
	
#Ket thuc chuong trinh
	addi	$v0,$zero,10
	syscall
	