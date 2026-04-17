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
      *--------------VARIÁVEIS ESTRUTURADAS-----------------------------
            
      *-----------------------------------------------------------------
       PROCEDURE                            DIVISION.
           
      *     DISPLAY '--------------------------------------'.
      *     DISPLAY 'CPF: ' WRK-CPF.           
      *     DISPLAY '--------------------------------------'.
           STOP RUN.