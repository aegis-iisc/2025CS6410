#define COIN  0
#define SELECT 1
#define DISPENSE 2

mtype = { COIN, SELECT, DISPENSE };
// mtype drink = 5;  // Selected drink type

chan input = [1] of { mtype };  // Channel for user input

active proctype BeverageMachine() {
    mtype state = COIN;  // Initial state: Waiting for a coin
    mtype drink; 
    do
    :: state == COIN -> 
        input?COIN;  // Wait for a coin from the user
        printf("Coin inserted.\n");
        state = SELECT

    :: state == SELECT -> 
        input?SELECT, drink;  // Wait for drink selection
        printf("Drink selected: %d\n", drink);
        state = DISPENSE

    :: state == DISPENSE -> 
        printf("Dispensing drink %d...\n", drink);
        state = COIN;  // Reset to waiting for a coin
    od;
}

active proctype User() {
    printf ("User action");
    input!COIN;  // Insert coin
    input!SELECT, 1; // 1 Select drink (e.g., 1 = Coffee)
}
