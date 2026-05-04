      *-----------------------------------------------------------------
       IDENTIFICATION                       DIVISION.
       PROGRAM-ID. RELAT.
       AUTHOR. ALFREDO DE OLIVEIRA JÚNIOR.
      *-----------------------------------------------------------------
       ENVIRONMENT                          DIVISION.
       INPUT-OUTPUT                         SECTION.
       FILE-CONTROL.
              SELECT ARQCRM ASSIGN TO "../DADOS/ARQCRM.DAT"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS ARQCRM-FS
              RECORD KEY IS ARQCRM-CHAVE.

      *-----------------------------------------------------------------              
       DATA                                 DIVISION.
       FILE                                 SECTION.
       FD  ARQCRM.
       COPY "#CRM".
       WORKING-STORAGE                      SECTION.
       COPY "#CRM-WRK-REL".       
      *------------------VARIÁVEIS OPERACIONAIS-------------------------
       01  ARQCRM-FS                        PIC 9(02) VALUE ZEROS.
      *------------------VARIÁVEIS DE APOIO-----------------------------
       01  WRK-SEGURATELA                   PIC X(01) VALUE ZERO.
      *-----------------VARIÁVEIS ACUMULADORAS-------------------------- 
       01  WRK-LINHA                        PIC 9(03).
       01  WRK-TOTACTV                      PIC 9(03) VALUE ZEROS.
       01  WRK-TOTINACTV                    PIC 9(03) VALUE ZEROS.
       01  WRK-TOTLIDOS                     PIC 9(03) VALUE ZEROS.
      *----------------VARIÁVEIS DE REGISTRO----------------------------
       01  WRK-CABEC.
               05  FILLER                   PIC X(04) VALUE "ID".
               05  FILLER                   PIC X(01).
               05  FILLER                   PIC X(25) VALUE "NOME".
               05  FILLER                   PIC X(01).
               05  FILLER                   PIC X(14) VALUE "TELEFONE".
               05  FILLER                   PIC X(01).
               05  FILLER                   PIC X(30) VALUE "EMAIL".
               05  FILLER                   PIC X(01).
               05  FILLER                   PIC X(02) VALUE "STATUS".
      *-----------------------------------------------------------------       
       LINKAGE                              SECTION.
       01  LNK-OPCAO                        PIC 9(01).
       SCREEN                               SECTION.
       01  TELA.
               05  BLANK SCREEN.      
       PROCEDURE                            DIVISION USING LNK-OPCAO.
           PERFORM INICIAR.
           EVALUATE LNK-OPCAO
              WHEN 1
                 DISPLAY TELA
                 MOVE 1 TO WRK-LINHA
                 MOVE 0 TO WRK-TOTACTV
                 MOVE 0 TO WRK-TOTLIDOS
                 DISPLAY "REGISTROS ATIVOS"    LINE WRK-LINHA COLUMN 01
                 ADD 2 TO WRK-LINHA
                 DISPLAY WRK-CABEC             LINE WRK-LINHA 
                                               COLUMN 01
                 ADD 1 TO WRK-LINHA              
                 PERFORM PROCACTV UNTIL ARQCRM-FS EQUAL 10
              WHEN 2
                 DISPLAY TELA
                 MOVE 1 TO WRK-LINHA
                 MOVE 0 TO WRK-TOTINACTV
                 MOVE 0 TO WRK-TOTLIDOS
                 DISPLAY "REGISTROS INATIVOS"  LINE WRK-LINHA COLUMN 01
                 ADD 2 TO WRK-LINHA
                 DISPLAY WRK-CABEC             LINE WRK-LINHA 
                                               COLUMN 01
                 ADD 1 TO WRK-LINHA                 
                 PERFORM PROCINACTV UNTIL ARQCRM-FS EQUAL 10
           END-EVALUATE.           
           PERFORM FINALIZAR.           
           GOBACK.

       INICIAR                              SECTION.           
           OPEN INPUT ARQCRM.
      
           IF ARQCRM-FS NOT EQUAL ZEROS
               DISPLAY "ERRO DE ABERTURA"             LINE 01 COLUMN 01
               ACCEPT WRK-SEGURATELA                  LINE 02 COLUMN 01
               GOBACK
           END-IF.

           READ ARQCRM.
           
           
       PROCACTV                             SECTION.
           IF ARQCRM-STATUS EQUAL 0
              MOVE ARQCRM-ID TO WRK-ARQCRM-ID
              MOVE ARQCRM-NOME TO WRK-ARQCRM-NOME
              MOVE ARQCRM-TELEFONE TO WRK-ARQCRM-TELEFONE
              MOVE ARQCRM-EMAIL TO WRK-ARQCRM-EMAIL
              MOVE ARQCRM-STATUS TO WRK-ARQCRM-STATUS
              DISPLAY WRK-ARQCRM-REGISTRO            LINE WRK-LINHA 
                                                     COLUMN 01
              ADD 1 TO WRK-LINHA
              ADD 1 TO WRK-TOTACTV
           END-IF.

           READ ARQCRM.
           ADD 1 TO WRK-TOTLIDOS.

       PROCINACTV                            SECTION.
           IF ARQCRM-STATUS EQUAL 1
              MOVE ARQCRM-ID TO WRK-ARQCRM-ID
              MOVE ARQCRM-NOME TO WRK-ARQCRM-NOME
              MOVE ARQCRM-TELEFONE TO WRK-ARQCRM-TELEFONE
              MOVE ARQCRM-EMAIL TO WRK-ARQCRM-EMAIL
              MOVE ARQCRM-STATUS TO WRK-ARQCRM-STATUS
              DISPLAY WRK-ARQCRM-REGISTRO            LINE WRK-LINHA 
                                                     COLUMN 01
              ADD 1 TO WRK-LINHA
              ADD 1 TO WRK-TOTINACTV
           END-IF.

           READ ARQCRM.
           ADD 1 TO WRK-TOTLIDOS.           

       FINALIZAR                             SECTION.
           CLOSE ARQCRM.

           ADD 2 TO WRK-LINHA.

           IF LNK-OPCAO EQUAL 1
              DISPLAY "TOTAL DE REGISTROS ATIVOS: "   LINE WRK-LINHA
                                                      COLUMN 01
              DISPLAY WRK-TOTACTV                     LINE WRK-LINHA 
                                                      COLUMN 29
              ADD 1 TO WRK-LINHA
              DISPLAY "TOTAL DE REGISTROS LIDOS: "    LINE WRK-LINHA
                                                      COLUMN 01
              DISPLAY WRK-TOTLIDOS                    LINE WRK-LINHA
                                                      COLUMN 27
           ELSE IF LNK-OPCAO EQUAL 2
              DISPLAY "TOTAL DE REGISTROS INATIVOS: " LINE WRK-LINHA
                                                      COLUMN 01
              DISPLAY WRK-TOTINACTV                   LINE WRK-LINHA 
                                                      COLUMN 31
              ADD 1 TO WRK-LINHA
              DISPLAY "TOTAL DE REGISTROS LIDOS: "    LINE WRK-LINHA
                                                      COLUMN 01
              DISPLAY WRK-TOTLIDOS                    LINE WRK-LINHA
                                                      COLUMN 27
             
           END-IF.

           

           ADD 2 TO WRK-LINHA.
           DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU PRINCIPAL..." 
                                                      LINE WRK-LINHA 
                                                      COLUMN 01.
           ACCEPT WRK-SEGURATELA                      LINE WRK-LINHA 
                                                      COLUMN 51.

           