class Node {
    String data;
    Node next;
    boolean isLetter;

    public Node() {
        this.next = null;
    }

    public Node(String data) {
        this.data = data;
        isLetter = (data.length() == 1);
        this.next = null;
    }
}

public class NameList {
    static Node head;
    int[] letters = new int[26];
    static final int MIN_NAME_LENGTH = 2;

    /*
     Adds a new name.  Names must be at least 2 characters long.  Adds the letter node if not already present.
     */
    public void add(String toAdd) {
        if (toAdd.length() < MIN_NAME_LENGTH || (head != null && find(toAdd)))
            return; // do nothing

        char firstLetter = toAdd.toLowerCase().charAt(0);

        if (head == null) { // if list is empty
            head = new Node(String.valueOf(firstLetter).toUpperCase());
            head.next = new Node(toAdd);
            letters[firstLetter-'a']++;
            return;
        }

        Node prev = head;
        Node current = head.next;
        do {
            if (current.data.compareToIgnoreCase(toAdd) > 0) { // Find proper spot to insert
                Node nodeToAdd = new Node(toAdd);
                nodeToAdd.next = current;
                if (letters[firstLetter-'a'] == 0) { // If we're starting a new section
                    prev.next = new Node(String.valueOf(firstLetter).toUpperCase());
                    prev.next.next = nodeToAdd;
                } else { // if section exists
                    prev.next = nodeToAdd;
                }
                letters[firstLetter-'a']++;
                return;
            }

            prev = current;
            current = current.next;
        } while (current != null);

        // Enter this only if we've reached end of list
        Node nodeToAdd = new Node(toAdd);
        if (letters[firstLetter-'a'] == 0) {
            prev.next = new Node(String.valueOf(firstLetter).toUpperCase());
            prev.next.next = nodeToAdd;
        } else {
            prev.next = nodeToAdd;
        }
        letters[firstLetter-'a']++;
    }

    /*
    Removes a name.  If the name is the last one for a letter, the letter node should also be removed.
     */
    public void remove(String name) {
        if (head.next == null || head.next.next == null) {
            head.next = null;
        }

        char firstLetter = name.toLowerCase().charAt(0);

        Node prev = head; // edge case is that there is only one element in the list but that won't happen
        Node current = head.next;
        while (current != null) {
            if (letters[firstLetter-'a'] > 1) { // if there are multiple names
                if (current.data.equalsIgnoreCase(name)) {
                    prev.next = current.next; // skip over inputted name
                    letters[firstLetter-'a']--;
                    return;
                }
            }
            else { // if there aren't multiple names
                if (current.isLetter && current.data.equalsIgnoreCase(String.valueOf(firstLetter))) {
                    prev.next = current.next.next;
                    letters[firstLetter-'a'] = 0;
                    return;
                }
            }

            prev = current;
            current = current.next;
        }
    }

    /*
    Removes a letter and all names for that letter.
     */
    public void removeLetter(String letter) {
        if (letter.length() > 1)
            return;

        Node prev = head;
        Node current = head.next;
        boolean foundFirstLetter = false;
        while (current != null) {
            if (foundFirstLetter) {
                if (current.isLetter) { // if we've reached next section
                    prev.next = current;
                    return;
                }
                else if (current.next == null) { // if we've reached end of list
                    prev.next = null;
                    return;
                }
            }
            else if (current.isLetter && current.data.equalsIgnoreCase(letter)) {
                foundFirstLetter = true;
            }
            else {
                prev = current;
            }

            current = current.next;
        }

        letters[letter.toLowerCase().charAt(0)-'a'] = 0;
    }

    /*
    Finds a name by traversing the nodes, returns a boolean.
     */
    public boolean find(String name) {
        Node current = head.next;
        while (current != null) {
            if (current.data.equalsIgnoreCase(name)) {
                return true;
            }
            current = current.next;
        }

        return false;
    }

    /*
    Returns a formatted string of the list
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        Node current = head;
        while (current != null) {
            if (current.isLetter) {
                sb.append(current.data).append("\n");
            }
            else {
                sb.append("   ").append(current.data).append("\n");
            }

            current = current.next;
        }

        return sb.toString();
    }

    public NameList() {
        head = null;
    }

    public static void main(String[] args) {
        NameList list = new NameList();

        System.out.println("Add various names:");
        list.add("Greg");
        list.add("Morpheus");
        list.add("George");
        list.add("matthew");
        list.add("Jennifer");
        list.add("Melanie");
        list.add("Jackie");
        list.add("Gordon");
        list.add("Mabel");
        list.add("mcKenzie");
        System.out.println(list.toString());
        System.out.println("----------");

        System.out.println("Remove individual names");
        list.remove("MaBel");
        list.remove("Jennifer");
        list.remove("GrEg");
        System.out.println(list.toString());
        System.out.println("----------");

        System.out.println("Remove the bottommost name of a letter section");
        list.remove("George");
        System.out.println(list.toString());
        System.out.println("----------");

        System.out.println("Remove a letter section with only one name left");
        list.remove("Jackie");
        System.out.println(list.toString());
        System.out.println("----------");

        System.out.println("Remove a letter section");
        list.removeLetter("G");
        System.out.println(list.toString());
        System.out.println("----------");

        System.out.println("Find \"Matthew\" in list? : " + list.find("Matthew"));
        System.out.println("----------");
    }
}

