﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;

public partial class PacmanDiscussion : System.Web.UI.Page
{
    DataTable dtEmp;
    Helper my;
    private string strSQL { get; set; }
    private int MyEmpID { get; set; }
    private int ForEmpID { get; set; }
    private int MyRepMgr { get; set; }
    private int PacmanCycle { get; set; }
    private int RStage { get; set; }
    private int IsRepMgr { get; set; }
    private string MySkillset { get; set; }
    private DateTime StartDate { get; set; }
    private DateTime EndDate { get; set; }
    private decimal SLRating { get; set; }
    private decimal OptimizationRating { get; set; }
    private decimal EIRating { get; set; }
    private decimal AbsenteeismRating { get; set; }
    private decimal BTPRating { get; set; }
    public string lblPacmanCycle { get; set; }
    public DataTable DtOfAccountsIHandle { get; set; }
    private int IEXMgmt { get; set; }
    private int AnalyticProject { get; set; }
    private int AnalyticTimeline { get; set; }
    private int Accuracy { get; set; }

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
                //MyRepMgr = Convert.ToInt32(dtEmp.Rows[0]["RepMgrCode"].ToString());
            }
        }
        catch (Exception Ex)
        {
            Console.WriteLine(Ex.Message.ToString());
            Response.Redirect(ViewState["PreviousPageUrl"] != null ? ViewState["PreviousPageUrl"].ToString() : "index.aspx", false);
        }
        Literal title = (Literal)PageExtensionMethods.FindControlRecursive(Master, "ltlPageTitle");
        title.Text = "PACMAN Discussion";

        btnSubmitPacman.Enabled = false;


        if (!IsPostBack)
        {
            fillddlReviewPeriod();
            fillddlStage();
            fillddlReportee();
            ddlStage_DataBound(sender, e);
            if (RStage == 3 || RStage == 4 || RStage == 5)
            {
                btnYesDiscussed.Enabled = false;
                btnNotDiscussed.Enabled = false;
            }
            else if (RStage == 2)
            {
                btnYesDiscussed.Enabled = false;
                btnNotDiscussed.Enabled = false;
                btnSubmitPacman.Enabled = true;
            }
            else
            {
                btnYesDiscussed.Enabled = true;
                btnNotDiscussed.Enabled = true;
            }
            if (IsRepMgr == 0)
            {
                btnYesDiscussed.Enabled = false;
                btnNotDiscussed.Enabled = false;
            }

            DtOfAccountsIHandle = getDtOfAccountsIHandle();
            showRelevantMetrics(ForEmpID);
        }
    }

    private void getMySkillset()
    {
        string strSQL = "SELECT Distinct A.Skillset FROM [CWFM_Umang].[WFMPMS].[tblEmp2Account] A ";
        strSQL += " inner join WFMPMS.tblCalculations B on B.ClientID = A.PrimaryClientID ";
        strSQL += " where EmpCode = " + MyEmpID + " and A.Active = 1 and B.InBO = 1 and " + StartDate + " between A.FromDate and A.ToDate";

    }

    private DataTable getDtOfAccountsIHandle()
    {
        string strSQL = "WFMPMS.GetAllAccountsIHandle";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.Parameters.AddWithValue("@Employee_ID", MyEmpID);
        StartDate = DateTime.Today.Date;
        cmd.Parameters.AddWithValue("@StartDate", StartDate);

        DataTable dt = my.GetDataTableViaProcedure(ref cmd);
        //dt.DefaultView.RowFilter = "InBO=1";
        //gvAllMyAccounts.DataSource = dt;
        //gvAllMyAccounts.DataBind();

        return dt;


    }

    private void showRelevantMetrics(int ForEmpID)
    {
        string strSQL = "SELECT Distinct B.id, B.Metrics FROM [CWFM_Umang].[WFMPMS].[tblEmp2Account] A  ";
        strSQL += " inner join [WFMPMS].[tblDsgn2KPIWtg] B on B.SkillsetId = A.SkillsetId  ";
        strSQL += " where EmpCode =  " + ForEmpID + " and [Active] = 1 and '" + StartDate + "' between A.FromDate and A.ToDate ";
        strSQL += " order by B.id, B.Metrics ";

        DataTable dt = my.GetData(strSQL);
        string myPanelName = string.Empty;

        foreach (DataRow d in dt.Rows)
        {
            myPanelName = "pnl_" + d["Metrics"].ToString().Replace("&", "").Replace(" ", "_");
            Control c = Page.FindControlRecursive(myPanelName);
            if (c != null)
            {
                Panel thePanel = c as Panel;
                thePanel.Visible = true;
            }
        }
    }

    private void fillddlReviewPeriod()
    {
        string strSQL = "WFMPMS.[GetPacmanCycleforPacmanDiscussion]";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.Parameters.AddWithValue("@EmpCode", MyEmpID);
        DataTable dt = my.GetDataTableViaProcedure(ref cmd);
        ddlReviewPeriod.DataSource = dt;
        ddlReviewPeriod.DataTextField = "TextDescription";
        ddlReviewPeriod.DataValueField = "Id";
        ddlReviewPeriod.DataBind();
    }

    private void fillddlStage()
    {
        string strSQL = "[WFMPMS].[GetReviewStage]";
        SqlCommand cmd = new SqlCommand(strSQL);
        DataTable dt1 = my.GetDataTableViaProcedure(ref cmd);
        ddlStage.DataSource = dt1;
        ddlStage.DataTextField = "Stage";
        ddlStage.DataValueField = "Id";
        ddlStage.DataBind();
    }

    protected void ddlStage_SelectedIndexChanged(object sender, EventArgs e)
    {
        fillddlReportee();

        ddlStage_DataBound(sender, e);
        if (RStage == 3 || RStage == 4 || RStage == 5)
        {
            btnYesDiscussed.Enabled = false;
            btnNotDiscussed.Enabled = false;
        }
        else if (RStage == 2)
        {
            btnYesDiscussed.Enabled = false;
            btnNotDiscussed.Enabled = false;
            btnSubmitPacman.Enabled = true;
        }
        else
        {
            btnYesDiscussed.Enabled = true;
            btnNotDiscussed.Enabled = true;
        }
    }

    protected void ddlReviewPeriod_SelectedIndexChanged(object sender, EventArgs e)
    {
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        string strSQL = "SELECT [FromDate],[ToDate] FROM [CWFM_Umang].[WFMPMS].[tblPacmanCycle] where [ID] =" + PacmanCycle;
        DataTable dt = my.GetData(strSQL);
        StartDate = Convert.ToDateTime(dt.Rows[0]["FromDate"].ToString());
        EndDate = Convert.ToDateTime(dt.Rows[0]["ToDate"].ToString());

        fillgvPrimaryKPI(ForEmpID);
        fillgvRealTimeOptimization(ForEmpID);
        fillLtlEI(ForEmpID);
        fillltlAbsenteeism(ForEmpID);
        fillpnlBTP("511TOT1");
        fillddlStage();
        fillddlReportee();
        ltlEmloyeeBanner.Text = " Performance Management Cycle : " + ddlReviewPeriod.SelectedItem.Text.ToString();
        if (ddlReportee.Items.Count > 0)
        {
            ltlEmloyeeBanner.Text = ddlReportee.SelectedItem.Text.ToString() + ltlEmloyeeBanner.Text;
        }

    }

    private void fillddlReportee()
    {
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        int stageNo = Convert.ToInt32(ddlStage.SelectedValue);

        string strSQL = "[WFMPMS].[fillEmployeePacmanDiscussion]";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.Parameters.AddWithValue("@EmpCode", MyEmpID);
        cmd.Parameters.AddWithValue("@stageNo", stageNo);
        cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
        DataTable dt2 = my.GetDataTableViaProcedure(ref cmd);
        ddlReportee.DataSource = dt2;
        ddlReportee.DataTextField = "Name";
        ddlReportee.DataValueField = "EmpCode";
        ddlReportee.DataBind();

    }

    protected void btnYesDiscussed_Click(object sender, EventArgs e)
    {
        btnSubmitPacman.Enabled = true;
        btnYesDiscussed.Enabled = false;
        btnNotDiscussed.Enabled = false;

        SqlConnection con = new SqlConnection(my.getConnectionString());
        con.Open();

        String strSQL = "[WFMPMS].[InsertPacmanStage]";
        SqlCommand cmd = new SqlCommand(strSQL, con);
        cmd.CommandType = CommandType.StoredProcedure;

        MyEmpID = Convert.ToInt32(dtEmp.Rows[0]["Employee_Id"].ToString());
        int reportee = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        int PreviousStage = Convert.ToInt32(ddlStage.SelectedItem.Value.ToString());
        int Stage = 2;
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedItem.Value.ToString());
        cmd.Parameters.AddWithValue("@EmpCode", reportee);
        cmd.Parameters.AddWithValue("@Stage", Stage);
        cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
        cmd.Parameters.AddWithValue("@ActionBy", MyEmpID);
        cmd.Parameters.AddWithValue("@PreviousStage", PreviousStage);

        cmd.Connection = con;
        cmd.ExecuteNonQuery();
        con.Close();

        //fillddlReportee();
    }

    protected void ddlStage_DataBound(object sender, EventArgs e)
    {
        RStage = Convert.ToInt32(ddlStage.SelectedItem.Value.ToString());
        strSQL = "[WFMPMS].[GetIsRepMgr]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", MyEmpID);
                IsRepMgr = Convert.ToInt32(cmd.ExecuteScalar());
            }
        }
    }

    protected void btnSubmitPacman_Click(object sender, EventArgs e)
    {
        btnYesDiscussed.Enabled = false;
        btnNotDiscussed.Enabled = false;
        btnSubmitPacman.Enabled = false;

        SqlConnection con = new SqlConnection(my.getConnectionString());
        con.Open();

        String strSQL = "[WFMPMS].[InsertPacmanStage]";
        SqlCommand cmd = new SqlCommand(strSQL, con);
        cmd.CommandType = CommandType.StoredProcedure;

        MyEmpID = Convert.ToInt32(dtEmp.Rows[0]["Employee_Id"].ToString());
        int reportee = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        int PreviousStage = Convert.ToInt32(ddlStage.SelectedItem.Value.ToString());
        int Stage = 3;
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedItem.Value.ToString());
        cmd.Parameters.AddWithValue("@EmpCode", reportee);
        cmd.Parameters.AddWithValue("@Stage", Stage);
        cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
        cmd.Parameters.AddWithValue("@ActionBy", MyEmpID);
        cmd.Parameters.AddWithValue("@PreviousStage", PreviousStage);

        cmd.Connection = con;
        cmd.ExecuteNonQuery();
        con.Close();

        fillddlReportee();
    }

    private void filltblKPI()
    {
        string strSQL = "[WFMPMS].[getSLForEmpAndAccount_511TOT1]";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.Parameters.AddWithValue("@Employee_ID", MyEmpID);
        cmd.Parameters.AddWithValue("@StartDate", StartDate);
        cmd.Parameters.AddWithValue("@EndDate", EndDate);
        DataTable dt = my.GetDataTableViaProcedure(ref cmd);
        tblKPI.DataSource = dt;
        tblKPI.DataBind();

    }

    private void fillgvPrimaryKPI(int ForEmpID)
    {

        string strSQL = "WFMPMS.getSLSummaryForPACMAN";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                cmd.Parameters.AddWithValue("@EndDate", EndDate);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    GridView gvPrimaryKPI = new GridView();
                    gvPrimaryKPI.ID = "gvPrimaryKPI";
                    gvPrimaryKPI.AutoGenerateColumns = true;
                    //gvPrimaryKPI.EmptyDataTemplate =  "No data found matching this set of parameters " + MyEmpID + StartDate.Month.ToString("M");


                    dt.Columns.Add("Calculation");
                    DataRow dr = dt.NewRow();

                    dt.ImportRow(ds.Tables[1].Rows[0]);
                    gvPrimaryKPI.DataSource = dt;
                    gvPrimaryKPI.CssClass = "table DataTable table-condensed table-bordered table-responsive";

                    gvPrimaryKPI.DataBind();
                    gvPrimaryKPI.Rows[gvPrimaryKPI.Rows.Count - 1].CssClass = "text-muted well well-sm no-shadow";
                    gvPrimaryKPI.Rows[gvPrimaryKPI.Rows.Count - 1].Font.Bold = true;
                    gvPrimaryKPI.PreRender += gv_PreRender;

                    SLRating = Convert.ToDecimal(ds.Tables[1].Rows[0]["Rating"].ToString());
                    ltlPrimaryKPI.Text = "Primary KPIname : Service Level &nbsp= &nbsp";
                    ltl_KPI.Text = SLRating.ToString();
                    pnlKPI.Controls.Add(gvPrimaryKPI);
                }
                else
                {
                    ltlPrimaryKPI.Text = "Primary KPIname : Service Level &nbsp= &nbsp" + "No Data found";
                }
            }

        }
    }

    private void fillgvRealTimeOptimization(int ForEmpID)
    {

        string strSQL = "WFMPMS.getSLOptimizationSummaryForPACMAN";

        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
        cmd.Parameters.AddWithValue("@StartDate", StartDate);
        cmd.Parameters.AddWithValue("@EndDate", EndDate);

        DataTable dt = my.GetDataTableViaProcedure(ref cmd);
        if (dt.Rows.Count > 0)
        {
            GridView gvOptimizationKPI = new GridView();
            gvOptimizationKPI.AutoGenerateColumns = true;

            gvOptimizationKPI.DataSource = dt;
            gvOptimizationKPI.DataBind();
            gvOptimizationKPI.CssClass = "table DataTable table-condensed table-bordered table-responsive";
            gvOptimizationKPI.Rows[gvOptimizationKPI.Rows.Count - 1].CssClass = "text-muted well well-sm no-shadow";
            gvOptimizationKPI.Rows[gvOptimizationKPI.Rows.Count - 1].Font.Bold = true;
            OptimizationRating = Convert.ToDecimal(dt.Rows[dt.Rows.Count - 1]["Rating"].ToString());
            ltlOptimization.Text = "Real Time Optimization &nbsp= &nbsp";
            ltl_Real_Time_Optimization.Text = OptimizationRating.ToString();
            pnlOptimization.Controls.Add(gvOptimizationKPI);

            gvOptimizationKPI.PreRender += gv_PreRender;
        }


    }

    private void fillLtlEI(int ForEmpID)
    {
        EIRating = 0;
        strSQL = "[WFMPMS].[GetEscalationInitiativeScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                cmd.Parameters.AddWithValue("@total", EIRating);
                cmd.Parameters["@total"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                EIRating = Convert.ToInt32(cmd.Parameters["@total"].Value.ToString());
                ltlEI.Text = "Escalations & Initiatives &nbsp= &nbsp";
                ltl_Escalations.Text = EIRating.ToString();
            }

        }
    }

    private void fillltlAbsenteeism(int ForEmpID)
    {


        AbsenteeismRating = 0;
        strSQL = "[WFMPMS].[GetSelfAttendanceScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        AbsenteeismRating = Convert.ToInt32(sdr.GetValue(0));
                    }
                }
                ltlAbsenteeism.Text = "Self-Attendance &nbsp= &nbsp";
                ltl_Absenteeism.Text = AbsenteeismRating.ToString();
            }

        }
    }

    private void fillpnlBTP(string ForAccountId)
    {

        string strSQL = "WFMPMS.getBTPForAccount";

        SqlCommand cmd = new SqlCommand(strSQL);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@AccountId", ForAccountId);
        cmd.Parameters.AddWithValue("@Month", StartDate);

        DataTable dt = my.GetDataTableViaProcedure(ref cmd);

        GridView gvBTP = new GridView();
        gvBTP.ID = "gvBTP";
        gvBTP.AutoGenerateColumns = true;

        gvBTP.DataSource = dt;
        gvBTP.CssClass = "table DataTable table-condensed table-bordered table-responsive";

        gvBTP.DataBind();
        gvBTP.Rows[gvBTP.Rows.Count - 1].CssClass = "text-muted well well-sm no-shadow";
        gvBTP.Rows[gvBTP.Rows.Count - 1].Font.Bold = true;
        gvBTP.PreRender += gv_PreRender;

        BTPRating = Convert.ToDecimal(dt.Rows[0]["Rating"].ToString());
        ltlBTP.Text = "Billed To Pay &nbsp= &nbsp";
        pnlBTP.Controls.Add(gvBTP);
        ltl_BTP.Text = BTPRating.ToString();
    }

    private void getFinalRating()
    {
        string strSQL = "SELECT [KPI],[Weight] FROM [CWFM_Umang].[WFMPMS].[tblDsgn2KPIWtg] A where Designation = 'RTA'";
        DataTable dtWeights = my.GetData(strSQL);
        DataRow[] drow = dtWeights.Select("KPI=KPI");
        Decimal KPIWt = Convert.ToDecimal(drow[0]["Weight"].ToString());
        SLRating = KPIWt * SLRating;

        string expression = "KPI='BTP'";
        drow = dtWeights.Select(expression);

        Decimal BTPWt = Convert.ToDecimal(drow[0]["Weight"].ToString());
        BTPRating = BTPWt * BTPRating;

        expression = "KPI='Absenteeism'";
        drow = dtWeights.Select(expression);
        Decimal AbsenteeismWt = Convert.ToDecimal(drow[0]["Weight"].ToString());
        AbsenteeismRating = AbsenteeismWt * AbsenteeismRating;

        expression = "KPI='Escalations'";
        drow = dtWeights.Select(expression);
        Decimal EscalationsWt = Convert.ToDecimal(drow[0]["Weight"].ToString());
        EIRating = EIRating * EscalationsWt;

        expression = "KPI='Real Time Optimization'";
        drow = dtWeights.Select(expression);

        Decimal RTAOptimizationsWt = Convert.ToDecimal(drow[0]["Weight"].ToString());
        OptimizationRating = OptimizationRating * RTAOptimizationsWt;

        ltlfinalScore.Text = Convert.ToString(SLRating + BTPRating + AbsenteeismRating + EIRating + OptimizationRating);


    }

    private void clearIEXMgmtScorefields()
    {
        ddlIEXMgmtScore.ClearSelection();
        txtIEXMgmtComments.Text = string.Empty;
    }

    protected void btnIEXMgmtScoreSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(my.getConnectionString());
        con.Open();

        String strSQL = "[WFMPMS].[InsertIEXManagementScore]";
        SqlCommand cmd = new SqlCommand(strSQL, con);
        cmd.CommandType = CommandType.StoredProcedure;
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedItem.Value.ToString());
        int reportee = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        int score = Convert.ToInt32(ddlIEXMgmtScore.SelectedItem.Value.ToString());
        string comments = txtIEXMgmtComments.Text.ToString();

        cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
        cmd.Parameters.AddWithValue("@EmpCode", reportee);
        cmd.Parameters.AddWithValue("@Score", score);
        cmd.Parameters.AddWithValue("@Comments", comments);
        cmd.Parameters.AddWithValue("@ActionedBy", MyEmpID);
        cmd.Connection = con;
        cmd.ExecuteNonQuery();
        con.Close();
        ltlIEX_Management.Text = "IEX Management &nbsp= &nbsp" + "<div class=\"pull-right header\">" + score + "</div>";
        clearIEXMgmtScorefields();
    }

    protected void ddlReportee_SelectedIndexChanged(object sender, EventArgs e)
    {
        ForEmpID = 
        if (ddlReviewPeriod.SelectedValue == "17")
        {
            getFinalRating();
        }
    }

    protected void btnAnalyticProjectScoreSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(my.getConnectionString());
        con.Open();

        String strSQL = "[WFMPMS].[InsertAnalyticsProjectsScore]";
        SqlCommand cmd = new SqlCommand(strSQL, con);
        cmd.CommandType = CommandType.StoredProcedure;
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedItem.Value.ToString());
        int reportee = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        int scoreProjects = Convert.ToInt32(ddlAnalyticProject.SelectedItem.Value.ToString());
        string commentsProjects = txtAnalyticProject.Text.ToString();

        cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
        cmd.Parameters.AddWithValue("@EmpCode", reportee);
        cmd.Parameters.AddWithValue("@Score", scoreProjects);
        cmd.Parameters.AddWithValue("@Comments", commentsProjects);
        cmd.Parameters.AddWithValue("@ActionedBy", MyEmpID);
        cmd.Connection = con;
        cmd.ExecuteNonQuery();
        con.Close();
        ltlProject.Text = "Projects &nbsp= &nbsp" + "<div class=\"pull-right header\">" + scoreProjects + "</div>";
        clearAnalyticProjectScorefields();

    }

    private void clearAnalyticProjectScorefields()
    {
        ddlAnalyticProject.ClearSelection();
        txtAnalyticProject.Text = string.Empty;
    }

    protected void btnCoachingScoreSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(my.getConnectionString());
        con.Open();

        String strSQL = "[WFMPMS].[InsertAnalyticsCoachingScore]";
        SqlCommand cmd = new SqlCommand(strSQL, con);
        cmd.CommandType = CommandType.StoredProcedure;
        PacmanCycle = Convert.ToInt32(ddlReviewPeriod.SelectedItem.Value.ToString());
        int reportee = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
        int scoreCoaching = Convert.ToInt32(ddlCoaching.SelectedItem.Value.ToString());
        string commentsCoaching = txtCoachingComments.Text.ToString();

        cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
        cmd.Parameters.AddWithValue("@EmpCode", reportee);
        cmd.Parameters.AddWithValue("@Score", scoreCoaching);
        cmd.Parameters.AddWithValue("@Comments", commentsCoaching);
        cmd.Parameters.AddWithValue("@ActionedBy", MyEmpID);
        cmd.Connection = con;
        cmd.ExecuteNonQuery();
        con.Close();
        ltlCoachingFeedback.Text = "Coaching & Feedback &nbsp= &nbsp" + "<div class=\"pull-right header\">" + scoreCoaching + "</div>";
        clearAnalyticCoachingScorefields();
    }

    private void clearAnalyticCoachingScorefields()
    {
        ddlCoaching.ClearSelection();
        txtCoachingComments.Text = string.Empty;
    }

    private void fillltlAnalyticTimeline()
    {
        AnalyticTimeline = 0;
        strSQL = "[WFMPMS].[GetAnalyticTimelineScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", MyEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        AnalyticTimeline = Convert.ToInt32(sdr.GetValue(0));
                    }
                }
                ltlOntimeDelivery.Text = "On Time Delivery &nbsp= &nbsp" + "<div class=\"pull-right header\">" + AnalyticTimeline + "</div>";
            }

        }
    }

    private void fillltlAccuracy()
    {
        Accuracy = 0;
        strSQL = "[WFMPMS].[GetAnalyticAccuracyScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", MyEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        Accuracy = Convert.ToInt32(sdr.GetValue(0));
                    }
                }
                ltlAccuracy.Text = "Accuracy &nbsp= &nbsp" + "<div class=\"pull-right header\">" + Accuracy + "</div>";
            }

        }
    }

    private void fillltlIEXMgmt(int ForEmpID)
    {
        IEXMgmt = 0;
        strSQL = "[WFMPMS].[GetIEXMgmtScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        IEXMgmt = Convert.ToInt32(sdr.GetValue(0));
                    }
                }
                ltlIEX_Management.Text = "IEX Management &nbsp= &nbsp";
                ltl_IEX_Management.Text = IEXMgmt.ToString();
            }

        }
    }

    private void fillltlAnalyticProject(int ForEmpID)
    {
        AnalyticProject = 0;
        strSQL = "[WFMPMS].[getAnalyticProjectScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        AnalyticProject = Convert.ToInt32(sdr.GetValue(0));
                    }
                }
                ltlAnalyticProject.Text = "Projects &nbsp= &nbsp" + "<div class=\"pull-right header\">" + AnalyticProject + "</div>";
            }

        }
    }

    private void fillltlAnalyticCoaching(int ForEmpID)
    {
        AnalyticCoaching = 0;
        strSQL = "[WFMPMS].[getAnalyticCoachingScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        AnalyticCoaching = Convert.ToInt32(sdr.GetValue(0));
                    }
                }
                ltlCoachingFeedback.Text = "Coaching & Feedback &nbsp= &nbsp" + "<div class=\"pull-right header\">" + AnalyticCoaching + "</div>";
            }

        }
    }

    private void fillltlfinalScore(int ForEmpID)
    {
        int FinalScore = 0;
        strSQL = "[WFMPMS].[getPacmanFinalScore]";
        using (SqlConnection cn = new SqlConnection(my.getConnectionString()))
        {
            cn.Open();
            using (SqlCommand cmd = new SqlCommand(strSQL, cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
                cmd.Parameters.AddWithValue("@PacmanCycle", PacmanCycle);
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    if (sdr.HasRows)
                    {
                        FinalScore = Convert.ToInt32(sdr.GetValue(0));
                        ltlfinalScore.Text = FinalScore.ToString();
                    }
                    else
                    { ltlfinalScore.Text = "Pacman discussion not completed"; }
                }

            }
        }
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
}