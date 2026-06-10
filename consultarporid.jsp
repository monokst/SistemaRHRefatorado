<%-- consultarporid.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Funcionario"%>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar por ID - ekko RH</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
        }

        /* ========== Sidebar ========== */
            .sidebar { width: 250px; background-color: #1e293b; color: #fff; display: flex; flex-direction: column; min-height: 100vh; position: fixed; top: 0; left: 0; }
            .sidebar-header { padding: 24px 20px; border-bottom: 1px solid rgba(255,255,255,0.08); }
            .sidebar-header h1 { font-size: 20px; font-weight: 700; }
            .sidebar-header h1 span { color: #818cf8; }
            .sidebar-header p { font-size: 11px; color: #94a3b8; margin-top: 2px; }
            .sidebar-label { font-size: 10px; text-transform: uppercase; letter-spacing: 1.5px; color: #64748b; padding: 24px 20px 8px; }
            .sidebar-nav { list-style: none; padding: 10px; }
            .sidebar-nav li a { display: flex; align-items: center; gap: 10px; padding: 10px 14px; color: #cbd5e1; text-decoration: none; font-size: 14px; border-radius: 8px; transition: background 0.2s; }
            .sidebar-nav li a:hover { background: rgba(255,255,255,0.06); }
            .sidebar-nav li a.active { background: #3b82f6; color: #fff; }
            .sidebar-nav li a .icon { width: 18px; text-align: center; }
            .sidebar-footer { margin-top: auto; padding: 20px; border-top: 1px solid rgba(255,255,255,0.08); }
            .sidebar-footer a { color: #ef4444; text-decoration: none; font-size: 14px; display: flex; align-items: center; gap: 8px; }

        /* Main */
        .main {
            margin-left: 250px;
            flex: 1;
            padding: 40px 48px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .page-title { font-size: 26px; font-weight: 700; color: #1e293b; }
        .page-subtitle { font-size: 14px; color: #64748b; margin-bottom: 32px; }

        .form-card {
            background: #fff;
            border-radius: 16px;
            padding: 36px 40px;
            width: 100%;
            max-width: 780px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            border: 1px solid #e2e8f0;
        }

      
        .result-container {
            background: #f8fafc;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            margin-top: 25px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-item {
            margin-bottom: 18px;
        }

        .info-label {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 4px;
            font-weight: 500;
        }

        .info-value {
            font-size: 15px;
            color: #1e293b;
            font-weight: 500;
        }

        .full-width { grid-column: 1 / -1; }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            border: none;
            font-weight: 600;
        }

        .btn-edit { background: #3b82f6; color: white; }
        .btn-delete { background: #ef4444; color: white; }
        .btn-edit:hover { background: #2563eb; }
        .btn-delete:hover { background: #dc2626; }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h1><span>ekko</span> RH</h1>
            <p>Gestão de Recursos Humanos</p>
        </div>
        <div class="sidebar-label">Menu Principal</div>
        <ul class="sidebar-nav">
            <li><a href="homepage.html"><span class="icon">🏠</span> Home</a></li>
            <li><a href="FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction" class="active"><span class="icon">👤</span> Funcionários</a></li>
            <li><a href="RelatorioController?op=DASHBOARD"><span class="icon">📊</span> Relatórios</a></li>
        </ul>
        <div class="sidebar-footer">
            <a href="ManterUsuario?btnop=ManterSair">🚪 Sair</a>
        </div>
    </aside>

    <!-- Main -->
    <main class="main">
        <h1 class="page-title">Consultar por ID</h1>
        <p class="page-subtitle">Digite o ID para buscar o funcionário</p>

        <div class="form-card">
            <form action="FuncionarioControllerPorID" method="get">
                <input type="hidden" name="op" value="ConsultaByIdFuncionarioAction">
                <div class="form-group">
                    <label for="id_fun">ID do Funcionário</label>
                    <input type="text" id="id_fun" name="id_fun" placeholder="1" required>
                </div>

                <div class="form-actions" style="text-align: right; margin-top: 20px;">
                    <button type="submit" class="btn btn-primary">Consultar</button>
                </div>
            </form>

            <%
                Funcionario f = (Funcionario) request.getAttribute("funcionario");
                String mensagem = (String) request.getAttribute("msg");

                if (mensagem != null) {
            %>
                <div class="alert" style="background: #fee2e2; color: #991b1b;">
                    <%= mensagem %>
                </div>
            <%
                } else if (f != null) {
            %>
                <div class="result-container">
                    <h3 style="margin-bottom: 20px;">Dados do Funcionário</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">ID</div>
                            <div class="info-value"><%= f.getId_Fun() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Nome</div>
                            <div class="info-value"><%= f.getNome() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">CPF</div>
                            <div class="info-value"><%= f.getCpf() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Data de Nascimento</div>
                            <div class="info-value"><%= f.getDataDeNascimento() != null ? f.getDataDeNascimento() : "-" %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Gênero</div>
                            <div class="info-value"><%= f.getGenero() != null ? f.getGenero() : "-" %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Telefone</div>
                            <div class="info-value"><%= f.getTelefone() != null ? f.getTelefone() : "-" %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">E-mail</div>
                            <div class="info-value"><%= f.getEmail() != null ? f.getEmail() : "-" %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Data de Admissão</div>
                            <div class="info-value"><%= f.getDataDeAdmissao() != null ? f.getDataDeAdmissao() : "-" %></div>
                        </div>

                        <% if (f.getDepartamento() != null) { %>
                        <div class="info-item">
                            <div class="info-label">Cargo</div>
                            <div class="info-value"><%= f.getDepartamento().getNome() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Função</div>
                            <div class="info-value"><%= f.getDepartamento().getFuncao() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Salário Base</div>
                            <div class="info-value">R$ <%= f.getDepartamento().getSalarioBase() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Salário Bruto (com Vale)</div>
                            <div class="info-value">R$ <%= String.format("%.2f", f.getSalarioBrutoComVale()) %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Salário Líquido</div>
                            <div class="info-value">R$ <%= String.format("%.2f", f.getSalarioLiquido()) %></div>
                        </div>
                        <% } %>

                        <% if (f.getEndereco() != null) { %>
                        <div class="info-item full-width" style="grid-column: 1 / -1;">
                            <div class="info-label">Endereço Completo</div>
                            <div class="info-value">
                                <%= f.getEndereco().getRua() %>, <%= f.getEndereco().getBairro() %><br>
                                <%= f.getEndereco().getCidade() %> - <%= f.getEndereco().getEstado() %><br>
                                CEP: <%= f.getEndereco().getCep() %>
                            </div>
                        </div>
                        <% } %>
                    </div>

                    <!-- Botões de Ação -->
                    <div style="margin-top: 25px; display: flex; gap: 10px;">
                        <a href="FuncionarioControllerAtualizar?op=ConsultaByIdFuncionarioAction&view=edit&id_fun=<%= f.getId_Fun() %>" class="btn btn-edit">Editar</a>
                        <a href="FuncionarioControllerPorID?op=ConsultaSalarioAction&id_fun=<%= f.getId_Fun() %>" class="btn btn-edit" style="background: #10b981;">Ver Salário</a>
                        <form action="FuncionarioControllerDeletar" method="post" style="display: inline;">
                            <input type="hidden" name="op" value="DeletaFuncionarioAction">
                            <input type="hidden" name="id_fun" value="<%= f.getId_Fun() %>">
                            <button type="submit" class="btn btn-delete" onclick="return confirm('Tem certeza que deseja excluir este funcionário?')">Excluir</button>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>
    </main>
</body>
</html>