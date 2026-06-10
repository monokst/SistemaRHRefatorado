<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Funcionario"%>
<%@page import="java.text.SimpleDateFormat"%>   <!-- ← IMPORT OBRIGATÓRIO -->

<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Consultar Todos - ekko RH</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

            * { margin: 0; padding: 0; box-sizing: border-box; }
            body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; min-height: 100vh; display: flex; }

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

            /* Main Content */
            .main { margin-left: 250px; flex: 1; padding: 40px 48px; }
            .page-title { font-size: 26px; font-weight: 700; color: #1e293b; margin-bottom: 8px; }
            .page-subtitle { font-size: 14px; color: #64748b; margin-bottom: 32px; }
            .form-card { background: #fff; border-radius: 16px; padding: 30px; box-shadow: 0 1px 3px rgba(0,0,0,0.06); border: 1px solid #e2e8f0; }

            table { width: 100%; border-collapse: collapse; margin-top: 10px; }
            th, td { padding: 14px 16px; text-align: left; border-bottom: 1px solid #e2e8f0; }
            th { background-color: #f8fafc; font-weight: 600; color: #334155; text-transform: uppercase; font-size: 13px; }
            tr:hover { background-color: #f1f5f9; }

            .btn { padding: 6px 14px; border-radius: 8px; font-size: 13px; font-weight: 600; cursor: pointer; border: none; text-decoration: none; display: inline-block; margin: 0 4px; }
            .btn-edit { background: #3b82f6; color: white; }
            .btn-delete { background: #ef4444; color: white; }
            .btn-edit:hover { background: #2563eb; }
            .btn-delete:hover { background: #dc2626; }

            .success-msg { background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
            .error-msg { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
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

        <!-- Main Content -->
        <main class="main">
            <h1 class="page-title">Todos os Funcionários</h1>
            <p class="page-subtitle">Lista completa de funcionários cadastrados</p>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <div class="<%= msg.toLowerCase().contains("sucesso") || msg.toLowerCase().contains("cadastrado") ? "success-msg" : "error-msg"%>">
                <%= msg%>
            </div>
            <%
                }
            %>

            <div class="form-card">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome</th>
                            <th>CPF</th>
                            <th>Cargo</th>
                            <th>Data Admissão</th>
                            <th>Email</th>
                            <th style="text-align: center; width: 180px;">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Funcionario> lista = (List<Funcionario>) request.getAttribute("lista");
                            if (lista != null && !lista.isEmpty()) {
                                for (Funcionario f : lista) {
                        %>
                        <tr>
                            <td><%= f.getId_Fun()%></td>
                            <td><%= f.getNome()%></td>
                            <td><%= f.getCpf() != null ? f.getCpf() : "Não informado" %></td>
                            <td><%= (f.getCargo() != null) ? f.getCargo().getNome() : "Sem cargo"%></td>
                            
                            <!-- ✅ DATA FORMATADA CORRETAMENTE -->
                            <td>
                                <%= (f.getDataDeAdmissao() != null) 
                                    ? new SimpleDateFormat("dd/MM/yyyy").format(f.getDataDeAdmissao()) 
                                    : "-" %>
                            </td>
                            
                            <td><%= f.getEmail() != null ? f.getEmail() : "-" %></td>
                            
                            <td style="text-align: center;">
                                <a href="FuncionarioControllerAtualizar?op=ConsultaByIdFuncionarioAction&view=edit&id_fun=<%= f.getId_Fun()%>" class="btn btn-edit">Editar</a>
                                <a href="FuncionarioControllerPorID?op=ConsultaSalarioAction&id_fun=<%= f.getId_Fun()%>" class="btn btn-edit" style="background: #10b981;">Salário</a>
                                
                                <form action="FuncionarioControllerDeletar" method="post" style="display: inline;">
                                    <input type="hidden" name="op" value="DeletaFuncionarioAction">
                                    <input type="hidden" name="id_fun" value="<%= f.getId_Fun()%>">
                                    <button type="submit" class="btn btn-delete" onclick="return confirm('Tem certeza que deseja excluir este funcionário?')">
                                        Excluir
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 40px; color: #64748b;">
                                Nenhum funcionário encontrado.
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>
    </body>
</html>