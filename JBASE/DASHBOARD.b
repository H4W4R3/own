* @ValidationCode : Mjo0MjY4MTY4MDc6Q3AxMjUyOjE3MDU1NjUzMzQ0MjE6a2hhbGVkLmFkYW06LTE6LTE6MDowOmZhbHNlOk4vQTpERVZfMjAyMDA5LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 18 Jan 2024 10:08:54
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : khaled abdelmoaty
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : DEV_202009.0
* @ValidationInfo : Copyright Temenos Headquarters SA 1993-2021. All rights reserved.
PROGRAM DASHBOARD
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------
 
    $INSERT I_COMMON
    $INSERT I_EQUATE
    $INSERT I_F.TSA.SERVICE
    $INSERT I_F.TSA.STATUS
    $INSERT I_F.BATCH

    
     
    GOSUB INIT

    GOSUB MAIN.DASH





*---------------------------------------------------------------------------------------
INIT:
*****

    SERVICES.ID='TSM':@FM:'COB'
    NO.SERVICES = DCOUNT(SERVICES.ID,@FM)
    
    STOP.REFRESH = @FALSE

    PREVUIS.PAGE=0
    EXIT.ARRAY  = 'EXIT':@VM:'exit':@VM:'Q':@VM:'q':@VM:'STOP':@VM:'stop':@VM:'S':@VM:'s'  ;* User can Type any of these and exit
    
    
    CONTINUE.REFRESH = 'Y'    ;* Default value
    REFRESH.SECS =10         ;* for automatic refresh
    
    SELECT.FLAG = 'SERVICE'

    FN.OFS.SOURCE = 'F.OFS.SOURCE'
    FV.OFS.SOURCE = ''
    CALL OPF(FN.OFS.SOURCE,FV.OFS.SOURCE)
    
    FN.TSA.SERVICE = 'F.TSA.SERVICE'
    F.TSA.SERVICE = ''
    CALL OPF(FN.TSA.SERVICE,F.TSA.SERVICE)

    FN.TSA.STATUS = 'F.TSA.STATUS'
    F.TSA.STATUS = ''
    CALL OPF(FN.TSA.STATUS,F.TSA.STATUS)
    
*For TSA.SERVICE
    TSM.DESCRIPTION     = 0
    TSM.SERVER.NAME     = 0
    TSM.WORK.PROFILE    = 0
    TSM.USER            = 0
    TSM.SERVICE.CONTROL = 0
    TSM.STARTED         = 0
    TSM.STOPPED         = 0
    TSM.ELAPSED         = 0
    TSM.INPUTTER        = 0
    TSM.DATE.TIME       = 0
    TSM.AUTHORISER      = 0
    TSM.CO.CODE         = 0


*For TSA.STATUS

    TSS.SERVER          = 0
    TSS.AGENT.STATUS    = 0
    TSS.LAST.CONTACT    = 0
    TSS.CURRENT.SERVICE = 0
    TSS.LAST.MESSAGE    = 0
    TSS.COMO.NAME       = 0
    TSS.JOB.PROGRESS    = 0
    TSS.T24.SESSION.NO  = 0
    
    OTHER_CMD=0
    RUN.OPTION='STOP'
    
    
    TAFJ.HOM="/T24/TAFJ"
    COMO.PATH="/log_T24/como/"
    COB.COMO=TAFJ.HOM:COMO.PATH
    

RETURN
*-------------------------------------------------------------------------------






*------------------------------------------------------------------------------
MAIN.DASH:
*---------

    LOOP
        CRT @(-1):@(0,0):         ;* This will clear the screen
        CRT FMT('','90-L')
        HEADER = 'DISPLAY STRATING SERVICE  pg.1'
        CRT SPACE(30):HEADER

        CRT FMT('','90-L')
        CRT''
    
        CRT SPACE(3):'[1] COB':SPACE(50-LEN('[1] COB')):'[2] TSM'
        CRT SPACE(3):'[3] BACKUP':SPACE(50-LEN('[3] BACKUP')):'[4] CLEAR [TSA.STATUS]'
        CRT ''
        CRT SPACE(3):'[5] CLEAR  [TSA.STATUS ~ EOD.ERROR ~ EOD.ERROR.DETAIL ~ BATCH.STATUS]'
        CRT ''
        
        CRT SPACE(3):"[6] CLEAR [EOD.ERROR ~ EOD.ERROR.DETAIL]"
        CRT SPACE(3):"[7] CHECK":SPACE(25-LEN('[7] CHECK')):"[8] START SERVICE":SPACE(25-LEN('[8] START SERVICE')):'[9] STOP SERVICE'
        CRT SPACE(3):"[10] GET JOB.LIST OR SERVICE"
        
        CRT''
        
        CRT FMT('','90-L')
        CRT 'SELECT AN OPTION OR PRESS Ss/Qq TO QUIT: '
        
        IF PREVUIS.PAGE NE 0 THEN
            MAIN.DASH_KEY =PREVUIS.PAGE
            
        END ELSE
      
            INPUT MAIN.DASH_KEY
        END
    
    
    WHILE NOT (MAIN.DASH_KEY MATCHES EXIT.ARRAY)         ;* Until user wants to exit
    
        BEGIN CASE
            CASE MAIN.DASH_KEY = 1
                
                
                LAST.INPUT=MAIN.DASH_KEY    ;* PREVUIS.PAGE=LAST.INPUT 1
 
                IF PREVUIS.PAGE EQ 0 THEN
                    GOSUB PREVUIS_PAGE    ;* PREVUIS.PAGE=LAST.INPUT  1
                END
              
        
                GOSUB COB
                
                
            CASE MAIN.DASH_KEY = 2
            
            
                LAST.INPUT=MAIN.DASH_KEY ;* PREVUIS.PAGE=LAST.INPUT 2

                IF PREVUIS.PAGE EQ 0 THEN
                    GOSUB PREVUIS_PAGE       ;* PREVUIS.PAGE=LAST.INPUT 2
                END
            
                GOSUB TSM
                
            CASE MAIN.DASH_KEY = 3
