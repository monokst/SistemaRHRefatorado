<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Funcionario" %>
<%@ page import="model.decorator.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>ekko RH - Cálculo de Salário</title>
  <meta name="description" content="ekko RH - Cálculo detalhado de salário do funcionário" />
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      min-height: 100vh;
      display: flex;
      background-color: #eef1f5;
      color: #0f1a2e;
    }

    /* ===== Sidebar ===== */
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
    .sidebar .glow-top {
      position: absolute; top: -80px; right: -80px;
      width: 250px; height: 250px; border-radius: 50%;
      background: rgba(14, 145, 210, 0.12); filter: blur(80px); pointer-events: none;
    }
    .sidebar .glow-bottom {
      position: absolute; bottom: -60px; left: -60px;
      width: 200px; height: 200px; border-radius: 50%;
      background: rgba(14, 145, 210, 0.18); filter: blur(80px); pointer-events: none;
    }
    .sidebar-logo {
      font-size: 1.8rem; font-weight: 700; color: #f0f4f8;
      text-align: center; margin-bottom: 0.5rem; position: relative; z-index: 1;
    }
    .sidebar-logo span { font-weight: 300; }
    .sidebar-subtitle {
      text-align: center; color: rgba(240, 244, 248, 0.5);
      font-size: 0.8rem; margin-bottom: 2.5rem; position: relative; z-index: 1;
    }
    .sidebar-divider { height: 1px; background: rgba(255,255,255,0.08); margin-bottom: 2rem; }
    .sidebar-section-title {
      font-size: 0.7rem; text-transform: uppercase; letter-spacing: 1.5px;
      color: rgba(240, 244, 248, 0.35); margin-bottom: 1rem; position: relative; z-index: 1;
    }
    .sidebar-nav {
      list-style: none; display: flex; flex-direction: column; gap: 0.4rem;
      position: relative; z-index: 1; flex: 1;
    }
    .sidebar-nav li a {
      display: flex; align-items: center; gap: 0.75rem;
      padding: 0.75rem 1rem; border-radius: 10px;
      color: rgba(240,244,248,0.7); text-decoration: none; font-size: 0.9rem;
      transition: background 0.2s, color 0.2s;
    }
    .sidebar-nav li a:hover { background: rgba(14,145,210,0.12); color: #f0f4f8; }
    .sidebar-nav li a.active { background: rgba(14,145,210,0.18); color: #f0f4f8; }
    .sidebar-nav li a .icon {
      width: 20px; height: 20px; display: flex;
      align-items: center; justify-content: center; font-size: 1rem;
    }
    .sidebar-footer { margin-top: auto; padding-top: 2rem; position: relative; z-index: 1; }
    .sidebar-footer a {
      display: flex; align-items: center; gap: 0.75rem;
      padding: 0.75rem 1rem; border-radius: 10px;
      color: rgba(240,244,248,0.5); text-decoration: none; font-size: 0.875rem;
      transition: background 0.2s, color 0.2s;
    }
    .sidebar-footer a:hover { background: rgba(255,255,255,0.05); color: #f0f4f8; }

    /* ===== Conteúdo principal ===== */
    .main-content {
      margin-left: 260px;
      flex: 1;
      padding: 2.5rem 3rem;
      min-height: 100vh;
    }
    .page-header { margin-bottom: 2.5rem; }
    .page-header h1 {
      font-size: 1.75rem; font-weight: 700; color: #0f1a2e; letter-spacing: -0.5px;
    }
    .page-header p { margin-top: 0.4rem; color: #6b7a8d; font-size: 0.925rem; }

    .container { max-width: 720px; }

    .card {
      background: #ffffff;
      border: 1px solid #d8dee6;
      border-radius: 12px;
      padding: 2rem;
      box-shadow: 0 4px 20px rgba(15, 26, 46, 0.04);
    }

    .employee-info {
      background: #f5f7fa;
      border-left: 4px solid #0f1a2e;
      padding: 1.25rem 1.5rem;
      border-radius: 10px;
      margin-bottom: 2rem;
    }
    .info-row {
      display: flex; justify-content: space-between;
      margin-bottom: 0.75rem; font-size: 0.875rem;
    }
    .info-row:last-child { margin-bottom: 0; }
    .info-label { color: #6b7a8d; font-weight: 600; }
    .info-value { color: #0f1a2e; font-weight: 500; }

    .salary-section { margin-bottom: 1.75rem; }
    .section-title {
      font-size: 0.7rem; font-weight: 700;
      text-transform: uppercase; letter-spacing: 1.5px;
      color: #6b7a8d; margin-bottom: 0.875rem;
      border-bottom: 1px solid #e1e6ee; padding-bottom: 0.625rem;
    }
    .salary-line {
      display: flex; justify-content: space-between;
      padding: 0.75rem 0; border-bottom: 1px solid #eef1f5;
      font-size: 0.9rem;
    }
    .salary-line:last-child { border-bottom: none; }

    .salary-line.total {
      background: rgba(14, 145, 210, 0.08);
      padding: 0.875rem 1rem;
      border-radius: 10px;
      font-weight: 700;
      border: none;
      margin-top: 0.625rem;
    }
    .salary-line.total .label { color: #0e91d2; font-size: 0.95rem; }
    .salary-line.total .value { color: #0e91d2; font-size: 0.95rem; }

    .label { color: #475569; }
    .value { color: #0f1a2e; font-weight: 600; }
    .value.discount { color: #dc2626; }
    .value.bonus { color: #16a34a; }

    .salary-line.net {
      background: linear-gradient(135deg, #0f1a2e, #1a2d4d);
      color: #f0f4f8;
      padding: 1.125rem 1.25rem;
      border-radius: 10px;
      font-weight: 700;
      border: none;
    }
    .salary-line.net .label,
    .salary-line.net .value { color: #f0f4f8; font-size: 1rem; }

    .note {
      background: rgba(245, 158, 11, 0.08);
      border-left: 4px solid #d97706;
      padding: 1rem 1.125rem;
      border-radius: 8px;
      margin-top: 1.5rem;
      font-size: 0.825rem;
      color: #92400e;
      line-height: 1.5;
    }

    .back-btn {
      display: inline-block;
      margin-top: 1.5rem;
      padding: 0.75rem 1.5rem;
      background: #0f1a2e;
      color: #f0f4f8;
      text-decoration: none;
      border-radius: 10px;
      font-weight: 500;
      font-size: 0.875rem;
      transition: background 0.2s, transform 0.1s;
    }
    .back-btn:hover { background: #1a2d4d; }
    .back-btn:active { transform: scale(0.98); }

    .error-card { text-align: center; padding: 3rem 2rem; }
    .error-card h2 { color: #dc2626; margin-bottom: 0.5rem; }
    .error-card p { color: #6b7a8d; margin-bottom: 1.25rem; font-size: 0.925rem; }

    /* ===== Mobile ===== */
    .mobile-header {
      display: none; align-items: center; justify-content: space-between;
      padding: 1rem 1.5rem;
      background: linear-gradient(135deg, #0f1a2e, #1a2d4d);
      color: #f0f4f8;
    }
    .mobile-header h1 { font-size: 1.4rem; font-weight: 700; }
    .mobile-header h1 span { font-weight: 300; }
    .hamburger {
      background: none; border: none; color: #f0f4f8;
      font-size: 1.5rem; cursor: pointer; padding: 0.25rem;
    }

    @media (max-width: 768px) {
      .sidebar { display: none; }
      .mobile-header { display: flex; }
      .main-content { margin-left: 0; padding: 1.5rem; }
      .card { padding: 1.5rem; }
    }
  </style>
</head>
<body>
  <!-- Header mobile -->
  <div class="mobile-header">
    <h1>ekko <span>RH</span></h1>
    <button class="hamburger">☰</button>
  </div>

  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="glow-top"></div>
    <div class="glow-bottom"></div>

    <div class="sidebar-logo">ekko <span>RH</span></div>
    <p class="sidebar-subtitle">Gestão de Recursos Humanos</p>

    <div class="sidebar-divider"></div>

    <p class="sidebar-section-title">Menu principal</p>

    <ul class="sidebar-nav">
      <li><a href="home.html"><span class="icon">🏠</span> Home</a></li>
      <li><a href="#" class="active"><span class="icon">👤</span> Funcionários</a></li>
      <li><a href="relatorios.jsp"><span class="icon">📊</span> Relatórios</a></li>
    </ul>

    <div class="sidebar-footer">
      <div class="sidebar-divider"></div>
      <a href="/"><span class="icon">🚪</span> Sair</a>
    </div>
  </aside>

  <!-- Conteúdo principal -->
  <main class="main-content">
    <%
      Funcionario f = (Funcionario) request.getAttribute("funcionario");

      if (f == null) {
    %>
      <div class="container">
        <div class="card error-card">
          <h2>Erro</h2>
          <p>Funcionário não encontrado.</p>
          <a href="FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction" class="back-btn">← Voltar</a>
        </div>
      </div>
    <%
      } else {
        Double salarioBase = f.getDepartamento() != null ? f.getDepartamento().getSalarioBase() : 0;
        Double salarioBrutoComVale = f.getSalarioBrutoComVale();
        Double inss = salarioBrutoComVale != null ? (salarioBrutoComVale * 0.11) : 0;
        Double irpf = salarioBrutoComVale != null ? ((salarioBrutoComVale - inss) * 0.15) : 0;
        Double salarioLiquido = f.getSalarioLiquido();
    %>
      <div class="page-header">
        <h1>Cálculo de Salário</h1>
        <p><%= f.getNome() %></p>
      </div>

      <div class="container">
        <div class="card">
          <!-- Informações do Funcionário -->
          <div class="employee-info">
            <div class="info-row">
              <span class="info-label">ID:</span>
              <span class="info-value">#<%= f.getId_Fun() %></span>
            </div>
            <div class="info-row">
              <span class="info-label">CPF:</span>
              <span class="info-value"><%= f.getCpf() %></span>
            </div>
            <div class="info-row">
              <span class="info-label">Departamento:</span>
              <span class="info-value"><%= f.getDepartamento() != null ? f.getDepartamento().getNome() : "-" %></span>
            </div>
            <div class="info-row">
              <span class="info-label">Função:</span>
              <span class="info-value"><%= f.getDepartamento() != null ? f.getDepartamento().getFuncao() : "-" %></span>
            </div>
          </div>

          <!-- Salário Base -->
          <div class="salary-section">
            <div class="section-title">📊 Base de Cálculo</div>
            <div class="salary-line">
              <span class="label">Salário Base</span>
              <span class="value">R$ <%= String.format("%.2f", salarioBase) %></span>
            </div>
          </div>

          <!-- Bônus/Adições -->
          <div class="salary-section">
            <div class="section-title">➕ Bônus e Adições</div>
            <div class="salary-line">
              <span class="label">Vale Alimentação</span>
              <span class="value bonus">+ R$ 765.00</span>
            </div>
            <div class="salary-line total">
              <span class="label">Salário Bruto</span>
              <span class="value">R$ <%= String.format("%.2f", salarioBrutoComVale) %></span>
            </div>
          </div>

          <!-- Descontos -->
          <div class="salary-section">
            <div class="section-title">➖ Descontos</div>
            <div class="salary-line">
              <span class="label">INSS (11%)</span>
              <span class="value discount">- R$ <%= String.format("%.2f", inss) %></span>
            </div>
            <div class="salary-line">
              <span class="label">IRPF (15%)</span>
              <span class="value discount">- R$ <%= String.format("%.2f", irpf) %></span>
            </div>
          </div>

          <!-- Salário Líquido -->
          <div class="salary-section">
            <div class="salary-line net">
              <span class="label">💵 Salário Líquido</span>
              <span class="value">R$ <%= String.format("%.2f", salarioLiquido) %></span>
            </div>
          </div>

          <!-- Nota -->
          <div class="note">
            <strong>ℹ️ Informação:</strong> Este cálculo é referente ao padrão mensal. Os valores de INSS (11%) e IRPF (15%) são descontos federais obrigatórios.
          </div>

          <a href="FuncionarioControllerConsultarTodos?op=ConsultaTodosFuncionarioAction" class="back-btn">← Voltar para Funcionários</a>
        </div>
      </div>
    <%
      }
    %>
  </main>
</body>
</html>
