<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Funcionario, java.util.*"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ekko RH - Relatórios</title>
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            background-color: #eef1f5;
            color: #0f1a2e;
        }
        /* Sidebar */
        .sidebar {
            width: 260px;
            min-height: 100vh;
            background: linear-gradient(180deg, #0f1a2e, #1a2d4d, #0b1220);
            display: flex;
            flex-direction: column;
            padding: 2rem 1.5rem;
            position: fixed;
            left: 0; top: 0; bottom: 0;
            overflow-y: auto;
            z-index: 10;
        }
        .sidebar .glow-top, .sidebar .glow-bottom {
            position: absolute;
            border-radius: 50%;
            background: rgba(14, 145, 210, 0.12);
            filter: blur(80px);
            pointer-events: none;
        }
        .sidebar .glow-top { top: -80px; right: -80px; width: 250px; height: 250px; }
        .sidebar .glow-bottom { bottom: -60px; left: -60px; width: 200px; height: 200px; }
        .sidebar-logo { font-size: 1.8rem; font-weight: 700; color: #f0f4f8; text-align: center; margin-bottom: 0.5rem; }
        .sidebar-logo span { font-weight: 300; }
        .sidebar-subtitle { text-align: center; color: rgba(240, 244, 248, 0.5); font-size: 0.8rem; margin-bottom: 2.5rem; }
        .sidebar-divider { height: 1px; background: rgba(255,255,255,0.08); margin-bottom: 2rem; }
        .sidebar-section-title { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 1.5px; color: rgba(240,244,248,0.35); margin-bottom: 1rem; }
        .sidebar-nav { list-style: none; display: flex; flex-direction: column; gap: 0.4rem; flex: 1; }
        .sidebar-nav li a { 
            display: flex; align-items: center; gap: 0.75rem; 
            padding: 0.75rem 1rem; border-radius: 10px; 
            color: rgba(240,244,248,0.7); text-decoration: none; 
            font-size: 0.9rem; transition: all 0.2s; 
        }
        .sidebar-nav li a:hover { background: rgba(14,145,210,0.12); color: #f0f4f8; }
        .sidebar-nav li a.active { background: rgba(14,145,210,0.25); color: #f0f4f8; }

        /* Main Content */
        .main-content { 
            margin-left: 260px; 
            flex: 1; 
            padding: 2.5rem 3rem; 
            min-height: 100vh;
            background: #eef1f5;
        }
        .page-header { margin-bottom: 2.5rem; }
        .page-header h1 { font-size: 1.75rem; font-weight: 700; color: #0f1a2e; letter-spacing: -0.5px; }
        .page-header p { margin-top: 0.4rem; color: #6b7a8d; font-size: 0.925rem; }

        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 1.25rem;
            margin-bottom: 2.5rem;
        }
        .kpi-card {
            background: #ffffff;
            border: 1px solid #d8dee6;
            border-radius: 12px;
            padding: 1.5rem;
        }
        .kpi-card-value { font-size: 2rem; font-weight: 700; color: #0f1a2e; letter-spacing: -1px; }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
            margin-bottom: 2.5rem;
        }
        .dashboard-card {
            background: #ffffff;
            border: 1px solid #d8dee6;
            border-radius: 12px;
            padding: 1.75rem;
        }
        .dashboard-card-title {
            font-size: 1.05rem;
            font-weight: 600;
            color: #0f1a2e;
            margin-bottom: 1.25rem;
        }
        .bar-list { display: flex; flex-direction: column; gap: 0.9rem; }
        .bar-item-header { display: flex; justify-content: space-between; align-items: center; }
        .bar-track { width: 100%; height: 10px; background: #eef1f5; border-radius: 6px; overflow: hidden; }
        .bar-fill { height: 100%; border-radius: 6px; transition: width 0.5s ease; }

        .bar-blue   { background: linear-gradient(90deg, #0e91d2, #3bb5e8); }
        .bar-green  { background: linear-gradient(90deg, #16a34a, #4ade80); }
        .bar-purple { background: linear-gradient(90deg, #7c3aed, #a78bfa); }
        .bar-amber  { background: linear-gradient(90deg, #d97706, #fbbf24); }
        .bar-red    { background: linear-gradient(90deg, #dc2626, #f87171); }
        .bar-pink   { background: linear-gradient(90deg, #ec4899, #f472b6); }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="glow-top"></div>
        <div class="glow-bottom"></div>
        <div class="sidebar-logo">ekko <span>RH</span></div>
        <p class="sidebar-subtitle">Gestão de Recursos Humanos</p>
        <div class="sidebar-divider"></div>
        <p class="sidebar-section-title">Menu principal</p>
        <ul class="sidebar-nav">
            <li><a href="homepage.html"><span class="icon">🏠</span> Home</a></li>
            <li><a href="FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction"><span class="icon">👤</span> Funcionários</a></li>
            <li><a href="RelatorioController?op=DASHBOARD" class="active"><span class="icon">📊</span> Relatórios</a></li>
        </ul>
        <div class="sidebar-footer">
            <a href="ManterUsuario?btnop=ManterSair"><span class="icon">🚪</span> Sair</a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <h1>Relatórios</h1>
            <p>Visão geral dos dados de recursos humanos da empresa.</p>
        </div>

        <%
            List<Funcionario> lista = (List<Funcionario>) request.getAttribute("lista");
            int totalFuncionarios = (lista != null) ? lista.size() : 0;

            int masculino = 0, feminino = 0, outro = 0;
            double somaSalarios = 0.0;
            int countSalarios = 0;
            long somaIdades = 0;
            int countIdades = 0;
            Map<String, Integer> porDepartamento = new HashMap<>();

            double somaSalarioMasculino = 0, somaSalarioFeminino = 0, somaSalarioOutro = 0;
            int countMasculino = 0, countFeminino = 0, countOutro = 0;

            if (lista != null) {
                Calendar hoje = Calendar.getInstance();

                for (Funcionario f : lista) {
                    String genero = (f.getGenero() != null) ? f.getGenero().trim().toLowerCase() : "";
                    if (genero.contains("masculino")) masculino++;
                    else if (genero.contains("feminino")) feminino++;
                    else outro++;

                    if (f.getDepartamento() != null) {
                        Double salario = f.getSalarioLiquido();
                        if (salario != null) {
                            somaSalarios += salario;
                            countSalarios++;

                            if (genero.contains("masculino")) {
                                somaSalarioMasculino += salario; countMasculino++;
                            } else if (genero.contains("feminino")) {
                                somaSalarioFeminino += salario; countFeminino++;
                            } else {
                                somaSalarioOutro += salario; countOutro++;
                            }
                        }
                    }

                    if (f.getDataDeNascimento() != null) {
                        Calendar nascimento = Calendar.getInstance();
                        nascimento.setTime(f.getDataDeNascimento());
                        int idade = hoje.get(Calendar.YEAR) - nascimento.get(Calendar.YEAR);
                        somaIdades += idade;
                        countIdades++;
                    }

                    String departamento = (f.getDepartamento() != null && f.getDepartamento().getNome() != null) 
                                   ? f.getDepartamento().getNome() : "Sem departamento";
                    porDepartamento.put(departamento, porDepartamento.getOrDefault(departamento, 0) + 1);
                }
            }

            double mediaSalarial = (countSalarios > 0) ? (somaSalarios / countSalarios) : 0.0;
            double mediaIdade = (countIdades > 0) ? (double) somaIdades / countIdades : 0.0;

            double mediaMasculino = (countMasculino > 0) ? somaSalarioMasculino / countMasculino : 0;
            double mediaFeminino  = (countFeminino > 0)  ? somaSalarioFeminino  / countFeminino  : 0;
            double mediaOutro     = (countOutro > 0)     ? somaSalarioOutro     / countOutro     : 0;
        %>

        <!-- KPI Cards -->
        <div class="kpi-grid">
            <div class="kpi-card">
                <span style="font-size: 0.9rem; color: #64748b;">TOTAL DE FUNCIONÁRIOS</span>
                <div class="kpi-card-value"><%= totalFuncionarios %></div>
            </div>
            <div class="kpi-card">
                <span style="font-size: 0.9rem; color: #64748b;">MÉDIA DE IDADE</span>
                <div class="kpi-card-value"><%= String.format("%.1f", mediaIdade) %> anos</div>
            </div>
            <div class="kpi-card">
                <span style="font-size: 0.9rem; color: #64748b;">MÉDIA SALARIAL</span>
                <div class="kpi-card-value">R$ <%= String.format("%.2f", mediaSalarial) %></div>
            </div>
            <div class="kpi-card">
                <span style="font-size: 0.9rem; color: #64748b;">CARGOS DISTINTOS</span>
                <div class="kpi-card-value"><%= porDepartamento.size() %></div>
            </div>
        </div>

        <!-- Dashboard Grid -->
        <div class="dashboard-grid">
            <!-- Funcionários por Departamento -->
            <div class="dashboard-card">
                <div class="dashboard-card-title">💼 Funcionários por Departamento</div>
                <div class="bar-list">
                    <% 
                        String[] cores = {"bar-blue", "bar-green", "bar-purple", "bar-amber", "bar-red"};
                        int corIndex = 0;
                        for (Map.Entry<String, Integer> entry : porDepartamento.entrySet()) { 
                            int percent = totalFuncionarios > 0 ? (entry.getValue() * 100 / totalFuncionarios) : 0;
                            String corAtual = cores[corIndex % cores.length];
                            corIndex++;
                    %>
                    <div class="bar-item">
                        <div class="bar-item-header">
                            <span><%= entry.getKey() %></span>
                            <span><%= entry.getValue() %></span>
                        </div>
                        <div class="bar-track">
                            <div class="bar-fill <%= corAtual %>" style="width: <%= percent %>%"></div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Distribuição por Gênero - GRÁFICO DE PIZZA -->
            <div class="dashboard-card">
                <div class="dashboard-card-title">⚧ Distribuição por Gênero</div>
                <div style="display:flex; align-items:center; justify-content:center; gap: 30px; margin: 20px 0;">
                    <!-- Pizza -->
                    <div style="width: 180px; height: 180px; border-radius: 50%; 
                                background: conic-gradient(#0e91d2 0% <%= (masculino*100.0/totalFuncionarios) %>%, 
                                #ec4899 <%= (masculino*100.0/totalFuncionarios) %>% <%= (masculino+feminino)*100.0/totalFuncionarios %>%, 
                                #8b5cf6 <%= (masculino+feminino)*100.0/totalFuncionarios %>% 100%); 
                                position: relative;">
                        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); 
                                    width: 90px; height: 90px; background: #ffffff; border-radius: 50%;"></div>
                    </div>
                    
                    <!-- Legenda -->
                    <div style="line-height: 2;">
                        <div><span style="display:inline-block; width:14px; height:14px; background:#0e91d2; border-radius:50%;"></span> Masculino: <%= masculino %> (<%= totalFuncionarios > 0 ? String.format("%.1f", masculino*100.0/totalFuncionarios) : 0 %>%)</div>
                        <div><span style="display:inline-block; width:14px; height:14px; background:#ec4899; border-radius:50%;"></span> Feminino: <%= feminino %> (<%= totalFuncionarios > 0 ? String.format("%.1f", feminino*100.0/totalFuncionarios) : 0 %>%)</div>
                        <div><span style="display:inline-block; width:14px; height:14px; background:#8b5cf6; border-radius:50%;"></span> Outro: <%= outro %> (<%= totalFuncionarios > 0 ? String.format("%.1f", outro*100.0/totalFuncionarios) : 0 %>%)</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Média Salarial por Gênero -->
        <div class="dashboard-card" style="margin-top: 2rem;">
            <div class="dashboard-card-title">💰 Média Salarial por Gênero</div>
            <div class="bar-list">
                <div class="bar-item">
                    <div class="bar-item-header"><span>👨 Masculino</span><span>R$ <%= String.format("%.2f", mediaMasculino) %></span></div>
                    <div class="bar-track"><div class="bar-fill bar-blue" style="width: <%= Math.min(100, (mediaMasculino / 15000)*100) %>%"></div></div>
                </div>
                <div class="bar-item">
                    <div class="bar-item-header"><span>👩 Feminino</span><span>R$ <%= String.format("%.2f", mediaFeminino) %></span></div>
                    <div class="bar-track"><div class="bar-fill bar-pink" style="width: <%= Math.min(100, (mediaFeminino / 15000)*100) %>%"></div></div>
                </div>
                <div class="bar-item">
                    <div class="bar-item-header"><span>⚧ Outro</span><span>R$ <%= String.format("%.2f", mediaOutro) %></span></div>
                    <div class="bar-track"><div class="bar-fill bar-purple" style="width: <%= Math.min(100, (mediaOutro / 15000)*100) %>%"></div></div>
                </div>
            </div>
        </div>

    </main>
</body>
</html>