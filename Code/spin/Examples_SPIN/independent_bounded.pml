int x = 0;   // Shared variable x
int y = 10;  // Shared variable y (initial value)

active proctype P1() {
    int i = 0;
    do
    :: (i < 10) -> 
        x = x + 1; 
        printf("P1: x = %d\n", x);
        assert(x != y);  // Ensure x and y are never equal
        i++
    :: (i >= 10) -> break  // Stop after 10 iterations
    od;
}

active proctype P2() {
    int j = 0;
    do
    :: (j < 10) -> 
        y = y - 3*y;  // Equivalent to y := -2*y
        printf("P2: y = %d\n", y);
        assert(x != y);  // Ensure x and y are never equal
        j++
    :: (j >= 10) -> break  // Stop after 10 iterations
    od;
}
