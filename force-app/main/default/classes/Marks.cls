/* addition functionality 

*/

public with sharing class Marks {
    public Marks() {
        // No-op constructor; keep if you plan to add instance state later.
    }

    public static Integer add(Integer a, Integer b) {
        return a + b;
    }
}