package model.decorator;

import model.Departamento;

public class DepartamentoFolha
        implements FolhaPagamento {

    private Departamento departamento;

    public DepartamentoFolha(
            Departamento departamento) {

        this.departamento = departamento;
    }

    @Override
    public double calcularSalario() {

        return departamento.getSalarioBase();
    }
}