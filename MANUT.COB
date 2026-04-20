      *-----------------------------------------------------------------
       IDENTIFICATION                       DIVISION.
       PROGRAM-ID. MANUT.
       AUTHOR. ALFREDO DE OLIVEIRA JÚNIOR.
      *-----------------------------------------------------------------
       ENVIRONMENT                          DIVISION.
       INPUT-OUTPUT                         SECTION.
       FILE-CONTROL.
              SELECT ARQCRM ASSIGN TO "../DADOS/ARQCRM.DAT"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS RANDOM
              FILE STATUS IS ARQCRM-FS
              RECORD KEY IS ARQCRM-CHAVE.

      *-----------------------------------------------------------------              
       DATA                                 DIVISION.
       FILE                                 SECTION.
       FD  ARQCRM.
       COPY "#CRM".
       WORKING-STORAGE                      SECTION.
      *------------------VARIÁVEIS DE APOIO-----------------------------
       01  ARQCRM-FS                        PIC 9(02) VALUE ZEROS. 
      *-----------------------------------------------------------------
       PROCEDURE                            DIVISION.
           PERFORM INICIAR.
           PERFORM FINALIZAR.
           GOBACK.

       INICIAR                              SECTION.
           OPEN INPUT ARQCRM.
           DISPLAY "STATUS DE ABERTURA - ARQCRM: " ARQCRM-FS.

           EVALUATE ARQCRM-FS
              WHEN 00
                 DISPLAY "ARQUIVO JÁ EXISTENTE!"      LINE 01 COLUMN 01
              WHEN 35
                 OPEN OUTPUT ARQCRM
                 DISPLAY "ARQUIVO FOI CRIADO!"        LINE 01 COLUMN 01
              WHEN OTHER
                 DISPLAY "ERRO DESCONHECIDO: "        LINE 01 COLUMN 01
                 DISPLAY ARQCRM-FS                    LINE 02 COLUMN 01
                 GOBACK
           END-EVALUATE.

       FINALIZAR                             SECTION.
           CLOSE ARQCRM.
           DISPLAY "ARQUIVO FECHADO COM SUCESSO!"     LINE 01 COLUMN 01.
           
      *     DISPLAY '--------------------------------------'.
      *     DISPLAY 'CPF: ' WRK-CPF.           
      *     DISPLAY '--------------------------------------'.