*test
            
            
*EXECUTE "SH -c '  tar -cvf exc.tar  '/T24/AA_ModelBank.jar'  '" CAPTURING JSTAT.OUTPUT
*CRT JSTAT.OUTPUT
*CRT 'DONE '
*CRT 'ZIPPING NOW '
*SLEEP 0.5
                
*EXECUTE "SH -c '  gzip exc.tar   '" CAPTURING JSTAT.OUTPUT
* CRT JSTAT.OUTPUT
* SLEEP 0.5
                
*EXECUTE "SH -c '  mv exc.tar.gz '/T24'  '" CAPTURING JSTAT.OUTPUT

*  CRT JSTAT.OUTPUT
                
*  CRT 'MOVED'
*SLEEP 0.5
*test
                CRT "Under development.."
                SLEEP 1
***********************************************************************
                
            CASE MAIN.DASH_KEY = 4
                
                
 
   
                CRT 'PRESS <Yy Nn> TO CLEAR: '
                INPUT CL
                CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
                IF   (CL MATCHES CL.ARRAY) THEN
                
                
                    EXECUTE "COUNT F.TSA.STATUS" CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    CRT RECRDS
             
                
                    EXECUTE 'CLEAR-FILE F.TSA.STATUS'CAPTURING JSTAT
                
                    CRT '#CLEARED.'
                
  
                    EXECUTE "COUNT F.TSA.STATUS" CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                    SLEEP 1
                END
              
                
      
               
            
       
***********************************************************************
            CASE MAIN.DASH_KEY = 5
            
            
                CRT 'PRESS <Yy Nn> TO CLEAR: '
                INPUT CL
                CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
                IF   (CL MATCHES CL.ARRAY) THEN
                 
            
                    EXECUTE "COUNT F.TSA.STATUS" CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    CRT RECRDS
             
                
                    EXECUTE 'CLEAR-FILE F.TSA.STATUS'CAPTURING JSTAT
                
                    CRT '#CLEARED.'
                
  
                    EXECUTE "COUNT F.TSA.STATUS" CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT JSTAT
                    
                
                    EXECUTE 'COUNT F.EB.EOD.ERROR'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                
                    EXECUTE 'CLEAR-FILE F.EB.EOD.ERROR'CAPTURING JSTAT
        
                    EXECUTE 'COUNT F.EB.EOD.ERROR'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                    CRT '#CLEARED.'
        
        
                    EXECUTE 'COUNT F.EB.EOD.ERROR.DETAIL'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                    CRT '#CLEARED'
                    EXECUTE "CLEAR-FILE F.EB.EOD.ERROR.DETAIL" CAPTURING JSTAT
                    EXECUTE 'COUNT F.EB.EOD.ERROR.DETAIL'CAPTURING JSTAT
         
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                    CRT '#CLEARED.'
                    
                    
                    
                    EXECUTE 'COUNT F.BATCH.STATUS'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                
                    EXECUTE 'CLEAR-FILE F.BATCH.STATUS'CAPTURING JSTAT
        
                    EXECUTE 'COUNT F.BATCH.STATUS'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
       
                
                    CRT '#CLEARED.'
                    SLEEP 1
                END

                
           
*LIST-ITEM F.TSA.STATUS WITH AGENT.STATUS EQ 'RUNNING'

*CLEAR-FILE F.BATCH.STATUS
*CLEAR-FILE F.OS.TOKEN
*CLEAR-FILE F.OS.TOKEN.USE

