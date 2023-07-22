import java.text.NumberFormat;

public class OutsidePrintjob extends Printjob {
    public double cost; // in cents

    public OutsidePrintjob(String name, int priority, int pages) {
        super(name, priority, pages);
        this.cost = super.getNumPages() * 0.1;
    }

    public double getCost() {
        return this.cost;
    }

    @Override
    public String toString() {
        NumberFormat nf = NumberFormat.getCurrencyInstance();
        return super.toString() + "  Cost: " + nf.format(cost);
    }
}