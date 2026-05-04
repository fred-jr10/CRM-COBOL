      *-----------------------------------------------------------------
       IDENTIFICATION                       DIVISION.
       PROGRAM-ID. RELATMENU.
       AUTHOR. ALFREDO DE OLIVEIRA JÚNIOR.
      *-----------------------------------------------------------------
       ENVIRONMENT                          DIVISION.
       CONFIGURATION                        SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *-----------------------------------------------------------------              
       DATA                                 DIVISION.
       WORKING-STORAGE                      SECTION.
      *--------------VARIÁVEIS DE TRABALHO------------------------------
       01  WRK-OPCAO                        PIC 9(01) VALUE ZERO.
      *-------------------LIMPEZA DE TELA------------------------------- 
       SCREEN                               SECTION.
       01  TELA.
                05  BLANK SCREEN.      
      *-----------------------------------------------------------------
       PROCEDURE                            DIVISION.           
           PERFORM PROCESSAR UNTIL WRK-OPCAO EQUAL 3.           
           GOBACK.

           PROCESSAR                        SECTION.
           DISPLAY TELA.

           DISPLAY "------------------------" LINE 01 COLUMN 01.
           DISPLAY "---- - RELATORIOS ------" LINE 02 COLUMN 01.
           DISPLAY "------------------------" LINE 03 COLUMN 01.           
 
           DISPLAY "1 - ATIVOS              " LINE 04 COLUMN 01.
           DISPLAY "2 - INATIVOS            " LINE 05 COLUMN 01.
           DISPLAY "3 - VOLTAR AO MENU      " LINE 06 COLUMN 01.
           
           DISPLAY "OPCAO:                  " LINE 08 COLUMN 01.
              ACCEPT WRK-OPCAO                LINE 08 COLUMN 15.

           DISPLAY TELA.

           CALL "RELAT" USING WRK-OPCAO.
           