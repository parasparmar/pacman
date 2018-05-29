﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Reflection;
using System.IO;
using CsvHelper;
using System.Web.UI.HtmlControls;
public partial class PacmanDiscussion : System.Web.UI.Page
{
    DataTable dtEmp;
    Helper my;
    private string strSQL { get; set; }
    private int MyEmpID { get; set; }
    private int ForEmpID { get; set; }
    private int PeriodID { get; set; }
    private DateTime StartDate { get; set; }
    private DateTime EndDate { get; set; }
    private decimal FinalRating { get; set; }
    public bool xShowButtons { get; set; }
    public DataTable DtProcName { get; set; }
    private List<RF> Transfer2DB = new List<RF>();
    protected void Page_Load(object sender, EventArgs e)
    {
        my = new Helper();

        try
        {
            dtEmp = (DataTable)Session["dtEmp"];
            if (dtEmp.Rows.Count <= 0)
            {
                Response.Redirect("index.aspx", false);
            }
            else
            {
                // In Production Use the below
                MyEmpID = Convert.ToInt32(dtEmp.Rows[0]["Employee_Id"].ToString());


            }
        }
        catch (Exception Ex)
        {
            Console.WriteLine(Ex.Message.ToString());
            Response.Redirect(ViewState["PreviousPageUrl"] != null ? ViewState["PreviousPageUrl"].ToString() : "index.aspx", false);
        }
        Literal title = (Literal)PageExtensionMethods.FindControlRecursive(Master, "ltlPageTitle");
        title.Text = "PACMAN Discussion";

        if (!IsPostBack)
        {
            fillddlReviewPeriod();
            fillddlStage();
            enableButtons();
        }
        else
        {

        }

    }
    private void fillddlReviewPeriod()
    {
        string strSQL = "WFMPMS.GetPacmanCycleforPacmanDiscussion_g";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;

        DataTable dtReportee = my.GetData(ref cmd);
        ddlReviewPeriod.DataSource = dtReportee;
        ddlReviewPeriod.DataTextField = "Period";
        ddlReviewPeriod.DataValueField = "PeriodID";
        ddlReviewPeriod.DataBind();
        ddlReviewPeriod.SelectedIndex = 0;
    }
    private void fillddlStage()
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        string strSQL = @"select * from [PMS].[Lock] where Active = 1";
        SqlCommand cmd = new SqlCommand(strSQL);

