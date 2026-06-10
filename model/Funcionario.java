package model;

import java.util.Date;
import model.decorator.DepartamentoFolha;
import model.decorator.FolhaPagamento;
import model.decorator.INSSDecorator;
import model.decorator.IRPFDecorator;
import model.decorator.ValeAlimentacaoDecorator;

public class Funcionario {

    private int id_fun;
    private String nome;
    private String cpf;
    private Date dataDeNascimento;
    private Endereco endereco;
    private Date dataDeAdmissao;
    private String genero;
    private String telefone;
    private String email;
    private Departamento departamento;
    
    // Cache em memória dos valores calculados
    private Double salarioBrutoComVale;
    private Double salarioLiquido;

    private Funcionario(FuncionarioBuilder builder) {
        this.id_fun = builder.id_fun;
        this.nome = builder.nome;
        this.cpf = builder.cpf;
        this.dataDeNascimento = builder.dataDeNascimento;
        this.endereco = builder.endereco;
        this.dataDeAdmissao = builder.dataDeAdmissao;
        this.genero = builder.genero;
        this.telefone = builder.telefone;
        this.email = builder.email;
        this.departamento = builder.departamento;
    }

    // GETTERS

    public int getId_Fun() {
        return id_fun;
    }

    public String getNome() {
        return nome;
    }

    public String getCpf() {
        return cpf;
    }

    public Date getDataDeNascimento() {
        return dataDeNascimento;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public Date getDataDeAdmissao() {
        return dataDeAdmissao;
    }

    public String getGenero() {
        return genero;
    }

    public String getTelefone() {
        return telefone;
    }

    public String getEmail() {
        return email;
    }

    public Departamento getDepartamento() {
        return departamento;
    }

    public Departamento getCargo() {
        return departamento;
    }
    
    /**
     * Calcula e retorna o salário bruto com vale alimentação (em cache).
     * O decorator é construído apenas uma vez por requisição.
     * @return Salário bruto + vale alimentação
     */
    public Double getSalarioBrutoComVale() {
        if (salarioBrutoComVale == null && departamento != null) {
            FolhaPagamento folha = new DepartamentoFolha(departamento);
            folha = new ValeAlimentacaoDecorator(folha);
            salarioBrutoComVale = folha.calcularSalario();
        }
        return salarioBrutoComVale;
    }
    
    /**
     * Calcula e retorna o salário líquido com todas as deduções (INSS + IRPF) - em cache.
     * O decorator é construído apenas uma vez por requisição.
     * @return Salário líquido (salário bruto com vale - INSS 11% - IRPF 15%)
     */
    public Double getSalarioLiquido() {
        if (salarioLiquido == null && departamento != null) {
            FolhaPagamento folha = new DepartamentoFolha(departamento);
            folha = new ValeAlimentacaoDecorator(folha);
            folha = new INSSDecorator(folha);
            folha = new IRPFDecorator(folha);
            salarioLiquido = folha.calcularSalario();
        }
        return salarioLiquido;
    }
 

    // BUILDER
    public static class FuncionarioBuilder {

        private int id_fun;
        private String nome;
        private String cpf;
        private Date dataDeNascimento;
        private Endereco endereco;
        private Date dataDeAdmissao;
        private String genero;
        private String telefone;
        private String email;
        private Departamento departamento;

        // CONSTRUTOR OBRIGATÓRIO
        public FuncionarioBuilder(String nome, String cpf, Date dataDeAdmissao, Departamento departamento) {
            this.nome = nome;
            this.cpf = cpf;
            this.dataDeAdmissao = dataDeAdmissao;
            this.departamento = departamento;
        }

        public FuncionarioBuilder id_fun(int id_fun) {
            this.id_fun = id_fun;
            return this;
        }

        public FuncionarioBuilder dataDeNascimento(Date dataDeNascimento) {
            this.dataDeNascimento = dataDeNascimento;
            return this;
        }

        public FuncionarioBuilder endereco(Endereco endereco) {
            this.endereco = endereco;
            return this;
        }

        public FuncionarioBuilder genero(String genero) {
            this.genero = genero;
            return this;
        }

        public FuncionarioBuilder telefone(String telefone) {
            this.telefone = telefone;
            return this;
        }

        public FuncionarioBuilder email(String email) {
            this.email = email;
            return this;
        }

        public Funcionario build() {
            return new Funcionario(this);
        }
    }
}