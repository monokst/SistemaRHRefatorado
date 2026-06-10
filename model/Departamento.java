package model;

public class Departamento {
        private int id_departamento;
        private String nome;
        private String funcao;
        private double salarioBase;

      
        public Departamento() {
        }

        public Departamento(int id_departamento, String nome, String funcao, double salarioBase) {
            this.id_departamento = id_departamento;
            this.nome = nome;
            this.funcao = funcao;
            this.salarioBase = salarioBase;
        }

        public int getId_departamento() {
            return id_departamento;
        }

        public String getNome() {
            return nome;
        }

        public String getFuncao() {
            return funcao;
        }

        public double getSalarioBase() {
            return salarioBase;
        }

        public void setId_departamento(int id_departamento) {
            this.id_departamento = id_departamento;
        }

        public void setNome(String nome) {
            this.nome = nome;
        }

        public void setFuncao(String funcao) {
            this.funcao = funcao;
        }

        public void setSalarioBase(double salarioBase) {
            this.salarioBase = salarioBase;
        }

    }