        DataTable dt1 = my.GetData(ref cmd);
        ddlStage.DataSource = dt1;
        ddlStage.DataTextField = "LockType";
        ddlStage.DataValueField = "LockID";
        ddlStage.DataBind();
        ListItem i = new ListItem("Pending", "0");
        ddlStage.Items.Insert(0, i);
        ddlStage.SelectedIndex = 0;
        fillddlReportee();
    }
    protected void ddlStage_SelectedIndexChanged(object sender, EventArgs e)
    {
        clearRP();
        fillddlReportee();
        enableButtons();
    }
    protected void ddlReviewPeriod_SelectedIndexChanged(object sender, EventArgs e)
    {
        clearRP();
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        string strSQL = "SELECT [FromDate],[ToDate] FROM [PMS].[PeriodMst] where [PeriodID] =" + PeriodID;
        DataTable dt = my.GetData(strSQL);
        StartDate = Convert.ToDateTime(dt.Rows[0]["FromDate"].ToString());
        EndDate = Convert.ToDateTime(dt.Rows[0]["ToDate"].ToString());
        fillddlStage();
        populateHeaders();
    }
    private void enableButtons()
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        ForEmpID = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        string strSQL = "WFMPMS.EnableButtonStates";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PeriodID", PeriodID);
        cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
        DataTable dt1 = my.GetData(ref cmd);
        if (ddlReportee.SelectedIndex > 0)
        {
            pnlSubmission.Visible = true;
        }
        if (dt1 != null && dt1.Rows.Count == 1)
        {
            btnYesDiscussed.Enabled = dt1.Rows[0]["btnDiscussed"].ToString() == "1" ? true : false;

            btnSubmitPacman.Enabled = dt1.Rows[0]["btnSubmit"].ToString() == "1" ? true : false;
            if (btnYesDiscussed.Enabled || btnSubmitPacman.Enabled) { pnlSubmission.Visible = true; }
            //btnAcknowledged.Enabled = dt1.Rows[0]["btnAcknowledged"].ToString() == "1" ? true : false;

        }
        else
        {
            btnYesDiscussed.Enabled = false;
            btnSubmitPacman.Enabled = false;
            pnlSubmission.Visible = false;
        }

    }
    private void populateHeaders()
    {
        ltlFinalRating.Text = "0";
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        string strSQL = "WFMPMS.getReporteeList";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@RepMgr", MyEmpID);
        cmd.Parameters.AddWithValue("@PeriodID", PeriodID);

        DataTable dtReportee = my.GetData(ref cmd);
        if (dtReportee != null && ddlReportee.Items.Count > 0 && ddlReportee.SelectedIndex > 0)
        {

            DataRow[] drs = dtReportee.Select("EmpCode = " + ForEmpID.ToString());
            string Role = string.Empty;
            if (drs.Length == 1)
            {
                Role = drs[0]["Role"].ToString();
            }
            ltlEmployeeBanner.Text = ddlReportee.SelectedItem.Text.ToString() + "( " + ForEmpID + " ) | Role : " + Role;

        }
        else
        {
            ltlEmployeeBanner.Text = "Not found";

        }
    }
    private void fillStartAndEndDates()
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        string strSQL = "SELECT [FromDate],[ToDate] FROM [PMS].[PeriodMst] where [PeriodID] =" + PeriodID;
        DataTable dt = my.GetData(strSQL);
        if (dt != null && dt.Rows.Count > 0)
        {
            StartDate = Convert.ToDateTime(dt.Rows[0]["FromDate"].ToString());
            EndDate = Convert.ToDateTime(dt.Rows[0]["ToDate"].ToString());

        }
        else
        {
            StartDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            EndDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 31);

        }

    }
    private void fillddlReportee()
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        int LockID = Convert.ToInt32(ddlStage.SelectedValue);
        string strSQL = "WFMPMS.getReporteeList";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@RepMgr", MyEmpID);
        cmd.Parameters.AddWithValue("@PeriodID", PeriodID);
        cmd.Parameters.AddWithValue("@LockID", LockID);

        DataTable dt2 = my.GetData(ref cmd);
        ddlReportee.DataSource = dt2;
        ddlReportee.DataTextField = "Name";
        ddlReportee.DataValueField = "EmpCode";
        ddlReportee.DataBind();
        ddlReportee.Items.Insert(0, new ListItem("Please Select", "0"));

    }
    protected void btnYesDiscussed_Click(object sender, EventArgs e)
    {
        Transfer2DB = Session["Transfer2DB"] as List<RF>;
        strSQL = "PMS.UpdateReview";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        int rowsAffected = 0;
        foreach (var trf in Transfer2DB)
        {
            cmd.Parameters.AddWithValue("@PERIODID", trf.PERIODID);
            cmd.Parameters.AddWithValue("@EMPCODE", trf.EMPCODE);
            cmd.Parameters.AddWithValue("@KPIIRATING", trf.KPIIRATING);
            cmd.Parameters.AddWithValue("@KPIID", trf.KPIID);
            cmd.Parameters.AddWithValue("@IsSPI", trf.IsSPI);
            rowsAffected += my.ExecuteDMLCommand(ref cmd, strSQL, "S");
            cmd.Parameters.Clear();
        }
        // To do : For this emp, LockID = 1 and SPI = false in PMS.Eligibility against this empcode and periodid

        strSQL = "PMS.UpdateEligibility";
        cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PERIODID", Transfer2DB[0].PERIODID);
        cmd.Parameters.AddWithValue("@EMPCODE", Transfer2DB[0].EMPCODE);
        cmd.Parameters.AddWithValue("@Lock", 1);
        cmd.Parameters.AddWithValue("@IsSPI", Transfer2DB[0].IsSPI);
        rowsAffected += my.ExecuteDMLCommand(ref cmd, strSQL, "S");

        clearRP();
        fillddlStage();

    }
    protected void ddlReportee_SelectedIndexChanged(object sender, EventArgs e)
    {
        clearRP();
        ForEmpID = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        populateHeaders();
        fillRP(ForEmpID);
        enableButtons();
    }
    private void fillRP(int ForEmpID)
    {
        //PMS.FillKPI 880343,5
        rp.Visible = true;
        int PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue.ToString());
        fillStartAndEndDates();
        strSQL = "PMS.FillKPI";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
        cmd.Parameters.AddWithValue("@PeriodID", PeriodID);

        DtProcName = my.GetData(ref cmd);
        rp.DataSource = DtProcName;
        rp.DataBind();
    }
    protected void gv_PreRender(object sender, EventArgs e)
    {
        GridView gv = (GridView)sender;
        if (gv.Rows.Count > 0)
        {
            gv.UseAccessibleHeader = true;
            gv.HeaderRow.TableSection = TableRowSection.TableHeader;
            gv.HeaderStyle.BorderStyle = BorderStyle.None;
            gv.BorderStyle = BorderStyle.None;
            gv.BorderWidth = Unit.Pixel(1);
        }
    }
    protected void rp_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType.ToString() == "Item" || e.Item.ItemType.ToString() == "AlternatingItem")
        {
            GridView gv = e.Item.FindControlRecursive("gvKPI") as GridView;

            RF k = new RF();
            k.EMPCODE = ForEmpID;
            k.PERIODID = PeriodID;
            k.IsSPI = Convert.ToInt32(ddlSPI.SelectedValue.ToString());
            if (gv != null)
            {
                fillStartAndEndDates();
                if (DtProcName != null && DtProcName.Rows.Count > 0)
                {
                    bool isManual;
                    string procName = string.Empty;
                    string Metric = string.Empty;
                    foreach (DataRow dr in DtProcName.Rows)
                    {
                        isManual = Convert.ToBoolean(dr["isManual"].ToString());
                        procName = dr["ProcName"].ToString();
                        Literal ltlKPIName = e.Item.FindControlRecursive("ltlKPIName") as Literal;
                        Metric = dr["Metric"].ToString();

                        if (ltlKPIName.Text == Metric)
                        {
                            int KPIId = Convert.ToInt32(dr["KPIID"].ToString());
                            k.KPIID = KPIId;
                            pnlSubmission.Visible = xShowButtons;
                            if (!isManual && procName.Length > 0)
                            {
                                SqlCommand cmd = new SqlCommand();
                                cmd.CommandText = procName;
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                                //cmd.Parameters.AddWithValue("@StartDate", StartDate);
                                //cmd.Parameters.AddWithValue("@EndDate", EndDate);
                                cmd.Parameters.AddWithValue("@StartDate", "20180401");
                                cmd.Parameters.AddWithValue("@EndDate", "20180430");

                                DataTable dt = my.GetData(ref cmd);
                                gv.DataSource = dt;
                                gv.DataBind();
                                string Rating = string.Empty;
                                DataRow[] drs = dt.Select("Account = 'Grand Total'");
                                if (drs.Length == 1)
                                {
                                    foreach (DataRow r in drs)
                                    {
                                        Rating = r["Rating"].ToString();
                                    }
                                    Literal ltlfinalScore = e.Item.FindControlRecursive("ltlKPIScore") as Literal;
                                    ltlfinalScore.Text = Rating.ToString();
                                    Decimal KPIRating = Convert.ToDecimal(Rating);
                                    k.KPIIRATING = KPIRating;
                                    Decimal KPIWtg = Convert.ToDecimal(dr["KPIWtg"].ToString());
                                    FinalRating += KPIRating * KPIWtg;
                                    ltlFinalRating.Text = Math.Round(FinalRating, 2).ToString();
                                    xShowButtons = true;
                                }
                            }
                            else
                            {
                                Panel pnlKPI = e.Item.FindControlRecursive("pnlKPI") as Panel;
                                pnlKPI.Visible = false;
                                Panel pnlManualKPI = e.Item.FindControlRecursive("pnlManualKPI") as Panel;
                                pnlManualKPI.Visible = true;



                                //Panel pnlDvKPI = e.Item.FindControlRecursive("dvkpi") as Panel;
                                //DropDownList ddlManualKPI = new DropDownList();
                                //ddlManualKPI.ID = "ddl_" + KPIId.ToString();
                                //ddlManualKPI.CssClass = "form-control select";

                                //for (int i = 1; i <= 5; i++)
                                //{
                                //    ListItem j = new ListItem(i.ToString(), i.ToString());
                                //    ddlManualKPI.Items.Add(j);
                                //}




                                //Button btnManualScoreSubmit = new Button();
                                //btnManualScoreSubmit.Text = "submit";
                                //btnManualScoreSubmit.CssClass = "btn btn-primary btn-flat";
                                //btnManualScoreSubmit.CommandArgument = KPIId.ToString();
                                //btnManualScoreSubmit.ID = KPIId.ToString();
                                //btnManualScoreSubmit.Click += new EventHandler(btnManualScoreSubmit_Click);

                                //Label lbl3 = new Label();
                                //lbl3.Text = Metric;

                                //HtmlGenericControl br = new HtmlGenericControl("br");

                                //Label lbl2 = new Label();
                                //lbl2.Text = "Please enter comments";

                                //Label lbl1 = new Label();
                                //lbl1.Text = "Select Rating";

                                //TextBox tbManualKPIComments = new TextBox();
                                //tbManualKPIComments.CssClass = "form-control select";
                                //tbManualKPIComments.TextMode = TextBoxMode.MultiLine;
                                //tbManualKPIComments.Rows = 2;
                                //tbManualKPIComments.ID = "tb" + KPIId.ToString();

                                //HtmlGenericControl d = new HtmlGenericControl("div");
                                //d.Attributes.Add("class", "col-md-3");
                                //d.Controls.Add(lbl3);
                                //d.Controls.Add(br);
                                //d.Controls.Add(btnManualScoreSubmit);

                                //HtmlGenericControl f = new HtmlGenericControl("div");
                                //f.Attributes.Add("class", "form-group");

                                //HtmlGenericControl c = new HtmlGenericControl("div");
                                //c.Attributes.Add("class", "col-md-6");
                                //c.Controls.Add(lbl2);
                                //c.Controls.Add(tbManualKPIComments);

                                //HtmlGenericControl b = new HtmlGenericControl("div");
                                //b.Attributes.Add("class", "col-md-3");
                                //b.Controls.Add(lbl1);
                                //b.Controls.Add(ddlManualKPI);

                                //HtmlGenericControl a = new HtmlGenericControl("div");
                                //f.Attributes.Add("class", "row");
                                //f.Controls.Add(b);
                                //f.Controls.Add(c);
                                //f.Controls.Add(d);
                                //a.Controls.Add(f);
                                //pnlDvKPI.Controls.Add(a);

                            }
                        }
                    }
                }
                else
                {
                    rp.Visible = false;
                    ltlFinalRating.Text = "0";
                }
            }

            Transfer2DB.Add(k);
            Session["Transfer2DB"] = Transfer2DB;
            pnlSubmission.Visible = xShowButtons;
        }
    }

  
  


    private void clearRP()
    {
        rp.Visible = false;
        ltlFinalRating.Text = "0";
        ltlEmployeeBanner.Text = string.Empty;
    }

    protected void btnManualScoreSubmit_Click(object sender, EventArgs e)
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        ForEmpID = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        Button btn = sender as Button;
        int KPIID = Convert.ToInt32(btn.CommandArgument.ToString());
        DropDownList ddl = Page.FindControlRecursive("ddlManualScore") as DropDownList;
        TextBox tb = Page.FindControlRecursive("txtManualComments") as TextBox;
        if (ddl != null && tb != null)
        {
            decimal KPIRating = Convert.ToDecimal(ddl.SelectedValue.ToString());
            string KPIComments = tb.Text;

            string strSQL = "PMS.SaveKPIManualRating";
            SqlCommand cmd = new SqlCommand(strSQL);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
            cmd.Parameters.AddWithValue("@PeriodID", PeriodID);
            cmd.Parameters.AddWithValue("@KPIID", KPIID);
            cmd.Parameters.AddWithValue("@KPIRating", KPIRating);
            cmd.Parameters.AddWithValue("@KPIComments", KPIComments);
            cmd.Parameters.AddWithValue("@ActionedBy", MyEmpID);
            int rowsAffected = my.ExecuteDMLCommand(ref cmd, strSQL, "S");

        }





    }
}

class RF
{
    public int PERIODID { get; set; }
    public int EMPCODE { get; set; }
    public decimal KPIIRATING { get; set; }
    public int KPIID { get; set; }
    public int IsSPI { get; set; }
}