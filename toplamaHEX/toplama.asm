;
	LIST 	P=16F877A
	INCLUDE	"P16F877A.INC"
	CBLOCK	H'20' ;ba�lanacak bellek alan� belirlendi 
	SAY1,SAY2 ;sabitler
	ENDC ;sabitler blo�unun sonunda kullan�l�r 
	BSF	STATUS,5 ;bank1'e ge� 
	MOVLW	H'07'
	MOVWF	TRISA ;W'yu TRISA'ya ayarla
	CLRF	TRISB ;TRISB ��k�� olarak ayarla
	MOVLW	H'06' ;PORTA'YI DIGITAL 
	MOVWF	ADCON1;I/O OLARAK AYARLA
	BCF	STATUS,5 ;BANK0'A D�N
	CLRF	PORTB ;portb temizle
TEST1
	BTFSC	PORTA,1 ;porta'n�n 1.biti 0 ise bir komut atla
	GOTO	TEST2
	BTFSS	PORTA,1 ;porta'n�n 1.biti 1 ise bir komut atla
	GOTO	$-1
	MOVLW	H'BD' ; W'ya ta��
	MOVWF	PORTB ;W'yu PORTB'YE TA�I
	MOVWF	SAY1
 
TEST2
	BTFSC	PORTA,2 
	GOTO	TEST0
	BTFSS	PORTA,2
	GOTO	$-1 ;�nceki talimata geri d�nmek anlam�na gelir 
	MOVLW	H'21'
	MOVWF	PORTB
	MOVWF	SAY2
	
	MOVF	SAY1,W ;say�1 ak�mulat�re y�kle
	ADDWF	SAY2,F ;say�2 ile ak�m�lat�r� topla
TEST0 ; test1-2 ile ayn� mant�kta cal�s�r
	BTFSC	PORTA,0
	GOTO	TEST1
	BTFSS	PORTA,0
	GOTO	$-1
	MOVF	SAY2,W
	MOVWF	PORTB
	GOTO	TEST1
	END