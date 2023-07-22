public class LinearProbingHashTable<K, V> {

    private static class Entry<K, V> {

    }

    public LinearProbingHashTable() {

    }

    /*
     Inserts entry; rehashes if half full; can re-use deleted entries;
     Throws exception if key is null, returns true if inserted, false if duplicate.
     */
    public boolean insert(K key, V value) {

        return false;
    }

    /*
      Returns value for key, or null if not found.
     */
    public V find(K key) {

    }

    /*
     Marks the entry deleted but leaves it there;
      Returns true if deleted, false if not found.
     */
    public boolean delete(K key) {

    }

    /*
     Doubles the table size, hashes everything to the new table,
        omitting items marked deleted
     */
    private void rehash() {

    }

    /*
     Returns the original index the key hashes to.
     (this is the value before probing occurs)
     */
    public int getHashTarget(K key) {

    }

    /*
     Returns the index for the given key, or -1 if not found.
     (This is the value after probing occurs)
     */
    public int getHashLocation(K key) {

    }

    /*
     Returns a formatted string of the hash table.
     */
    public String toString() {

    }

    public static void main(String[] args) {

    }
}
