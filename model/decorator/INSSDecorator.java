/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.decorator;

public class INSSDecorator extends FolhaDecorator {

    private static final double INSS_RATE = 0.11;

    public INSSDecorator(FolhaPagamento folha) {
        super(folha);
    }

    @Override
    public double calcularSalario() {
        double salarioBruto = super.calcularSalario();
        return salarioBruto - (salarioBruto * INSS_RATE);
    }
}
