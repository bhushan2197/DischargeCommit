<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dis_decommit.aspx.cs" Inherits="DischargeCommit.Dis_decommit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Discharge Commit</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #e0e0e0;
            margin: 0;
            padding: 0;
        }

        .topbar {
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

            .topbar img {
                height: 40px;
            }

            .topbar .nav {
                display: flex;
                gap: 20px;
                align-items: center;
            }

                .topbar .nav a {
                    color: white;
                    text-decoration: none;
                    font-size: 16px;
                }

                    .topbar .nav a:hover {
                        text-decoration: underline;
                    }

        .btn-logout {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .main-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            /*height: calc(100vh - 70px);*/
            height: calc(105vh - 130px);
            margin-top: 15px
        }

        .card {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 500px;
        }

        .header {
            text-align: center;
            font-size: 27px;
            font-weight: bold;
            color: #333333;
            margin-bottom: 30px;
        }

        .input-group {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        input[type="text"] {
            flex: 1;
            padding: 10px 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .btn-search {
            background-color: #2196F3;
            color: white;
        }

            .btn-search:hover {
                background-color: #1976D2;
            }

        .btn-commit {
            background-color: #1c8e21;
            color: white;
        }

            .btn-commit:hover {
                background-color: #073109;
            }

        .btn-clear {
            background-color: #f44336;
            color: white;
        }

            .btn-clear:hover {
                background-color: #d32f2f;
            }
    </style>

    <script type="text/javascript">
        function Case_No_Pad() {

            csNo = document.getElementById('txtCaseNo');
            num = document.getElementById('txtCaseNo').value;

            if (num === "") {
                return;
            }


            var csNo2char = num.substring(0, 2);
            var csNo2char1 = Number.parseInt(csNo2char);

            z = 0
            st = 0
            z1 = 0
            l1 = ""
            s = 0
            chkslash = ""

            if (isNaN(csNo2char)) {
                chkslash = num.substring(3, 2)
                var l = 5, ID = "C", strpt = 3;
                if (chkslash == "/") {
                    chkslash = num.substring(3, 2);
                    l1 = num.substring(0, 2).toUpperCase()
                    //alert("l1 "+l1);
                    ln = num.length;
                    s = String(num).substring(strpt, ln);
                    st1 = s.length;
                    if (st1 < l) {
                        Z = l - st1
                        st = "0"
                        z1 = Z
                        while (z1 > 1) {
                            st = st + "0"
                            z1 = z1 - 1
                        }
                        s = st + s
                    }
                    st = s
                    num = st
                    switch (ID) {
                        case "C":
                            st2 = l1 + "/" + num
                            csNo.value = st2
                            break;
                        default: csNo.value = st2;
                    }
                }
                else {

                    l1 = num.substring(0, 2).toUpperCase()
                    s2 = num.length;
                    newstr = num.substring(2, s2)
                    num = l1 + "/" + newstr
                    //alert(num);
                    ln = num.length;
                    s = String(num).substring(strpt, ln);
                    st1 = s.length;
                    if (st1 < l) {
                        Z = l - st1
                        st = "0"
                        z1 = Z
                        while (z1 > 1) {
                            st = st + "0"
                            z1 = z1 - 1
                        }
                        s = st + s
                    }
                    st = s
                    num = st
                    switch (ID) {
                        case "C":
                            st2 = l1 + "/" + num
                            csNo.value = st2
                            break;
                        default: csNo.value = st2;
                    }
                }
            }
            else {
                chkslash = num.substring(7, 8)

                var l = 6, ID = "C", strpt = 8;
                if (chkslash == "/") {
                    l1 = num.substring(0, 7).toUpperCase()
                    //alert("l1 "+l1);
                    ln = num.length;
                    s = String(num).substring(strpt, ln);
                    st1 = s.length;
                    if (st1 < l) {
                        Z = l - st1
                        st = "0"
                        z1 = Z
                        while (z1 > 1) {
                            st = st + "0"
                            z1 = z1 - 1
                        }
                        s = st + s
                    }
                    st = s
                    num = st
                    switch (ID) {
                        case "C":
                            st2 = l1 + "/" + num
                            csNo.value = st2
                            break;
                        default: csNo.value = st2;
                    }
                }
                else {
                    l1 = num.substring(0, 7).toUpperCase()
                    s2 = num.length;
                    newstr = num.substring(7, s2)
                    num = l1 + "/" + newstr
                    //alert(num);
                    ln = num.length;
                    s = String(num).substring(strpt, ln);
                    st1 = s.length;
                    if (st1 < l) {
                        Z = l - st1
                        st = "0"
                        z1 = Z
                        while (z1 > 1) {
                            st = st + "0"
                            z1 = z1 - 1
                        }
                        s = st + s
                    }
                    st = s
                    num = st
                    switch (ID) {
                        case "C":
                            st2 = l1 + "/" + num
                            csNo.value = st2
                            break;
                        default: csNo.value = st2;
                    }
                }
            }

        }
        function validateCaseNo() {
            var caseNo = document.getElementById('txtCaseNo').value.trim();
            if (caseNo === "") {
                Swal.fire({
                    icon: 'warning',
                    title: 'Missing Case Number',
                    text: 'Please enter a case number before searching.',
                    confirmButtonText: 'OK'
                });
                return false; // Prevents the server-side event from firing
            }
            return true; // Allows the server-side event to proceed
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
        <!-- Topbar with logo, navigation, and logout -->
        <div class="topbar">
            <img src="Image/tmclogo.png" alt="Logo" />
            <div class="nav">
                <a href="Dis_decommit.aspx">Home</a>
                <asp:Button ID="btnLogout" runat="server" CausesValidation="false" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="main-container">
            <div class="card">
                <div class="header">Patient Discharge Summary Decommit</div>

                <div class="input-group">
                    <asp:TextBox ID="txtCaseNo" runat="server" Placeholder="Enter Case No" MaxLength="50" AutoComplete="off" ClientIDMode="Static" />

                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-search" CausesValidation="false" OnClick="btnSearch_Click" OnClientClick="Case_No_Pad();" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-clear" CausesValidation="false" OnClick="btnClear_Click" />
                </div>
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" Style="display: none;" ClientIDMode="Static" />
                <div id="divResult" runat="server" visible="false" style="margin-top: 30px;">
                    <h3>Patient Information</h3>
                    <asp:Label ID="lblName" runat="server" Text="" /><br />
                    <asp:Label ID="lblAdmSeqNo" runat="server" Text="" /><br />
                    <asp:Label ID="lblAdmsDate" runat="server" Text="" /><br />
                    <asp:HiddenField ID="hdnAdmsDate" runat="server" />
                    <asp:Label ID="lblDischDate" runat="server" Text="" /><br />
                    <asp:HiddenField ID="hdnDischDate" runat="server" />
                    <%--          <div style="max-height: 90px; overflow-y: auto; background-color: #f9f9f9; padding-top: 5px">
                        <asp:Label ID="lblDischSummary" runat="server" Text="" />
                    </div>--%>
                    <%--<asp:Label ID="lblRecStat" runat="server" Text="" /><br />--%>
                    <asp:HyperLink ID="lnkDischSummary" runat="server" Text="View Discharge Summary" Target="_blank" OnClick="lnkDischSummary_Click" /><br />

                    <div id="remarkdiv" runat="server" visible="false" style="margin-top: 15px;">
                        <asp:Label ID="lblRemarks" runat="server" Text="Remarks:" Font-Bold="true" />
                        <span style="color: red">*</span>
                        <br />
                        <asp:TextBox ID="txtremarks" runat="server" AutoComplete="off" TextMode="MultiLine" MaxLength="400" Rows="3" Columns="50" CssClass="form-control" onkeypress="return restrictSpecialChars(event);" />
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtremarks"
                            ErrorMessage="Please enter a remarks" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <hr />
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div style="display: flex;">
                                <asp:Image ID="imgCaptcha" runat="server" />
                                <asp:ImageButton ID="btnRefreshCaptcha" runat="server"
                                    ImageUrl="~/Image/refresh1.png"
                                    OnClick="btnRefreshCaptcha_Click"
                                    Style="width: 40px; height: auto; background: none; padding: 0px;" CausesValidation="false" />
                            </div>
                            <br />
                            <asp:TextBox ID="txtCaptchaAnswer" runat="server" MaxLength="6" Placeholder="Enter CAPTCHA" onkeypress="return restrictSpecialChars(event);"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCaptchaAnswer"
                                ErrorMessage="Please enter a captcha" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvCaptchaValidate" runat="server"
                                ControlToValidate="txtCaptchaAnswer"
                                OnServerValidate="OnCaptchaValidate"
                                ErrorMessage="Incorrect CAPTCHA."
                                ForeColor="Red"
                                Display="Dynamic" />
                            <asp:Label runat="server" ID="lblError" Visible="false" ForeColor="Red"></asp:Label>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div style="text-align: center; margin-top: 30px">
                    <asp:Button ID="btnCommit" runat="server" Text="Decommit" Visible="false" CssClass="btn btn-commit" OnClick="btnCommit_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        var txtCaseNo = document.getElementById('txtCaseNo');

        // Function to allow only alphanumeric characters and '/'
        function isValidInput(char) {
            return /^[a-zA-Z0-9\/]$/.test(char);
        }

        // Restrict characters during typing
        txtCaseNo.addEventListener('keypress', function (e) {
            var char = String.fromCharCode(e.which || e.keyCode);
            if (!isValidInput(char)) {
                e.preventDefault();
            }
        });

        // Sanitize pasted content
        txtCaseNo.addEventListener('paste', function (e) {
            e.preventDefault();
            var pasteData = (e.clipboardData || window.clipboardData).getData('text');
            var sanitizedData = pasteData.replace(/[^a-zA-Z0-9\/]/g, '');
            var start = txtCaseNo.selectionStart;
            var end = txtCaseNo.selectionEnd;
            var currentValue = txtCaseNo.value;
            txtCaseNo.value = currentValue.substring(0, start) + sanitizedData + currentValue.substring(end);
            txtCaseNo.setSelectionRange(start + sanitizedData.length, start + sanitizedData.length);
        });
    });

    function restrictSpecialChars(event) {
        var invalidChars = ['<', '>', '%', '~','(',')'];
        var char = String.fromCharCode(event.which || event.keyCode);

        if (invalidChars.includes(char)) {
            event.preventDefault();
            //Swal.fire({
            //    icon: 'warning',
            //    title: 'Invalid Character',
            //    text: 'Special characters <, >, %, ~ are not allowed.',
            //    confirmButtonText: 'OK'
            //});
            return false;
        }
    }

</script>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const caseInput = document.getElementById("txtCaseNo");
        const searchBtn = document.getElementById("btnSearch");

        if (caseInput && searchBtn) {
            caseInput.addEventListener("keydown", function (event) {
                if (event.key === "Enter") {
                    event.preventDefault(); 
                    searchBtn.click();     
                }
            });
        }

        const captchaInput = document.getElementById("txtCaptchaAnswer");
        const commitBtn = document.getElementById("btnCommit");

        if (captchaInput && commitBtn) {
            captchaInput.addEventListener("keydown", function (event) {
                if (event.key === "Enter" && commitBtn.offsetParent !== null) { 
                    event.preventDefault();
                    commitBtn.click();
                }
            });
        }
    });
</script>







