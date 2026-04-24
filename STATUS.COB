      *-----------------------------------------------------------------
       IDENTIFICATION                       DIVISION.
       PROGRAM-ID. STATUS.
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
       01  WRK-SEGURATELA                   PIC X(01) VALUE ZERO.
       01  WRK-CONFIRMA                     PIC X(01) VALUE SPACE.
      
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
           DISPLAY "----      STATUS      ----"       LINE 02 COLUMN 01.
           DISPLAY "--------------------------"       LINE 03 COLUMN 01.
           DISPLAY "ID: "                             LINE 04 COLUMN 01.
              ACCEPT WRK-ARQCRM-ID                    LINE 04 COLUMN 15.
              MOVE WRK-ARQCRM-ID TO ARQCRM-ID.
           READ ARQCRM.

           EVALUATE ARQCRM-FS
              WHEN 00
                 DISPLAY "NOME: "                     LINE 05 COLUMN 01             
                 DISPLAY ARQCRM-NOME                  LINE 05 COLUMN 15             
                 DISPLAY "TELFONE: "                  LINE 06 COLUMN 01             
                 DISPLAY ARQCRM-TELEFONE              LINE 06 COLUMN 15             
                 DISPLAY "EMAIL: "                    LINE 07 COLUMN 01             
                 DISPLAY ARQCRM-EMAIL                 LINE 07 COLUMN 15
                 DISPLAY "STATUS: "                   LINE 08 COLUMN 01             
                 DISPLAY ARQCRM-STATUS                LINE 08 COLUMN 15             
                 DISPLAY "DESEJA DESATIVAR (S/N)? : " LINE 10 COLUMN 01
                    ACCEPT WRK-CONFIRMA               LINE 10 COLUMN 26
                    IF WRK-CONFIRMA EQUAL "S"
                       MOVE 1 TO WRK-ARQCRM-STATUS
                       MOVE WRK-ARQCRM-STATUS TO ARQCRM-STATUS        
      *                MOVE WRK-ARQCRM-REGISTRO TO ARQCRM-REGISTRO
                       REWRITE ARQCRM-REGISTRO
                       DISPLAY "REGISTRO DESATIVADO." LINE 15 COLUMN 01
                    END-IF
             WHEN 23
                 DISPLAY "ID NAO ENCONTRADO."         LINE 04 COLUMN 01           
             WHEN OTHER
                 DISPLAY "ERRO NA LEITURA: "          LINE 04 COLUMN 01
                 DISPLAY ARQCRM-FS                    LINE 04 COLUMN 17
           END-EVALUATE.

           DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU PRINCIPAL..." 
                                                      LINE 17 COLUMN 01.
           ACCEPT WRK-SEGURATELA                      LINE 17 COLUMN 51.

       FINALIZAR                             SECTION.
           CLOSE ARQCRM.
      *     DISPLAY "ARQUIVO FECHADO COM SUCESSO!"    LINE 01 COLUMN 01.

