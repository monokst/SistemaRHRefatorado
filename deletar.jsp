<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deletar Funcionário - ekko RH</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
        }
        /* Sidebar (mesma das outras páginas) */
        .sidebar { width: 250px; background: #1e293b; color: #fff; position: fixed; top: 0; left: 0; height: 100vh; display: flex; flex-direction: column; }
        .sidebar-header { padding: 24px 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-header h1 { font-size: 20px; font-weight: 700; }
        .sidebar-header h1 span { color: #818cf8; }
        .sidebar-label { font-size: 10px; text-transform: uppercase; letter-spacing: 1.5px; color: #64748b; padding: 24px 20px 8px; }
        .sidebar-nav { list-style: none; padding: 10px; }
        .sidebar-nav li a { display: flex; align-items: center; gap: 10px; padding: 12px 16px; color: #cbd5e1; text-decoration: none; border-radius: 8px; }
        .sidebar-nav li a:hover, .sidebar-nav li a.active { background: #3b82f6; color: white; }

        .main { margin-left: 250px; flex: 1; padding: 40px; }
        .form-card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            max-width: 480px;
            margin: 0 auto;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .btn {
            padding: 12px 28px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            border: none;
        }
        .btn-outline { background: transparent; border: 1px solid #e2e8f0; color: #64748b; }
        .btn-danger { background: #ef4444; color: white; }
        .btn-danger:hover { background: #dc2626; }
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
            <li><a href="homepage.html">🏠 Home</a></li>
            <li><a href="FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction" class="active">👤 Funcionários</a></li>
            <li><a href="RelatorioController?op=DASHBOARD">📊 Relatórios</a></li>
        </ul>
        <div class="sidebar-footer" style="margin-top:auto; padding:20px;">
            <a href="ManterUsuario?btnop=ManterSair">🚪 Sair</a>
        </div>
    </aside>

    <main class="main">
        <h1 style="text-align:center; margin-bottom:8px;">Deletar Funcionário</h1>
        <p style="text-align:center; color:#64748b; margin-bottom:30px;">Esta ação não pode ser desfeita.</p>

        <div class="form-card">
            <form action="FuncionarioControllerDeletar" method="post">
                <input type="hidden" name="op" value="DeletaFuncionarioAction">

                <div style="margin-bottom:20px;">
                    <label style="display:block; margin-bottom:6px; font-weight:500;">ID do Funcionário</label>
                    <input type="number" name="id_fun" placeholder="Ex: 5" required 
                           style="width:100%; padding:12px; border:1px solid #e2e8f0; border-radius:10px;">
                </div>

                <div style="display:flex; gap:12px; justify-content:flex-end;">
                    <a href="FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction" 
                       class="btn btn-outline">Voltar</a>
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('⚠️ Tem certeza que deseja deletar este funcionário?')">
                        Deletar Funcionário
                    </button>
                </div>
            </form>
        </div>
    </main>

    
    <%
        String msg = (String) request.getAttribute("msg");
        Boolean sucesso = (Boolean) request.getAttribute("sucesso");
        if (msg != null) {
    %>
    <script>
        alert("<%= msg %>");
        <% if (sucesso != null && sucesso) { %>
            window.location.href = "FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction";
        <% } %>
    </script>
    <% } %>
</body>
</html>