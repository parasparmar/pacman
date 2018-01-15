﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PacmanDiscussion.aspx.cs" Inherits="PacmanDiscussion" %>


<%@ MasterType VirtualPath="~/MasterPage.master" %>

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
    </style>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="pageheader" runat="Server">
    <ol class="breadcrumb">
        <li><a href="index.aspx"><i class="iconfa-home"></i>Home</a></li>
        <li class="active"><a href="PacmanDiscussion.aspx"><i class="fa fa-file-text"></i>Pacman Discussion</a></li>
    </ol>

    <div class="pageheader">
        <div class="pageicon"><span class="fa fa-file-text"></span></div>
        <div class="pagetitle">
            <h5>Discussion of Monthly Performance <strong>for my team</strong></h5>
            <h1>PACMAN Discussion</h1>
        </div>
    </div>
    <!--pageheader-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="The_Body" runat="Server">

    <!-- Small boxes (Stat box) -->
    <%--<div class="row">
        <div class="col-lg-2 col-xs-4">
            <!-- small box -->
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>3.59</h3>
                    <p>service level</p>
                </div>
                <div class="icon">
                </div>
                <a href="#" class="small-box-footer">more info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-xs-4">
            <!-- small box -->
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>2.48<sup style="font-size: 20px"></sup></h3>

                    <p>btp</p>
                </div>
                <div class="icon">
                </div>
                <a href="#" class="small-box-footer">more info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-xs-4">
            <!-- small box -->
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>3.6</h3>

                    <p>coaching</p>
                </div>
                <div class="icon">
                </div>
                <a href="#" class="small-box-footer">more info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-xs-4">
            <!-- small box -->
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>5.0</h3>

                    <p>escalations</p>
                </div>
                <div class="icon">
                </div>
                <a href="#" class="small-box-footer">more info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-xs-4">
            <!-- small box -->
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>5.0</h3>

                    <p>attendance</p>
                </div>
                <div class="icon">
                </div>
                <a href="#" class="small-box-footer">more info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-xs-4">
            <!-- small box -->
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>3.0</h3>

                    <p>rta optimization</p>
                </div>
                <div class="icon">
                </div>
                <a href="#" class="small-box-footer">more info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
    </div>--%>
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


                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Select Review Stage</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlStage" OnDataBound="ddlStage_DataBound" runat="server" OnSelectedIndexChanged="ddlStage_SelectedIndexChanged" AutoPostBack="true">
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
                            <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlReportee" runat="server">
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
                            <asp:DropDownList ItemType="text" CssClass="form-control select" ID="DropDownList3" runat="server">
                                <asp:ListItem Enabled="true" Selected="True" Text="Select SPI Status" Value="2"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="False" Value="0"></asp:ListItem>
                                <asp:ListItem Enabled="true" Text="True" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- /.input group -->
                    </div>
                </div>
            </div>
        </div>
    </div>

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
                        <asp:Literal ID="ltlEmloyeeBanner" runat="server"></asp:Literal>
                    </li>
                </ul>
                <div class="tab-content no-padding">
                    <!-- Morris chart - Sales -->
                    <div class="box-body tab-pane active" id="monthly-scorecard" style="position: relative; height: 300px;">
                        <!-- START ACCORDION & CAROUSEL-->
                        <%--<h2 class="page-header"></h2>--%>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="box box-solid">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Score Card
                                            <asp:Literal ID="ltlfinalScore" runat="server"></asp:Literal>
                                        </h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">

                                        <div class="box-group" id="accordion">
                                            <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->

                                            <!--Common KPI for RTA, Scheduler, Planner-->
                                            <asp:Panel ID="pnl_KPI" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                                            <asp:Literal ID="ltlPrimaryKPI" runat="server" Text="Primary KPI : "></asp:Literal>
                                                            <asp:Literal ID="ltl_KPI" Text="0" runat="server"></asp:Literal></a>
                                                    </h4>
                                                </div>
                                                <div id="collapseOne" class="panel-collapse collapse in">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlKPI" runat="server">
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--Primary KPI-->
                                            <asp:Panel ID="pnl_BTP" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                                            <asp:Literal ID="ltlBTP" runat="server" Text="BTP : Billed To Pay Ratio"></asp:Literal>
                                                            <asp:Literal ID="ltl_BTP" Text="0" runat="server"></asp:Literal>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseTwo" class="panel-collapse collapse">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlBTP" runat="server">
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--BTP-->
                                            <asp:Panel ID="pnl_Escalations" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
                                                            <asp:Literal ID="ltlEI" runat="server" Text="Escalations & Initiatives : "></asp:Literal>
                                                            <asp:Literal ID="ltl_Escalations" Text="0" runat="server"></asp:Literal>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <%--<div id="collapseThree" class="panel-collapse collapse">
                                                    <div class="box-body">
                                                        
                   
                                                    </div>
                                                </div>--%>
                                            </asp:Panel>
                                            <!--Escalations & Initiatives-->

                                            <!--Commom KPI for all(RTA, Scheduler, Planner, Analytics)-->
                                            <asp:Panel ID="pnl_Absenteeism" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
                                                            <asp:Literal ID="ltlAbsenteeism" runat="server" Text="Absenteeism : "></asp:Literal>
                                                            <asp:Literal ID="ltl_Absenteeism" Text="0" runat="server"></asp:Literal>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <%--<div id="collapseFour" class="panel-collapse collapse">
                                                    <div class="box-body">
                                                    </div>
                                                </div>--%>
                                            </asp:Panel>
                                            <!--Self-Attendance-->

                                            <!--RTA KPI's-->
                                            <asp:Panel ID="pnl_Real_Time_Optimization" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
                                                            <asp:Literal ID="ltlOptimization" runat="server" Text="Real Time Optimization KPI"></asp:Literal>
                                                            <asp:Literal ID="ltl_Real_Time_Optimization" Text="0" runat="server"></asp:Literal>
                                                        </a>

                                                    </h4>
                                                </div>
                                                <div id="collapseFive" class="panel-collapse collapse">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlOptimization" runat="server">
                                                        </asp:Panel>

                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--Real Time Optimization KPI-->

                                            <!-- Planner KPI's -->
                                            <asp:Panel ID="pnl_Forecasting_Accuracy" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseSix">
                                                            <asp:Literal ID="ltlForecasting_Accuracy" runat="server" Text="Forecast Accuracy : "></asp:Literal>
                                                            <asp:Literal ID="ltl_Forecasting_Accuracy" Text="0" runat="server"></asp:Literal>

                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseSix" class="panel-collapse collapse in">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlForecasting_Accuracy" runat="server">
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--Forecast Accuracy-->
                                            <asp:Panel ID="pnl_Headcount_Accuracy" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseSeven">
                                                            <asp:Literal ID="ltlHeadcount_Accuracy" runat="server" Text="Headcount Accuracy"></asp:Literal>
                                                            <asp:Literal ID="ltl_Headcount_Accuracy" Text="0" runat="server"></asp:Literal>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseSeven" class="panel-collapse collapse in">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlHeadcount_Accuracy" runat="server">
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--Headcount Accuracy-->

                                            <!--Scheduler KPI's-->
                                            <asp:Panel ID="pnl_Scheduling_Accuracy" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseNine">
                                                            <asp:Literal ID="ltlSchedulingAccuracy" runat="server" Text="Scheduling Accuracy"></asp:Literal>
                                                            <asp:Literal ID="ltl_Scheduling_Accuracy" Text="0" runat="server"></asp:Literal></a>
                                                    </h4>
                                                </div>
                                                <div id="Div1" class="panel-collapse collapse in">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlScheduling_Accuracy" runat="server">
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--Scheduling Accuracy-->

                                            <asp:Panel ID="pnl_IEX_Management" CssClass="panel box box-primary" runat="server" Visible="false">
                                                <div class="box-header with-border">
                                                    <h4 class="box-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseEight">
                                                            <asp:Literal ID="ltlIEX_Management" runat="server" Text="IEX Management"></asp:Literal>
                                                            <asp:Literal ID="ltl_IEX_Management" Text="0" runat="server"></asp:Literal>

                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseEight" class="panel-collapse collapse">
                                                    <div class="box-body">
                                                        <asp:Panel ID="pnlIEX_Management" runat="server">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <asp:Literal ID="Literal5" runat="server" Text="Select rating"></asp:Literal>
                                                                    <asp:DropDownList ID="ddlIEXMgmtScore" runat="server" CssClass="form-control select">
                                                                        <asp:ListItem Value="5" Text="5" runat="server"></asp:ListItem>
                                                                        <asp:ListItem Value="4" Text="4" runat="server"></asp:ListItem>
                                                                        <asp:ListItem Value="3" Text="3" runat="server"></asp:ListItem>
                                                                        <asp:ListItem Value="2" Text="2" runat="server"></asp:ListItem>
                                                                        <asp:ListItem Value="1" Text="1" runat="server"></asp:ListItem>
                                                                        <asp:ListItem Value="0" Text="0" runat="server"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <asp:Label ID="label1" runat="server">Please enter comments</asp:Label>
                                                                    <asp:TextBox ID="txtIEXMgmtComments" runat="server" CssClass="form-control select" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-2">
                                                                    <asp:Button ID="btnIEXMgmtScoreSubmit" runat="server" Text="submit" CssClass="btn btn-primary" OnClick="btnIEXMgmtScoreSubmit_Click" />
                                                                </div>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <!--IEX Management-->

                                            <!--Analytics KPI-->
                                            <asp:Panel ID="pnl_Analytics" runat="server" Visible="false">

                                                <div class="panel box box-warning">
                                                    <div class="box-header with-border">
                                                        <h4 class="box-title">
                                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTen">
                                                                <asp:Literal ID="ltlCoachingFeedback" runat="server" Text="Coaching  & Feedback"></asp:Literal></a>
                                                        </h4>
                                                    </div>
                                                    <div id="collapseTen" class="panel-collapse collapse">
                                                        <div class="box-body">
                                                            <asp:Panel ID="Panel5" runat="server">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <asp:Literal ID="ltlCoaching" runat="server" Text="Select rating"></asp:Literal>
                                                                        <asp:DropDownList ID="ddlCoaching" runat="server" CssClass="form-control select">
                                                                            <asp:ListItem Value="5" Text="5" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="4" Text="4" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="3" Text="3" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="2" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="1" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="0" Text="0" runat="server"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <asp:Label ID="label3" runat="server">Please enter comments</asp:Label>
                                                                        <asp:TextBox ID="txtCoachingComments" runat="server" CssClass="form-control select" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <asp:Button ID="btnCoachingScoreSubmit" runat="server" Text="submit" CssClass="btn btn-primary" OnClick="btnCoachingScoreSubmit_Click" />
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="panel box box-warning">
                                                    <div class="box-header with-border">
                                                        <h4 class="box-title">
                                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseEleven">
                                                                <asp:Literal ID="ltlOntimeDelivery" runat="server" Text="On-Time Delivery"></asp:Literal>
                                                            </a>
                                                        </h4>
                                                    </div>
                                                    <div id="collapseEleven" class="panel-collapse collapse">
                                                        <div class="box-body">
                                                            <asp:Panel ID="Panel6" runat="server">
                                                            </asp:Panel>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel box box-warning">
                                                    <div class="box-header with-border">
                                                        <h4 class="box-title">
                                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwelve">
                                                                <asp:Literal ID="ltlAccuracy" runat="server" Text="Accuracy"></asp:Literal></a>
                                                        </h4>
                                                    </div>
                                                    <div id="collapseTwelve" class="panel-collapse collapse">
                                                        <div class="box-body">
                                                            <asp:Panel ID="Panel7" runat="server">
                                                            </asp:Panel>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel box box-warning">
                                                    <div class="box-header with-border">
                                                        <h4 class="box-title">
                                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseProject">
                                                                <asp:Literal ID="ltlProject" runat="server" Text="Projects"></asp:Literal>
                                                                <asp:Literal ID="ltlAnalyticProject" runat="server" Text="Projects"></asp:Literal>
                                                            </a>
                                                        </h4>
                                                    </div>
                                                    <div id="collapseProject" class="panel-collapse collapse">
                                                        <div class="box-body">
                                                            <asp:Panel ID="Panel8" runat="server">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <asp:Literal ID="ltlAnalyticsproject" runat="server" Text="Select rating"></asp:Literal>
                                                                        <asp:DropDownList ID="ddlAnalyticProject" runat="server" CssClass="form-control select">
                                                                            <asp:ListItem Value="5" Text="5" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="4" Text="4" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="3" Text="3" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="2" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="1" runat="server"></asp:ListItem>
                                                                            <asp:ListItem Value="0" Text="0" runat="server"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <asp:Label ID="label2" runat="server">Please enter comments</asp:Label>
                                                                        <asp:TextBox ID="txtAnalyticProject" runat="server" CssClass="form-control select" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <asp:Button ID="btnAnalyticProjectScoreSubmit" runat="server" Text="submit" CssClass="btn btn-primary" OnClick="btnAnalyticProjectScoreSubmit_Click" />
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>

                                                        </div>
                                                    </div>
                                                </div>

                                            </asp:Panel>
                                        </div>
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
        </section>
        <!-- /.Left col -->
        <!-- /.Left col -->
        <div class="col-md-6">
            <div class="box">
                <div class="box-body">
                    <div class="form-group">
                        <h4>Has the above Reportee's PACMAN been discussed?
                 <span class="btn-group pull-right">
                     <asp:Button ID="btnNotDiscussed" runat="server" Text="Not Discussed" CssClass="btn btn-default" />
                     <asp:Button ID="btnYesDiscussed" runat="server" Text="Discussed" CssClass="btn btn-primary" OnClick="btnYesDiscussed_Click" />
                 </span>
                        </h4>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box">
                <div class="box-body">
                    <div class="form-group">
                        <h4>Submit PACMAN for Employee's Acknowledgement
                 <span class="btn-group pull-right">
                     <%--<asp:Button ID="btnDoNotAgree" runat="server" Text="I Do Not Agree" CssClass="btn btn-warning" />--%>
                     <asp:Button ID="btnSubmitPacman" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSubmitPacman_Click" />
                 </span>
                        </h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.row (main row) -->

</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="below_footer" runat="Server">

    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>


</asp:Content>

