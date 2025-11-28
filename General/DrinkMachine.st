PROGRAM DrinkMachine 
VAR
    Select: INT; (* 1= TEA, 2= COFFEE *)
    StartBrew: BOOL; (*Start Button *)
    Brewing: BOOL; (*Output: Brew Light ON/OFF *)
    Timer: TON; (*Timer *)
    TotalCount: DINT := 0; (*Counts Drinks Brewed *)
END_VAR

(*stored recipes directly in code, no extra DB array *)
IF Select = 1 THEN
    Timer(IN := StartBrew, PT := T#6s); (*Tea Brews 6 sec *)
IF Select = 2 THEN
    Timer(IN := StartBrew, PT := T#4s); (*Coffee brews 4 sec *)
ELSE
    Timer(IN := FALSE, PT := T#0s); (*invalid selection -> timer off *)
END_IF;

Brewing := Timer.Q; (*Light ON when timer is done *)

(*count once when brew actually starts *)
IF StartBrew AND Timer.ET = T#0s THEN
    TotalCount := TotalCount +1;
END_IF;

END_PROGRAM