***********************************************************************


            CASE MAIN.DASH_KEY = 6
                
 
        
    
                CRT 'PRESS <Yy Nn> TO CLEAR: '
                INPUT CL
                CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
                IF   (CL MATCHES CL.ARRAY) THEN
                
                
                
                    EXECUTE 'COUNT F.EB.EOD.ERROR'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                
                    EXECUTE 'CLEAR-FILE F.EB.EOD.ERROR'CAPTURING JSTAT
        
                    EXECUTE 'COUNT F.EB.EOD.ERROR'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                     
                    CRT RECRDS
                    
                    
                    CRT '#CLEARED.'
        
        
                    EXECUTE 'COUNT F.EB.EOD.ERROR.DETAIL'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                    EXECUTE "CLEAR-FILE F.EB.EOD.ERROR.DETAIL" CAPTURING JSTAT
                    EXECUTE 'COUNT F.EB.EOD.ERROR.DETAIL'CAPTURING JSTAT
                    RECRDS = JSTAT[3,LEN(JSTAT)]
                    
                    CRT RECRDS
                    CRT '#CLEARED.'
                    
                    SLEEP 1
                END
            
            
            
            CASE MAIN.DASH_KEY = 7
***********************************************************************[7] CHECK
                GOSUB CHECK
***********************************************************************[7] CHECK
            CASE MAIN.DASH_KEY = 8
***********************************************************************[8] START SERVICE


                CRT 'INPUT SERVICE NAME :'
            
                INPUT X
                IF X THEN
                    CHANGE '/' TO '^' IN X
                    CRT "STARTING.. ":X
                    GOSUB SLEEPING
                
                    GOSUB SLEEPING
                    RUN.OPTION='START'
                    GOSUB SERVICE.RUN

                END



***********************************************************************[8] START SERVICE
            
            CASE MAIN.DASH_KEY = 9
***********************************************************************[9] STOP SERVICE
                CRT 'INPUT SERVICE NAME :'
                INPUT X
                IF X THEN
                
                    CHANGE '/' TO '^' IN X
                    CRT "STOPPING.. ":X
                    GOSUB SLEEPING
                 
                    RUN.OPTION='STOP'
                    GOSUB SERVICE.RUN
                END
 

***********************************************************************[9] STOP SERVICE
                            
            CASE MAIN.DASH_KEY = 10
***********************************************************************[9] STOP SERVICE
     
         
            
                CRT 'INPUT SERVICE.NAME OR JOB.LIST.*: '
                INPUT ORDER
                CRT ''
                  
                IF ORDER NE ''THEN
                    EXECUTE "SELECT F.LOCKING WITH @ID LIKE '...":ORDER:"...'"
                    READLIST ORDER.IDS ELSE  ORDER.IDS= ''
                    OPEN 'F.LOCKING' TO F.LOCKING.TB ELSE CRT 'Unable to open F.LOCKING file' ; OPENDFILE=0
                    IF OPENDFILE NE 0 AND ORDER.IDS  NE '' THEN
                  
                        READ Y.R.LOCKING FROM F.LOCKING.TB, ORDER.IDS THEN
                            CRT 'CURRENT SERV/JOB: ':ORDER.IDS
                            CRT 'CURRENT SERV/JOB: ':Y.R.LOCKING
                        END
                    END
                END
              
                CRT '' ;CRT 'PRESS ANY KEY TO BACK'
            
                INPUT DUMMY

***********************************************************************[9] STOP SERVICE
                

                

                
            CASE @TRUE
                CRT "You came no where"
                


              
              
                
           
        END CASE
    REPEAT
    
    
RETURN
*---------------------------------------------------------------------------------------
    

 



*------------------------------------------------------------------------------
COB:
*---------


    
    SERVICE.NAME=SERVICES.ID<2> ;* SERVICES.ID='TSM':@FM:'COB'
    CMD = "SELECT  F.TSA.SERVICE WITH @ID EQ  '":SERVICE.NAME:"'"
    SELECT.FLAG = 'SERVICE'
    GOSUB SELECTION
   
 
    CRT @(-1):@(0,0):         ;* This will clear the screen
    CRT FMT('','90-L')
    HEADER = 'DISPLAY COB SERVICE OPTION   ->[' :R.SERVICE<TS.TSM.SERVICE.CONTROL>:']      .pg.2 '
    CRT SPACE(20):HEADER

    CRT FMT('','90-L')
    


    

    CRT''
    
    
    
