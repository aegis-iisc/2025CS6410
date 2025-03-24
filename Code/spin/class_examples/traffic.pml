#define GREEN  0
#define YELLOW 1
#define RED    2

mtype = { GREEN, YELLOW, RED };

// Traffic Signal Process
proctype TrafficSignal(byte id) {
    mtype state = RED; // Start with RED
    do
    :: state == GREEN  -> state = YELLOW; printf("Signal %d: YELLOW\n", id)
    :: state == YELLOW -> state = RED;    printf("Signal %d: RED\n", id)
    :: state == RED    -> state = GREEN;  printf("Signal %d: GREEN\n", id)
    od;
}

// Instantiate multiple independent signals
init {
    atomic {
        run TrafficSignal(1);
        run TrafficSignal(2);
        run TrafficSignal(3);
    }
}



