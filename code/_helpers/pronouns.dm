#define P_THEY(g) g == MALE && "он" \
               || g == FEMALE && "она" \
               || g == NEUTER && "оно" \
               || "они"

#define P_THEM(g) g == MALE && "его" \
               || g == FEMALE && "её" \
               || "их"

#define P_THEIR(g) g == MALE && "его" \
               || g == FEMALE && "её" \
               || "их"