*SELECT DATA TO DISPLAY IT FOR FIRST TIME
   

    BF.AF='BEFORE'
    CMD = "SELECT  F.TSA.SERVICE WITH ":BF.AF:".COB EQ  'Y'"
    SELECT.FLAG = 'SERVICE'
    GOSUB SELECTION
    AF.SELECTED=SELECTED
    
    
    
    BF.AF='AFTER'
    CMD = "SELECT  F.TSA.SERVICE WITH ":BF.AF:".COB EQ  'Y'"
    SELECT.FLAG = 'SERVICE'
    
    GOSUB SELECTION
    BF.SELECTED=SELECTED
    
  
    
    NO.BF.SERVICE = DCOUNT(BF.SERVICE,@FM)
    NO.AF.SERVICE = DCOUNT(AF.SERVICE,@FM)
 
 

    
    CRT SPACE(3):'[1] START COB':SPACE(50-LEN('[1] START COB')):'[2] STOP COB'
    CRT SPACE(3):'[3] CHECK':SPACE(50-LEN('[1] CHECK')):'[4] AGENTS'
     
    CRT ''
    
    CRT SPACE(3):'[5] START BEFORE COB   ':'(':NO.BF.SERVICE:') ':SPACE(50-LEN('[5] START BEFORE COB       ')):'[6] STOP BEFORE COB'
    





    FOR I = 1 TO  NO.BF.SERVICE
        CRT SPACE(4):'\__ [':I:'] ': BF.SERVICE<I>
    NEXT I
    
    CRT ''
    
    CRT SPACE(3):'[7] START AFTER COB  ':'(':NO.AF.SERVICE:') ':SPACE(50-LEN('[5] START AFTER COB       ')):'[8] STOP AFTER COB'

    
    
    FOR I = 1 TO  NO.AF.SERVICE
        CRT SPACE(4):'\__ [':I:'] ': AF.SERVICE<I>
    NEXT I

    
    CRT ''
    
    CRT SPACE(3):'[9] COB.MONITOR':SPACE(50-LEN('[9] COB.MONITOR')):'[10] EXTRACT JT.ANALYSE ~ RT.ANALYSE REPORTS'
    CRT SPACE(3):'[11] DELETE HANGED COB AGENTS'
    
    
    
    CRT ''
    CRT FMT('','90-L')
    CRT 'CHOOSE AN ACTION  OR PRESS (*) TO BACK:'
    INPUT COB_KEY
        
        
        
        
    
        
        
    BEGIN CASE
        CASE COB_KEY = 1
*********************************
            
            CRT "STARTING COB.."    ;*[1] START COB'
            GOSUB SLEEPING
            X='COB'
            RUN.OPTION='START'
            GOSUB SERVICE.RUN
*********************************
        CASE COB_KEY = 2 ;*[2] STOP COB'
*    OUTREC = 'TSA.SERVICE,OFS//PROCESS,//GB0010001,':X:',SERVICE.CONTROL=':RUN.OPTION
        
        
        
        
            CRT "STOPPING COB.."
            GOSUB SLEEPING
            X='COB'
            RUN.OPTION='STOP'
            GOSUB SERVICE.RUN
                
                
*********************************
                
                
        CASE COB_KEY = 3    ;*'[3] CHECK'
*********************************
                      
            
            GOSUB CHECK

            
*********************************
            
            
            
            
        CASE COB_KEY = 4
*********************************
        
            SERVICE.NAME=SERVICES.ID<2>        ;*'[4] AGENTS'
        
            GOSUB AGENTS
*********************************
        CASE COB_KEY = 5              ;*'[5] BEFORE COB'
*    OUTREC = 'TSA.SERVICE,OFS//PROCESS,//GB0010001,':X:',SERVICE.CONTROL=':RUN.OPTION
            CRT 'PRESS <Yy Nn> TO PROCEED: '
            INPUT CL
            CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
            IF   (CL MATCHES CL.ARRAY) THEN
                
        
                RUN.OPTION='START'
        
                FOR I = 1 TO  NO.BF.SERVICE
                    X=BF.SERVICE<I>
                    CHANGE '/' TO '^' IN X
               
                    GOSUB SERVICE.RUN
        
                NEXT I
            END
        
        CASE COB_KEY = 6
            
            CRT 'PRESS <Yy Nn> TO PROCEED: '
            INPUT CL
            CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
            IF   (CL MATCHES CL.ARRAY) THEN
                
        
                RUN.OPTION='STOP'
        
                FOR I = 1 TO  NO.BF.SERVICE
                    X=BF.SERVICE<I>
                    CHANGE '/' TO '^' IN X
               
                    GOSUB SERVICE.RUN
        
                NEXT I
            END
        
               
        CASE COB_KEY = 7            ;*'[5] START AFTER COB'
*    OUTREC = 'TSA.SERVICE,OFS//PROCESS,//GB0010001,':X:',SERVICE.CONTROL=':RUN.OPTION
        
            CRT 'PRESS <Yy Nn> TO PROCEED: '
            INPUT CL
            CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
            IF   (CL MATCHES CL.ARRAY) THEN
                
        
                RUN.OPTION='START'
                FOR II = 1 TO  NO.AF.SERVICE
                    X=AF.SERVICE<II>
                    CHANGE '/' TO '^' IN X
               
                    GOSUB SERVICE.RUN
        
                NEXT II
            END
        
        
        CASE COB_KEY = 8            ;*'[5] STOP AFTER COB'
        
            CRT 'PRESS <Yy Nn> TO PROCEED: '
            INPUT CL
            CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
            IF   (CL MATCHES CL.ARRAY) THEN
                
        
                RUN.OPTION='START'
                FOR II = 1 TO  NO.AF.SERVICE
                    X=AF.SERVICE<II>
                    CHANGE '/' TO '^' IN X
               
                    GOSUB SERVICE.RUN
        
                NEXT II
            END
        
        CASE COB_KEY = 9

            EXECUTE 'COB.MONITOR'
            
        CASE COB_KEY = 10
            CRT 'PRESS <Yy Nn> TO PROCEED: '
            INPUT CL
            CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                
            IF   (CL MATCHES CL.ARRAY) THEN
                
                EXECUTE 'JT.ANALYSE'
            
                SLEEP(1)
                EXECUTE 'RT.ANALYSE'
                SLEEP(1)
            END
