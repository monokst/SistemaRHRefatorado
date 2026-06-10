package model.decorator;

public class ValeAlimentacaoDecorator
        extends FolhaDecorator {

    private static final double VALE = 765.00;

    public ValeAlimentacaoDecorator(
            FolhaPagamento folha) {

        super(folha);
    }

    @Override
    public double calcularSalario() {

        return super.calcularSalario()
                + VALE;
    }
}