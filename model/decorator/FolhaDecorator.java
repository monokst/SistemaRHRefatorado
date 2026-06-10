package model.decorator;

public abstract class FolhaDecorator
        implements FolhaPagamento {

    protected FolhaPagamento folha;

    public FolhaDecorator(
            FolhaPagamento folha) {

        this.folha = folha;
    }

    @Override
    public double calcularSalario() {

        return folha.calcularSalario();
    }
}