*********************************

        CASE COB_KEY = 11

            GOSUB DELTE.AGENTS
            




        CASE COB_KEY = '*'
            GOSUB BACK.TO.DEFAULT

        
    END CASE
RETURN

*---------------------------------------------------------------------------------------

 

 


*------------------------------------------------------------------------------
TSM:
*---
    
    SERVICE.NAME=SERVICES.ID<1> ;* SERVICES.ID='TSM':@FM:'COB'
    CMD = "SELECT  F.TSA.SERVICE WITH @ID EQ  '":SERVICE.NAME:"'"
    SELECT.FLAG = 'SERVICE'
    GOSUB SELECTION
 
    CRT @(-1):@(0,0):         ;* This will clear the screen
    CRT FMT('','90-L')
    HEADER = 'DISPLAY TSM SERVICE OPTION   ->[' :R.SERVICE<TS.TSM.SERVICE.CONTROL>:']      .pg.2 '
    CRT SPACE(20):HEADER



    CRT FMT('','90-L')
    
    
    
    CRT ''
    CRT SPACE(3):'[1] START TSM':SPACE(50-LEN('[1] START TSM')):'[2] STOP TSM'
    CRT SPACE(3):'[3] CHECK':SPACE(50-LEN('[1] CHECK')):'[4] AGENTS'
    CRT ''
    CRT FMT('','90-L')
    CRT 'CHOOSE AN ACTION  OR PRESS (*) TO BACK:'
    INPUT TSM_KEY
        
        
    BEGIN CASE
        CASE TSM_KEY = 1
*********************************
            
            CRT "STARTING TSM.."    ;*[1] START TSM'
            GOSUB SLEEPING
            
            X='TSM'
            RUN.OPTION='START'
            GOSUB SERVICE.RUN
*********************************
        CASE TSM_KEY = 2                ;*[2] STOP TSM
        
        

            CRT "STOPPING TSM.."    ;*[1] START TSM'
            GOSUB SLEEPING
            X='TSM'
            RUN.OPTION='STOP'
            GOSUB SERVICE.RUN
            
            
*********************************
                
        CASE TSM_KEY = 3             ;*'[3] CHECK'
            GOSUB CHECK

            
        CASE TSM_KEY = 4             ;*'[4] AGENTS'
            SERVICE.NAME=SERVICES.ID<1>

            GOSUB AGENTS
            
            
            
*********************************
                     
        CASE TSM_KEY = '*'
         
            GOSUB BACK.TO.DEFAULT
         
           
    END CASE

    
RETURN

*---------------------------------------------------------------------------------------




 
 

*---------------------------------------------------------------------------------------
SELECTION:
*-------




            
    BEGIN CASE
        CASE SELECT.FLAG = 'SERVICE'
***************************
           
        
            SELECT.STATEMENT = CMD
            TSA.STATUS.LIST = ''
            LIST.NAME = ''
            SELECTED = ''
            SYSTEM.RETURN.CODE = ''
            CALL EB.READLIST(SELECT.STATEMENT,TSA.STATUS.LIST,LIST.NAME,SELECTED,SYSTEM.RETURN.CODE)
            
            
            
            IF BF.AF='BEFORE'THEN
                BF.SERVICE=TSA.STATUS.LIST
            END
            IF BF.AF='AFTER'THEN
                AF.SERVICE=TSA.STATUS.LIST
            END
            
            IF SELECTED THEN
                
                FOR JJ=1 TO SELECTED

                    R.STATUS = ''
                    YERR = ''
                    CALL F.READ(FN.TSA.SERVICE,TSA.STATUS.LIST<JJ>,R.SERVICE,F.TSA.SERVICE,YERR)
                    
