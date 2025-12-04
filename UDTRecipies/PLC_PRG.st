PROGRAM PLC_PRG
VAR_GLOBAL
    Recipe1: RecipeType := (TargetTemperature := 70.0, AgitatorSpeed := 150); 
    Recipe2: RecipeType := (TargetTemperature := 90.0, AgitatorSpeed := 300);

    //Arrayof avalible recipes
    RecipeList : ARRAY[1..2] OF RecipeType := [Recipe_1, Recipe_2];

    SelectedRecipeIndex : INT := 1;

    MachineTargetTemp : REAL := 0.0;
    MachineAgitatorSpeed: INT := 0;

    LoadRecipeCommand: BOOL := FALSE;
END_VAR

VAR
    //Internal State
    RecipeLoaded : BOOL := FALSE;
END_VAR

IF LoadRecipeCommand THEN 
    IF SelectedRecipeIndex >= 1 AND SelectedRecipeIndex <= 2 THEN 
        //Load selected recipe into machine controls
        MachineTargetTemp := RecipeList[SelectedRecipeIndex].TargetTemperature;
        MachineAgitatorSpeed := RecipeList[SelectedRecipeIndex].AgitatorSpeed;
        RecipeLoaded := TRUE;
    ELSE
        //Handling the invalid section
        MachineTargetTemp := 0.0;
        MachineAgitatorSpeed := 0;
        RecipeLoaded := FALSE;
    END_IF;

    //Acknowledge Command
    LoadRecipeCommand := FALSE;

END_IF;

 
END_PROGRAM