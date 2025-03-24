
#define DATA0  0
#define DATA1 1
#define ACK0 2
#define ACK1 3
#define TIMEOUT 4

mtype = { DATA0, DATA1, ACK0, ACK1, TIMEOUT }  /* Message types for alternating bit protocol */

chan c = [0] of { mtype }; /* Unreliable channel from sender to receiver */
chan d = [0] of { mtype }; /* Unreliable channel from receiver to sender */
chan t = [0] of { mtype }; /* Timer communication channel */

proctype Sender() {
    mtype bit = DATA0;
    
    do ::
        /* Send a message with the current bit and notify timer */
        c!bit;
        t!bit;
        printf("Sender: Sent %e\n", bit);
        
        /* Wait for acknowledgment or timeout */
        do ::
            d?ACK0 -> if :: bit == DATA0 -> bit = DATA1; break; fi;
            d?ACK1 -> if :: bit == DATA1 -> bit = DATA0; break; fi;
            t?TIMEOUT -> printf("Sender: Timeout, resending %e\n", bit);
                       c!bit; t!bit;
        od;
    od;
}

proctype Receiver() {
    mtype expected = DATA0;
    do ::
        /* Receive a message */
        if
            :: c?DATA0 -> 
                if :: expected == DATA0 -> printf("Receiver: Received DATA0, sending ACK0\n"); d!ACK0; expected = DATA1; fi;
            :: c?DATA1 -> 
                if :: expected == DATA1 -> printf("Receiver: Received DATA1, sending ACK1\n"); d!ACK1; expected = DATA0; fi;
        fi;
    od;
}

proctype Timer() {
    do ::
        mtype msg;
        t?msg;
        /* Simulate timeout delay */
        skip; skip; skip; skip; skip; /* Representing time delay */
        t!TIMEOUT;
    od;
}

init {
    atomic {
        run Sender();
        run Receiver();
        run Timer();
    }
}