*CRT ' TS.TSM.DESCRIPTION >> '     : R.SERVICE<TS.TSM.DESCRIPTION>
*CRT ' TS.TSM.SERVER.NAME >> '     : R.SERVICE<TS.TSM.SERVER.NAME>
*CRT ' TS.TSM.WORK.PROFILE >> '     : R.SERVICE<TS.TSM.WORK.PROFILE>
*CRT ' TS.TSM.USER >> '     : R.SERVICE<TS.TSM.USER>
*CRT ' TS.TSM.SERVICE.CONTROL >> '     : R.SERVICE<TS.TSM.SERVICE.CONTROL>
*CRT ' TS.TSM.STARTED >> '     : R.SERVICE<TS.TSM.STARTED>
*CRT ' TS.TSM.STOPPED >> '     : R.SERVICE<TS.TSM.STOPPED>
*CRT ' TS.TSM.ELAPSED >> '     : R.SERVICE<TS.TSM.ELAPSED>
*CRT ' TS.TSM.INPUTTER >> '     : R.SERVICE<TS.TSM.INPUTTER>
*CRT ' TS.TSM.DATE.TIME >> '     : R.SERVICE<TS.TSM.DATE.TIME>
*CRT ' TS.TSM.AUTHORISER >> '     : R.SERVICE<TS.TSM.AUTHORISER>
*CRT ' TS.TSM.CO.CODE >> '     : R.SERVICE<TS.TSM.CO.CODE>
     

                    TSM.DESCRIPTION     = R.SERVICE<TS.TSM.DESCRIPTION>
                    TSM.SERVER.NAME     = R.SERVICE<TS.TSM.SERVER.NAME>
                    TSM.WORK.PROFILE    = R.SERVICE<TS.TSM.WORK.PROFILE>
                    TSM.USER            = R.SERVICE<TS.TSM.USER>
                    TSM.SERVICE.CONTROL = R.SERVICE<TS.TSM.SERVICE.CONTROL>
                    TSM.STARTED         = R.SERVICE<TS.TSM.STARTED>
                    TSM.STOPPED         = R.SERVICE<TS.TSM.STOPPED>
                    TSM.ELAPSED         = R.SERVICE<TS.TSM.ELAPSED>
                    TSM.INPUTTER        = R.SERVICE<TS.TSM.INPUTTER>
                    
                    
                    TSM.DATE.TIME       = R.SERVICE<TS.TSM.DATE.TIME>
                    TSM.AUTHORISER      = R.SERVICE<TS.TSM.AUTHORISER>
                    TSM.CO.CODE         = R.SERVICE<TS.TSM.CO.CODE>
                    
                    
                NEXT JJ
           
            
            
            
            
            END ELSE
                CRT '-> NO AGENTS AVAILABLES FOR ':SERVICE.NAME:' SERVICE '
            END
        
        
        
***************************
                
                
        CASE SELECT.FLAG = 'AGENTS'
      
            
            
    
            SELECT.STATEMENT1 = CMD
            TSA.STATUS.LIST1 = ''
            LIST.NAM1E = ''
            SELECTED1 = ''
            SYSTEM.RETURN.CODE1 = ''
            CALL EB.READLIST(SELECT.STATEMENT1,TSA.STATUS.LIST1,LIST.NAME1,SELECTED1,SYSTEM.RETURN.CODE1)
            
            
            
            IF SELECTED1 THEN
                
                FOR J=1 TO SELECTED1

                  
                   
                            
                    
                    
                    
                    R.STATUS1 = ''
                    YERR1 = ''
                    CALL F.READ(FN.TSA.STATUS,TSA.STATUS.LIST1<J>,R.STATUS1,F.TSA.STATUS,YERR1)
               

                    CRT FMT('','90-L')
                   
                    TSS.SERVER         = R.STATUS1<TS.TSS.SERVER>
                        
                    TSS.AGENT.STATUS    = R.STATUS1<TS.TSS.AGENT.STATUS>
                    TSS.LAST.CONTACT    = R.STATUS1<TS.TSS.LAST.CONTACT>
                    TSS.CURRENT.SERVICE = R.STATUS1<TS.TSS.CURRENT.SERVICE>
                    TSS.LAST.MESSAGE    = R.STATUS1<TS.TSS.LAST.MESSAGE>
                    TSS.COMO.NAME       = R.STATUS1<TS.TSS.COMO.NAME>
                    TSS.JOB.PROGRESS    = R.STATUS1<TS.TSS.JOB.PROGRESS>
                    TSS.T24.SESSION.NO  = R.STATUS1<TS.TSS.T24.SESSION.NO>
                    
                    
                    spc=SPACE(3)
                    spc1=SPACE(5)
                    CRT SPACE(3):'-(':J:') ':'@ID':spc:'#ServerName' :spc:'#AgentStatus':spc:'#CurrnServ':spc:'#LastCont':spc:' ':'#COMO':SPACE(23):'#LastMsg'
                    CRT SPACE(6):TSA.STATUS.LIST1<J>:spc1:TSS.SERVER:spc1:TSS.AGENT.STATUS:spc1:'  ':TSS.CURRENT.SERVICE:spc1:"   ":TSS.LAST.CONTACT:spc:TSS.COMO.NAME:spc1:TSS.LAST.MESSAGE
        
                
                
                    IF SERVICE.NAME  NE 'TSM' THEN
                        QUERY="SH -c ' cat ":TAFJ.HOM:COMO.PATH:TSS.COMO.NAME:"|  awk 'match($0, /F.JOB.LIST\.[0-9]+/) {print substr($0, RSTART, RLENGTH)}' | tail -1 '"
     
                        EXECUTE QUERY   CAPTURING JOB.LIST
           
                        IF  INDEX(JOB.LIST , "Cannot open", 1) THEN
                            CRT 'COMO: Cannot be opened or placed on another server.'
	     
                        END ELSE
	                            
                            EXECUTE 'COUNT ':JOB.LIST   CAPTURING JOB.LIST.COUNT
	                        
                            JOB.LIST.COUNT = JOB.LIST.COUNT[3,LEN(JOB.LIST.COUNT)]
	                        
                            CRT "JOB: LIST-ITEM ":JOB.LIST:"  COUNT: ":JOB.LIST.COUNT
	                        
           
                        END
                
                   
                    END

               

            
                    
                 
                 
                    

                NEXT J
            
            
            END ELSE
                CRT '-> NO AGENTS AVAILABLES FOR ':SERVICE.NAME:' SERVICE '
            END
           
    END CASE
 
    



