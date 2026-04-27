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
       01  WRK-LINHA                        PIC 9(01) VALUE 1.
       01  WRK-TOTVAL                       PIC 9(03) VALUE ZEROS.
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
               05  FILLER                   PIC X(01) VALUE "STATUS".
      *-----------------------------------------------------------------
       PROCEDURE                            DIVISION.
           PERFORM INICIAR.
           PERFORM PROCESSAR UNTIL ARQCRM-FS EQUAL 10.
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
           DISPLAY WRK-CABEC                          LINE WRK-LINHA 
                                                       COLUMN 01.
           ADD 1 TO WRK-LINHA.
           
       PROCESSAR                             SECTION.
           IF ARQCRM-STATUS NOT EQUAL 1
              MOVE ARQCRM-ID TO WRK-ARQCRM-ID
              MOVE ARQCRM-NOME TO WRK-ARQCRM-NOME
              MOVE ARQCRM-TELEFONE TO WRK-ARQCRM-TELEFONE
              MOVE ARQCRM-EMAIL TO WRK-ARQCRM-EMAIL
              MOVE ARQCRM-STATUS TO WRK-ARQCRM-STATUS
              DISPLAY WRK-ARQCRM-REGISTRO            LINE WRK-LINHA 
                                                     COLUMN 01
              ADD 1 TO WRK-LINHA
              ADD 1 TO WRK-TOTVAL
           END-IF.

           READ ARQCRM.
           ADD 1 TO WRK-TOTLIDOS.           

       FINALIZAR                             SECTION.
           ADD 2 TO WRK-LINHA.
           DISPLAY "TOTAL DE REGISTROS VALIDOS: "     LINE WRK-LINHA
                                                      COLUMN 01.
           DISPLAY WRK-TOTVAL                         LINE WRK-LINHA
                                                      COLUMN 29.

           ADD 1 TO WRK-LINHA.
           DISPLAY "TOTAL DE REGISTROS LIDOS: "       LINE WRK-LINHA
                                                      COLUMN 01.
           DISPLAY WRK-TOTVAL                         LINE WRK-LINHA
                                                      COLUMN 27.

           ADD 2 TO WRK-LINHA.
           DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU PRINCIPAL..." 
                                                      LINE WRK-LINHA 
                                                      COLUMN 01.
           ACCEPT WRK-SEGURATELA                      LINE WRK-LINHA 
                                                      COLUMN 51.

           CLOSE ARQCRM.
           