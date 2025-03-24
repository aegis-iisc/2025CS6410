int x = 1;  // Shared variable, initialized to 1

active proctype P1() {
    int i = 0;
    do
    :: atomic {(i < 10) -> 
        x = x + 1; 
        printf("P1: x = %d\n", x);
        assert(x > 0);  // Ensure x never becomes non-positive
        i++}
    :: (i >= 10) -> break  // Stop after 10 iterations
    od;
}

active proctype P2() {
    int j = 0;
    do
    :: atomic {(j < 10) -> 
        x = 2 * x;  
        printf("P2: x = %d\n", x);
        assert(x > 0);  // Ensure x never becomes non-positive
        j++}
    :: (j >= 10) -> break  // Stop after 10 iterations
    od;
}
