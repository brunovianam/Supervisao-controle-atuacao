PROGRAM Planta
  VAR
    PID0 : PID;
  END_VAR
  VAR
    Setpoint AT %QW1 : INT;
    EN_PID AT %QX0.3 : BOOL;
    KP AT %QW2 : INT;
    TR AT %QW3 : INT;
    TD AT %QW4 : INT;
    VP AT %IW100 : INT;
    SC AT %QW101 : INT;
    QUO AT %QW5 : INT;
  END_VAR
  VAR
    INT_TO_REAL16_OUT : REAL;
    MAX17_OUT : REAL;
    INT_TO_REAL5_OUT : REAL;
    INT_TO_REAL7_OUT : REAL;
    DIV25_OUT : REAL;
    INT_TO_REAL6_OUT : REAL;
    DIV14_OUT : REAL;
    INT_TO_REAL8_OUT : REAL;
    DIV10_OUT : REAL;
    REAL_TO_INT29_OUT : INT;
    MAX28_OUT : INT;
  END_VAR

  INT_TO_REAL16_OUT := INT_TO_REAL(VP);
  MAX17_OUT := MAX(INT_TO_REAL16_OUT, 0.0);
  INT_TO_REAL5_OUT := INT_TO_REAL(Setpoint);
  INT_TO_REAL7_OUT := INT_TO_REAL(KP);
  DIV25_OUT := DIV(INT_TO_REAL7_OUT, 1000.0);
  INT_TO_REAL6_OUT := INT_TO_REAL(TR);
  DIV14_OUT := DIV(INT_TO_REAL6_OUT, 1000.0);
  INT_TO_REAL8_OUT := INT_TO_REAL(TD);
  DIV10_OUT := DIV(INT_TO_REAL8_OUT, 1000.0);
  PID0(AUTO := EN_PID, PV := MAX17_OUT, SP := INT_TO_REAL5_OUT, KP := DIV25_OUT, TR := DIV14_OUT, TD := DIV10_OUT, CYCLE := T#10ms);
  REAL_TO_INT29_OUT := REAL_TO_INT(PID0.XOUT);
  MAX28_OUT := MAX(REAL_TO_INT29_OUT, 0);
  SC := MAX28_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : Planta;
  END_RESOURCE
END_CONFIGURATION
