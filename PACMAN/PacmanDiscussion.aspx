﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PacmanDiscussion.aspx.cs" Inherits="PacmanDiscussion" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content4" ContentPlaceHolderID="pageheader" runat="Server">
    <ol class="breadcrumb">
        <li><a href="index.aspx"><i class="iconfa-home"></i>Home</a></li>
        <li class="active"><a href="PacmanDiscussion.aspx"><i class="fa fa-file-text"></i>Pacman Discussion</a></li>
    </ol>

    <div class="pageheader">
        <div class="pageicon"><span class="fa fa-file-text"></span></div>
        <div class="pagetitle">
            <h5>Discussion of Monthly Performance</h5>
            <h1>PACMAN Discussion</h1>
        </div>
    </div>
    <!--pageheader-->
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="Server">
    <link href="Sitel/plugins/bootstrap-toggle/css/bootstrap-toggle.min.css" rel="stylesheet" />
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="AdminLTE/plugins/iCheck/all.css">
    <style>
        .border-between > [class*='col-']:before {
            background: #e3e3e3;
            bottom: 0;
            content: " ";
            left: 0;
            position: absolute;
            width: 1px;
            top: 0;
        }

        .content-wrapper {
            min-height: 897.76px !important;
        }

        .border-between > [class*='col-']:first-child:before {
            display: none;
        }

        /* Inline style div.widget-user-header */
        div.widget-user-header {
            padding-top: 10px !important;
            padding-bottom: 40px !important;
        }

        /* AdminLTE.css (3063, 42) */
        .widget-user-2 .widget-user-image > img {
            width: 65px !important;
            height: 65px !important;
            float: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="The_Body" runat="Server">

    <!-- Small boxes (Stat box) -->

    <!-- /.row -->
    <div class="box">
        <div class="box-body">
            <div class="form-group">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Select Pacman Cycle</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar-check-o"></i>
                            </div>
                            <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlReviewPeriod" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlReviewPeriod_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <!-- /.input group -->
                    </div>
                </div>
                <asp:Panel ID="pnlIsPacmanDiscussion" runat="server" Visible="true">
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label>Select Review Stage</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlStage" runat="server" OnSelectedIndexChanged="ddlStage_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                            <!-- /.input group -->
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label>Select Reportee</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-user"></i>
                                </div>
                                <asp:DropDownList ItemType="text" CssClass="form-control select2" ID="ddlReportee"
                                    runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlReportee_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <!-- /.input group -->
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label>Is SPI</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-user"></i>
                                </div>
                                <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlSPI" runat="server">
                                    <%--<asp:ListItem Enabled="true" Selected="True" Text="Select SPI Status" Value="2"></asp:ListItem>--%>
                                    <asp:ListItem Enabled="true" Text="False" Value="0"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Text="True" Value="1"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <!-- /.input group -->
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>

    <asp:Panel ID="pnlOverall" runat="server" Visible="false">
        <div id="leftSection" class="col-md-4">
            <asp:Repeater ID="rptOverAll" runat="server">
                <HeaderTemplate>
                    <!-- Widget: user widget style 1 -->
                    <div class="box box-widget widget-user-2">
                        <!-- Add the bg color to the header using any of the bg-* classes -->
                        <div class="widget-user-header bg-primary">
                            <div class="widget-user-image">
                                <asp:Image ID="imgReportee" CssClass="img-circle" ImageUrl="~/Sitel/user_images/unknownUser.jpg" runat="server" AlternateText="Avatar" />
                            </div>
                            <!-- /.widget-user-image -->
                            <h1 class="widget-user-desc"></h1>
                            <h1 class="widget-user-desc"></h1>
                            <h4 class="widget-user-username" style="font-size: large">
                                <asp:Literal ID="ltlUserName" runat="server" Text="My Name"></asp:Literal>
                            </h4>
                        </div>
                        <div id="leftBox"  class="box-footer no-padding">
                            <ul class="nav nav-stacked">
                </HeaderTemplate>
                <ItemTemplate>
                    <li>
                        <a>
                            <asp:Literal ID="ltlHeader" runat="server" Text='<%# Eval("Row")%>'></asp:Literal>
                            <span class="pull-right badge">
                                <asp:Literal ID="ltlValue" runat="server" Text='<%# Eval("Column")%>'></asp:Literal>
                            </span>
                        </a>
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                                </div>                            
                            <!-- /.widget-user -->
                    </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div id="rightSection" class="col-md-8">
            <!-- Widget: user widget style 1 -->
            <div class="box box-widget widget-user-2">
                <!-- Add the bg color to the header using any of the bg-* classes -->
                <div class="widget-user-header bg-gray">
                    <div class="widget-user-image">
                        <asp:Image ID="imgReportingMgr" CssClass="img-circle" ImageUrl="~/Sitel/user_images/unknownPerson.jpg" runat="server" AlternateText="Avatar" />
                    </div>
                    <!-- /.widget-user-image -->
                    <h1 class="widget-user-desc"></h1>
                    <h1 class="widget-user-desc"></h1>
                    <h4 class="widget-user-username" style="font-size: large">My Comments for the Cycle.</h4>
                </div>
                <div class="box-footer no-padding">
                    <asp:TextBox ID="tbManualComments" CssClass="form-control bg-info" Rows="4"
                        TextMode="MultiLine" Wrap="True" ReadOnly="true" BorderStyle="None"
                        BorderWidth="0" Font-Names="Tahoma" Height="100px"
                        Style="overflow: hidden;" runat="server"></asp:TextBox>

                    <li id="rightFooter">
                            <asp:Label ID="lblOverAll" runat="server" CssClass="text text-primary text-uppercase form-control" Text=""></asp:Label>
                        </li>
                </div>
            </div>
            <!-- /.widget-user -->
        </div>
    </asp:Panel>



    <!-- Main row -->
    <div class="row">
        <!-- Left col -->
        <section class="col-lg-12 connectedSortable">
            <!-- Custom tabs (Charts with tabs)-->
            <div class="nav-tabs-custom">
                <!-- Tabs within a box -->
                <ul class="nav nav-tabs pull-right">
                    <li><a href="#itemized-details" data-toggle="tab">Itemized Details</a></li>
                    <li class="active"><a href="#monthly-scorecard" data-toggle="tab">Overall Scorecard</a></li>

                    <li class="pull-left header"><i class="fa fa-inbox"></i>
                        <asp:Literal ID="ltlEmployeeBanner" runat="server"></asp:Literal>
                    </li>
                </ul>
                <div class="tab-content no-padding">
                    <!-- Morris chart - Sales -->
                    <div class="box-body tab-pane active" id="monthly-scorecard" style="position: relative; min-height: 300px;">
                        <!-- START ACCORDION & CAROUSEL-->
                        <%--<h2 class="page-header"></h2>--%>

                        <div class="row" id="one" runat="server">
                            <div class="col-md-12">
                                <div class="box box-solid">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Overall Score :
                                            <asp:Literal ID="ltlFinalRating" Text="0" runat="server"></asp:Literal>
                                        </h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <asp:Repeater ID="rp" runat="server" OnItemDataBound="rp_ItemDataBound">
                                            <HeaderTemplate>
                                                <div class="box-group" id="accordion">
                                                    <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                                                    <!--Common KPI for RTA, Scheduler, Planner-->
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Panel ID="pnl_KPI" CssClass="panel box box-primary" runat="server" Visible="true">
                                                    <div class="box-header with-border">
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <h4 class="box-title">
                                                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# Eval("KPIID") %>">
                                                                        <asp:Label ID="ltlKPIName" Text='<%#Eval("Metric") %>' runat="server"></asp:Label>
                                                                    </a>
                                                                </h4>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# Eval("KPIID") %>">
                                                                    <h4 class="box-title">Wtg %:
                                                                    <asp:Label ID="ltlKPIWeightage" Text='<%#Convert.ToDecimal(Eval("KPIWtg"))*100 %>' runat="server"></asp:Label>
                                                                    </h4>
                                                                </a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# Eval("KPIID") %>">
                                                                    <h4 class="box-title">Score :
                                                                    <asp:Label ID="ltlKPIScore" Text="0" runat="server"></asp:Label>
                                                                    </h4>
                                                                </a>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <%--<a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# Eval("KPIID") %>">
                                                                    <h4 class="box-title">Wtd Score :
                                                                    <asp:Literal ID="ltlWeightedScore" Text="0" runat="server"></asp:Literal>
                                                                    </h4>
                                                                </a>--%>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <asp:LinkButton ID="btnKPI" CssClass="btn btn-primary btn-flat pull-right"
                                                                    CommandArgument='<%# Eval("KPIID") %>' Text="Download Details"
                                                                    runat="server" CausesValidation="false" OnClick="btnKPI_Click"><i class="fa fa-download"></i></asp:LinkButton>
                                                            </div>
                                                        </div>
                                                        <!-- /.box-tools -->
                                                    </div>
                                                    <!-- /.box-header -->
                                                    <div id="collapse<%# Eval("KPIID") %>" class="panel-collapse collapse">
                                                        <div class="box-body">
                                                            <asp:Panel ID="pnlKPI" runat="server">

                                                                <div class="row">
                                                                    <asp:Panel ID="dvKPI" class="col-md-12" runat="server">
                                                                        <asp:GridView ID="gvKPI" runat="server" CssClass="table table-condensed"></asp:GridView>
                                                                    </asp:Panel>
                                                                </div>
                                                            </asp:Panel>
                                                            <!--Auto KPI Panel-->
                                                            <asp:Panel ID="pnlManualKPI" runat="server" Visible="false">
                                                                <div class="row">
                                                                    <div class="form-group">
                                                                        <div class="col-md-3">
                                                                            <asp:Literal ID="Literal5" runat="server" Text="Select rating"></asp:Literal>
                                                                            <asp:DropDownList ID="ddlManualScore" runat="server" CssClass="form-control select">
                                                                                <asp:ListItem Value="5" Text="5" runat="server"></asp:ListItem>
                                                                                <asp:ListItem Value="4" Text="4" runat="server"></asp:ListItem>
                                                                                <asp:ListItem Value="3" Text="3" runat="server"></asp:ListItem>
                                                                                <asp:ListItem Value="2" Text="2" runat="server"></asp:ListItem>
                                                                                <asp:ListItem Value="1" Text="1" runat="server"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <asp:Label ID="label1" runat="server">Please enter comments</asp:Label>
                                                                            <asp:TextBox ID="txtManualComments" runat="server" CssClass='form-control' TextMode="MultiLine" Rows="2" CausesValidation="false"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <asp:Label ID="lbl" Text="." runat="server"></asp:Label>
                                                                            <asp:Button ID="btnManualScoreSubmit" runat="server" Text="submit" CommandArgument='<%#Eval("KPIID") %>' CssClass="btn btn-primary" OnClick="btnManualScoreSubmit_Click" CausesValidation="false" />
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </asp:Panel>
                                                            <!--Manual KPI Panel-->
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                                <!--Primary KPI-->
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </div>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <!-- /.box-body -->
                                </div>
                                <!-- /.box -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                        <!-- END ACCORDION & CAROUSEL-->

                    </div>
                    <%--<div class="chart tab-pane" id="itemized-details" style="position: relative">
                        <asp:GridView ID="tblKPI" runat="server" CssClass="table table-condensed table-bordered table-responsive"
                            AutoGenerateColumns="true">
                        </asp:GridView>

                    </div>--%>
                    <%--<div class="chart tab-pane" id="itemized-details2" style="position: relative; height: 300px;"></div>--%>
                </div>
                <div class="box-footer"></div>
            </div>
            <!-- /.nav-tabs-custom -->

            <!-- /.Left col -->
            <asp:Panel ID="pnlSubmission" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-12">
                        <!-- quick email widget -->
                        <div class="box box-info">
                            <div class="box-header">
                                <i class="fa fa-envelope"></i>
                                <h3 class="box-title">Feedback</h3>
                            </div>
                            <div class="box-body">
                                <div>
                                    <asp:TextBox ID="tbFeedback" CssClass="textarea" TextMode="MultiLine" placeholder="Feedback" runat="server" MaxLength="254"
                                        Style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv" runat="server" ErrorMessage="Feedback is mandatory." ForeColor="Red" ControlToValidate="tbFeedback"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegExp1" runat="server"
                                        ErrorMessage="Character length should not exceed 254 characters" ForeColor="Red"
                                        ControlToValidate="tbFeedback"
                                        ValidationExpression="^.{10,254}$" />
                                </div>
                                <input type="text" style="width: 50px; border: none;" class="pull-right" readonly="readonly" disabled id="tbChLength" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="box">
                            <div class="box-body">
                                <div class="form-group">
                                    <h4>Has the above Reportee's PACMAN been discussed?
                 <span class="btn-group pull-right">
                     <asp:Button ID="btnAcknowledged" runat="server" Enabled="false" Text="Discussed" CssClass="btn btn-primary" OnClick="btnAcknowledged_Click" />
                 </span>
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </section>
        <!-- /.Left col -->
    </div>
    <!-- /.row (main row) -->

</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="below_footer" runat="Server">

    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <script>
        $(function () {
            $("#tbFeedback").change(function () {
                $("#tbChLength").val($(this).text().length);
            });
            if ($("#pnlOverall") !== null) {
                var tbManualCommentsPadding = $("#tbManualComments").innerHeight() - $("#tbManualComments").height();
                var leftBox = $("#leftBox").height();
                var rightFooter = $("#rightFooter").height();

                var desiredHeight = leftBox - rightFooter - tbManualCommentsPadding;
                $("#tbManualComments").height(desiredHeight);
            }
        });

    </script>
</asp:Content>

