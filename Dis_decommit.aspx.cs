using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPSnippets.Captcha;

namespace DischargeCommit
{
    public partial class Dis_decommit : System.Web.UI.Page
    {

        Webservice1.WebEmrService service = new Webservice1.WebEmrService();
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
                Response.Cache.SetNoStore();

                if (Request.QueryString["cleared"] == "1")
                {
                    string script = $@"
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
        <script type='text/javascript'>
            Swal.fire({{
                icon: 'success',
                title: 'Discharge decommit successfully',
                showConfirmButton: false,
                timer: 2000,
            }});
        </script>";

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                    ClearForm();

                }
            }

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                this.Captcha = new Captcha(150, 40, 20f, "#FFFFFF", "#2c6449", Mode.AlphaNumeric);
                imgCaptcha.ImageUrl = this.Captcha.ImageData;
            }

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string caseNo = txtCaseNo.Text.Trim();
            if (!string.IsNullOrEmpty(caseNo))
            {

                var summary = service.SearchDischargeSummary(caseNo);

                if (!summary.IsFound)
                {
                    btnCommit.Visible = false;
                    divResult.Visible = false;
                    remarkdiv.Visible = false;
                    //Response.Write("<script>alert('" + summary.Message + "');</script>");
                    string script = $@"
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
        <script type='text/javascript'>
            Swal.fire({{
                icon: 'error',
                title: 'Not Found',
                text: '{summary.Message}',
                confirmButtonText: 'OK'
            }});
        </script>";

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                    return;
                }

        //        if (!summary.IsWithin48Hours)
        //        {
        //            btnCommit.Visible = false;
        //            divResult.Visible = false;
        //            remarkdiv.Visible = false;
        //            //Response.Write("<script>alert('" + summary.Message + "');</script>");
        //            string script = $@"
        //<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
        //<script type='text/javascript'>
        //    Swal.fire({{
        //        icon: 'warning',
        //        title: 'Time',
        //        text: '{summary.Message}',
        //        confirmButtonText: 'OK'
        //    }});
        //</script>";

        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
        //            return;
        //        }

                lblName.Text = $"Name: {summary.FirstName} {summary.LastName}";
                lblAdmSeqNo.Text = $"Adm Seq No: {summary.AdmSeqNo}";
                //lblAdmsDate.Text = $"Admission Date: {summary.AdmsDate:yyyy-MM-dd}";
                //lblDischDate.Text = $"Discharge Date: {summary.DischDate:yyyy-MM-dd}";
                lblAdmsDate.Text = $"Admission Date: {summary.AdmsDate:dd-MM-yyyy}";
                hdnAdmsDate.Value = summary.AdmsDate.ToString("yyyy-MM-dd");

                lblDischDate.Text = $"Discharge Date: {summary.DischDate:dd-MM-yyyy}";
                hdnDischDate.Value = summary.DischDate.ToString("yyyy-MM-dd");


                //lnkDischSummary.NavigateUrl = "https://tmc.gov.in/EMRREPORTS1/printDischSumm.aspx?admsno=" + summary.AdmSeqNo;
                lnkDischSummary.NavigateUrl = "https://intranet.tmc.gov.in/Discharge%20Summary/printdischsumm.aspx?admsno=" + summary.AdmSeqNo;
                lnkDischSummary.Visible = true;




                divResult.Visible = true;
                btnCommit.Visible = true;
                remarkdiv.Visible = true;
            }
            else
            {
                lblMessage.Visible = true;
                string script = $@"
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
        <script type='text/javascript'>
            Swal.fire({{
                icon: 'warning',
                title: 'Case no.',
                text: 'Please enter a case number.',
                confirmButtonText: 'OK'
            }});
        </script>";

                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
                //Response.Write("<script>alert('Please enter case no');</script>");
            }
        }
        protected void btnCommit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                lblError.Visible = true;
                return;
            }

            string caseNo = txtCaseNo.Text.Trim();
            string admSeqNo = lblAdmSeqNo.Text.Replace("Adm Seq No: ", "").Trim();
            string decmtBy = Session["UserID"]?.ToString() ?? "Unknown";
            DateTime admsDate = DateTime.ParseExact(hdnAdmsDate.Value.Replace("Admission Date: ", "").Trim(), "yyyy-MM-dd", null);
            DateTime dischDate = DateTime.ParseExact(hdnDischDate.Value.Replace("Discharge Date: ", "").Trim(), "yyyy-MM-dd", null);
            string remarks = txtremarks.Text.Trim();
            string ipAddress = Request.UserHostAddress;



            // string result = service.CommitDischargeSummary(caseNo, admSeqNo, decmtBy, remarks, dischDate, ipAddress);
            string result = service.CommitDischargeSummary(caseNo, admSeqNo, decmtBy, remarks, dischDate, admsDate, ipAddress);

            if (result == "Commit successful")
            {
                //Response.Write("<script>alert('Decommit successful');</script>");
                //Session["CommitMessage"] = "Decommit successful";

                ClearForm();
                txtCaseNo.Text = "";
                txtremarks.Text = "";
                lblName.Text = "";
                lblAdmSeqNo.Text = "";
                lblAdmsDate.Text = "";
                lblDischDate.Text = "";
                //lblRecStat.Text = "";
                divResult.Visible = false;
                btnCommit.Visible = false;
                remarkdiv.Visible = false;

                Response.Redirect("Dis_decommit.aspx?cleared=1");
            }
            else
            {
                Response.Write("<script>alert('Error: " + result + "');</script>");
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Redirect("Login.aspx");
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            txtCaseNo.Text = "";
            txtremarks.Text = "";
            lblName.Text = "";
            lblAdmSeqNo.Text = "";
            lblAdmsDate.Text = "";
            lblDischDate.Text = "";
            //lblRecStat.Text = "";
            divResult.Visible = false;
            remarkdiv.Visible = false;
            btnCommit.Visible = false;
        }
        private void ClearForm()
        {
            txtCaseNo.Text = "";
            txtremarks.Text = "";
            lblName.Text = "";
            lblAdmSeqNo.Text = "";
            lblAdmsDate.Text = "";
            lblDischDate.Text = "";
            //lblRecStat.Text = "";
            divResult.Visible = false;
            remarkdiv.Visible = false;
            btnCommit.Visible = false;
        }
        private Captcha Captcha
        {
            get
            {
                return (Captcha)ViewState["Captcha"];
            }
            set
            {
                ViewState["Captcha"] = value;
            }
        }
        protected void OnCaptchaValidate(object source, ServerValidateEventArgs args)
        {

            args.IsValid = Captcha.IsValid(txtCaptchaAnswer.Text);
            if (!args.IsValid)
            {

                imgCaptcha.ImageUrl = Captcha.ImageData;
            }
        }
        protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
        {
            this.Captcha = new Captcha(150, 40, 20f, "#FFFFFF", "#2c6449", Mode.AlphaNumeric);
            imgCaptcha.ImageUrl = this.Captcha.ImageData;
            txtCaptchaAnswer.Text = "";

            lblError.Visible = false;
        }
    }
}