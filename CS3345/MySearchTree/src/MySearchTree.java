import java.util.*;

public class MySearchTree<T extends Comparable<? super T>> {

    private static class Node<T> {
        T data;
        Node<T> left, right;
        Node(T data) {
            this.data = data;
            left = null;
            right = null;
        }
    }

    private Node<T> root;

    public MySearchTree(T value) {
        root = new Node<T>(value);
    }

    /*
    Adds a node to the tree containing the passed value.
     */
    public Node<T> add(Node<T> current, T data) {
        if (current == null) {
            return new Node<>(data); // new node essentially "bubbles" up and gets attached
        }

        if (data.compareTo(current.data) < 0) {
            current.left = add(current.left, data);
        }
        else if (data.compareTo(current.data) > 0) {
            current.right = add(current.right, data);
        }

        return current; // the provided data is already in the tree (compareTo returned 0)
    }

    /*
    Returns true if the value passed is in the tree.
     */
    public boolean find(Node<T> current, T data) {
        if (current == null) {
            return false;
        }

        int compareResult = data.compareTo(current.data);
        if (compareResult == 0) {
            return true;
        }

        if (compareResult < 0) {
            return find(current.left, data); // go down left subtree
        } else {
            return find(current.right, data); // down right subtree
        }
    }

    /*
    Returns the count of all the leaves in the tree
     */
    public int leafCount(Node<T> current) {
        int count = 0;

        if (current == null) {
            return 0;
        }
        else if (current.left == null && current.right == null ) { // check if leaf
            return 1;
        }
        else {
            return leafCount(current.left) + leafCount(current.right);
        }
    }

    /*
    Returns the count of all of the parents in the tree.
     */
    public int parentCount(Node<T> current) {
        if (current == null || (current.left == null && current.right == null)) {
            return 0; // if it is null or a leaf, skip this node
        } else {
            return 1 + parentCount(current.left) + parentCount(current.right);
        }
    }

    /*
    Returns the height of the tree.
     */
    public int height(Node<T> current) {
        if (current == null) {
            return -1; // if tree is empty
        } else {
            int leftHeight = height(current.left);
            int rightHeight = height(current.right);
            return 1 + Math.max(leftHeight, rightHeight);
        }
    }

    /*
    Returns true if the tree is a perfect tree.
        (A perfect tree is filled at every level).
     */
    public boolean isPerfect(Node<T> current) { // use height() on subtrees and make sure they're equivalent
        if (current == null) {
            return true;
        }

        int left = height(current.left);
        int right = height(current.right);

        if (left != right)
            return false;

        return isPerfect(current.left) && isPerfect(current.right);
    }

    /*
    Returns the ancestor values of the passed value.
     */
    public ArrayList<Node<T>> ancestors(Node<T> current, T value, ArrayList<Node<T>> ancestors) { // use similar logic to find()
        if (current.data == value) {
            return ancestors;
        }

        ancestors.add(current);

        int compareResult = value.compareTo(current.data);
        if (compareResult < 0) {
            return ancestors(current.left, value, ancestors); // go down left subtree
        } else {
            return ancestors(current.right, value, ancestors); // down right subtree
        }
    }

    /*
    Prints node values using an inorder traversal.
     */
    public void inOrderPrint(Node<T> current) {
        if (current == null)
            return;

        inOrderPrint(current.left);
        System.out.print(current.data + " ");
        inOrderPrint(current.right);
    }

    /*
    Prints node values using a preorder traversal.
     */
    public void preOrderPrint(Node<T> current) {
        if (current == null)
            return;

        System.out.print(current.data + " ");
        preOrderPrint(current.left);
        preOrderPrint(current.right);
    }

    public static void main(String[] args) {
        // Create tree storing various integers
        MySearchTree<Integer> tree = new MySearchTree<>(8);
        tree.add(tree.root, 5);
        tree.add(tree.root, 9);
        tree.add(tree.root, 2);
        tree.add(tree.root, 10);
        tree.add(tree.root, 13);
        tree.add(tree.root, 4);
        tree.add(tree.root, 1);

        System.out.print("Inorder traversal: ");
        tree.inOrderPrint(tree.root);
        System.out.println();
        System.out.print("Preorder traversal: ");
        tree.preOrderPrint(tree.root);
        System.out.println("\n");

        System.out.println("The tree contains 3 : " + tree.find(tree.root, 3));
        System.out.println("The tree contains 13 : " + tree.find(tree.root, 13));

        System.out.println();
        System.out.println("The tree contains: " + tree.leafCount(tree.root) + " leaves");
        System.out.println("The tree contains: " + tree.parentCount(tree.root) + " parents");

        System.out.println();
        System.out.println("The tree has a height of: " + tree.height(tree.root));
        System.out.println("The tree is perfect : " + tree.isPerfect(tree.root));
        System.out.println();

        ArrayList<Node<Integer>> ancestors = new ArrayList<>();
        ancestors = tree.ancestors(tree.root, 1, ancestors);
        System.out.println("These are the ancestors of the value 1, from root to bottom: ");
        for (Node<Integer> node : ancestors) {
            System.out.print(node.data + " ");
        }
        System.out.println();
    }
}
