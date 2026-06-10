
package model.decorator;

public class IRPFDecorator extends FolhaDecorator {

    private static final double IRPF_RATE = 0.15;

    public IRPFDecorator(FolhaPagamento folha) {
        super(folha);
    }

    @Override
    public double calcularSalario() {
        double salarioBruto = super.calcularSalario();
        return salarioBruto - (salarioBruto * IRPF_RATE);
    }
}
