#define COIN  0
#define SELECT 1
#define DISPENSE 2

mtype = { COIN, SELECT, DISPENSE };
mtype drink;  // Selected drink type

active proctype BeverageMachine() {
    mtype state = COIN;  // Initial state: Waiting for a coin

    do
    :: state == COIN -> 
        printf("Coin inserted.\n");
        state = SELECT

    :: state == SELECT -> 
        drink = 1;  // Assume user selects drink 1 (Coffee)
        printf("Drink selected: %d\n", drink);
        state = DISPENSE

    :: state == DISPENSE -> 
        printf("Dispensing drink %d...\n", drink);
        state = COIN;  // Reset to waiting for a coin
    od;
}
