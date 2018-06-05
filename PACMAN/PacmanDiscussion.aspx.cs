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
using System.Web.Services;

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

    private DataTable dtTrf2DB;
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
                MyEmpID = dtEmp.Rows[0]["Employee_Id"].ToString().ToInt32();
                if (pnlIsPacmanDiscussion.Visible == false)
                {
                    ForEmpID = MyEmpID;
                }
                else if (ddlReportee.SelectedIndex > 0)
                {
                    ForEmpID = Convert.ToInt32(ddlReportee.SelectedItem.Value.ToString());
                }

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
        if (dtTrf2DB == null)
        {
            dtTrf2DB = new DataTable();
            dtTrf2DB.Columns.Add(new DataColumn("PeriodID"));
            dtTrf2DB.Columns.Add(new DataColumn("EmpCode"));
            dtTrf2DB.Columns.Add(new DataColumn("KPIRating"));
            dtTrf2DB.Columns.Add(new DataColumn("KPIID"));
            dtTrf2DB.Columns.Add(new DataColumn("IsSPI"));
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
        ddlReviewPeriod.Items.Insert(0,new ListItem("Please Select", "0"));
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
            btnAcknowledged.Enabled = dt1.Rows[0]["btnDiscussed"].ToString() == "1" ? true : false;
            
            if (btnAcknowledged.Enabled ) { pnlSubmission.Visible = true; }
        }
        else
        {
            btnAcknowledged.Enabled = false;            
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
        int lockid = ddlStage.SelectedValue.ToString().ToInt32();
        cmd.Parameters.AddWithValue("@LockID", lockid);

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
    protected void btnAcknowledged_Click(object sender, EventArgs e)
    {
        DataTable dtTrf2DB = Session["Transfer2DB"] as DataTable;
        strSQL = "PMS.UpdateReview";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        int rowsAffected = 0;
        foreach (DataRow trf in dtTrf2DB.Rows)
        {
            cmd.Parameters.AddWithValue("@PeriodID", trf["PeriodID"].ToInt32());
            cmd.Parameters.AddWithValue("@EmpCode", trf["EmpCode"].ToInt32());
            cmd.Parameters.AddWithValue("@KPIIRATING", Convert.ToDecimal(trf["KPIRating"].ToString()));
            cmd.Parameters.AddWithValue("@KPIID", trf["KPIID"].ToInt32());
            cmd.Parameters.AddWithValue("@IsSPI", trf["IsSPI"].ToInt32());
            rowsAffected += my.ExecuteDMLCommand(ref cmd, strSQL, "S");
            cmd.Parameters.Clear();
        }
        // To do : For this emp, LockID = 1 and SPI = false in PMS.Eligibility against this empcode and periodid

        strSQL = "PMS.UpdateEligibility";
        cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PeriodID", dtTrf2DB.Rows[0]["PeriodID"].ToInt32());
        cmd.Parameters.AddWithValue("@EmpCode", dtTrf2DB.Rows[0]["EmpCode"].ToInt32());
        cmd.Parameters.AddWithValue("@ActionedBy", MyEmpID);

        cmd.Parameters.AddWithValue("@Lock", 1);
        cmd.Parameters.AddWithValue("@IsSPI", dtTrf2DB.Rows[0]["IsSPI"].ToInt32());
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
        filltbFeedback();
    }
    private void filltbFeedback() {

        int PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue.ToString());
        fillStartAndEndDates();
        strSQL = "PMS.FillFeedback";
        SqlCommand cmd = new SqlCommand(strSQL);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
        cmd.Parameters.AddWithValue("@PeriodID", PeriodID);

        DtProcName = my.GetData(ref cmd);
        tbFeedback.Text = DtProcName.Rows[0]["DefaultRatingComments"].ToString();
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
            gv.Columns.Clear();
            List<ReviewUpdate> Transfer2DB = new List<ReviewUpdate>();
            ReviewUpdate k = new ReviewUpdate();
            k.EmpCode = ForEmpID;
            k.PeriodID = PeriodID;
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
                                cmd.Parameters.AddWithValue("@StartDate", StartDate);
                                cmd.Parameters.AddWithValue("@EndDate", EndDate);


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
                                    //Literal ltlWeightedScore = e.Item.FindControlRecursive("ltlWeightedScore") as Literal;
                                    ltlfinalScore.Text = Rating.ToString();
                                    //Button btn = e.Item.FindControlRecursive("btnKPI") as Button;
                                    if (!string.IsNullOrEmpty(Rating))
                                    {
                                        //btn.ID = "btnKPI" + KPIId;
                                        Decimal KPIRating = Convert.ToDecimal(Rating);
                                        k.KPIRating = KPIRating;
                                        Decimal KPIWtg = Convert.ToDecimal(dr["KPIWtg"].ToString());
                                        FinalRating += KPIRating * KPIWtg;
                                        ltlFinalRating.Text = Math.Round(FinalRating, 2).ToString();
                                    }
                                    else
                                    { ltlFinalRating.Text = string.Empty; }
                                    xShowButtons = true;
                                }
                            }
                            else
                            {
                                Panel pnlKPI = e.Item.FindControlRecursive("pnlKPI") as Panel;
                                pnlKPI.Visible = false;
                                Panel pnlManualKPI = e.Item.FindControlRecursive("pnlManualKPI") as Panel;
                                pnlManualKPI.Visible = true;
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



            foreach (ReviewUpdate l in Transfer2DB)
            {
                DataRow dtr = dtTrf2DB.NewRow();
                dtr[0] = l.PeriodID;
                dtr[1] = l.EmpCode;
                dtr[2] = l.KPIRating;
                dtr[3] = l.KPIID;
                dtr[4] = l.IsSPI;
                dtTrf2DB.Rows.Add(dtr);
            }
            Session["Transfer2DB"] = dtTrf2DB;

            pnlSubmission.Visible = xShowButtons;
        }
    }
    private void clearRP()
    {
        rp.Visible = false;
        ltlFinalRating.Text = "0";
        ltlEmployeeBanner.Text = string.Empty;
        tbFeedback.Text = string.Empty;
    }
    protected void btnManualScoreSubmit_Click(object sender, EventArgs e)
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
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
    private void populateGVOverall()
    {
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        string strSQL = "PMS.ShowEmpPacmanDetails";
        SqlConnection cn = new SqlConnection(my.getConnectionString());
        cn.Open();
        SqlCommand cmd = new SqlCommand(strSQL, cn);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
        cmd.Parameters.AddWithValue("@PeriodID", PeriodID);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        DataTable dtOverall = ds.Tables[0];
        DataTable dtPhase = ds.Tables[1];
        gvOverAll.DataSource = dtOverall;
        gvOverAll.DataBind();
        ltlOverAll.Text = dtPhase.Rows[0][0].ToString();
    }
    protected void btnKPI_Click(object sender, EventArgs e)
    {
        LinkButton btnKPI = sender as LinkButton;
        PeriodID = Convert.ToInt32(ddlReviewPeriod.SelectedValue);
        if (btnKPI != null)
        {
            string MyName = my.getFirstResult("select dbo.getFullName(" + ForEmpID + ") as FullName");

            int KPIID = btnKPI.CommandArgument.ToInt32();
            string strSQL = "PMS.FillKPI";
            SqlCommand cmd = new SqlCommand(strSQL);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
            cmd.Parameters.AddWithValue("@PeriodID", PeriodID);
            cmd.Parameters.AddWithValue("@KPIID", KPIID);
            DataTable dt = my.GetData(ref cmd);
            fillStartAndEndDates();
            string KPIName = dt.Rows[0]["Metric"].ToString();
            string ProcName = dt.Rows[0]["DetailedKPI"].ToString();
            string FileName = MyName + "'s " + KPIName + " for " + StartDate.ToString("MMM yyyy") + " downloaded " + DateTime.Now.ToString("dd-MMM-yyyy HH-mm-ss") + ".csv";

            cmd.Parameters.Clear();
            cmd = new SqlCommand(ProcName);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = my.open_db();
            cmd.Parameters.AddWithValue("@EmpCode", ForEmpID);
            cmd.Parameters.AddWithValue("@StartDate", StartDate);
            cmd.Parameters.AddWithValue("@EndDate", EndDate);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            
            DataSet ds = new DataSet();
            da.Fill(ds);

            foreach(DataTable d in ds.Tables)
            {
                d.TableName = FileName;

                //Get the physical path to the file.
                string FilePath = Server.MapPath("Sitel//metric_downloads//" + FileName);
                using (var textWriter = File.CreateText(FilePath))
                {
                    using (var csv = new CsvWriter(textWriter))
                    {
                        // Write columns
                        foreach (DataColumn column in d.Columns)
                        {
                            csv.WriteField(column.ColumnName);
                        }
                        csv.NextRecord();

                        // Write row values
                        foreach (DataRow row in d.Rows)
                        {
                            for (var i = 0; i < d.Columns.Count; i++)
                            {
                                csv.WriteField(row[i]);
                            }
                            csv.NextRecord();
                        }
                    }
                }

                //Send the CSV file as a Download.
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=" + FileName);
                Response.Charset = "";
                Response.ContentType = "application/text";
                Response.Output.Write(File.ReadAllText(FilePath));
                Response.Flush();
                Response.End();
                
                File.Delete(FilePath);
            }
            

            

        }
        

    }

//    TO DO
//1	Find Reportees
//2	Find KPIs Per Reportee
//3	Create Sets of Employees per KPI
//3	Run KPI Specific Procedures for employee sets

}

