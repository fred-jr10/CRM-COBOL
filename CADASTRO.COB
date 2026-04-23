      *-----------------------------------------------------------------
       IDENTIFICATION                       DIVISION.
       PROGRAM-ID. CADASTRO.
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
       COPY "#CRM-WRK".

      *------------------VARIÁVEIS OPERACIONAIS-------------------------
       01  ARQCRM-FS                        PIC 9(02) VALUE ZEROS.
      *------------------VARIÁVEIS DE APOIO-----------------------------
       01  WRK-SEGURATELA                   PIC 9(01) VALUE ZERO.
      
      *-----------------------------------------------------------------
       PROCEDURE                            DIVISION.
           PERFORM INICIAR.
           PERFORM PROCESSAR.
           PERFORM FINALIZAR.           
           GOBACK.

       INICIAR                              SECTION.           
           OPEN I-O ARQCRM.
      *    DISPLAY "STATUS DE ABERTURA - ARQCRM: " ARQCRM-FS.
           IF ARQCRM-FS NOT EQUAL ZEROS
               DISPLAY "ERRO DE ABERTURA"             LINE 01 COLUMN 01
               ACCEPT WRK-SEGURATELA                  LINE 02 COLUMN 01
               GOBACK
           END-IF.
           
       PROCESSAR                             SECTION.
           DISPLAY "--------------------------"       LINE 01 COLUMN 01.
           DISPLAY "----     CADASTRO     ----"       LINE 02 COLUMN 01.
           DISPLAY "--------------------------"       LINE 03 COLUMN 01.
           DISPLAY "ID: "                             LINE 04 COLUMN 01.
              ACCEPT WRK-ARQCRM-ID                    LINE 04 COLUMN 15.
           DISPLAY "NOME: "                           LINE 05 COLUMN 01.
              ACCEPT WRK-ARQCRM-NOME                  LINE 05 COLUMN 15.
           DISPLAY "TELFONE: "                        LINE 06 COLUMN 01.
              ACCEPT WRK-ARQCRM-TELEFONE              LINE 06 COLUMN 15.
           DISPLAY "EMAIL: "                          LINE 07 COLUMN 01.
              ACCEPT WRK-ARQCRM-EMAIL                 LINE 07 COLUMN 15.
           DISPLAY "STATUS: "                         LINE 08 COLUMN 01.
              ACCEPT WRK-ARQCRM-STATUS                LINE 08 COLUMN 15.

           MOVE WRK-ARQCRM-REGISTRO TO ARQCRM-REGISTRO.
           WRITE ARQCRM-REGISTRO.

           EVALUATE ARQCRM-FS
              WHEN 00
                 DISPLAY "REGISTRO GRAVADO."          LINE 10 COLUMN 01
              WHEN 22
                 DISPLAY "RTEGISTRO JAH EXISTE."      LINE 10 COLUMN 01
              WHEN OTHER
                 DISPLAY "ERRO NA GRAVACAO: "         LINE 10 COLUMN 01
                 DISPLAY ARQCRM-FS                    LINE 10 COLUMN 19
           END-EVALUATE.

           DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU PRINCIPAL..." 
                                                      LINE 12 COLUMN 01.
           ACCEPT WRK-SEGURATELA                      LINE 12 COLUMN 51.

       FINALIZAR                             SECTION.
           CLOSE ARQCRM.
           DISPLAY "ARQUIVO FECHADO COM SUCESSO!"     LINE 01 COLUMN 01.

