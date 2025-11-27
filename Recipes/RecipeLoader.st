PROGRAM RecipeLoader 
VAR
    (*Recipe Database: 10 sorted recipes *)
    RecipeDB: Array[1..10] OF RecipeType;

    (*Working copy of the currently active recipe *)
    ActiveRecipe: RecipeType;

    (*Operator Interface *)
    SelectedRecipe : INT; (*recipe number chosen by operator (1..10) *)
    LoadRecipeCmd: BOOL; (*button: TRUE when operator presses LOAD *)

    (*Status Flags *)
    RecipeLoaded: BOOL; (*TRUE for one scan when a recipe us successfully loaded *)
    RecipeError: BOOL; (*TRUE if invalid recipe number requested *)

    (*Internal for edge detection *)
    PrevLoadCmd : BOOL; (*previous scan value of LoadRecipeCmd *)
    RisingEdgeLoad: BOOL; (*TRUE for one scan when LoadRecipe goes 0->1 *)
    
END_VAR

(*Rising edge detection for load command *)
RisingEdgeLoad := LoadRecipeCmd AND (NOT PrevLoadCmd);

(*Handle Recipe Loading Logic *)
IF RisingEdgeLoad = TRUE THEN
    IF(SelectedRecipe >= 1.0) AND (SelectedRecipe <= 10) THEN
        ActiveRecipe := RecipeDB[SelectedRecipe];
        RecipeLoaded := TRUE;
        RecipeError := FALSE;
        
    ELSE
        RecipeLoaded := FALSE;
        RecipeError := TRUE;

        
    END_IF;

 ELSE 
    RecipeLoaded := FALSE; (*keeps it as a pulse *)
END_IF;

(*Store current load command for next scan *)
PrevLoadCmd := LoadRecipeCmd;


END_PROGRAM