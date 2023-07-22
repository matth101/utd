public class Pair<T> {
    T first, second;
    public Pair(T first, T second) {
        this.first = first;
        this.second = second;
    }

    public T getFirst() { return first; }
    public T getSecond() { return second; }

    public void swap() {
        T temp = first;
        first = second;
        second = temp;
    }

    public static void main(String[] args) {
        Pair pair = new Pair("UT", "Dallas");
        System.out.println("Before (first, second): (" + pair.getFirst() + ", " + pair.getSecond() + ")");
        pair.swap();
        System.out.println("Before (first, second): (" + pair.getFirst() + ", " + pair.getSecond() + ")");
    }
}
