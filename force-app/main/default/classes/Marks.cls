public with sharing class Marks {
  public Marks() {
    // No-op constructor; keep if you plan to add instance state later.
  }

  // Defines how to treat null inputs during total calculation
  public enum NullValueMode {
    TreatNullAsZero, // null -> 0
    RejectOnNull // throw an exception if any input is null
  }

  // Convenience overload: sum exactly three marks, treating nulls as zero by default
  public static Integer total(Integer mark1, Integer mark2, Integer mark3) {
    return total(
      new List<Integer>{ mark1, mark2, mark3 },
      NullValueMode.TreatNullAsZero,
      null,
      null
    );
  }

  /**
   * Overload with null handling strategy for exactly three marks.
   * min/max constraints are not applied in this overload.
   */
  public static Integer total(
    Integer mark1,
    Integer mark2,
    Integer mark3,
    NullValueMode nullMode
  ) {
    return total(
      new List<Integer>{ mark1, mark2, mark3 },
      nullMode,
      null,
      null
    );
  }

  /**
   * Primary implementation: sum any number of marks with optional validation.
   * Behavior:
   * - If marks is null, returns 0 (no values to add).
   * - If nullMode = RejectOnNull and any element is null, throws IllegalArgumentException.
   * - If minAllowed is not null and a value is below minAllowed, throws IllegalArgumentException.
   * - If maxAllowed is not null and a value is above maxAllowed, throws IllegalArgumentException.
   * - If both minAllowed and maxAllowed are provided and minAllowed > maxAllowed, throws IllegalArgumentException.
   */
  public static Integer total(
    List<Integer> marks,
    NullValueMode nullMode,
    Integer minAllowed,
    Integer maxAllowed
  ) {
    // Normalize mode
    NullValueMode effectiveMode = (nullMode == null)
      ? DEFAULT_NULL_MODE
      : nullMode;

    // Early return for null list
    if (marks == null) {
      return 0;
    }

    // Validate bounds relationship if both provided
    if (minAllowed != null && maxAllowed != null && minAllowed > maxAllowed) {
      throw new IllegalArgumentException(
        'Invalid bounds: minAllowed (' +
          minAllowed +
          ') cannot be greater than maxAllowed (' +
          maxAllowed +
          ').'
      );
    }

    Integer sum = 0;
    for (Integer m : marks) {
      Integer normalized = normalizeMark(m, effectiveMode);
      if (minAllowed != null && normalized < minAllowed) {
        throw new IllegalArgumentException(
          'Mark ' +
            normalized +
            ' is less than the minimum allowed value of ' +
            minAllowed +
            '.'
        );
      }
      if (maxAllowed != null && normalized > maxAllowed) {
        throw new IllegalArgumentException(
          'Mark ' +
            normalized +
            ' exceeds the maximum allowed value of ' +
            maxAllowed +
            '.'
        );
      }
      sum += normalized;
    }
    return sum;
  }

  // Helper to apply null policy. Returns 0 for TreatNullAsZero when m is null; otherwise returns m.
  private static Integer normalizeMark(Integer m, NullValueMode mode) {
    if (m == null) {
      if (mode == NullValueMode.RejectOnNull) {
        throw new IllegalArgumentException(
          'Null mark encountered while nullMode=RejectOnNull.'
        );
      }
      return 0; // TreatNullAsZero
    }
    return m;
  }
}
