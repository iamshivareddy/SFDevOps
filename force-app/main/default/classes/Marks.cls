public with sharing class Marks {
    public Marks() {
        // No-op constructor; keep if you plan to add instance state later.
    }

    // Defines how to treat null inputs during total calculation
    public enum NullValueMode {
        TreatNullAsZero,     // null -> 0
        RejectOnNull         // throw an exception if any input is null
    }

    // Convenience overload: sum exactly three marks, treating nulls as zero by default
    public static Integer total(Integer mark1, Integer mark2, Integer mark3) {
        return total(new List<Integer>{ mark1, mark2, mark3 }, NullValueMode.TreatNullAsZero, null, null);
    }

    // Overload with null handling strategy
    public static Integer total(Integer mark1, Integer mark2, Integer mark3, NullValueMode nullMode) {
        return total(new List<Integer>{ mark1, mark2, mark3 }, nullMode, null, null);
    }

    // Primary implementation: sum any number of marks with optional validation
    // minAllowed and maxAllowed are optional domain constraints (e.g., 0..100)
    // Pass null for no lower/upper bound respectively.
    public static Integer total(List<Integer> marks, NullValueMode nullMode, Integer minAllowed, Integer maxAllowed) {
        if (marks == null) {
            // Define behavior: null list treated as zero total
            return 0;
        }

        Integer sum = 0;
        for (Integer m : marks) {
            if (m == null) {
                if (nullMode == NullValueMode.RejectOnNull) {
                    throw new IllegalArgumentException('Null mark encountered while nullMode=RejectOnNull.');
                } else {
                    // Treat null as zero
                    continue;
                }
            }

            if (minAllowed != null && m < minAllowed) {
                throw new IllegalArgumentException('Mark ' + m + ' is less than the minimum allowed value of ' + minAllowed + '.');
            }
            if (maxAllowed != null && m > maxAllowed) {
                throw new IllegalArgumentException('Mark ' + m + ' exceeds the maximum allowed value of ' + maxAllowed + '.');
            }
                    sum += m;
                }
            }
        }