RETURN
*---------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------
AGENTS:
*-------
  


    LOOP
    WHILE NOT (CONTINUE.REFRESH MATCHES EXIT.ARRAY)         ;* Until user wants to exit

        IF STOP.REFRESH THEN      ;* If COB has been completed do not refresg anymore
            
            CONTINUE.REFRESH = 'EXIT'       ;* Say bye end exit
           
            
        END ELSE
           
            CRT @(-1):@(0,0):         ;* This will clear the screen
            CRT FMT('','90-L')
            HEADER = 'AGENTS FOR ':SERVICE.NAME:'   pg.3'
            CRT SPACE(30):HEADER
            
             
            CRT FMT('','90-L')
            CRT ''
            
            
            
            EXECUTE "COUNT F.TSA.STATUS WITH CURRENT.SERVICE EQ '":SERVICE.NAME:"' AND WITH AGENT.STATUS EQ 'RUNNING' AND WITH LAST.MESSAGE UNLIKE '...exhausted'" CAPTURING un.exhausted
            unexRECRDS = un.exhausted[3,LEN(un.exhausted)]
* RECRDS
*CRT SPACE(3):'Un-exhausted > ':un.exhausted
    
    
            EXECUTE "COUNT F.TSA.STATUS WITH CURRENT.SERVICE EQ '":SERVICE.NAME:"' AND WITH AGENT.STATUS EQ 'RUNNING' AND WITH LAST.MESSAGE LIKE '...exhausted'"  CAPTURING exhausted
   
            exRECRDS = exhausted[3,LEN(exhausted)]
* RUNNING= unexRECRDS[1,1]+exRECRDS[1,1]
*CRT exRECRDS
*CRT SPACE(3):'exhausted > ':exhausted
* RECRDS
             
            
            
            
            EXECUTE "COUNT F.TSA.STATUS WITH AGENT.STATUS EQ 'RUNNING'"  CAPTURING allagents


            Allagents = allagents[3,LEN(allagents)]
            
* CRT SPACE(3):'Allagents > ':allagents
            
            
     
            CRT SPACE(3):'Un-exhausted: ':unexRECRDS:SPACE(50-LEN('Un-exhausted:   ')):'Exhausted: ':exRECRDS
    
            CRT SPACE(3):'*AllAgents*:  ':Allagents
            CRT ''
       
        
        
        
        
*OTHER_CMD = "COUNT F.TSA.STATUS WITH AGENT.STATUS EQ 'RUNNING'"
            
            IF OTHER_CMD NE 0 THEN
                CMD= OTHER_CMD
            END ELSE
                CMD = "SELECT  F.TSA.STATUS WITH CURRENT.SERVICE EQ '":SERVICE.NAME:"'"
            
            END
        
        
       

            SELECT.FLAG = 'AGENTS'
            GOSUB SELECTION
            CRT ''
 
        
         
            CRT FMT('','90-L')
            KEY.PRESS = 'To Quit Press  STOP  stop  S   s'
            
            CRT KEY.PRESS
            
            INPUT CONTINUE.REFRESH  FOR REFRESH.SECS THEN        ;* Else get the option from USER
            END
        
        
        END
    REPEAT
    STOP.REFRESH = @FALSE
    CONTINUE.REFRESH = 'Y'    ;* Default value
          

            

RETURN
*---------------------------------------------------------------------------------------






*---------------------------------------------------------------------------------------
SLEEPING:
*-------
    
    SLEEP 0.5
RETURN
*---------------------------------------------------------------------------------------


*---------------------------------------------------------------------------------------
PREVUIS_PAGE:
*------------
    PREVUIS.PAGE=LAST.INPUT

RETURN
*---------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------
BACK.TO.DEFAULT:
*---------------

    CONTINUE.REFRESH = 'Y'    ;* Default value
    LAST.INPUT=0
    GOSUB PREVUIS_PAGE
    GOSUB MAIN.DASH
    
RETURN
*---------------------------------------------------------------------------------------
 


*---------------------------------------------------------------------------------------
SERVICE.RUN:
*-----------
    GOSUB FORM.OFS.MSG
    GOSUB POST.OFS.MSG
RETURN
*---------------------------------------------------------------------------------------



*---------------------------------------------------------------------------------------
FORM.OFS.MSG:
*-------------
*':R.JFILE<I>:'
    OUTREC = ''
* OUTREC = 'TSA.SERVICE,OFS//PROCESS,//GB0010001,BNK^DW.INCR.PRE.PROCESS.SERVICE,SERVICE.CONTROL=STOP'
    
    OUTREC = 'TSA.SERVICE,OFS//PROCESS,//EG0010001,':X:',SERVICE.CONTROL=':RUN.OPTION
    
    
