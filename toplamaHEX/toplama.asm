;
	LIST 	P=16F877A
	INCLUDE	"P16F877A.INC"
	CBLOCK	H'20' ;baþlanacak bellek alaný belirlendi 
	SAY1,SAY2 ;sabitler
	ENDC ;sabitler bloðunun sonunda kullanýlýr 
	BSF	STATUS,5 ;bank1'e geç 
	MOVLW	H'07'
	MOVWF	TRISA ;W'yu TRISA'ya ayarla
	CLRF	TRISB ;TRISB çýkýþ olarak ayarla
	MOVLW	H'06' ;PORTA'YI DIGITAL 
	MOVWF	ADCON1;I/O OLARAK AYARLA
	BCF	STATUS,5 ;BANK0'A DÖN
	CLRF	PORTB ;portb temizle
TEST1
	BTFSC	PORTA,1 ;porta'nýn 1.biti 0 ise bir komut atla
	GOTO	TEST2
	BTFSS	PORTA,1 ;porta'nýn 1.biti 1 ise bir komut atla
	GOTO	$-1
	MOVLW	H'BD' ; W'ya taþý
	MOVWF	PORTB ;W'yu PORTB'YE TAÞI
	MOVWF	SAY1
 
TEST2
	BTFSC	PORTA,2 
	GOTO	TEST0
	BTFSS	PORTA,2
	GOTO	$-1 ;önceki talimata geri dönmek anlamýna gelir 
	MOVLW	H'21'
	MOVWF	PORTB
	MOVWF	SAY2
	
	MOVF	SAY1,W ;sayý1 akümulatöre yükle
	ADDWF	SAY2,F ;sayý2 ile akümülatörü topla
TEST0 ; test1-2 ile ayný mantýkta calýsýr
	BTFSC	PORTA,0
	GOTO	TEST1
	BTFSS	PORTA,0
	GOTO	$-1
	MOVF	SAY2,W
	MOVWF	PORTB
	GOTO	TEST1
	END