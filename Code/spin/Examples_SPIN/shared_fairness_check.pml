int x = 1;  // Shared variable, initialized to 1
bool p1_active = false;  // Tracks if P1 has executed
bool p2_active = false;  // Tracks if P2 has executed

active proctype P1() {
    do
    :: (x < 1000000) ->  
        x = x + 1; 
        p1_active = true;  // Mark that P1 executed
        printf("P1: x = %d\n", x);
        assert(x > 0);  // Ensure x never becomes non-positive
    :: else -> break  // If x >= 1000000, P1 stops
    od;
}

active proctype P2() {
    do
    :: (x < 1000000) ->  
        x = 2 * x;  
        p2_active = true;  // Mark that P1 executed
        printf("P2: x = %d\n", x);
        assert(x > 0);  // Ensure x never becomes non-positive
    :: else -> break  // If x >= 1000000, P2 stops
    od;
}

// Deadlock detection
ltl deadlock_check { []<>(x < 1000000) }

// Fair execution check: P1 and P2 must execute infinitely often
ltl fair_execution { [](<> p1_active) && [](<> p2_active) }