RETURN
*---------------------------------------------------------------------------------------
POST.OFS.MSG:
*------------

    OFS.MSG = ""
    IF OUTREC NE '' THEN
        OFS.MSG = OUTREC
        Y.OFS.LINE = OUTREC

        OFS$SOURCE.ID = 'UPLOAD'
        R.OFS.SOURCE = ''
        ERR.OFS.SRC= ''
        
        
        CALL F.READ(FN.OFS.SOURCE,OFS$SOURCE.ID,R.OFS.SOURCE,FV.OFS.SOURCE,ERR.OFS.SRC)
        OFS$SOURCE.REC = R.OFS.SOURCE
        Y.OFS.MSG.OUT = ''
        Y.COMMITED = ''
        PRINT OUTREC
        SLEEP 0.5
        CALL OFS.CALL.BULK.MANAGER(OFS$SOURCE.ID,OUTREC,Y.OFS.MSG.OUT,Y.COMMITED)
 
        IF Y.COMMITED EQ 'TRUE' THEN
            CURRENT.LINE = OUTREC
            PRINT 'MSG IN: ':CURRENT.LINE
            SLEEP 0.5
* RETURN
        END ELSE
            CURRENT.LINE = Y.OFS.MSG.OUT
            PRINT 'MSG OUT: ':CURRENT.LINE
            SLEEP 0.5
        END
    END
RETURN
*---------------------------------------------------------------------------------------


*---------------------------------------------------------------------------------------
CHECK:
*---------


   


    LOOP
    WHILE NOT (CONTINUE.REFRESH MATCHES EXIT.ARRAY)
    
        CRT @(-1):@(0,0):
        CRT FMT('','90=L')
        CRT SPACE(3):'SERVIC NAME':SPACE(50-LEN('SERVIC NAME')):'STATUS'
        CRT FMT('','90=L')

        CRT ''
        IF STOP.REFRESH THEN      ;* If COB has been completed do not refresg anymore
            
            CONTINUE.REFRESH = 'EXIT'       ;* Say bye end exit
           
            
        END ELSE




            CMD ="SSELECT  F.TSA.SERVICE WITH SERVICE.CONTROL EQ 'START'"

            SELECT.STATEMENT = CMD
            TSA.STATUS.LIST = ''
            LIST.NAME = ''
            SELECTED = ''
            SYSTEM.RETURN.CODE = ''
            CALL EB.READLIST(SELECT.STATEMENT,TSA.STATUS.LIST,LIST.NAME,SELECTED,SYSTEM.RETURN.CODE)
            
              
            FOR I=0 TO SELECTED
        
                IF TSA.STATUS.LIST<I> NE '' THEN

                    CALC.SPACE =LEN(TSA.STATUS.LIST<I>)
                    SIZE=50-CALC.SPACE
                    PRINT I:'. ':TSA.STATUS.LIST<I>:SPACE(SIZE):'START'
        
                END
        
            NEXT I
            CRT ''
            CRT FMT('','90=L')

            KEY.PRESS = 'To Quit Press  STOP  stop  S   s'
            
            CRT KEY.PRESS
            
            INPUT CONTINUE.REFRESH  FOR 5 THEN        ;* Else get the option from USER
            END


        END
    REPEAT
    CONTINUE.REFRESH = 'Y'    ;* Default value
 
    
    
 

RETURN
*---------------------------------------------------------------------------------------

*---------------------------------------------------------------------------------------

DELTE.AGENTS:
*---------------------------------------------------------------------------------------
    

                        
    EXECUTE "SELECT  F.TSA.STATUS WITH CURRENT.SERVICE EQ 'COB' AND WITH AGENT.STATUS EQ 'RUNNING'"
    
    READLIST SEL.AGENT ELSE SEL.AGENT= ''
     
    
    NO.AGENTS = DCOUNT(SEL.AGENT,@FM)
    CRT FMT('','90-L')
    
    CRT "Agents No.: ":NO.AGENTS
    CRT "@IDs: ":
    
    FOR NO = 1 TO NO.AGENTS
        CRT SEL.AGENT<NO>:" ":
    NEXT NO

     
    
    CRT ''
    IF SEL.AGENT NE ''THEN
        CRT 'PRESS <Yy Nn> TO DELETE: '
        INPUT CL
        CL.ARRAY  = 'Y':@VM:'y'  ;* User can Type any of these and exit
                        

        IF   (CL MATCHES CL.ARRAY) THEN
       
            FOR NO = 1 TO NO.AGENTS
                EXECUTE "DELETE  F.TSA.STATUS ":SEL.AGENT<NO>
                
                EXECUTE "COUNT  F.TSA.STATUS ":SEL.AGENT<NO> CAPTURING DEL.AGENT
                
                DEL.AGENT = DEL.AGENT[3,LEN(DEL.AGENT)]
                CRT DEL.AGENT
            NEXT NO
                                
        END
    END
    SLEEP(1)

RETURN
*---------------------------------------------------------------------------------------




*************************************************************************
PROGRAM.END:
**********
RETURN

END
