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
      *------------------VARIÁVEIS OPERACIONAIS-------------------------
       01  ARQCRM-FS                        PIC 9(02) VALUE ZEROS.
      *------------------VARIÁVEIS DE APOIO-----------------------------
       01  WRK-SEGURATELA                   PIC 9(01) VALUE ZERO.
      *-------------------LIMPEZA DE TELA-------------------------------
       SCREEN                               SECTION.
       01  TELA.
                05  BLANK SCREEN.
      *-----------------------------------------------------------------
       PROCEDURE                            DIVISION.
           PERFORM INICIAR.
           PERFORM FINALIZAR.           
           GOBACK.

       INICIAR                              SECTION.
           DISPLAY TELA.
           OPEN INPUT ARQCRM.
           DISPLAY "STATUS DE ABERTURA - ARQCRM: " ARQCRM-FS.

           EVALUATE ARQCRM-FS
              WHEN 00
                 DISPLAY "ARQUIVO JAH EXISTENTE!"     LINE 01 COLUMN 01
              WHEN 35
                 OPEN OUTPUT ARQCRM
                 DISPLAY "ARQUIVO FOI CRIADO!"        LINE 01 COLUMN 01
              WHEN OTHER
                 DISPLAY "ERRO DESCONHECIDO: "        LINE 01 COLUMN 01
                 DISPLAY ARQCRM-FS                    LINE 02 COLUMN 01
                 DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU..." 
                                                      LINE 10 COLUMN 51                 
                 GOBACK
           END-EVALUATE.

           DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU PRINCIPAL..." 
                                                      LINE 10 COLUMN 01.
           ACCEPT WRK-SEGURATELA                      LINE 10 COLUMN 51.
             

       FINALIZAR                             SECTION.
           CLOSE ARQCRM.
           DISPLAY "ARQUIVO FECHADO COM SUCESSO!"     LINE 01 COLUMN 01.

