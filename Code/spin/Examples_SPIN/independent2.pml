int x = 0;   // Shared variable x
int y = 10;  // Shared variable y (initial value)

active proctype P1() {
    do
    :: x = x + 1; 
       printf("P1: x = %d\n", x);
       assert(x != y);  // Ensure x and y are never equal
       assert (x > 0);
    od;
}

active proctype P2() {
    do
    :: y = y - 3*y;  // Equivalent to y := -2*y
       printf("P2: y = %d\n", y);
       assert(x != y);  // Ensure x and y are never equal
    od;
}
