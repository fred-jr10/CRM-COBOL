      *-----------------------------------------------------------------
       IDENTIFICATION                       DIVISION.
       PROGRAM-ID. EXCLUSAO.
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
           DISPLAY "----     EXCLUSAO     ----"       LINE 02 COLUMN 01.
           DISPLAY "--------------------------"       LINE 03 COLUMN 01.
           DISPLAY "ID: "                             LINE 04 COLUMN 01.
              ACCEPT ARQCRM-ID                        LINE 04 COLUMN 15.
           READ ARQCRM.

           EVALUATE ARQCRM-FS
              WHEN 00
                 DISPLAY "NOME: "                     LINE 05 COLUMN 01             
                 DISPLAY ARQCRM-NOME                  LINE 05 COLUMN 15             
                 DISPLAY "TELFONE: "                  LINE 06 COLUMN 01             
                 DISPLAY ARQCRM-TELEFONE              LINE 06 COLUMN 15             
                 DISPLAY "EMAIL: "                    LINE 07 COLUMN 01             
                 DISPLAY ARQCRM-EMAIL                 LINE 07 COLUMN 15             
                 DISPLAY "DESEJA EXCLUIR (S/N)? : "   LINE 09 COLUMN 01
                    ACCEPT WRK-CONFIRMA               LINE 09 COLUMN 25
                    IF WRK-CONFIRMA EQUAL "S"
                    
                       DELETE ARQCRM
                       DISPLAY "REGISTRO DELETADO."   LINE 11 COLUMN 01
                    END-IF
             WHEN 23
                 DISPLAY "ID NAO ENCONTRADO."         LINE 06 COLUMN 01           
             WHEN OTHER
                 DISPLAY "ERRO NA LEITURA: "          LINE 06 COLUMN 01
                 DISPLAY ARQCRM-FS                    LINE 06 COLUMN 17
           END-EVALUATE.

           DISPLAY "APERTE UMA TECLA PARA VOLTAR AO MENU PRINCIPAL..." 
                                                      LINE 13 COLUMN 01.
           ACCEPT WRK-SEGURATELA                      LINE 13 COLUMN 51.

       FINALIZAR                             SECTION.
           CLOSE ARQCRM.
      *     DISPLAY "ARQUIVO FECHADO COM SUCESSO!"    LINE 01 COLUMN 01.

