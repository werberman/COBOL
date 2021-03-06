      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STUFILE
           ASSIGN TO "C:\SJunk\STUFILE3.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT CONVERTED
           ASSIGN TO "C:\SJunk\CONVERTED-STUFILE3.TXT"
               ORGANIZATION IS INDEXED
               ACCESS IS SEQUENTIAL
               RECORD KEY IS RECORD-FD-KEY.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
       FD  STUFILE.
           01 STUDENT-RECORD.
               05 STUDENT-NUMBER PIC 9(6).
               05 TUITION-OWED PIC 9(4)V99.
               05 STUDENT-NAME PIC X(40).
               05 PROGRAM-OF-STUDY PIC X(5).
               05 COURSE-CODE-1 PIC X(7).
               05 COURSE-AVERAGE-1 PIC 9(3).
               05 COURSE-CODE-2 PIC X(7).
               05 COURSE-AVERAGE-2 PIC 9(3).
               05 COURSE-CODE-3 PIC X(7).
               05 COURSE-AVERAGE-3 PIC 9(3).
               05 COURSE-CODE-4 PIC X(7).
               05 COURSE-AVERAGE-4 PIC 9(3).
               05 COURSE-CODE-5 PIC X(7).
               05 COURSE-AVERAGE-5 PIC 9(3).

       FD  CONVERTED.
           *> RECORD IS VARYING IN SIZE
           *> FROM 15 TO 110.
           01 INDX-STUDENT-RECORD.
               05 RECORD-FD-KEY PIC 9(5).
               05 STUDENT-NUMBER PIC 9(6).
               05 TUITION-OWED PIC 9(4)V99.
               05 STUDENT-NAME PIC X(40).
               05 PROGRAM-OF-STUDY PIC X(5).
               05 COURSE-CODE-1 PIC X(7).
               05 COURSE-AVERAGE-1 PIC 9(3).
               05 COURSE-CODE-2 PIC X(7).
               05 COURSE-AVERAGE-2 PIC 9(3).
               05 COURSE-CODE-3 PIC X(7).
               05 COURSE-AVERAGE-3 PIC 9(3).
               05 COURSE-CODE-4 PIC X(7).
               05 COURSE-AVERAGE-4 PIC 9(3).
               05 COURSE-CODE-5 PIC X(7).
               05 COURSE-AVERAGE-5 PIC 9(3).
      *-----------------------
       WORKING-STORAGE SECTION.
       01 WS-CONTROL-FIELDS.
           05 EOF-FLAG PIC X(1).
           05 IX-CNTR PIC 9(5).

       01 WS-STUDENT-RECORD.
           05 RECORD-WS-KEY PIC 9(5).
           05 WS-STUDENT-NUMBER PIC 9(6).
           05 WS-TUITION-OWED PIC 9(4)V99.
           05 WS-STUDENT-NAME PIC X(40).
           05 WS-PROGRAM-OF-STUDY PIC X(5).
           05 WS-COURSE-CODE-1 PIC X(7).
           05 WS-COURSE-AVERAGE-1 PIC 9(3).
           05 WS-COURSE-CODE-2 PIC X(7).
           05 WS-COURSE-AVERAGE-2 PIC 9(3).
           05 WS-COURSE-CODE-3 PIC X(7).
           05 WS-COURSE-AVERAGE-3 PIC 9(3).
           05 WS-COURSE-CODE-4 PIC X(7).
           05 WS-COURSE-AVERAGE-4 PIC 9(3).
           05 WS-COURSE-CODE-5 PIC X(7).
           05 WS-COURSE-AVERAGE-5 PIC 9(3).
      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
           OPEN INPUT STUFILE.
           OPEN OUTPUT CONVERTED.
           PERFORM UNTIL EOF-FLAG = 'Y'
               READ STUFILE INTO WS-STUDENT-RECORD
                   AT END MOVE 'Y' TO EOF-FLAG
                   NOT AT END
                       MOVE IX-CNTR TO RECORD-WS-KEY
      *> Add 1 to the index value so the key is unique
                       ADD 1 TO IX-CNTR
                       DISPLAY WS-STUDENT-RECORD
                       WRITE INDX-STUDENT-RECORD FROM WS-STUDENT-RECORD
                       INVALID KEY
                           DISPLAY "INVALID KEY"
               END-READ
           END-PERFORM.
           CLOSE STUFILE.
           CLOSE CONVERTED.
      ** add other procedures here
       END PROGRAM YOUR-PROGRAM-NAME.
