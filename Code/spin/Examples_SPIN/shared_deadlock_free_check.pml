int x = 1;  // Shared variable, initialized to 1

active proctype P1() {
    do
    :: (x < 1000000) ->  // Prevent integer overflow
        x = x + 1; 
        printf("P1: x = %d\n", x);
        assert(x > 0);  // Ensure x never becomes non-positive
    :: else -> break  // If x >= 1000000, P1 stops
    od;
}

active proctype P2() {
    do
    :: (x < 1000000) ->  
        x = 2 * x;  
        printf("P2: x = %d\n", x);
        assert(x > 0);  // Ensure x never becomes non-positive
    :: else -> break  // If x >= 1000000, P2 stops
    od;
}
// x is always eventually less than 1000000.
ltl deadlock_check { []<>(x < 500000) }



docker container run -it \  
--name refsyn \
--memory 32g \
--platform linux/amd64 \
oopsla25-refsyn:latest \
/bin/bash