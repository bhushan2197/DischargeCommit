<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DischargeCommit.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/891/891462.png" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet" />
    
    <style>
        body {
            background: linear-gradient(to right, #2c5364, #203a43, #0f2027);
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-card {
            background: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.3);
            width: 120%;
            max-width: 400px;
            box-sizing: border-box;
        }

        .login-card h2 {
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
        }

        .login-card input[type="text"],
        .login-card input[type="password"],
        .login-card input[type="submit"] {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-sizing: border-box;
        }

        .login-card input[type="submit"] {
            background: linear-gradient(to right, #ff4b2b, #ff416c);
            color: white;
            font-weight: bold;
            cursor: pointer;
            border: none;
            transition: background 0.3s ease;
        }

        .login-card input[type="submit"]:hover {
            background: linear-gradient(to right, #ff416c, #ff4b2b);
        }

        .password-wrapper {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            top: 12px;
            right: 12px;
            cursor: pointer;
            color: #999;
            font-size: 18px;
        }

        .login-footer {
            margin-top: 20px;
            color: #aaa;
            font-size: 12px;
            text-align: center;
        }

        @keyframes focus-pop {
            0% { transform: scale(1); box-shadow: none; }
            50% { transform: scale(1.05); box-shadow: 0 0 10px rgba(255, 75, 43, 0.5); }
            100% { transform: scale(1); box-shadow: none; }
        }

        .login-card input:focus {
            animation: focus-pop 0.4s ease;
            outline: none;
        }

        .captcha-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 15px;
        }

        /* Responsive adjustments */
        @media (max-width: 600px) {
            .login-card {
                padding: 30px 20px;
                width: 90%;
            }

            .toggle-password {
                top: 10px;
                right: 10px;
            }

            .captcha-container img,
            .captcha-container input {
                max-width: 100%;
            }
        }
    </style>

    <script type="text/javascript">
        function togglePassword() {
            var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            var toggleIcon = document.getElementById('togglePasswordIcon');
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleIcon.innerHTML = "🙈";
            } else {
                passwordInput.type = "password";
                toggleIcon.innerHTML = "👁️";
            }
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="login-card">
                    <h2>Login</h2>

                    <asp:TextBox ID="txtUsername" runat="server" AutoComplete="off" Placeholder="Enter Username" MaxLength="6" ClientIDMode="Static" onkeypress="return restrictSpecialChars(event);"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                        ErrorMessage="Username is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

                    <div class="password-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" AutoComplete="off" ClientIDMode="Static" Placeholder="Enter Password" MaxLength="20" onkeypress="return restrictSpecialChars1(event);"></asp:TextBox>
                        <span id="togglePasswordIcon" class="toggle-password" onclick="togglePassword()">👁️</span>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

                    <div class="captcha-container">
                        <asp:Image ID="imgCaptcha" runat="server" />
                        <asp:ImageButton ID="btnRefreshCaptcha" runat="server"
                            ImageUrl="~/Image/refresh1.png"
                            OnClick="btnRefreshCaptcha_Click"
                            Style="width: 40px; height: auto; background: none; padding: 0px;" CausesValidation="false" />
                    </div>

                    <asp:TextBox ID="txtCaptchaAnswer" runat="server" MaxLength="6" ClientIDMode="Static" Placeholder="Enter CAPTCHA" onkeypress="return restrictSpecialChars(event);"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCaptchaAnswer"
                        ErrorMessage="Please enter a captcha" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvCaptchaValidate" runat="server" ControlToValidate="txtCaptchaAnswer"
                        OnServerValidate="OnCaptchaValidate" ErrorMessage="Incorrect CAPTCHA." ForeColor="Red" Display="Dynamic" />

                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />

                    <asp:Label runat="server" ID="lblError" Visible="false" ForeColor="Red"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    <script type="text/javascript">
        function restrictSpecialChars(event) {
            var invalidChars = ['<', '>', '%', '~', '(', ')'];
            var char = String.fromCharCode(event.which || event.keyCode);
            if (invalidChars.includes(char)) {
                event.preventDefault();
                return false;
            }
        }

        function restrictSpecialChars1(event) {
            var invalidChars = ['<', '>', '%', '~', '(', ')'];
            var char = String.fromCharCode(event.which || event.keyCode);
            if (invalidChars.includes(char)) {
                event.preventDefault();
                return false;
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            const loginBtn = document.getElementById("btnLogin");
            ['txtUsername', 'txtPassword', 'txtCaptchaAnswer'].forEach(function (id) {
                const input = document.getElementById(id);
                if (input) {
                    input.addEventListener("keydown", function (event) {
                        if (event.key === "Enter") {
                            event.preventDefault();
                            loginBtn.click();
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>
