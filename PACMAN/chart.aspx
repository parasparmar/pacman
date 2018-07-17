﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="chart.aspx.cs" Inherits="chart" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content4" ContentPlaceHolderID="pageheader" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="The_Body" runat="Server">
    <%--<div class="box">
        <div class="box-body">
            <div class="form-group">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Select Manager</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar-check-o"></i>
                            </div>
                            <asp:DropDownList ItemType="text" CssClass="form-control select2" ID="ddlMgr" runat="server" OnSelectedIndexChanged="ddlMgr_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <!-- /.input group -->
                    </div>
                </div>
                <asp:Panel ID="pnlIsPacmanDiscussion" runat="server" Visible="true">
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label>Select Reportee</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlStage" runat="server">
                                </asp:DropDownList>
                            </div>
                            <!-- /.input group -->
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label>Select Designation</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-user"></i>
                                </div>
                                <asp:DropDownList ItemType="text" CssClass="form-control select2" ID="ddlDesignation"
                                    runat="server" AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                            <!-- /.input group -->
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="form-group">
                            <label>Select Role</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-user"></i>
                                </div>
                                <asp:DropDownList ItemType="text" CssClass="form-control select" ID="ddlSPI" runat="server">                                    
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
    </div>--%>
    <asp:ListView ID="lvMGR" runat="server">
        <LayoutTemplate>
            <div class="row" id="itemPlaceholderContainer" runat="server">
                <div class="col-md-6" id="itemPlaceholder" runat="server">
                </div>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div class="col-md-6" runat="server">
                <div class="box box-primary" runat="server">
                    <div class="box-header with-border" runat="server">
                        <h3 class="box-title" runat="server">Logged In User : <%#Eval("NAME") %></h3>
                        <div class="box-tools pull-right" runat="server">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse" runat="server">
                                <i class="fa fa-minus" runat="server"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove" runat="server"><i class="fa fa-times" runat="server"></i></button>
                        </div>
                    </div>
                    <div class="box-body" runat="server">
                        <div class="chart-container" runat="server">
                            <canvas id="managerchart" runat="server"></canvas>
                        </div>
                    </div>
                    <!-- /.box-body  -->
                </div>
                <!-- /.box -->
            </div>
        </ItemTemplate>
    </asp:ListView>
    <asp:ListView ID="lvSkill" runat="server">
        <LayoutTemplate>
            <div class="row" id="itemPlaceholderContainer" runat="server">
                <div class="col-md-3" id="itemPlaceholder" runat="server">
                </div>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div class="col-md-3" runat="server">
                <div class="box box-primary" runat="server">
                    <div class="box-header with-border" runat="server">
                        <h3 class="box-title" runat="server">Department : <%#Eval("Skill") %></h3>
                        <div class="box-tools pull-right" runat="server">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse" runat="server">
                                <i class="fa fa-minus" runat="server"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove" runat="server"><i class="fa fa-times" runat="server"></i></button>
                        </div>
                    </div>
                    <div class="box-body" runat="server">
                        <div class="chart-container" runat="server">
                            <canvas id="managerchart" runat="server"></canvas>
                        </div>
                    </div>
                    <!-- /.box-body  -->
                </div>
                <!-- /.box -->
            </div>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="below_footer" runat="Server">
    <!-- Pace style -->
    <link href="AdminLTE/plugins/pace/pace.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
    <!-- PACE -->
    <%--<script src="AdminLTE/plugins/pace/pace.min.js"></script>--%>
    <script>
        $(function () {
            //fillTypeList("", "ddlMgr");
        });
        function NineBoxChart(xdata) {
            var ctx = $("#myChart");
            if (xdata != null) {
                ctx.empty();
            }
            var myChart = new Chart(ctx, {
                type: 'bubble',
                data: {
                    labels: "Managers",
                    datasets: xdata,
                    hoverRadius: 0
                },

                options: {
                    title: {
                        display: true,
                        text: 'Scores acheived by Managers on PACMAN Tests and Feedback scores'
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                min: 0,
                                max: 100,
                                stepSize: 33.33,
                                maxTicksLimit: 4
                            },
                            scaleLabel: {
                                display: true,
                                labelString: "Feedback Scores (More is better)"
                            }
                        }],
                        xAxes: [{
                            ticks: {
                                beginAtZero: true,
                                min: 0,
                                max: 100,
                                stepSize: 33.33,
                                maxTicksLimit: 4
                            },
                            scaleLabel: {
                                display: true,
                                labelString: "Pacman Scores (More is better)"
                            }
                        }]
                    },
                },

            });
        }
        function fillChartbubble() {
            //debugger;
            $(document).ajaxStart(function () {
                Pace.start();
            });
            var optionSelected = $("[id$=ddlStage] option:selected").val();
            var params = '{"stageID":"' + optionSelected + '"}';
            if (optionSelected != "" && optionSelected != "0") {
                //debugger;
                var myDropDownList = $('#ddlStage');
                $.ajax({
                    type: "POST",
                    url: "/chart.aspx/GetBubbleChart",
                    data: params,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //debugger;
                        console.log(data.d);

                        var dynamicColors = function () {
                            var r = Math.floor(Math.random() * 255);
                            var g = Math.floor(Math.random() * 255);
                            var b = Math.floor(Math.random() * 255);
                            return "rgb(" + r + "," + g + "," + b + ")";
                        };
                        var xDataSets = [];
                        for (var i = 0; i < data.d.length; i++) {
                            var xDataSet = {
                                label: data.d[i]["Name"].toString(),
                                backgroundColor: dynamicColors(),
                                borderColor: "rgb(69,70,72)",
                                borderWidth: 1,
                                hoverBorderWidth: 0,
                                hoverRadius: 4,
                                hitRadius: 1,
                                data: [
                                    {
                                        x: data.d[i]["Performance"].toString(),
                                        y: data.d[i]["Competency"].toString(),
                                        r: data.d[i]["Radius"].toString()
                                    }

                                ],
                                hoverRadius: 4,
                                hitRadius: 1,
                            };
                            xDataSets.push(xDataSet);
                        }
                        //debugger;
                        var strData = $.parseJSON(JSON.stringify(data.d));
                        NineBoxChart(xDataSets);

                    },
                    failure: function (response) {
                        alert(response.d);
                        $(document).ajaxStop(function () {
                            Pace.stop();
                        });
                    }
                });

                FillDesignationList(optionSelected);
                $(document).ajaxStop(function () {
                    Pace.stop();
                });
            }
        }
    </script>
</asp:Content>

