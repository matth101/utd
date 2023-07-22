public class Printjob implements Comparable<Printjob>{

    private String name;
    private int user_priority; // integer from 1 to 3
    private int numPages;
    private int job_priority;

    public Printjob() {

    }

    public Printjob(String name, int user_priority, int numPages) {
        this.name = name;
        this.user_priority = user_priority;
        this.numPages = numPages;
        this.job_priority = numPages * user_priority;
    }

    public String getUserName() {
        return name;
    }

    public int getPriority() {
        return this.job_priority;
    }

    public int getNumPages() {
        return numPages;
    }

    @Override
    public int compareTo(Printjob o) {
        return Integer.compare(this.job_priority, o.job_priority);
    }

    @Override
    public String toString() {
        return String.format("Name: %-15s Priority: %-5s Pages: %-5s", name, user_priority, numPages);
    }
}