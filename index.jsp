

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ekko RH - Login</title>
        <meta name="description" content="ekko RH - Gestão de recursos humanos" />
        <style>
            /* ===== Reset ===== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                min-height: 100vh;
                display: flex;
                background-color: #eef1f5;
                color: #0f1a2e;
            }

            /* ===== Painel esquerdo (marca) ===== */
            .brand-panel {
                display: none;
                width: 50%;
                background: linear-gradient(135deg, #0f1a2e, #1a2d4d, #0b1220);
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 3rem;
                position: relative;
                overflow: hidden;
            }

            .brand-panel .glow-top {
                position: absolute;
                top: -120px;
                right: -120px;
                width: 350px;
                height: 350px;
                border-radius: 50%;
                background: rgba(14, 145, 210, 0.12);
                filter: blur(80px);
            }

            .brand-panel .glow-bottom {
                position: absolute;
                bottom: -100px;
                left: -100px;
                width: 280px;
                height: 280px;
                border-radius: 50%;
                background: rgba(14, 145, 210, 0.18);
                filter: blur(80px);
            }

            .brand-content {
                position: relative;
                z-index: 1;
                text-align: center;
            }

            .brand-content h1 {
                font-size: 3rem;
                font-weight: 700;
                color: #f0f4f8;
                letter-spacing: -1px;
            }

            .brand-content h1 span {
                font-weight: 300;
            }

            .brand-content p {
                margin-top: 1rem;
                color: rgba(240, 244, 248, 0.6);
                font-size: 1.1rem;
                max-width: 320px;
                line-height: 1.6;
            }


            .dots {
                display: flex;
                gap: 8px;
                justify-content: center;
                margin-top: 2rem;
            }

            .dots span {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background: #0e91d2;
            }

            .dots span:nth-child(2) {
                opacity: 0.5;
            }
            .dots span:nth-child(3) {
                opacity: 0.25;
            }

            /* ===== Painel direito (formulário) ===== */
            .form-panel {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .form-container {
                width: 100%;
                max-width: 420px;
            }

            .mobile-logo {
                text-align: center;
                margin-bottom: 2rem;
                font-size: 1.8rem;
                font-weight: 700;
                color: #0f1a2e;
            }

            .mobile-logo span {
                font-weight: 300;
            }

            .form-header h2 {
                font-size: 3.0rem;
                font-weight: 600;
                color: #0f1a2e;
                letter-spacing: -0.5px;
            }

            .form-header p {
                margin-top: 0.5rem;
                font-size: 1.0rem;
                color: #6b7a8d;
            }

            /* ===== Formulário ===== */
            form {
                margin-top: 2rem;
            }

            .field {
                margin-bottom: 1.25rem;
            }

            .field label {
                display: block;
                font-size: 0.875rem;
                font-weight: 500;
                color: #0f1a2e;
                margin-bottom: 0.5rem;
            }

            .field input {
                width: 100%;
                height: 48px;
                padding: 0 1rem;
                border: 1px solid #c2cad6;
                border-radius: 10px;
                background: #ffffff;
                font-size: 0.875rem;
                color: #0f1a2e;
                outline: none;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            .field input::placeholder {
                color: #6b7a8d;
            }

            .field input:focus {
                border-color: #0e91d2;
                box-shadow: 0 0 0 3px rgba(14, 145, 210, 0.15);
            }
            /* ===== Botão ===== */
            .btn-primary {
                width: 100%;
                height: 48px;
                border: none;
                border-radius: 10px;
                background: #0f1a2e;
                color: #f0f4f8;
                font-size: 1rem;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.2s;
            }

            .btn-primary:hover {
                background: #1a2d4d;
            }


            /* ===== Responsivo: desktop ===== */
            @media (min-width: 1024px) {
                .brand-panel {
                    display: flex;
                }

                .form-panel {
                    width: 50%;
                }

                .mobile-logo {
                    display: none;
                }
            }
        </style>
    </head>

    <body>
        <!-- Painel esquerdo -->
        <div class="brand-panel">
            <div class="glow-top"></div>
            <div class="glow-bottom"></div>
            <div class="brand-content">
                <h1>ekko <span>RH</span></h1>
                <p>Gestão de recursos humanos simplificada para a sua empresa.</p>
                <div class="dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>

        <!-- Painel direito -->
        <div class="form-panel">
            <div class="form-container">
                <div class="mobile-logo">ekko <span>RH</span></div>

                <div class="form-header">
                    <h2>Entrar na sua conta</h2>
                    <p>Insira suas credenciais para acessar o sistema.</p>
                </div>

                <form action="ManterUsuario" method="post">
                    <input type="hidden" name="btnop" value="UsuarioAutenticarCommand">

                    <div class="field">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" name="email" placeholder="seu@email.com" required />
                    </div>

                    <div class="field">
                        <label for="password">Senha</label>
                        <input type="password" id="password" name="senha" placeholder="••••••••" required />
                    </div>

                    <button type="submit" class="btn-primary">Entrar</button>

                    <%
                        String msg = (String) request.getAttribute("msg");
                        if (msg != null) {
                    %>
                    <p class="error-message"><%= msg%></p>
                    <%
                        }
                    %>
                </form>

            </div>
    </body>
</html>

