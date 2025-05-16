using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPSnippets.Captcha;

namespace DischargeCommit
{
    public partial class Login : System.Web.UI.Page
    {

        Webservice1.WebEmrService service = new Webservice1.WebEmrService();
       
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();


            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                txtUsername.Attributes.Add("autocomplete", "off");
                //this.Captcha = new Captcha(150, 40, 20f, "#FFFFFF", "#0f2027", Mode.AlphaNumeric);
                this.Captcha = new Captcha(150, 40, 20f, "#FFFFFF", "#2c6449", Mode.AlphaNumeric);
                imgCaptcha.ImageUrl = this.Captcha.ImageData;
            }
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
        protected void btnLogin_Click(object sender, EventArgs e)
        {

            if (!Page.IsValid)
            {
                lblError.Visible = true;
                return;
            }

            string userId = txtUsername.Text.Trim();
            string userPass = txtPassword.Text.Trim();


            bool isValid = service.IsLoginValid(userId, userPass);

            if (isValid)
            {
                Session["UserID"] = userId;
                Response.Redirect("Dis_decommit.aspx");
            }
            else
            {
                lblError.Text = "Invalid User ID or Password. Please try again.";
                lblError.Visible = true;
            }



        }
        protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
        {

            string tempPassword = txtPassword.Text;
            //this.Captcha = new Captcha(150, 40, 20f, "#FFFFFF", "#61028D", Mode.AlphaNumeric);
            this.Captcha = new Captcha(150, 40, 20f, "#FFFFFF", "#2c6449", Mode.AlphaNumeric);
            imgCaptcha.ImageUrl = this.Captcha.ImageData; 
            txtCaptchaAnswer.Text = "";
            txtPassword.Attributes["value"] = tempPassword;
            lblError.Visible = false; 
        }

    }
}