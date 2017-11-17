USE [CWFM_Umang]
GO
/****** Object:  User [APC\avish001]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE USER [APC\avish001] FOR LOGIN [APC\avish001] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [APC\rkuch001]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE USER [APC\rkuch001] FOR LOGIN [APC\rkuch001] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [APC\vshir001]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE USER [APC\vshir001] FOR LOGIN [APC\vshir001] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [cwfm_umang]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE USER [cwfm_umang] FOR LOGIN [cwfm_umang] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [cwfm_umangpp]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE USER [cwfm_umangpp] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [APC\avish001]
GO
ALTER ROLE [db_datareader] ADD MEMBER [APC\avish001]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [APC\avish001]
GO
ALTER ROLE [db_owner] ADD MEMBER [APC\rkuch001]
GO
ALTER ROLE [db_datareader] ADD MEMBER [APC\rkuch001]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [APC\rkuch001]
GO
ALTER ROLE [db_owner] ADD MEMBER [APC\vshir001]
GO
ALTER ROLE [db_datareader] ADD MEMBER [APC\vshir001]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [APC\vshir001]
GO
ALTER ROLE [db_owner] ADD MEMBER [cwfm_umang]
GO
ALTER ROLE [db_datareader] ADD MEMBER [cwfm_umang]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [cwfm_umang]
GO
ALTER ROLE [db_owner] ADD MEMBER [cwfm_umangpp]
GO
ALTER ROLE [db_datareader] ADD MEMBER [cwfm_umangpp]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [cwfm_umangpp]
GO
/****** Object:  Schema [ACPER2]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [ACPER2]
GO
/****** Object:  Schema [CA]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [CA]
GO
/****** Object:  Schema [Debug]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [Debug]
GO
/****** Object:  Schema [FDT]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [FDT]
GO
/****** Object:  Schema [HiringModule]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [HiringModule]
GO
/****** Object:  Schema [IA]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [IA]
GO
/****** Object:  Schema [INTRADAY]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [INTRADAY]
GO
/****** Object:  Schema [KPI]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [KPI]
GO
/****** Object:  Schema [LA]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [LA]
GO
/****** Object:  Schema [PM]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [PM]
GO
/****** Object:  Schema [PMS]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [PMS]
GO
/****** Object:  Schema [PollTest]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [PollTest]
GO
/****** Object:  Schema [RTA]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [RTA]
GO
/****** Object:  Schema [Sample]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [Sample]
GO
/****** Object:  Schema [Seat]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [Seat]
GO
/****** Object:  Schema [TA]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [TA]
GO
/****** Object:  Schema [TDC]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [TDC]
GO
/****** Object:  Schema [WFMP]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [WFMP]
GO
/****** Object:  Schema [xAC_PRF]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [xAC_PRF]
GO
/****** Object:  Schema [xSPT]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE SCHEMA [xSPT]
GO
/****** Object:  UserDefinedTableType [WFMP].[ROSTEREE]    Script Date: 11/18/2017 3:51:43 AM ******/
CREATE TYPE [WFMP].[ROSTEREE] AS TABLE(
	[RosterID] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [int] NOT NULL,
	[DeptLinkId] [int] NOT NULL,
	[WeekID] [int] NOT NULL,
	[rDate] [smalldatetime] NOT NULL,
	[ShiftID] [int] NULL,
	[RepMgrCode] [int] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[updatedOn] [datetime] NOT NULL,
	[WOCount] [int] NULL,
	PRIMARY KEY CLUSTERED 
(
	[EmpCode] ASC,
	[rDate] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AccountDetails_Chart1]

@Client_Name varchar(255),
@YEAR varchar(255),
@MONTH varchar(255)

as

select ClientName, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal from(

select ClientName, sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit from   

(Select project_code,  

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,  

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal  

from financeraw2016  

where YEAR = @YEAR and 
[MONTH] = @MONTH and
Metric_Name = 'Revenue'  

group by Metric_Category, Metric_Name,Project_Code)  

a  

Left Join  

(Select * from Client_mapping)b  

on a.Project_Code = b.PRCode  

where ClientName is not null  

group by ClientName)x

where ClientName = @Client_Name
GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1_load]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AccountDetails_Chart1_load]


@Client_Name varchar(255)
as
select ClientName, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal from(
select ClientName, sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit from   

(Select project_code,  

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Budget,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Optimal
from financeraw2016 
where [Year] = datename(YEAR,GETDATE()) and 
 Metric_Name = 'Revenue' and
[month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+31),3),left(datename(M,GETDATE()+63),3))


group by Metric_Category, Metric_Name,Project_Code)  

a  

Left Join  

(Select * from Client_mapping)b  

on a.Project_Code = b.PRCode  

where ClientName is not null  

group by ClientName)x

where ClientName = @Client_Name

GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1_regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AccountDetails_Chart1_regional]

@Region varchar(255),
@Client_Name varchar(255)

AS

select ClientName,sum(Revenue) as Revenue,sum(Budget) as Budget,sum(Optimal) as Optimal from 
(select ClientName, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal,Location_Code from(
select ClientName, sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit,Location_Code 
from   

(Select project_code,  
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Budget,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Optimal,
Location_Code
from financeraw2016 
where [Year] = datename(YEAR,GETDATE()) and 
Metric_Name = 'Revenue' and
[month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+30),3),left(datename(M,GETDATE()+60),3))

group by Metric_Category, Metric_Name,Project_Code,Location_Code)a  

Left Join  
(Select * from Client_mapping)b  
on a.Project_Code = b.PRCode  
where ClientName is not null  
group by ClientName,Location_Code)x
where ClientName = @Client_Name
)Revenue

Left Join

(Select * from Location_Mapping)loc
on
Revenue.Location_Code = loc.LOC_Code
where 
loc.Region = @Region
group by ClientName

GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1_Slider]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AccountDetails_Chart1_Slider]

@Region varchar(255),
@Client_Name varchar(255)

AS

select ClientName,month,sum(Revenue) as Revenue,sum(Budget) as Budget,sum(Optimal)as Optimal,SUM(Act_COS)as ACT_COS,SUM(Budget_COS)as BDT_COS,SUM(OPT_COS)as OPT_COS  from 
(select ClientName,MONTH, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal,round(ACT_COS,0) as ACT_COS,round(BGT_COS,0)as Budget_COS,round(OPT_COS,0)as OPT_COS,Location_Code from(
select ClientName, month,sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,SUM(Act_COS) as ACT_COS,SUM(Budget_COS) as BGT_COS,SUM(Optimal_COS) as OPT_COS,Location_Code 
from   

(Select project_code, [MONTH],
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal,
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Budget_COS,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Optimal_COS,


Location_Code
from financeraw2016 
where [Year] = datename(YEAR,GETDATE()) and 
Metric_Name in ('Revenue','Total Cost of Services') and
[month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()-30),3), left(datename(M,GETDATE()),3),left(datename(M,GETDATE()+30),3))

group by Metric_Category, Metric_Name,Project_Code,Location_Code,month)a  

Left Join  
(Select * from Client_mapping)b  
on a.Project_Code = b.PRCode  
where ClientName is not null  
group by ClientName,Location_Code,month)x
where ClientName = @Client_Name
)Revenue

Left Join

(Select * from Location_Mapping)loc
on
Revenue.Location_Code = loc.LOC_Code
where 
loc.Region = @Region
group by ClientName, month

GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1_Slider_allRegion]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[AccountDetails_Chart1_Slider_allRegion]


@Client_Name varchar(255)

AS

select ClientName,month,sum(Revenue) as Revenue,sum(Budget) as Budget,sum(Optimal)as Optimal,SUM(Act_COS)as ACT_COS,SUM(Budget_COS)as BDT_COS,SUM(OPT_COS)as OPT_COS  from 
(select ClientName,MONTH, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal,round(ACT_COS,0) as ACT_COS,round(BGT_COS,0)as Budget_COS,round(OPT_COS,0)as OPT_COS,Location_Code from(
select ClientName, month,sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,SUM(Act_COS) as ACT_COS,SUM(Budget_COS) as BGT_COS,SUM(Optimal_COS) as OPT_COS,Location_Code 
from   

(Select project_code, [MONTH],
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal,
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Budget_COS,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Optimal_COS,


Location_Code
from financeraw2016 
where [Year] = datename(YEAR,GETDATE()) and 
Metric_Name in ('Revenue','Total Cost of Services') and
[month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()-30),3), left(datename(M,GETDATE()),3),left(datename(M,GETDATE()+30),3))

group by Metric_Category, Metric_Name,Project_Code,Location_Code,month)a  

Left Join  
(Select * from Client_mapping)b  
on a.Project_Code = b.PRCode  
where ClientName is not null  
group by ClientName,Location_Code,month)x
where ClientName = @Client_Name
)Revenue

Left Join

(Select * from Location_Mapping)loc
on
Revenue.Location_Code = loc.LOC_Code

group by ClientName, month

GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1_sub_region]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AccountDetails_Chart1_sub_region]

@YEAR varchar(255),
@MONTH varchar(255),
@SUBREGION varchar(255),
@Client_Name varchar(255)

AS

select  ClientName,sum(Revenue) as Revenue,sum(Budget) as Budget,sum(Optimal) as Optimal from 
(select ClientName, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal,Location_Code from(
select ClientName, sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit,Location_Code 
from   

(Select project_code,  
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget,
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal,
Location_Code
from financeraw2016 
where [YEAR] = @YEAR
 and Metric_Name = 'Revenue'  
and [month] = @MONTH

group by Metric_Category, Metric_Name,Project_Code,Location_Code)a  

Left Join  
(Select * from Client_mapping)b  
on a.Project_Code = b.PRCode  
where ClientName is not null  
group by ClientName,Location_Code)x
where ClientName = @Client_Name
)Revenue

Left Join

(Select * from Location_Mapping)loc
on
Revenue.Location_Code = loc.LOC_Code
where 
loc.Sub_Region = @SUBREGION
group by  ClientName
GO
/****** Object:  StoredProcedure [dbo].[AccountDetails_Chart1y]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AccountDetails_Chart1y]

@Client_Name varchar(255),
@YEAR varchar(255)

as

select ClientName, round(Revenue,0) as Revenue, round(Budget,0)as Budget, round(Optimal,0) as Optimal from(

select ClientName, sum(Act_Rev)*-1 as Revenue ,sum(optimal)*-1 as Optimal, sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit from   

(Select project_code,  

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,  

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal  

from financeraw2016  

where YEAR = @YEAR and 
Metric_Name = 'Revenue'  

group by Metric_Category, Metric_Name,Project_Code)  

a  

Left Join  

(Select * from Client_mapping)b  

on a.Project_Code = b.PRCode  

where ClientName is not null  

group by ClientName)x

where ClientName = @Client_Name
GO
/****** Object:  StoredProcedure [dbo].[Accounts_in_warroom_revenue_Global]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Accounts_in_warroom_revenue_Global]
  
@REGION VARCHAR(255)  = NULL  
AS    
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
BEGIN  
 SET @REGION = 'ALL'  
END  

(Select Sum(aa.Revenue) as Total_Account,(Select Sum(Revenue) from War_Room 
WHERE 1 = 1  
AND (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')) as War_room_Account  
  
 from  
(  
Select ClientName,Region, [YEAR],[MONTH],   
       sum (Revenue) as Revenue,  
       sum(Cost_of_service)as Total_Cost_of_Service,  
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',  
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',  
       SUM([Billable hours]) as Billable_Hours,  
       sum([Expense Hours]) as Expense_Hours,  
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,  
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,  
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',  
         
       SUM(Inbound_Penalties) as 'Inbound_Penalties',  
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',  
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
         
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',  
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',  
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',  
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',  
       SUM(Overtime) as 'Overtime',  
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',  
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',  
       SUM([Regular Wages]) as 'Regular Wages',  
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'  
         
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],  
case when [Month] in ('Jan','Feb','Mar') then 'Q1'  
     when [Month] in ('Apr','May','Jun') then 'Q2'  
     when [Month] in ('Jul','Aug','Sep') then 'Q3'  
     when [Month] in ('Oct','Nov','Dec') then 'Q4'  
     else '' end as 'Quarter',  
  
Country,Sub_Region,Region,  
       
     SUM(Revenue) as Revenue,   
     sum([Cost of Services]) as Cost_of_service ,   
      
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                                  
                                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                                  
                                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'           
                  
                  
  
from   
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
ClientName,  
Country,  
Sub_Region,Region,  
  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,  
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],  
  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],  
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],  
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],  
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],  
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],  
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]  
  
  
from  
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
ClientName,  
Country,Sub_Region,Region,  
sum(Metric_Value) as Metric_Value  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code  
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code   
where   
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',  
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')  
--and [Year] in ('2014','2015')  
and len (location_code) = 6  
group by Location_Code,[Location_ Name]  
,Metric_Category,Metric_Name,[Year],[Month],ClientName,  
Country,Sub_Region,Region) aa) bb  
where Metric_Category ='USD Actual @ Budget Rate'  
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'   
  
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'  
--and Metric_Category  
--='USD Actual @ Budget Rate'  
----USD Actual  
----USD Actual @ Budget Rate  
----USD Budget Load  
----USD Optimal Load  
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn  
  
where [YEAR] = '2016' and [Month] = 'Feb' and (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
group by ClientName,Region, [YEAR],[Month])aa)  
  
GO
/****** Object:  StoredProcedure [dbo].[Accounts_in_warroom_revenue_Global_DOTNET]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Accounts_in_warroom_revenue_Global_DOTNET]
(
	@REGION VARCHAR(255)  = NULL,
	@NT_ID as varchar(max) = NULL,
    @AccessType as varchar(max) = NULL 
)
AS    
BEGIN
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
	BEGIN  
	 SET @REGION = 'ALL'  
	END  


	-- EXEC dbo.Accounts_in_warroom_revenue_Global_DOTNET 'All','vkole003','Regional'

	Select 
	case when Sum(Revenue) >= 1000000 then cast(round(Sum(Revenue)/1000000,2) as varchar(max))+ 'M'
	when Sum(Revenue) >= 1000 then cast(round(Sum(Revenue)/1000,2) as varchar(max))+ 'K' END as [xRevenue]
	from War_Room 
	 WHERE 1 = 1  
			AND (
				CONVERT(VARCHAR,REGION) = @REGION  
				OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,REGION) end in 
					(
						select Region from tbl_WR_User_Role
						where NT_ID = @NT_ID
						AND Access_Type = @AccessType
						and Start_Date <= GETDATE() and End_Date is null
					)
				)
			)








	----------------------------------------------------------------- Backup 26-12-2016
	--(Select Sum(aa.Revenue) as Total_Account,(Select 
	--case when Sum(Revenue) >= 1000000 then cast(round(Sum(Revenue)/1000000,2) as varchar(max))+ 'M'
	--when Sum(Revenue) >= 1000 then cast(round(Sum(Revenue)/1000,2) as varchar(max))+ 'K' END as [xRevenue]
	--from War_Room 
	--WHERE 1 = 1  
	--AND (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
	--) as War_room_Account  
  
	-- from  
	--(  
	--Select ClientName,Region, [YEAR],[MONTH],   
	--	   sum (Revenue) as Revenue,  
	--	   sum(Cost_of_service)as Total_Cost_of_Service,  
	--	   sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',  
	--	   (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',  
	--	   SUM([Billable hours]) as Billable_Hours,  
	--	   sum([Expense Hours]) as Expense_Hours,  
	--	   SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',  
	--	   SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,  
	--	   SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,  
	--	   SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
	--	   sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',  
         
	--	   SUM(Inbound_Penalties) as 'Inbound_Penalties',  
	--	   SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',  
	--	   SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
         
	--	   SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',  
	--	   SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',  
	--	   sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',  
	--	   SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
	--	   (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',  
	--	   SUM(Overtime) as 'Overtime',  
	--	   SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',  
	--	   SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',  
	--	   SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',  
	--	   SUM([Regular Wages]) as 'Regular Wages',  
	--	   SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'  
         
	--	   From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],  
	--case when [Month] in ('Jan','Feb','Mar') then 'Q1'  
	--	 when [Month] in ('Apr','May','Jun') then 'Q2'  
	--	 when [Month] in ('Jul','Aug','Sep') then 'Q3'  
	--	 when [Month] in ('Oct','Nov','Dec') then 'Q4'  
	--	 else '' end as 'Quarter',  
  
	--Country,Sub_Region,Region,  
       
	--	 SUM(Revenue) as Revenue,   
	--	 sum([Cost of Services]) as Cost_of_service ,   
      
	--				SUM([Billable Hours]) as [Billable hours],  
	--				SUM([Expense Hours]) as [Expense Hours],  
                                  
                                  
	--				SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
	--				SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                                  
                                  
                  
	--				SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
	--				Sum([OVERTIME]) as Overtime,  
	--				SUM([REGULAR WAGES]) as 'Regular Wages',  
	--				sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'           
                  
                  
  
	--from   
	--(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
	--ClientName,  
	--Country,  
	--Sub_Region,Region,  
  
	--case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,  
	--case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],  
  
	--case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],  
	--case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],  
	--case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],  
	--case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],  
	--case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],  
	--case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],  
	--case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],  
	--case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]  
  
  
	--from  
	--(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
	--ClientName,  
	--Country,Sub_Region,Region,  
	--sum(Metric_Value) as Metric_Value  
	--from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code  
	--left join Location_Mapping lm on lm.LOC_Code = f.Location_Code   
	--where   
	--Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',  
	--'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')  
	----and [Year] in ('2014','2015')  
	--and len (location_code) = 6  
	--group by Location_Code,[Location_ Name]  
	--,Metric_Category,Metric_Name,[Year],[Month],ClientName,  
	--Country,Sub_Region,Region) aa) bb  
	--where Metric_Category ='USD Actual @ Budget Rate'  
	----and region not in ('Corp','Global', 'Null') and ClientName <> 'null'   
  
	----ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'  
	----and Metric_Category  
	----='USD Actual @ Budget Rate'  
	------USD Actual  
	------USD Actual @ Budget Rate  
	------USD Budget Load  
	------USD Optimal Load  
	--group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn  
  
	--where [YEAR] = '2016' and [Month] = 'Feb' and (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
	--group by ClientName,Region, [YEAR],[Month])aa)  
END
GO
/****** Object:  StoredProcedure [dbo].[add_author]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[add_author]
@au_id char(11),
@au_lname varchar(20),
@au_fname varchar(20),
@tabname varchar(30) AS

BEGIN
DECLARE @insert_stmt varchar(255)
SELECT @insert_stmt='INSERT ' + @tabname + ' (au_id,
au_lname, au_fname, contract) VALUES (''' + @au_id +
''',''' + @au_lname + ''',''' + @au_fname + ''', 1)'

EXECUTE (@insert_stmt)
END

GO
/****** Object:  StoredProcedure [dbo].[Add_Leave_Request]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_Leave_Request]    
@ECN as varchar(255)    
AS    
select First_Name +''+Last_Name as Name,     
Supervisor, Department,     
Designation,Supervisor_ECN, Sub_Department ,(Select Designation from WFM_Employee_List  where Employee_ID= (Select Supervisor_ECN from WFM_Employee_List where Employee_ID = @ECN)) as Sup_Designation
from WFM_Employee_List where Employee_ID = @ECN

GO
/****** Object:  StoredProcedure [dbo].[Average_ageing_global]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Average_ageing_global]  
(
	@REGION VARCHAR(255) = NULL,
	@NT_ID as varchar(max) = NULL,
	@AccessType as varchar(max) = NULL
)

AS    
BEGIN  
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
	BEGIN  
	 SET @REGION = 'ALL'  
	END  


	-- EXEC  Average_ageing_global 'All','vkole003','Global'
  
	Select AVG(aa.DiffDate) 
	from
		(
			Select DATEDIFF(day,Start_Date,getdate()) AS DiffDate  
			from War_Room wr 
			WHERE 1 = 1  
			AND (
				CONVERT(VARCHAR,REGION) = @REGION  
				OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,REGION) end in 
					(
						select Region from tbl_WR_User_Role
						where NT_ID = @NT_ID
						AND Access_Type = @AccessType
						and Start_Date <= GETDATE() and End_Date is null
					)
				)
			)
		)aa
END



GO
/****** Object:  StoredProcedure [dbo].[bgt_SP_ACMGMT_Save_Data]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bgt_SP_ACMGMT_Save_Data]
@xAccount varchar(255),
@xLOB varchar(255),
@xSite varchar(255),
@xMetric varchar(255)

as
SELECT
       [Jan]
      ,[Feb]
      ,[Mar]
      ,[Apr]
      ,[May]
      ,[Jun]
      ,[Jul]
      ,[Aug]
      ,[Sep]
      ,[Oct]
      ,[Nov]
      ,[Dec]
      
      
  FROM [dbo].[bgt_tbl_Data_upload] where Project_Name=@xAccount and LOB=@xLOB and xSite =@xSite and Metric =@xMetric and Department='Account Mgmt' and upload_type='ACMGMT'

  




GO
/****** Object:  StoredProcedure [dbo].[bgt_sp_Monthly_Distro_Volume]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[bgt_sp_Monthly_Distro_Volume] 
@xAccount varchar(255),
@Lob varchar(255)
as

begin
declare @xYear AS varchar(4)=null

	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate()))
	End
Select xSite,
round(convert(float,sum(Jan))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Jan,
round(convert(float,sum(Feb))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Feb ,
round(convert(float,sum(Mar))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Mar,
round(convert(float,sum(Apr))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Apr,
round(convert(float,sum(May))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as May,
round(convert(float,sum(Jun))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Jun,
round(convert(float,sum(Jul))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Jul,
round(convert(float,sum(Aug))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Aug,
round(convert(float,sum(Sep))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Sep,
round(convert(float,sum(Oct))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Oct,
round(convert(float,sum(Nov))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as Nov,
round(convert(float,sum(Dec))/sum(Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+[Dec])*100,2) as [Dec]
from BGT_TBL_DATA_UPLOAD
where Project_Name = @xAccount and LOB = @Lob and Metric = 'Volume' and Budgeting_Year=@xYear
group by xSite
with rollup
end





GO
/****** Object:  StoredProcedure [dbo].[bgt_Sp_Ops_Final_View_Volume]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bgt_Sp_Ops_Final_View_Volume]-- @xAccount = 'BELL CANADA',@xRegion='APAC',@xSite='MANILA, PHILIPPINES (ONE JULIA VARGAS)',@xMetric='AHT',@xLOB='CANADA-BACK OFFICE OFA FTV'

@xAccount varchar(255),
@xRegion varchar(255),
@xSite varchar(255),
@xLOB Varchar(255),
@xMetric varchar(255),
@Department varchar(255)
as

begin
declare @xYear AS varchar(4)=null

	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate())+1)
	End

(Select Metric, Department,Jan,Feb ,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,[Dec] from BGT_TBL_DATA_UPLOAD
where Region=@xRegion and xSite=@xSite and Project_Name = @xAccount and LOB = @xLOB  and  Metric = @xMetric
and (Department=@Department or @Department='All')
and Budgeting_Year = 2017 and Budgeting_For=@xYear)

end
GO
/****** Object:  StoredProcedure [dbo].[bgt_sp_Shrinkage_brkup]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[bgt_sp_Shrinkage_brkup] 

@xAccount Varchar(255),
@xLOB varchar(255),
@xMetric varchar(255),
@xSite varchar(255)

as

begin
declare @xYear AS varchar(4)=null

	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate())+1)
	End

(Select Department, Metric,Jan,Feb ,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,[Dec] 
from BGT_TBL_DATA_UPLOAD where Project_Name=@xAccount and LOB=@xLOB
and Metric= @xMetric and xSite = @xSite and Department in ('A/C Mgmt & WFM','OPS & A/C Mgmt')
and Budgeting_Year = @xYear
 
 )
 end
GO
/****** Object:  StoredProcedure [dbo].[bgt_sp_xLock_OPS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[bgt_sp_xLock_OPS]

@xAccount varchar(255),
@Budgeting_Year varchar(55)
as

update bgt_tbl_Data_upload set xStatus=1 where Project_ID = @xAccount and upload_type='Ops Upload' and Budgeting_Year=@Budgeting_Year and Department='OPS'

GO
/****** Object:  StoredProcedure [dbo].[bgt_sp_xOps_distribution]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bgt_sp_xOps_distribution]
@xAccount varchar(255),
@xLoB varchar(255),
@xSite varchar(255),
@xMetric varchar(255)
as
(Select Budgeting_Year,Jan,Feb ,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,[Dec] from BGT_TBL_DATA_UPLOAD
where Department ='WFM' and Project_Name = @xAccount and LOB = @xLoB and xSite = @xSite and Metric = @xMetric )




GO
/****** Object:  StoredProcedure [dbo].[bgt_sp_xSite]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[bgt_sp_xSite]
@xAccount varchar(255),
@xLob varchar(255)
as
(

Select distinct facility  from bgt_tbl_LOBs where CLIENT_NAME = @xAccount and Campaign=@xLob)
GO
/****** Object:  StoredProcedure [dbo].[bgt_SP_xSite_Wise_Distribution]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[bgt_SP_xSite_Wise_Distribution]

@xProject varchar(255),
@xLob varchar(255),
@xSite varchar(255)
as

	BEGIN      
	declare @xYear AS varchar(4)=null
	if isnull(@xSite,'') = ''
	begin
		set @xSite = 'ALL'
	end


	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate())+1)
	End

	
	Select convert(varchar, Budgeting_Year) Budgeting_Year,
	round(convert(float,sum(Jan)),2) as Jan,
	round(convert(float,sum(Feb)),2) as Feb ,
	round(convert(float,sum(Mar)),2) as Mar,
	round(convert(float,sum(Apr)),2) as Apr,
	round(convert(float,sum(May)),2) as May,
	round(convert(float,sum(Jun)),2) as Jun,
	round(convert(float,sum(Jul)),2) as Jul,
	round(convert(float,sum(Aug)),2) as Aug,
	round(convert(float,sum(Sep)),2) as Sep,
	round(convert(float,sum(Oct)),2) as Oct,
	round(convert(float,sum(Nov)),2) as Nov,
	round(convert(float,sum(Dec)),2) as [Dec]
	from BGT_TBL_DATA_UPLOAD
	where Budgeting_For=@xYear and (xSite = @xSite OR @xSite = 'ALL') and Department = 'WFM' and Project_Name = @xProject and LOB = @xLob
	and Metric ='Volume'
	group by Budgeting_Year
	
	UNION
	
	Select Budgeting_Year,
	Avg(Jan) Jan,Avg(Feb) Feb,Avg(Mar) Mar,Avg(Apr) Apr,Avg(May) May,Avg(Jun) Jun,Avg(Jul) Jul,Avg(Aug) Aug,Avg(Sep) Sep,Avg(Oct) Oct,Avg(Nov) Nov,Avg(Dec) [Dec]
	from (
	
		Select 'xAverage' Budgeting_Year,
		round(convert(float,sum(Jan)),2) as Jan,
		round(convert(float,sum(Feb)),2) as Feb ,
		round(convert(float,sum(Mar)),2) as Mar,
		round(convert(float,sum(Apr)),2) as Apr,
		round(convert(float,sum(May)),2) as May,
		round(convert(float,sum(Jun)),2) as Jun,
		round(convert(float,sum(Jul)),2) as Jul,
		round(convert(float,sum(Aug)),2) as Aug,
		round(convert(float,sum(Sep)),2) as Sep,
		round(convert(float,sum(Oct)),2) as Oct,
		round(convert(float,sum(Nov)),2) as Nov,
		round(convert(float,sum(Dec)),2) as [Dec]
		from BGT_TBL_DATA_UPLOAD
		where Budgeting_For=@xYear and Budgeting_Year in (@xYear-1,@xYear-2) and (xSite = @xSite OR @xSite = 'ALL') and Department = 'WFM' and Project_Name = @xProject and LOB = @xLob
		and Metric ='Volume'
		group by Budgeting_Year
	)	tmp 
	group by Budgeting_Year
	End
	
	

	




GO
/****** Object:  StoredProcedure [dbo].[bgt_SP_xTotal_Distribution]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bgt_SP_xTotal_Distribution]
@xAccount varchar(255),
@Lob varchar(255)
as

BEGIN
	declare @xYear AS varchar(4)=null
	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate())+1)
	End


Select Budgeting_Year,
	round(convert(float,sum(Jan)),2) as Jan,
	round(convert(float,sum(Feb)),2) as Feb ,
	round(convert(float,sum(Mar)),2) as Mar,
	round(convert(float,sum(Apr)),2) as Apr,
	round(convert(float,sum(May)),2) as May,
	round(convert(float,sum(Jun)),2) as Jun,
	round(convert(float,sum(Jul)),2) as Jul,
	round(convert(float,sum(Aug)),2) as Aug,
	round(convert(float,sum(Sep)),2) as Sep,
	round(convert(float,sum(Oct)),2) as Oct,
	round(convert(float,sum(Nov)),2) as Nov,
	round(convert(float,sum(Dec)),2) as [Dec]
	from BGT_TBL_DATA_UPLOAD
	where Budgeting_For=@xYear and Department = 'WFM' and Project_Name = @xAccount and LOB = @Lob
	and Metric ='Volume'
	group by Budgeting_Year
	
	end
	
	
GO
/****** Object:  StoredProcedure [dbo].[Bottom_Peformer]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Bottom_Peformer]

AS
                
Select Y2015.ClientName,  
                Y2015.[Quarter], y2015.[month],
                Y2015.[YEAR],Country,Sub_Region,Region,
                Y2015.Revenue * Y2014.[Gross_Margin%] as 'GM%2014',
    Y2015.Gross_Margin-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG)) as 'Cost Impact/Wages',           
                
--  Y2014.Overtime as Overtime,      
               
-- (Y2014.Total_Cost_of_Service - Y2014.Overtime) as Normal_Cost,       
               
----Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1 as 'OTHOURS+1',         
----Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1)as NormalHrs,  
----Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))as OvertimeHrs,        
--(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1)))))as NormalRat               
--  (Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Servic              
(Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))))))-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG)))as Overtime_impact,              
               
 ---Calculatin for Penalty     
               
                --Y2015.Inbound_Penalties AS poa,
                
--(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%]  AS penalt,               
               
 Y2015.Gross_Margin-((Y2015.Revenue + ((ISNULL(Y2015.Inbound_Penalties,0)-(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%])))- Y2015.Total_Cost_of_Service) as 'Penalty Impact',               
               
 ---Calcualtion for BTP Impact            
               
  Y2015.Gross_Margin -( Y2015.Revenue -( Y2015.Total_Cost_of_Service + (Y2015.COSPEXHWITHTRG *( Y2015.Billable_Hours / Y2014.[BTP with Training%] - Y2015.Expense_Hours) )))as 'BTP Impact',       
                
 ----Calculation for Other    
               
 Y2015.Gross_Margin - ((Y2015.Revenue * Y2014.[Gross_Margin%])       
  + Y2015.Gross_Margin-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG))     
  + ((Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))))))-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG))))                 
  + ( Y2015.Gross_Margin-((Y2015.Revenue + ((ISNULL(Y2015.Inbound_Penalties,0)-(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%])))- Y2015.Total_Cost_of_Service))           
  + (Y2015.Gross_Margin -( Y2015.Revenue -( Y2015.Total_Cost_of_Service + (Y2015.COSPEXHWITHTRG *( Y2015.Billable_Hours / Y2014.[BTP with Training%] - Y2015.Expense_Hours) ))))) as Other,         
                
                
                 
                
Y2015.Gross_Margin as GM2015     
                
                
                
  from     
                
(Select ClientName, [YEAR],[Quarter],[month],Country,Sub_Region,Region,           
       sum (Revenue) as Revenue,       
       sum(Cost_of_service)as Total_Cost_of_Service,    
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',     
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',   
       SUM([Billable hours]) as Billable_Hours,  
       sum([Expense Hours]) as Expense_Hours,               
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',                
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,           
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,       
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',                
                
       SUM(Inbound_Penalties) as 'Inbound_Penalties',  
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',               
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
                
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',   
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',      
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',               
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',       
       SUM(Overtime) as 'Overtime',   
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',           
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',                
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',        
       SUM([Regular Wages]) as 'Regular Wages',             
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'    
                
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],        
case when [Month] in ('Jan','Feb','Mar') then 'Q1'        
     when [Month] in ('Apr','May','Jun') then 'Q2'           
     when [Month] in ('Jul','Aug','Sep') then 'Q3'             
     when [Month] in ('Oct','Nov','Dec') then 'Q4'           
     else '' end as 'Quarter',  
                
Country,Sub_Region,Region,             
                
     SUM(Revenue) as Revenue,         
     sum([Cost of Services]) as Cost_of_service ,             
                
                SUM([Billable Hours]) as [Billable hours],
                SUM([Expense Hours]) as [Expense Hours],
                
                
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,
                
                
                
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,
                
                Sum([OVERTIME]) as Overtime,
                SUM([REGULAR WAGES]) as 'Regular Wages',
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'
                
                
                
from       
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
ClientName,          
Country, 
Sub_Region,Region,            
                
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,         
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],             
                
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES], 
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],          
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],      
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],                
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],          
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],                
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],              
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]                
                
                
from       
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
ClientName,          
Country,Sub_Region,Region,             
sum(Metric_Value) as Metric_Value                
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code 
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code          
where    
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',      
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')                
--and [Year] in ('2014','2015')           
and len (location_code) = 6               
group by Location_Code,[Location_ Name]   
,Metric_Category,Metric_Name,[Year],[Month],ClientName,     
Country,Sub_Region,Region) aa) bb 
where Metric_Category ='USD Actual @ Budget Rate'                
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'          
                
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'   
                
--='USD Actual @ Budget Rate'          
                
----USD Actual @ Budget Rate           
                
                
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn        
               
 where [YEAR] = '2016' group by ClientName, [YEAR],[Quarter],[month],Country,Sub_Region,Region) Y2015                 
                
  left Join                
                
(Select ClientName, [YEAR],[Quarter],             
       sum (Revenue) as Revenue,       
       sum(Cost_of_service)as Total_Cost_of_Service,    
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',     
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',   
       SUM([Billable hours]) as Billable_Hours,  
       sum([Expense Hours]) as Expense_Hours,               
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',                
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,           
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,       
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',                
                
       SUM(Inbound_Penalties) as 'Inbound_Penalties',  
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',               
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
                
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',   
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',      
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',               
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',       
       SUM(Overtime) as 'Overtime',   
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',           
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',                
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',        
       SUM([Regular Wages]) as 'Regular Wages',             
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'    
                
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],        
case when [Month] in ('Jan','Feb','Mar') then 'Q1'        
     when [Month] in ('Apr','May','Jun') then 'Q2'           
     when [Month] in ('Jul','Aug','Sep') then 'Q3'             
     when [Month] in ('Oct','Nov','Dec') then 'Q4'           
     else '' end as 'Quarter',  
                
Country,Sub_Region,Region,             
                
     SUM(Revenue) as Revenue,         
     sum([Cost of Services]) as Cost_of_service ,             
                
                SUM([Billable Hours]) as [Billable hours],
                SUM([Expense Hours]) as [Expense Hours],
                
                
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,
                
                
                
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,
                
                Sum([OVERTIME]) as Overtime,
                SUM([REGULAR WAGES]) as 'Regular Wages',
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'
                
                
                
from       
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
ClientName,          
Country, 
Sub_Region,Region,            
                
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,         
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],             
                
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES], 
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],          
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],      
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],                
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],          
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],                
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],              
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]                
                
                
from       
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
ClientName,          
Country,Sub_Region,Region,             
sum(Metric_Value) as Metric_Value                
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code 
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code          
where    
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',      
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')                
--and [Year] in ('2014','2015')           
and len (location_code) = 6               
group by Location_Code,[Location_ Name]   
,Metric_Category,Metric_Name,[Year],[Month],ClientName,     
Country,Sub_Region,Region) aa) bb 
where Metric_Category ='USD Budget Load' 
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'          
                
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'   
                
--='USD Actual @ Budget Rate'          
                
----USD Actual @ Budget Rate           
                
                
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn        
               
  where [YEAR] = '2016' group by ClientName, [YEAR],[Quarter]) Y2014 on Y2014.ClientName = Y2015.ClientName and Y2014.[Quarter]=Y2015.[Quarter]   
  where y2015.ClientName is not null              
  --and y2015.[QUARTER] in('Q2')     
  and Y2015.Gross_Margin is not null               
and region not in ('Corp','Global')     
order by y2015.ClientName, y2015.[QUARTER]            


GO
/****** Object:  StoredProcedure [dbo].[Bottom_Peformer_filter]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Bottom_Peformer_filter]  

@YEAR as varchar(255),
@MONTH as varchar(255),
@REGION as varchar(255)

AS

select 
round(sum([COS])*-1,0) AS [COS], 
round(sum(Overtime_impact),0) as OT,
round(sum([Penalty Impact])*-1,0) as [Penalty Impact],  
round(sum(BTP)*-1,0) as BTP,
round(sum(other)*-1,0) as Other

from
(
select 
case when [Cost Impact/Wages] < 0 then [Cost Impact/Wages] end as [COS],
Overtime_impact,
case when [Penalty Impact] < 0 then [Penalty Impact] end as [Penalty Impact],
case when [BTP Impact] < 0 then [BTP Impact] end as BTP,
case when Other < 0 then Other end as other
from 
(
Select Y2015.ClientName,    
                Y2015.[Quarter], y2015.[month],  
                Y2015.[YEAR],Country,Sub_Region,Region,  
                Y2015.Revenue * Y2014.[Gross_Margin%] as 'GM%2014',  
    Y2015.Gross_Margin-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG)) as 'Cost Impact/Wages',             
                  
--  Y2014.Overtime as Overtime,        
                 
-- (Y2014.Total_Cost_of_Service - Y2014.Overtime) as Normal_Cost,         
                 
----Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1 as 'OTHOURS+1',           
----Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1)as NormalHrs,    
----Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))as OvertimeHrs,          
--(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1)))))as NormalRat
                 
--  (Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Servic
                
(Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - 
Y2014.Overtime)+1))))))-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG)))as Overtime_impact,                
                 
 ---Calculatin for Penalty       
                 
                --Y2015.Inbound_Penalties AS poa,  
                  
--(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%]  AS penalt,                 
                 
 Y2015.Gross_Margin-((Y2015.Revenue + ((ISNULL(Y2015.Inbound_Penalties,0)-(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%])))- Y2015.Total_Cost_of_Service) as 'Penalty Impact',                 
                 
 ---Calcualtion for BTP Impact              
                 
  Y2015.Gross_Margin -( Y2015.Revenue -( Y2015.Total_Cost_of_Service + (Y2015.COSPEXHWITHTRG *( Y2015.Billable_Hours / Y2014.[BTP with Training%] - Y2015.Expense_Hours) )))as 'BTP Impact',         
                  
 ----Calculation for Other      
                 
 Y2015.Gross_Margin - ((Y2015.Revenue * Y2014.[Gross_Margin%])         
  + Y2015.Gross_Margin-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG))       
  + ((Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))))))-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG))))                   
  + ( Y2015.Gross_Margin-((Y2015.Revenue + ((ISNULL(Y2015.Inbound_Penalties,0)-(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%])))- Y2015.Total_Cost_of_Service))             
  + (Y2015.Gross_Margin -( Y2015.Revenue -( Y2015.Total_Cost_of_Service + (Y2015.COSPEXHWITHTRG *( Y2015.Billable_Hours / Y2014.[BTP with Training%] - Y2015.Expense_Hours) ))))) as Other,                  
Y2015.Gross_Margin as GM2015       
                  
                  
                  
  from       
                  
(Select ClientName, [YEAR],[Quarter],[month],Country,Sub_Region,Region,             
       sum (Revenue) as Revenue,         
       sum(Cost_of_service)as Total_Cost_of_Service,      
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',              (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',     
       SUM([Billable hours]) as Billable_Hours,    
       sum([Expense Hours]) as Expense_Hours,                 
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',                  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,             
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,         
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',    
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',                  
                  
       SUM(Inbound_Penalties) as 'Inbound_Penalties',    
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',                 
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',    
                  
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',     
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',        
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',                 
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',    
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',         
       SUM(Overtime) as 'Overtime',     
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',             
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',                  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',          
       SUM([Regular Wages]) as 'Regular Wages',               
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'      
                  
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],          
case when [Month] in ('Jan','Feb','Mar') then 'Q1'          
     when [Month] in ('Apr','May','Jun') then 'Q2'             
     when [Month] in ('Jul','Aug','Sep') then 'Q3'               
     when [Month] in ('Oct','Nov','Dec') then 'Q4'             
     else '' end as 'Quarter',    
                  
Country,Sub_Region,Region,               
                  
     SUM(Revenue) as Revenue,           
     sum([Cost of Services]) as Cost_of_service ,               
                  
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                  
                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                  
                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'  
                  
                  
                  
from         
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],    
ClientName,            
Country,   
Sub_Region,Region,              
                  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,           
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],               
                  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],   
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],            
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],        
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],                  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],            
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],                  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],                
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]                  
                  
                  
from         
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],    
ClientName,            
Country,Sub_Region,Region,               
sum(Metric_Value) as Metric_Value                  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code   
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code            
where      
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',        
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')                  
--and [Year] in ('2014','2015')             
and len (location_code) = 6                 
group by Location_Code,[Location_ Name]     
,Metric_Category,Metric_Name,[Year],[Month],ClientName,       
Country,Sub_Region,Region) aa) bb   
where Metric_Category ='USD Actual @ Budget Rate'                  
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'            
                  
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'     
                  
--='USD Actual @ Budget Rate'            
                  
----USD Actual @ Budget Rate             
                  
                  
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn          
                 
 where [YEAR] = @YEAR
 and [Month]= @MONTH
 and Region = @REGION
 
 group by ClientName, [YEAR],[Quarter],[month],Country,Sub_Region,Region) Y2015                   
                  
  left Join                  
                  
(Select ClientName, [YEAR],[Quarter],               
       sum (Revenue) as Revenue,         
       sum(Cost_of_service)as Total_Cost_of_Service,      
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',       
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',     
       SUM([Billable hours]) as Billable_Hours,    
       sum([Expense Hours]) as Expense_Hours,                 
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',                  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,             
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,         
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',    
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',                  
                  
       SUM(Inbound_Penalties) as 'Inbound_Penalties',    
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',                 
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',    
                  
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',     
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',        
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',                 
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',    
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',         
       SUM(Overtime) as 'Overtime',     
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',             
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',                  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',          
       SUM([Regular Wages]) as 'Regular Wages',               
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'      
                  
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],          
case when [Month] in ('Jan','Feb','Mar') then 'Q1'          
     when [Month] in ('Apr','May','Jun') then 'Q2'             
     when [Month] in ('Jul','Aug','Sep') then 'Q3'               
     when [Month] in ('Oct','Nov','Dec') then 'Q4'             
     else '' end as 'Quarter',    
                  
Country,Sub_Region,Region,               
                  
     SUM(Revenue) as Revenue,           
     sum([Cost of Services]) as Cost_of_service ,               
                  
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                  
                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                  
                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'  
                  
                  
                  
from         
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],    
ClientName,            
Country,   
Sub_Region,Region,              
                  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,           
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],               
                  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],   
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],            
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],        
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],                  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],            
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],                  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],                
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]                  
                  
                  
from         
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],    
ClientName,            
Country,Sub_Region,Region,               
sum(Metric_Value) as Metric_Value                  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code   
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code            
where      
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',        
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')     
--and [Year] in ('2014','2015')             
and len (location_code) = 6                 
group by Location_Code,[Location_ Name]     
,Metric_Category,Metric_Name,[Year],[Month],ClientName,       
Country,Sub_Region,Region) aa) bb   
where Metric_Category ='USD Budget Load'   
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'            
                  
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'     
                  
--='USD Actual @ Budget Rate'            
                  
----USD Actual @ Budget Rate             
                  
                  
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn          
                 
where [YEAR] = @YEAR
 and [Month]= @MONTH
 and Region = @REGION 
 
 group by ClientName, [YEAR],[Quarter]) Y2014 
on Y2014.ClientName = Y2015.ClientName and Y2014.[Quarter]=Y2015.[Quarter]     
where y2015.ClientName is not null                
  --and y2015.[QUARTER] in('Q2')       
and Y2015.Gross_Margin is not null                 
and region not in ('Corp','Global') 
)x )y    


GO
/****** Object:  StoredProcedure [dbo].[Bottom_Peformer_Region]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Bottom_Peformer_Region]  

@YEAR as varchar(255),
--@MONTH as varchar(255),
@REGION as varchar(255)

AS  

select 
round(sum([COS])*-1,0) AS [COS], 
round(sum(Overtime_impact),0) as OT,
round(sum([Penalty Impact])*-1,0) as [Penalty Impact],  
round(sum(BTP)*-1,0) as BTP,
round(sum(other)*-1,0) as Other

from
(
select 
case when [Cost Impact/Wages] < 0 then [Cost Impact/Wages] end as [COS],
Overtime_impact,
case when [Penalty Impact] < 0 then [Penalty Impact] end as [Penalty Impact],
case when [BTP Impact] < 0 then [BTP Impact] end as BTP,
case when Other < 0 then Other end as other
from 
(                  
Select Y2015.ClientName,    
                Y2015.[Quarter], y2015.[month],  
                Y2015.[YEAR],Country,Sub_Region,Region,  
                Y2015.Revenue * Y2014.[Gross_Margin%] as 'GM%2014',  
    Y2015.Gross_Margin-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG)) as 'Cost Impact/Wages',             
                  
--  Y2014.Overtime as Overtime,        
                 
-- (Y2014.Total_Cost_of_Service - Y2014.Overtime) as Normal_Cost,         
                 
----Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1 as 'OTHOURS+1',           
----Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1)as NormalHrs,    
----Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))as OvertimeHrs,          
--(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1)))))as NormalRat
                 
--  (Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Servic
                
(Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - 
Y2014.Overtime)+1))))))-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG)))as Overtime_impact,                
                 
 ---Calculatin for Penalty       
                 
                --Y2015.Inbound_Penalties AS poa,  
                  
--(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%]  AS penalt,                 
                 
 Y2015.Gross_Margin-((Y2015.Revenue + ((ISNULL(Y2015.Inbound_Penalties,0)-(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%])))- Y2015.Total_Cost_of_Service) as 'Penalty Impact',                 
                 
 ---Calcualtion for BTP Impact              
                 
  Y2015.Gross_Margin -( Y2015.Revenue -( Y2015.Total_Cost_of_Service + (Y2015.COSPEXHWITHTRG *( Y2015.Billable_Hours / Y2014.[BTP with Training%] - Y2015.Expense_Hours) )))as 'BTP Impact',         
                  
 ----Calculation for Other      
                 
 Y2015.Gross_Margin - ((Y2015.Revenue * Y2014.[Gross_Margin%])         
  + Y2015.Gross_Margin-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG))       
  + ((Y2015.Revenue-(Y2015.Expense_Hours*(Y2014.Total_Cost_of_Service/((Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))+1.5*(Y2014.Expense_Hours-(Y2014.Expense_Hours/(Y2014.Overtime/1.5/(Y2014.Total_Cost_of_Service - Y2014.Overtime)+1))))))-(Y2015.Revenue - (Y2015.Expense_Hours * Y2014.COSPEXHWITHTRG))))                   
  + ( Y2015.Gross_Margin-((Y2015.Revenue + ((ISNULL(Y2015.Inbound_Penalties,0)-(Y2015.Revenue + ISNULL(Y2015.Inbound_Penalties,0)) * Y2014.[PENALTY%])))- Y2015.Total_Cost_of_Service))             
  + (Y2015.Gross_Margin -( Y2015.Revenue -( Y2015.Total_Cost_of_Service + (Y2015.COSPEXHWITHTRG *( Y2015.Billable_Hours / Y2014.[BTP with Training%] - Y2015.Expense_Hours) ))))) as Other,                  
Y2015.Gross_Margin as GM2015       
                  
                  
                  
  from       
                  
(Select ClientName, [YEAR],[Quarter],[month],Country,Sub_Region,Region,             
       sum (Revenue) as Revenue,         
       sum(Cost_of_service)as Total_Cost_of_Service,      
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',              (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',     
       SUM([Billable hours]) as Billable_Hours,    
       sum([Expense Hours]) as Expense_Hours,                 
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',                  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,             
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,         
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',    
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',                  
                  
       SUM(Inbound_Penalties) as 'Inbound_Penalties',    
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',                 
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',    
                  
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',     
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',        
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',                 
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',    
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',         
       SUM(Overtime) as 'Overtime',     
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',             
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',                  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',          
       SUM([Regular Wages]) as 'Regular Wages',               
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'      
                  
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],          
case when [Month] in ('Jan','Feb','Mar') then 'Q1'          
     when [Month] in ('Apr','May','Jun') then 'Q2'             
     when [Month] in ('Jul','Aug','Sep') then 'Q3'               
     when [Month] in ('Oct','Nov','Dec') then 'Q4'             
     else '' end as 'Quarter',    
                  
Country,Sub_Region,Region,               
                  
     SUM(Revenue) as Revenue,           
     sum([Cost of Services]) as Cost_of_service ,               
                  
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                  
                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                  
                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'  
                  
                  
                  
from         
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],    
ClientName,            
Country,   
Sub_Region,Region,              
                  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,           
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],               
                  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],   
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],            
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],        
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],                  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],            
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],                  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],                
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]                  
                  
                  
from         
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],    
ClientName,            
Country,Sub_Region,Region,               
sum(Metric_Value) as Metric_Value                  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code   
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code            
where      
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',        
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')                  
--and [Year] in ('2014','2015')             
and len (location_code) = 6                 
group by Location_Code,[Location_ Name]     
,Metric_Category,Metric_Name,[Year],[Month],ClientName,       
Country,Sub_Region,Region) aa) bb   
where Metric_Category ='USD Actual @ Budget Rate'                  
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'            
                  
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'     
                  
--='USD Actual @ Budget Rate'            
                  
----USD Actual @ Budget Rate             
                  
                  
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn          
                 
 where [YEAR] = @YEAR
 and Region = @REGION
 
 group by ClientName, [YEAR],[Quarter],[month],Country,Sub_Region,Region) Y2015                   
                  
  left Join                  
                  
(Select ClientName, [YEAR],[Quarter],               
       sum (Revenue) as Revenue,         
       sum(Cost_of_service)as Total_Cost_of_Service,      
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',       
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',     
       SUM([Billable hours]) as Billable_Hours,    
       sum([Expense Hours]) as Expense_Hours,                 
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',                  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,             
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,         
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',    
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',                  
                  
       SUM(Inbound_Penalties) as 'Inbound_Penalties',    
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',                 
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',    
                  
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',     
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',        
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',                 
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',    
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',         
       SUM(Overtime) as 'Overtime',     
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',             
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',                  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',          
       SUM([Regular Wages]) as 'Regular Wages',               
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'      
                  
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],          
case when [Month] in ('Jan','Feb','Mar') then 'Q1'          
     when [Month] in ('Apr','May','Jun') then 'Q2'             
     when [Month] in ('Jul','Aug','Sep') then 'Q3'               
     when [Month] in ('Oct','Nov','Dec') then 'Q4'             
     else '' end as 'Quarter',    
                  
Country,Sub_Region,Region,               
                  
     SUM(Revenue) as Revenue,           
     sum([Cost of Services]) as Cost_of_service ,               
                  
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                  
                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                  
                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'  
                  
                  
                  
from         
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],    
ClientName,            
Country,   
Sub_Region,Region,              
                  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,           
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],               
                  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],   
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],            
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],        
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],                  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],            
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],                  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],                
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]                  
                  
                  
from         
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],    
ClientName,            
Country,Sub_Region,Region,               
sum(Metric_Value) as Metric_Value                  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code   
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code            
where      
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',        
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')     
--and [Year] in ('2014','2015')             
and len (location_code) = 6                 
group by Location_Code,[Location_ Name]     
,Metric_Category,Metric_Name,[Year],[Month],ClientName,       
Country,Sub_Region,Region) aa) bb   
where Metric_Category ='USD Budget Load'   
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null'            
                  
--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'     
                  
--='USD Actual @ Budget Rate'            
                  
----USD Actual @ Budget Rate             
                  
                  
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn          
                 
where [YEAR] = @YEAR
and Region = @REGION
 
 group by ClientName, [YEAR],[Quarter]) Y2014 
on Y2014.ClientName = Y2015.ClientName and Y2014.[Quarter]=Y2015.[Quarter]     
where y2015.ClientName is not null                
  --and y2015.[QUARTER] in('Q2')       
and Y2015.Gross_Margin is not null                 
and region not in ('Corp','Global')       
)x )y    
GO
/****** Object:  StoredProcedure [dbo].[BUDGET_SP1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BUDGET_SP1]

(
       @CLIENTNAME AS VARCHAR(max),
       @LOB NVARCHAR(MAX),
       @METRIC NVARCHAR(max)
)
AS
BEGIN
SELECT Project_Name, LOB,xSite,Budgeting_Year, 
Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, [Dec] FROM BGT_TBL_DATA_UPLOAD
where Metric = @METRIC
and Project_Name = @CLIENTNAME
and LOB = @LOB
order by Budgeting_Year,xSite
END
GO
/****** Object:  StoredProcedure [dbo].[CapctureSaveing]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CapctureSaveing]
As
Begin
	Declare @xEmpCode as float
	Declare @xProjectCode as nvarchar(255)
	Declare @xCATEGORY as nvarchar(255)

	Declare @xEmpCodeCheck as float
	Declare @xProjectCodeCheck as nvarchar(255)
	Declare @xCATEGORYCheck as nvarchar(255)

	Declare @xMoved as int
	Declare @xAttrited as int

	if exists (
		select  * from tempdb.xSPT.sysobjects o
		where o.xtype in ('U') 

	   and o.id = object_id(N'tempdb..#TmpTable')
	)
	Begin
		DROP TABLE #TmpTable;
	end

	Select [User/Employee ID] EMPCODE ,S.PROJECTCODE,S.CATEGORY,0 ATTRITED, 0 MOVED into #TmpTable
	from [SAMPLE] S
	INNER JOIN (
	Select ProjectCode,CATEGORY,[Month]
	from (
		SELECT     TOP (100) PERCENT convert (varchar,xSPT.Sample.xMonth,112) AS Month, xSPT.Sample.Country, xSPT.Sample.[Job Classification Job Level], SUBSTRING(xSPT.Sample.[Job Classification Job Code], 1, 6) 
						  AS JobCode, xSPT.Sample.CATEGORY, xSPT.Sample.ProjectCode, COUNT(xSPT.Sample.[Job Classification Job Level]) AS CurrentCount,
							  (
								SELECT     COUNT(CATEGORY) AS Expr1
								FROM          xSPT.Sample AS a
								WHERE      (ProjectCode = xSPT.Sample.ProjectCode) AND (CATEGORY = 'Agent')) AS ProjectAgentsCount, xSPT.OpportunityPositions.GOSRatio, 
						  xSPT.ForeCasting.AgentCount - xSPT.ForeCasting.AgentCount * 40 / 100 AS ForecastAgentCount, (xSPT.ForeCasting.AgentCount - xSPT.ForeCasting.AgentCount * 40 / 100) 
						  / xSPT.OpportunityPositions.GOSRatio AS ForecastPositionCount, COUNT(xSPT.Sample.[Job Classification Job Level]) 
						  - (xSPT.ForeCasting.AgentCount - xSPT.ForeCasting.AgentCount * 40 / 100) / xSPT.OpportunityPositions.GOSRatio AS Opportunities, xSPT.Sample.DivisionName, 
						  xSPT.Sample.WorkLocationName, xSPT.Sample.ProjectName
	FROM         xSPT.Sample INNER JOIN
						  xSPT.OpportunityPositions ON SUBSTRING(xSPT.Sample.[Job Classification Job Code], 1, 6) = SUBSTRING(xSPT.OpportunityPositions.[Job Classification Job Code], 1, 6) 
						  LEFT OUTER JOIN
						  xSPT.ForeCasting ON xSPT.Sample.ProjectCode = xSPT.ForeCasting.ProjectCode
						  AND convert (varchar,xSPT.Sample.xMonth,112) = convert (varchar,xSPT.ForeCasting.Date,112)
						  --where xSPT.Sample.Country='India'
	--where CATEGORY='OPS_Coach'
	GROUP BY convert (varchar,xSPT.Sample.xMonth,112) ,xSPT.Sample.Country, xSPT.Sample.ProjectCode, xSPT.Sample.[Job Classification Job Code], xSPT.Sample.[Job Classification Job Level], xSPT.Sample.CATEGORY, 
						  xSPT.OpportunityPositions.GOSRatio, xSPT.ForeCasting.AgentCount, xSPT.Sample.DivisionName, xSPT.Sample.WorkLocationName, xSPT.Sample.ProjectName
	) TMP
	WHERE 1 = 1
	AND isnull(TMP.Opportunities,0) > 0
	--AND TMP.CATEGORY = 'OPS_Coach'
	AND [Month] = '20160801') TMP2 on TMP2.CATEGORY = S.CATEGORY
	AND S.[xMonth] = TMP2.[Month]
	and S.ProjectCode = TMP2.ProjectCode
	ORDER BY S.ProjectCode,S.CATEGORY


	Declare  xCursor cursor for
	Select EMPCODE ,PROJECTCODE,CATEGORY from #TmpTable

	Open xCursor

	FETCH NEXT FROM xCursor INTO @xEmpCode,@xProjectCode,@xCATEGORY
	WHILE @@FETCH_STATUS = 0
	BEGIN
		print @xEmpCode
		Select @xEmpCodeCheck = [User/Employee ID],
		@xPROJECTCODECheck = PROJECTCODE,
		@xCATEGORYCheck = CATEGORY
		from [SAMPLE]
		WHERE [User/Employee ID]=@xEmpCode
		and xMonth = '20160901'
		
		Set @xMoved = 0
		If (@xEmpCodeCheck = @xEmpCode AND @xPROJECTCODECheck <> @xProjectCode)--@xCATEGORYCheck = @xCATEGORY
		Begin
			Set @xMoved = 1
		End
		
		Set @xAttrited = 0
		If (@xEmpCodeCheck <> @xEmpCode)
		Begin
			Set @xAttrited = 1
		End
		
		Update #TmpTable set ATTRITED = @xAttrited, MOVED = @xMoved WHERE EMPCODE = @xEmpCode
		
		FETCH NEXT FROM xCursor INTO @xEmpCode,@xProjectCode,@xCATEGORY
	END

	CLOSE xCursor
	DEALLOCATE xCursor

	Select * from #TmpTable


	--select convert(nvarchar(255),CATEGORY) from [SAMPLE]
	
	End

GO
/****** Object:  StoredProcedure [dbo].[captureMonthlyOpp]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [xSPT].[captureMonthlyOpp]
CREATE Proc [dbo].[captureMonthlyOpp]

AS
BEGIN
SELECT     TOP (100) PERCENT 'Sep' AS Month, xSPT.Sample.Country, xSPT.Sample.[Job Classification Job Level], SUBSTRING(xSPT.Sample.[Job Classification Job Code], 1, 6) 
                      AS JobCode, xSPT.Sample.CATEGORY, xSPT.Sample.ProjectCode, COUNT(xSPT.Sample.[Job Classification Job Level]) AS CurrentCount,
                          (SELECT     COUNT(CATEGORY) AS Expr1
                            FROM          xSPT.Sample AS a
                            WHERE      (ProjectCode = xSPT.Sample.ProjectCode) AND (CATEGORY = 'Agent')) AS ProjectAgentsCount, xSPT.OpportunityPositions.GOSRatio, 
                      xSPT.ForeCasting.AgentCount - xSPT.ForeCasting.AgentCount * 40 / 100 AS ForecastAgentCount, (xSPT.ForeCasting.AgentCount - xSPT.ForeCasting.AgentCount * 40 / 100) 
                      / xSPT.OpportunityPositions.GOSRatio AS ForecastPositionCount, COUNT(xSPT.Sample.[Job Classification Job Level]) 
                      - (xSPT.ForeCasting.AgentCount - xSPT.ForeCasting.AgentCount * 40 / 100) / xSPT.OpportunityPositions.GOSRatio AS Opportunities, xSPT.Sample.DivisionCode, 
                      xSPT.Sample.WorkLocationName, xSPT.Sample.ProjectName, xSPT.Sample.WorkLocationCode
FROM         xSPT.Sample INNER JOIN
                      xSPT.OpportunityPositions ON SUBSTRING(xSPT.Sample.[Job Classification Job Code], 1, 6) = SUBSTRING(xSPT.OpportunityPositions.[Job Classification Job Code], 1, 6) 
                      INNER JOIN
                      xSPT.ForeCasting ON xSPT.Sample.ProjectCode = xSPT.ForeCasting.ProjectCode
GROUP BY xSPT.Sample.Country, xSPT.Sample.ProjectCode, xSPT.Sample.[Job Classification Job Code], xSPT.Sample.[Job Classification Job Level], xSPT.Sample.CATEGORY, 
                      xSPT.OpportunityPositions.GOSRatio, xSPT.ForeCasting.AgentCount, xSPT.Sample.DivisionCode, xSPT.Sample.WorkLocationName, xSPT.Sample.ProjectName, 
                      xSPT.Sample.WorkLocationCode
--ORDER BY xSPT.Sample.ProjectCode
END

GO
/****** Object:  StoredProcedure [dbo].[check_credentials_warroom]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[check_credentials_warroom]
@NT_ID Varchar(255)
as

Select Region,Access_Type from War_room_user_Role where NT_ID = @NT_ID
GO
/****** Object:  StoredProcedure [dbo].[CHEKEMP]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CHEKEMP]
@WorkLocationName nvarchar(50)
AS
BEGIN
select * from Employee 
inner join
BusinessHeads on Employee.EmployeeID=BusinessHeads.EmployeeId where BusinessHeads.WorkLocationName=@WorkLocationName
END

GO
/****** Object:  StoredProcedure [dbo].[Client_Location_Map]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Client_Location_Map]

@ClientName Varchar(255)
as
Select Location_Code,[Location_ Name] as Location from CLIENT_LOC where CLIENTNAME =@ClientName

GO
/****** Object:  StoredProcedure [dbo].[CUSTOM_F_Client_missing_GM_Procedure]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CUSTOM_F_Client_missing_GM_Procedure]
@REGION VARCHAR(255)  = NULL    
as     

IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END    

(
select * from CUSTOM_F_Client_missing_GM_Sheet2
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
and GM_Sur_Def is not null

)
order by GM_Sur_Def ASC
GO
/****** Object:  StoredProcedure [dbo].[CUSTOM_F_CLIENT_MISSING_REV_GM_Procedure]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CUSTOM_F_CLIENT_MISSING_REV_GM_Procedure]
@REGION VARCHAR(255)  = NULL    
as     

IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END    

(
select * from CUSTOM_F_CLIENT_MISSING_REV_GM
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
and GM_Sur_Def is not null

)
order by GM_Sur_Def ASC
GO
/****** Object:  StoredProcedure [dbo].[CUSTOM_F_Client_missing_rev_Procedure]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CUSTOM_F_Client_missing_rev_Procedure]
@REGION VARCHAR(255)  = NULL    
as     

IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END    

(
select * from CUSTOM_F_Client_missing_rev_Sheet2
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
and Rev_Sur_Def is not null

)
order by Rev_Sur_Def ASC
GO
/****** Object:  StoredProcedure [dbo].[CUSTOM_MONTHLY_REVENUE_GM_Procedure]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CUSTOM_MONTHLY_REVENUE_GM_Procedure]
(
@CLIENT_NAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL    
)
as     
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    

BEGIN    
SET @REGION = 'ALL'    
END    
(

select * from CUSTOM_MONTHLY_REVENUE_GM
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL') AND
ClientName = @CLIENT_NAME
and A_REVENUE is not null
)
order by region,[YEAR],[RANK] ASC
GO
/****** Object:  StoredProcedure [dbo].[CUSTOMIZE_MONTHLY_7CHART_3SHEET]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CUSTOMIZE_MONTHLY_7CHART_3SHEET]
(
@REGION VARCHAR(255)  = NULL
)
AS
BEGIN
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''
BEGIN
SET @REGION = 'ALL'
END

TRUNCATE TABLE 	CUSTOMIZE_MONTHLY_7CHART
INSERT  INTO CUSTOMIZE_MONTHLY_7CHART

SELECT  LM.REGION,B.CLIENTNAME,[MONTH], [YEAR],
ROUND(SUM(ACT_REV),0) AS A_REVENUE,
ROUND(SUM(BGT_REV),0) AS B_REVENUE,
CASE WHEN (ROUND(SUM(ACT_REV),0)-ROUND(SUM(BGT_REV),0)) >0 THEN (ROUND(SUM(ACT_REV),0)-ROUND(SUM(BGT_REV),0)) ELSE '' END AS SURPLUS_REVENUE,
CASE WHEN (ROUND(SUM(ACT_REV),0)-ROUND(SUM(BGT_REV),0)) <0 THEN (ROUND(SUM(ACT_REV),0)-ROUND(SUM(BGT_REV),0)) ELSE '' END AS DEFICIT_REVENUE,

ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0)  AS A_GM,
ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0)  AS B_GM,
CASE WHEN (ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0)) >0 THEN (ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0)) ELSE '' END AS SURPLUS_GM,
CASE WHEN (ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0)) <0 THEN (ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0)) ELSE '' END AS DEFICIT_GM,

((ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))/NULLIF(ROUND(SUM(ACT_REV),0),0))  AS 'A_GM%',
((ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0))/NULLIF(ROUND(SUM(BGT_REV),0),0))  AS 'B_GM%',
CASE WHEN (((ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))/NULLIF(ROUND(SUM(ACT_REV),0),0))-((ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0))/NULLIF(ROUND(SUM(BGT_REV),0),0)))>0
THEN (((ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))/NULLIF(ROUND(SUM(ACT_REV),0),0))-((ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0))/NULLIF(ROUND(SUM(BGT_REV),0),0)))
ELSE '' END AS 'SURPLUS_GM%',
CASE WHEN (((ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))/NULLIF(ROUND(SUM(ACT_REV),0),0))-((ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0))/NULLIF(ROUND(SUM(BGT_REV),0),0)))>0
THEN (((ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0))/NULLIF(ROUND(SUM(ACT_REV),0),0))-((ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0))/NULLIF(ROUND(SUM(BGT_REV),0),0)))
ELSE '' END AS 'DEFICIT_GM%',

(ROUND(SUM(ACT_BHET),0)/nullif(ROUND(SUM(ACT_EHET),0),0)) AS A_BTP,
(ROUND(SUM(BGT_BHET),0)/nullif(ROUND(SUM(BGT_EHET),0),0)) AS B_BTP,
CASE WHEN ((ROUND(SUM(ACT_BHET),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_BHET),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) >0
THEN  ((ROUND(SUM(ACT_BHET),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_BHET),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) ELSE '' END AS SURPLUS_BTP,
CASE WHEN ((ROUND(SUM(ACT_BHET),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_BHET),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) <0
THEN  ((ROUND(SUM(ACT_BHET),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_BHET),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) ELSE '' END AS Deficit_BTP,

(ROUND(SUM(ACT_REV),0)/nullif(ROUND(SUM(ACT_EHET),0),0)) AS A_RPEH,
(ROUND(SUM(BGT_REV),0)/nullif(ROUND(SUM(BGT_EHET),0),0)) AS B_RPEH,
CASE WHEN ((ROUND(SUM(ACT_REV),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_REV),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) >0
THEN ((ROUND(SUM(ACT_REV),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_REV),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) ELSE '' END AS SURLUS_RPEH,
CASE WHEN ((ROUND(SUM(ACT_REV),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_REV),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) <0
THEN ((ROUND(SUM(ACT_REV),0)/nullif(ROUND(SUM(ACT_EHET),0),0))-(ROUND(SUM(BGT_REV),0)/nullif(ROUND(SUM(BGT_EHET),0),0))) ELSE '' END AS DEFICIT_RPEH,

(ROUND(SUM(ACT_PENALTIES),0)) AS A_PENALTIES,
(ROUND(SUM(BGT_PENALTIES),0)) AS B_PENALTIES,

(ROUND(SUM(ACT_COS),0)) AS A_COS,
(ROUND(SUM(BGT_COS),0)) AS B_COS,
CASE WHEN (ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_COS),0)) >0 THEN  (ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_COS),0)) ELSE '' END AS SURPLUS_COS,
CASE WHEN (ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_COS),0)) <0 THEN  (ROUND(SUM(ACT_COS),0))-(ROUND(SUM(BGT_COS),0)) ELSE '' END AS SURPLUS_COS,

MR.[RANK]
FROM (
SELECT PROJECT_CODE,LOCATION_CODE,[MONTH], [YEAR],
CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'REVENUE' THEN (SUM(METRIC_VALUE)*-1) END AS ACT_REV,
CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE)*-1 END AS BGT_REV,

CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS ACT_COS,
CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS BGT_COS,

CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'BILLABLE HOURS EXCLUDING TRAINING' THEN (SUM(METRIC_VALUE)*-1) END AS ACT_BHET,
CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'EXPENSE HOURS EXCLUDING TRAINING' THEN SUM(METRIC_VALUE) END AS ACT_EHET,
CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'BILLABLE HOURS EXCLUDING TRAINING' THEN SUM(METRIC_VALUE) END AS BGT_BHET,
CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'EXPENSE HOURS EXCLUDING TRAINING' THEN SUM(METRIC_VALUE) END AS BGT_EHET,

CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'INBOUND PENALTIES' THEN (SUM(METRIC_VALUE)*-1) END AS ACT_PENALTIES,
CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'INBOUND PENALTIES' THEN SUM(METRIC_VALUE)*-1 END AS BGT_PENALTIES

FROM FINANCERAW2016
WHERE YEAR IN ('2015','2016')
GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE,LOCATION_CODE,[MONTH], [YEAR]
)A    	LEFT JOIN    (
SELECT DISTINCT CLIENTNAME, PRCODE
FROM CLIENT_MAPPING
)B    	ON A.PROJECT_CODE = B.PRCODE
LEFT JOIN (
SELECT *
FROM LOCATION_MAPPING
)LM   ON  LM.LOC_CODE =  A.LOCATION_CODE
LEFT JOIN  (
SELECT *
FROM MONTHSRANK
)MR  ON A.[MONTH] = MR.[MONTHS]
WHERE  1=1
AND ISNULL(REGION,'') NOT IN('','CORP','GLOBAL')
--AND    (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
GROUP BY LM.REGION,B.CLIENTNAME,[MONTH], [YEAR],MR.[RANK]
ORDER BY LM.REGION,B.CLIENTNAME, A.[YEAR] ASC,MR.[RANK] ASC
END


GO
/****** Object:  StoredProcedure [dbo].[CUSTOMIZE_MONTHLY_7CHART_Procedure]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CUSTOMIZE_MONTHLY_7CHART_Procedure]
-- 'TOTAL AMAZON'
(
@CLIENT_NAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL    
)
as     
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    

BEGIN    
SET @REGION = 'ALL'    
END    
(

select * from CUSTOMIZE_MONTHLY_7CHART
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL') AND
ClientName = @CLIENT_NAME
and A_REVENUE is not null
)
order by REGION,CLIENTNAME,[YEAR],[RANK] ASC
GO
/****** Object:  StoredProcedure [dbo].[Department_Combo]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Department_Combo]
as
(
Select * from Department
)
GO
/****** Object:  StoredProcedure [dbo].[Designation_Combo]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Designation_Combo]
as
(
Select * from Designation
)
GO
/****** Object:  StoredProcedure [dbo].[Emp_role_Combo]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Emp_role_Combo]
as
(
Select * from Emp_role
)
GO
/****** Object:  StoredProcedure [dbo].[Emp_Type_Combo]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Emp_Type_Combo]
as
(
Select * from Emp_Type
)
GO
/****** Object:  StoredProcedure [dbo].[employee_list_box_home]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[employee_list_box_home]  
(
	@Sup_ECN as varchar(max)  
)
  
as  
  
Begin  
	select 
	Employee_ID,
	lower(NT_ID) AS NI_ID,
	Upper(first_name)AS FIRST_NAME,
	Upper(last_name) AS LAST_NAME, 
	Lower(Email_ID) AS EMAIL_ID
	from WFM_Employee_List   
	where Supervisor_ECN =@Sup_ECN and  
	Employee_Status = 'Active'  
End 
  
  
  
  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[Employee_master_data]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Employee_master_data]  
as      
BEGIN  
 IF EXISTS(SELECT * FROM WFM_Leave_pacman_empdetails)      
 BEGIN  
  DROP TABLE WFM_LEAVE_PACMAN_EMPDETAILS      
 END  
   
 Select * into WFM_Leave_pacman_empdetails from      
 (      
 Select * from       
 (select   
 case when cast(Employee_ID as nvarchar(max)) = ''  then 'No ECN' else cast(Employee_ID as nvarchar(max)) end AS 'ECN',  
 NT_ID AS 'NT ID',  
 First_Name AS 'First Name',  
 Middle_Name AS 'Middle Name',  
 Last_Name AS 'Last Name',  
 Gender AS 'Gender',  
 Date_of_Birth AS 'DOB',  
 Marital_Status AS 'Marital Status',  
 Anniversary_Date AS 'Anniversary Date',  
 Address_Country AS 'Address Country',  
 Address_City AS 'City',  
 Address_Line_1 AS 'Address 1',  
 Address_Line_2 AS 'Address 2',  
 Address_Landmark AS 'Landmark',  
 Permanent_Address_City AS 'Permanent City',  
 Contact_Number AS 'Contact Number',  
 Alternate_Contact AS 'Alternate Contact',  
 Email_id AS 'Email id',  
 Transport_User AS 'Transport User',  
 Country AS 'Country',  
 City AS 'Current City',  
 [Site] AS 'Site',  
 Department AS 'Department',  
 Sub_Department AS 'Sub Department',  
 Designation AS 'Designation',  
 Supervisor AS 'Supervisor',  
 Date_of_Joining AS 'DOJ',  
 Employee_Role AS 'Employee Role',  
 Employee_Type AS 'Employee Type',  
 Employee_Status AS 'Employee Status',  
 Total_Work_Experience AS 'Total Experience (in months)',  
 Highest_Qualificatin AS 'Highest Qualificatin',  
 Skill_Set_1 AS 'Skill Set 1',  
 Skill_Set_1 AS 'Skill Set 2',  
 Skill_Set_1 AS 'Skill Set 3',  
 Updated_by AS 'Updated By',  
 Update_Date AS 'Update Date',  
 Supervisor_ECN AS 'Supervisor ECN'  
 from WFM_Employee_List)employee_database      
 Left Join      
 (select ECN as leave_ECN,      
 isnull([Compensatory],0)as [Comp Off],      
 isnull([Current Leave],0)as [Current Leave],      
 [Previous Leave],      
 [Current Balance] as [Total Leave Balance]      
 from leave_balance)Leave_balance      
 on employee_database.ECN = Leave_balance.leave_ECN
 left join      
 (Select      
 Emp_ID as 'EMP_ID',    
 Leave_Type as 'Leave Type',    
 Request_Date as 'Request Date',    
 [Start_Date] as 'Start Date',    
 End_Date as 'End Date',    
 No_of_Days as 'Leave Applied (Days)',    
 Leave_Status as 'Leave Status',    
 [Description],    
 Supevisor_Comment as 'Supervisor Comment',    
 Week_Before as 'Week Before',    
 Days_Before as 'Days Before',    
 Leave_Segment as 'Leave Segment'   
 from User_Leave_Request)leave_request      
 on employee_database.ECN= leave_request.Emp_ID)tblaaa   
 where [Employee Status] = 'Active'  
END  
GO
/****** Object:  StoredProcedure [dbo].[Employees_GetEmployees]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employees_GetEmployees]

      @Employee_Status nvarchar(255) = NULL

AS

BEGIN



      IF ISNULL(@Employee_Status, '') <> ''

      BEGIN

            SELECT Employee_Status

                  ,FirstName

                  ,LastName

            FROM WFM_Employees_List

            WHERE Employee_Status = @Employee_Status

      END

      ELSE

      BEGIN

            SELECT Employee_Status

                  ,FirstName

                  ,LastName

            FROM WFM_Employees_List

      END

END
GO
/****** Object:  StoredProcedure [dbo].[EPMRaw2EPM]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[EPMRaw2EPM]
(
	@NtName varchar(8),
	@RowsDeleted int output,
	@RowsAffected int output
)
AS
BEGIN
	Declare @xCnt int = 0;

	SELECT @xCnt = Count(*)
	FROM TBLEPM_TEMP
	WHERE [UPLOADEDBY] = @NtName;

	if (@xCnt > 0)
	BEGIN
		
		DECLARE @Year INT;
		DECLARE @Month VARCHAR(3);

		Set @RowsDeleted = 0;

		Declare xCursor Cursor for SELECT 
		LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH]
		FROM TBLEPM_TEMP
		WHERE [UPLOADEDBY] = @NtName
		GROUP BY LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))),
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3)
		;

		OPEN xCursor  

		FETCH NEXT FROM xCursor   
		INTO @Year,@Month

		WHILE @@FETCH_STATUS = 0  
		BEGIN
			
			DELETE FROM tblEPM
			WHERE [YEAR] = @Year
			and [Month] = @Month;

			Set @RowsDeleted = @RowsDeleted + @@ROWCOUNT;

			FETCH NEXT FROM xCursor   
		INTO @Year,@Month
		END   
		CLOSE xCursor;  
		DEALLOCATE xCursor;  

		INSERT INTO tblEPM 
				Select 
		REPLACE(LTRIM(RTRIM(LEFT([PROJECT], CHARINDEX('-', [PROJECT])-1))),'_','') [PROJECT_CODE],
		LTRIM(RTRIM(RIGHT([PROJECT], LEN([PROJECT])-CHARINDEX('-', [PROJECT])))) [PROJECT_NAME],
		LTRIM(RTRIM(LEFT([PROFITCTR], CHARINDEX('-', [PROFITCTR])-1))) [LOCATION_CODE],[LOCATION] [LOCATION_NAME],
		REPLACE([CLIENT ID],'_','') [CLIENT_ID],
		LTRIM(RTRIM(REPLACE([CLIENT NAME],'TOTAL',''))) [CLIENT NAME],
		TMP.[COUNTRY],CR.[REGION],
		MC.EssBase [Metric_Category], ISNULL(MN.EssBase,TMP.ACCOUNT) [Metric_Name],
		LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH],
		[DATA] [Metric_Value],NULL,NULL,1

		FROM TBLEPM_TEMP TMP
		LEFT OUTER JOIN TBLCOUNTRYREGION CR on CR.COUNTRY = TMP.COUNTRY
		LEFT OUTER JOIN TBLMETRIC_CATEGORY MC on MC.EPM1 = TMP.Category and MC.EPM2 = [Currency Type]
		LEFT OUTER JOIN TBLMETRIC_NAME MN on MN.EPM = TMP.ACCOUNT
		WHERE ISNULL([DATA],0) <> 0
		AND [UPLOADEDBY] = @NtName;

		Set @RowsAffected = @@ROWCOUNT;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[EPMTemp2EPMRaw]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[EPMTemp2EPMRaw]
(
	@NtName varchar(8),
	@RowsDeleted int output,
	@RowsAffected int output
)
AS
BEGIN
	Declare @xCnt int = 0;

	SELECT @xCnt = Count(*)
	FROM TBLEPM_TEMP
	WHERE [UPLOADEDBY] = @NtName;

	if (@xCnt > 0)
	BEGIN
		
		DECLARE @Year INT;
		DECLARE @Month VARCHAR(3);

		Set @RowsDeleted = 0;

		Declare xCursor Cursor for SELECT 
		LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH]
		FROM TBLEPM_TEMP
		WHERE [UPLOADEDBY] = @NtName
		GROUP BY LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))),
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3)
		;

		OPEN xCursor  

		FETCH NEXT FROM xCursor   
		INTO @Year,@Month

		WHILE @@FETCH_STATUS = 0  
		BEGIN
			
			DELETE FROM tblEPMRaw
			WHERE [YEAR] = @Year
			and [Month] = @Month;

			Set @RowsDeleted = @RowsDeleted + @@ROWCOUNT;

			FETCH NEXT FROM xCursor   
		INTO @Year,@Month
		END   
		CLOSE xCursor;  
		DEALLOCATE xCursor;  

		INSERT INTO tblEPMRaw 
		SELECT LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH],
		[CATEGORY],[CURRENCY TYPE],REPLACE([CLIENT ID],'_','') [CLIENT_ID],
		LTRIM(RTRIM(REPLACE([CLIENT NAME],'TOTAL',''))) [CLIENT NAME],
		[LOB_NAME],
		LTRIM(RTRIM(LEFT([PROFITCTR], CHARINDEX('-', [PROFITCTR])-1))) [LOCATION_CODE],
		[LOCATION],TMP.[COUNTRY],CR.[REGION],
		REPLACE(LTRIM(RTRIM(LEFT([PROJECT], CHARINDEX('-', [PROJECT])-1))),'_','') [PROJECT_CODE],
		LTRIM(RTRIM(RIGHT([PROJECT], LEN([PROJECT])-CHARINDEX('-', [PROJECT])))) [PROJECT],[PROFITCTR],[ACCOUNT],[DATA]
		FROM TBLEPM_TEMP TMP
		LEFT OUTER JOIN TBLCOUNTRYREGION CR on CR.COUNTRY = TMP.COUNTRY
		WHERE ISNULL([DATA],0) <> 0
		AND [UPLOADEDBY] = @NtName;

		Set @RowsAffected = @@ROWCOUNT;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[F_BRIDGE_DATA]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_BRIDGE_DATA]
(
@CLIENT_NAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL    
)
as     
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END 

Select * from F_Finance_Bridge
where  1=1
AND (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')   
AND ClientName = @CLIENT_NAME
GO
/****** Object:  StoredProcedure [dbo].[F_Client_Count_Home]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_Client_Count_Home]  
  
@REGION VARCHAR(255)  = NULL    
  
as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END    
  
Select y.region,count(y.ClientName) from
(Select  lm.Region, b.ClientName

from   
(Select Project_Code,location_code,
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Act_Rev  
from financeraw2016  
where YEAR IN ('2016')  
group by Metric_Category, Metric_Name,Project_Code,location_code, [YEAR]  
)a  
Left Join  
(Select distinct ClientName, PRCode from Client_mapping)b  
on a.Project_Code = b.PRCode  
left join (Select * from Location_Mapping)LM 
on  LM.LOC_Code =  a.Location_code 
where  Region is not null AND region not in('CORP','GLOBAL')
and a.Act_Rev is not null
and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
group by LM.Region,b.ClientName
)y
group  by y.Region
order by y.Region
GO
/****** Object:  StoredProcedure [dbo].[F_Client_missing_GM_Sheet2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_Client_missing_GM_Sheet2]  
  
@REGION VARCHAR(255)  = NULL    
  
as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END    


Select Region,ClientName,A_GM,B_GM,GM_Sur_Def
from

(Select  lm.Region,b.ClientName,
round(Sum(Act_Rev),0)-round(sum(Act_COS),0)as A_GM,
round(Sum(Bgt_Rev),0)-round(sum(Bgt_COS),0)as B_GM,
(round(Sum(Act_Rev),0)-round(sum(Act_COS),0))-(round(Sum(Bgt_Rev),0)-round(sum(Bgt_COS),0)) as GM_Sur_Def
from 
(Select Project_Code,location_code,[MONTH],
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Act_Rev,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Bgt_Rev,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Bgt_COS

from financeraw2016
where YEAR = datename(YEAR,GETDATE())
and [month] in ('Jan','Feb','Mar')
group by Metric_Category, Metric_Name,Project_Code,location_code, [Month]
)a
Left Join
(Select distinct ClientName, PRCode from Client_mapping)b
on a.Project_Code = b.PRCode
left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code
where  Region not in ('Global','Corp')
and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
group by LM.Region,b.ClientName
)p
Where GM_Sur_Def is not null
and GM_Sur_Def <0
and ClientName is not null
order by GM_Sur_Def


GO
/****** Object:  StoredProcedure [dbo].[F_Client_missing_Rev_GM_Sheet2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_Client_missing_Rev_GM_Sheet2]  
  
@REGION VARCHAR(255)  = NULL    
  
as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END    


Select Region,ClientName,A_Revenue,B_Revenue,Rev_Sur_Def,A_GM,B_GM,GM_Sur_Def
from

(Select  lm.Region,b.ClientName,
round(Sum(Act_Rev),0) as A_Revenue, 
round(Sum(Bgt_Rev),0) as B_Revenue,
round(Sum(Act_Rev),0)-round(Sum(Bgt_Rev),0) as Rev_Sur_Def,
round(Sum(Act_Rev),0)-round(sum(Act_COS),0)as A_GM,
round(Sum(Bgt_Rev),0)-round(sum(Bgt_COS),0)as B_GM,
(round(Sum(Act_Rev),0)-round(sum(Act_COS),0))-(round(Sum(Bgt_Rev),0)-round(sum(Bgt_COS),0)) as GM_Sur_Def
from 
(Select Project_Code,location_code,[MONTH],
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Act_Rev,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Bgt_Rev,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Bgt_COS

from financeraw2016
where YEAR = datename(YEAR,GETDATE())
and [month] in ('Jan','Feb','Mar')
group by Metric_Category, Metric_Name,Project_Code,location_code, [Month]
)a
Left Join
(Select distinct ClientName, PRCode from Client_mapping)b
on a.Project_Code = b.PRCode
left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code
where  Region not in ('Global','Corp')
and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
group by LM.Region,b.ClientName
)p
Where Rev_Sur_Def is not null
and Rev_Sur_Def <0
and GM_Sur_Def <0
and ClientName is not null
order by Rev_Sur_Def


GO
/****** Object:  StoredProcedure [dbo].[F_Client_missing_rev_Sheet2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_Client_missing_rev_Sheet2]  
  
@REGION VARCHAR(255)  = NULL    
  
as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END    


Select Region,ClientName,A_Revenue,B_Revenue,Rev_Sur_Def
from

(Select  lm.Region,b.ClientName,
round(Sum(Act_Rev),0) as A_Revenue, 
round(Sum(Bgt_Rev),0) as B_Revenue,
round(Sum(Act_Rev),0)-round(Sum(Bgt_Rev),0) as Rev_Sur_Def

from 
(Select Project_Code,location_code,[MONTH],
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Act_Rev,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Bgt_Rev,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Bgt_COS

from financeraw2016
where YEAR = datename(YEAR,GETDATE())
and [month] in ('Jan','Feb','Mar')
group by Metric_Category, Metric_Name,Project_Code,location_code, [Month]
)a
Left Join
(Select distinct ClientName, PRCode from Client_mapping)b
on a.Project_Code = b.PRCode
left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code
where  Region not in ('Global','Corp')
and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
group by LM.Region,b.ClientName
)p
Where Rev_Sur_Def is not null
and Rev_Sur_Def <0
and ClientName is not null
order by Rev_Sur_Def


GO
/****** Object:  StoredProcedure [dbo].[F_COST_ANALYSIS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_COST_ANALYSIS]
(
@CLIENT_NAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL    
 )

as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END    

Select  * from
(Select 
ab.ClientName,ab.Region,MetricName,
round(SUM(ab.B_Value),0) as B_COS,
round(SUM(ab.A_Value),0) as A_COS,
Case when SUM(ab.A_Value)>SUM(ab.B_Value) then round((SUM(ab.A_Value)-SUM(ab.B_Value)),0)*-1 else 0 end as Exceed,
Case when SUM(ab.A_Value)<SUM(ab.B_Value) then round((SUM(ab.B_Value)-SUM(ab.A_Value)),0) else 0 end as Saved
from
(
Select 
cm.ClientName,lm.Region,
MetricName, SUM([AValue]) as A_Value , SUM([BValue]) as B_Value from
(
Select 
Project_Code,Location_Code,
c.MetricName, 
case when Metric_Category = 'USD ACTUAL @ BUDGET RAte' then SUM(Metric_Value) else '' end as  AValue,
case when  Metric_Category = 'USD BUDGET Load' then SUM(Metric_Value) else '' end as  BValue
from financeraw2016 f
left join MetricName_COS C on f.Metric_Name =  c.MetricName
where Metric_Category in ('USD ACTUAL @ BUDGET RATE', 'USD BUDGET LOAD')
and Year = 2016
and Month in ('Jan','Feb','Mar')
and Metric_Value is not null
--and Metric_Name = ''
and c.metricname is not null
--and c.MetricName = 'COS_Salaries & Temporary Help'
group by
Project_Code,Location_Code,Metric_Category,c.MetricName) base
left join Client_Mapping cm on base.Project_Code=cm.PRCode
left join Location_Mapping lm on lm.LOC_Code=base.Location_Code

group by
cm.ClientName,lm.Region,
MetricName,AValue,BValue
)ab
group by ab.ClientName,ab.Region,MetricName
)final
where MetricName not in ('COS_Salaries % of Revenue','COS_Tax & Fringe % of Salaries','REC AND WELFARE 50%')
and ClientName = @CLIENT_NAME
and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
and A_COS > 000
order by 
Saved desc,Exceed desc


GO
/****** Object:  StoredProcedure [dbo].[F_COST_INDEPTH_ANALYSIS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F_COST_INDEPTH_ANALYSIS]
(
@CLIENTNAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL    
)  
as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END    
  


Select top 12 * from
(Select 
ab.ClientName,ab.Region,MetricName,
round(SUM(ab.B_Value),0) as B_COS,
round(SUM(ab.A_Value),0) as A_COS,
Case when SUM(ab.A_Value)>SUM(ab.B_Value) then round((SUM(ab.A_Value)-SUM(ab.B_Value)),0)*-1 else 0 end as Exceed,
Case when SUM(ab.A_Value)<SUM(ab.B_Value) then round((SUM(ab.B_Value)-SUM(ab.A_Value)),0) else 0 end as Saved
from
(
Select 
cm.ClientName,lm.Region,
MetricName, SUM([AValue]) as A_Value , SUM([BValue]) as B_Value from
(
Select 
Project_Code,Location_Code,
c.MetricName, 
case when Metric_Category = 'USD ACTUAL @ BUDGET RAte' then SUM(Metric_Value) else '' end as  AValue,
case when  Metric_Category = 'USD BUDGET Load' then SUM(Metric_Value) else '' end as  BValue
from financeraw2016 f
left join MetricName_COS C on f.Metric_Name =  c.MetricName
where Metric_Category in ('USD ACTUAL @ BUDGET RATE', 'USD BUDGET LOAD')
and Metric_Name not in ('COS_Salaries % of Revenue','COS_Tax & Fringe % of Salaries','REC AND WELFARE 50%')
and Year = 2016
and Month in ('Jan','Feb','Mar')
and Metric_Value is not null
--and Metric_Name = ''
and c.metricname is not null
--and c.MetricName = 'COS_Salaries & Temporary Help'
group by
Project_Code,Location_Code,Metric_Category,c.MetricName) base
left join Client_Mapping cm on base.Project_Code=cm.PRCode
left join Location_Mapping lm on lm.LOC_Code=base.Location_Code
group by
cm.ClientName,lm.Region,
MetricName,AValue,BValue
)ab
group by ab.ClientName,ab.Region,MetricName
)final
where ClientName = @CLIENTNAME
and (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
order by 
Exceed, 
ClientName


GO
/****** Object:  StoredProcedure [dbo].[F_Finance_Bridge_PROCEDURE]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F_Finance_Bridge_PROCEDURE]

as

truncate table F_Finance_Bridge

INSERT into F_Finance_Bridge

Select ClientName,metric_category,metric_name,[year],Region,
     
    SUM(Revenue) as Revenue, 
    sum([Cost of Services]) as Cost_of_service , 
    
	SUM([Billable Hours]) as [Billable hours],
	SUM([Expense Hours]) as [Expense Hours],
		
		
	SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
	SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,	
			
	SUM([INBOUND PENALTIES]) as Inbound_Penalties,
	
	Sum([OVERTIME]) as Overtime,
	SUM([REGULAR WAGES]) as 'Regular Wages',
	sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'	
	
	

from 
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],
ClientName,PRCode,PRName,
Country,
Sub_Region,Region,

case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],

case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]


from
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],PRCode,PRName,
ClientName,
Country,Sub_Region,Region,
sum(Metric_Value) as Metric_Value
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code 
where 
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')

and len (location_code) = 6
group by Location_Code,[Location_ Name]
,Metric_Category,Metric_Name,[Year],[Month],ClientName,PRCode,PRName,
Country,Sub_Region,Region) aa) bb
where Metric_Category in ('USD Actual @ Budget Rate','USD Budget Load')
and ClientName is not null
and [Year] in ('2015','2016')
and [Month] in (left(datename(month, dateadd(m,-3,getdate())), 3), left(datename(month, dateadd(m,-2,getdate())), 3),left(datename(month, dateadd(m,-1,getdate())), 3))

group by ClientName,metric_category,metric_name,[year],ClientName,Region




GO
/****** Object:  StoredProcedure [dbo].[F_FINANCE_DASHBOARD_BASE_UNIQUE_DATA]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F_FINANCE_DASHBOARD_BASE_UNIQUE_DATA]
(
@CLIENT_NAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL
)
as     
  
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END    
  
Select 
warroom.ClientName,
Region.Region,
warroom.[Actual week],
round(warroom.[Client Forecasted Calls Offered],0) as [Client Forecasted Calls Offered],
warroom.[Actual Weekly Contacts Offered],
round(warroom.[Actual SL],1) as [Actual SL],
round(warroom.[SLA],0) as [SLA],
round(warroom.[Forecasted AHT],0) as [Forecasted AHT],
round(warroom.[Actual Weekly AHT],0) as [Actual Weekly AHT],
round(warroom.[Forecasted Abandon Rate],1) as [Forecasted Abandon Rate],
round(warroom.[Actual Weekly Abandon Rate],1) as [Actual Weekly Abandon Rate],
round(warroom.[Attr],1) as Attrition,
round(warroom.[Actual Attrition Percentage],1) as [Actual Attrition Percentage],
warroom.[Actual Headcount],
warroom.[Final Heads Required]
FROM(
(select * from WAR_ROOMDATA)warroom
left join
(select * from Client_Mapping)client
on warroom.ESSBASEID = client.PRCode
left join
(select * from Location_Mapping)region
on warroom.LOCID = region.LOC_Code
)
where 1 = 1 AND
[Actual week]  between GETDATE()-91 and GETDATE() AND
(CONVERT(VARCHAR,WARROOM.Region) = @REGION  OR  @REGION = 'ALL')  AND
WARROOM.ClientName =  @CLIENT_NAME

GO
/****** Object:  StoredProcedure [dbo].[F_Monthly_Trend_Home]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_Monthly_Trend_Home]
(    
	@REGION VARCHAR(255)  = NULL      
 )   
as       
Begin
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''      
	BEGIN      
	 SET @REGION = 'ALL'      
	END      
	 truncate table 	 customize_monthly_trend 
	insert  into customize_monthly_trend
	 
	Select  lm.Region,[MONTH], [YEAR],  
	round(Sum(Act_Rev),0) as Revenue,    
	round(sum(Act_COS),0)  as COS,    
	round(sum(BHET),0)/round(sum(EHET),0) as BTP ,  
	mr.[rank]   
	from (
		Select Project_Code,location_code,[MONTH], [YEAR],    
		case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Act_Rev,    
		case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,    
		case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Billable Hours excluding training' then sum(Metric_Value) end as BHET,    
		case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Expense Hours excluding training' then sum(Metric_Value) end as EHET    
		    
		from financeraw2016    
		where YEAR IN ('2013','2014','2015','2016')    
		group by Metric_Category, Metric_Name,Project_Code,location_code,[MONTH], [YEAR]    
	)a    	Left Join    (
		Select distinct ClientName, PRCode 
		from Client_mapping
	)b    	on a.Project_Code = b.PRCode    
	left join (
		Select * 
		from Location_Mapping
	)LM   on  LM.LOC_Code =  a.Location_code   
	Left Join  (
		Select * 
		from monthsrank
	)MR  on a.[MONTH] = MR.[Months]   
	where  1=1
	and isnull(Region,'') not in('','CORP','GLOBAL') 
	and    (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')    
	group by LM.Region,[MONTH], [YEAR],MR.[rank]   
	order by LM.Region, A.[Year],MR.[rank] asc 
END
GO
/****** Object:  StoredProcedure [dbo].[F_Monthly_Trend_Home_procedure]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_Monthly_Trend_Home_procedure]
(
@REGION VARCHAR(255)  = NULL    
)
as     
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END    
(
Select * from customize_monthly_trend 
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
and revenue is not null
)
order by region, year, RANK
GO
/****** Object:  StoredProcedure [dbo].[F_Yearly_Trend_Home]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F_Yearly_Trend_Home]  
(  
@REGION VARCHAR(255)  = NULL    
 ) 
AS     
BEGIN 
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
	BEGIN    
	 SET @REGION = 'ALL'    
	END    
  
	SELECT  LM.REGION, [YEAR],
	ROUND(SUM(ACT_REV),0) AS REVENUE,  
	ROUND(SUM(ACT_REV),0)-ROUND(SUM(ACT_COS),0)  AS GM,  
	(ROUND(SUM(ACT_REV),0)-ROUND(SUM(ACT_COS),0))/ROUND(SUM(ACT_REV),0)  AS 'GM%',  
	ROUND(SUM(A_EBITDA),0) AS EBITDA,
	ROUND(SUM(A_EBITDA),0)/ROUND(SUM(ACT_REV),0) AS 'EBITDA%',
	ROUND(SUM(ACT_REV),0)/ROUND(SUM(EHET),0) AS RPEH

	FROM   
	(SELECT PROJECT_CODE,LOCATION_CODE, [YEAR],  
	CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'REVENUE' THEN (SUM(METRIC_VALUE)*-1) END AS ACT_REV,  
	CASE WHEN METRIC_CATEGORY =  'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS ACT_COS,  
	CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'EBITDA (INCOME)/LOSS' THEN SUM(METRIC_VALUE)*-1 END AS A_EBITDA,  
	CASE WHEN METRIC_CATEGORY =  'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'EXPENSE HOURS EXCLUDING TRAINING' THEN SUM(METRIC_VALUE) END AS EHET  
  
	FROM FINANCERAW2016  
	WHERE YEAR IN ('2013','2014','2015','2016')  
	GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE,LOCATION_CODE, [YEAR]  
	)A  
	LEFT JOIN  
	(SELECT DISTINCT CLIENTNAME, PRCODE FROM CLIENT_MAPPING)B  
	ON A.PROJECT_CODE = B.PRCODE  
	LEFT JOIN (SELECT * FROM LOCATION_MAPPING)LM 
	ON  LM.LOC_CODE =  A.LOCATION_CODE 
	WHERE  REGION IS NOT NULL AND REGION NOT IN('CORP','GLOBAL')
	AND  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
	GROUP BY LM.REGION,[YEAR]
	ORDER BY LM.REGION, A.[YEAR]
END
GO
/****** Object:  StoredProcedure [dbo].[F_YEARLY_TREND_HOME_PROCEDURE]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[F_YEARLY_TREND_HOME_PROCEDURE]
@REGION VARCHAR(255)  = NULL    
as     

IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
SET @REGION = 'ALL'    
END    

(
Select * from CUSTOM_F_YEARLY_TREND_HOME 
where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
and revenue is not null

)
order by region, year


GO
/****** Object:  StoredProcedure [dbo].[finance_bar_chart]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[finance_bar_chart]
as 
Select ClientName, [YEAR],[MONTH], metric_category,
       sum (Revenue) as Revenue,
       sum(Cost_of_service)as Total_Cost_of_Service,
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',
       SUM([Billable hours]) as Billable_Hours,
       sum([Expense Hours]) as Expense_Hours,
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%'

                    
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],
case when [Month] in ('Jan','Feb','Mar') then 'Q1'
     when [Month] in ('Apr','May','Jun') then 'Q2'
     when [Month] in ('Jul','Aug','Sep') then 'Q3'
     when [Month] in ('Oct','Nov','Dec') then 'Q4'
     else '' end as 'Quarter',

Country,Sub_Region,Region,
     
     SUM(Revenue) as Revenue, 
     sum([Cost of Services]) as Cost_of_service , 
    
                SUM([Billable Hours]) as [Billable hours],
                SUM([Expense Hours]) as [Expense Hours],
                                
                                
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training                            
 from 
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],
ClientName,
Country,
Sub_Region,Region,

case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],

case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]
from
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],
ClientName,
Country,Sub_Region,Region,
sum(Metric_Value) as Metric_Value
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code 
where 
Metric_Name in ('Total Cost of Services','Revenue','Expense Hours Excluding Training','Expense Hours',
'Billable Hours Excluding Training','Billable Hours')
--and [Year] in ('2014','2015')
and len (location_code) = 6
group by Location_Code,[Location_ Name]
,Metric_Category,Metric_Name,[Year],[Month],ClientName,
Country,Sub_Region,Region) aa) bb
where Metric_Category in ('USD Actual @ Budget Rate','USD Budget Load')
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn
where [YEAR] in ('2016','2015') and ClientName is not null

group by ClientName, [YEAR],[Month],metric_category
GO
/****** Object:  StoredProcedure [dbo].[finance_Data]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[finance_Data]
as 

select b.ClientName, lm.Region,
((sum(Act_Rev)*-1)-(sum(Optimal)*-1)) as Optimal , ((sum(Act_Rev)*-1)-(sum(Budget)*-1)) as Budget from 

(Select project_code,location_code,

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Optimal,

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Budget

from financeraw2016

where YEAR = datename(YEAR,GETDATE()) and 
Metric_Name = 'Revenue'
and [month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+31),3),left(datename(M,GETDATE()+63),3))

group by Metric_Category, Metric_Name,Project_Code,location_code)
a

Left Join

(Select * from Client_mapping)b

on a.Project_Code = b.PRCode

left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code

where ClientName is not null

and ClientName not in (Select distinct (Client_Name) from war_room) 
group by ClientName,lm.Region
GO
/****** Object:  StoredProcedure [dbo].[finance_Data_Region]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[finance_Data_Region]

@region varchar(255)

as
 (
select b.ClientName, lm.Region,
((sum(Act_Rev)*-1)-(sum(Optimal)*-1)) as Optimal , ((sum(Act_Rev)*-1)-(sum(Budget)*-1)) as Budget from 

(Select project_code,location_code,

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Optimal,

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Budget

from financeraw2016

where YEAR = datename(YEAR,GETDATE()) and 
Metric_Name = 'Revenue'
and [month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+31),3),left(datename(M,GETDATE()+63),3))

group by Metric_Category, Metric_Name,Project_Code,location_code)

a

Left Join

(Select * from Client_mapping)b

on a.Project_Code = b.PRCode

left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code

where ClientName is not null
and region = @region

and ClientName not in (Select distinct (Client_Name) from war_room) 
group by ClientName,lm.Region)






GO
/****** Object:  StoredProcedure [dbo].[Finance_Data_Region_Wise]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Finance_Data_Region_Wise]
@Region varchar(255)

as

select b.ClientName, lm.Region,
((sum(Act_Rev)*-1)-(sum(Optimal)*-1)) as Optimal , ((sum(Act_Rev)*-1)-(sum(Budget)*-1)) as Budget from 

(Select project_code,location_code,

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Optimal,

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then avg(Metric_Value) end as Budget

from financeraw2016

where YEAR = datename(YEAR,GETDATE()) and 
Metric_Name = 'Revenue'
and [month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+31),3),left(datename(M,GETDATE()+63),3))

group by Metric_Category, Metric_Name,Project_Code,location_code)

a

Left Join

(Select * from Client_mapping)b

on a.Project_Code = b.PRCode

left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code


where ClientName is not null and Region = @Region

and ClientName not in (Select distinct (Client_Name) from war_room) 

group by ClientName,lm.Region






GO
/****** Object:  StoredProcedure [dbo].[Finance_Date_Period]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Finance_Date_Period]

@YEAR as varchar(255),

@MONTH as varchar(255)

as
select * from (

select ClientName, sum(Optimal)*-1 as Optimal , sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit from 

(Select project_code,[Year],[Month],

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal,

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget

from financeraw2016

where Metric_Name = 'Revenue'

group by Metric_Category, Metric_Name,Project_Code,[Year],[Month])

a

Left Join

(Select * from Client_mapping)b

on a.Project_Code = b.PRCode

where ClientName is not null

and [Year] = @YEAR and

[Month] = @MONTH

group by ClientName
)x
where SurplusDeficit is not null
and 
Optimal is not null

order by SurplusDeficit
GO
/****** Object:  StoredProcedure [dbo].[Finance_Date_Periody]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Finance_Date_Periody]

@YEAR as varchar(255)

as
select * from (
select ClientName, sum(Optimal)*-1 as Optimal , sum(Budget)*-1 as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit from 

(Select project_code,[Year],[Month],

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,

case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal,

case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget

from financeraw2016

where Metric_Name = 'Revenue'

group by Metric_Category, Metric_Name,Project_Code,[Year],[Month])

a

Left Join

(Select * from Client_mapping)b

on a.Project_Code = b.PRCode

where ClientName is not null

and [Year] = @YEAR

group by ClientName
)y
where SurplusDeficit is not null
and 
Optimal is not null
order by SurplusDeficit
GO
/****** Object:  StoredProcedure [dbo].[Findata]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [AgentData_CWFM]
--GO
--/****** Object:  StoredProcedure [dbo].[Findata]    Script Date: 06/28/2016 22:17:46 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO


Create procedure [dbo].[Findata] as

Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],
case when [Month] in ('Jan','Feb','Mar') then 'Q1'
     when [Month] in ('Apr','May','Jun') then 'Q2'
     when [Month] in ('Jul','Aug','Sep') then 'Q3'
     when [Month] in ('Oct','Nov','Dec') then 'Q4'
     else '' end as 'Quarter',

Country,Sub_Region,Region,
     
     SUM(Revenue) as Revenue, 
     sum([Cost of Services]) as Cost_of_service , 
    
	SUM([Billable Hours]) as [Billable hours],
	SUM([Expense Hours]) as [Expense Hours],
		
		
	SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
	SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,
		
		
	
	SUM([INBOUND PENALTIES]) as Inbound_Penalties,
	
	Sum([OVERTIME]) as Overtime,
	SUM([REGULAR WAGES]) as 'Regular Wages',
	sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'	
	
	

from 
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],
ClientName,
Country,
Sub_Region,Region,

case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],

case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]


from
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],
ClientName,
Country,Sub_Region,Region,
sum(Metric_Value) as Metric_Value
from Financeraw2016 f left join Client_mapping cm on cm.PRCode collate SQL_Latin1_General_CP1_CI_AS = f.Project_Code collate SQL_Latin1_General_CP1_CI_AS
left join Location_Mapping lm on lm.LOC_Code collate SQL_Latin1_General_CP1_CI_AS= f.Location_Code collate SQL_Latin1_General_CP1_CI_AS
where 
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')
and [Year] in ('2015','2016')
and len (location_code) = 6
group by Location_Code,[Location_ Name]
,Metric_Category,Metric_Name,[Year],[Month],ClientName,
Country,Sub_Region,Region) aa) bb
where Metric_Category ='USD Actual @ Budget Rate'
and ClientName is not null
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null' 

--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'
--and Metric_Category
--='USD Actual @ Budget Rate'
----USD Actual
----USD Actual @ Budget Rate
----USD Budget Load
----USD Optimal Load
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region


GO
/****** Object:  StoredProcedure [dbo].[gAddress]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gAddress] --null,'prashant'
(
	@empId int = null,
	@xName varchar(255) = null
)
AS
BEGIN
	
	SELECT A.EMPLOYEE_ID, A.FIRST_NAME + ' ' + A.LAST_NAME AS NAME, 
	A.ADDRESS_LINE, B.DEPARTMENT, B.DESIGNATION
	FROM TEST_EMP_DETAILS A
	INNER JOIN TEST_EMP_SAL B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID
	where (case when @empId is null then a.Employee_ID else @empId end = a.Employee_ID
	or
	A.FIRST_NAME + ' ' + A.LAST_NAME like ('%'+@xName+'%')
	)
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Employee]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Employee]

      @Employee_Status nvarchar(255) = NULL

AS

BEGIN



      IF ISNULL(@Employee_Status, '') <> ''

      BEGIN

            SELECT Employee_Status

                  ,First_Name

                  ,Last_Name

            FROM WFM_Employee_List

            WHERE Employee_Status = @Employee_Status

      END

      ELSE

      BEGIN

            SELECT Employee_Status

                  ,First_Name

                  ,Last_Name

            FROM WFM_Employee_List

      END

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Employee_Detail]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Employee_Detail]

      @Employee_Status nvarchar(255) = NULL

AS

BEGIN



      IF ISNULL(@Employee_Status, '') <> ''

      BEGIN

            SELECT Employee_Status

                  ,First_Name

                  ,Last_Name

				  ,City

            FROM WFM_Employee_List

            WHERE Employee_Status = @Employee_Status

      END

      ELSE

      BEGIN

            SELECT Employee_Status

                  ,First_Name

                  ,Last_Name

				  ,City

            FROM WFM_Employee_List

      END

END
GO
/****** Object:  StoredProcedure [dbo].[Get_Employees]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Employees]

      @Employee_Status nvarchar(255) = NULL

AS

BEGIN



      IF ISNULL(@Employee_Status, '') <> ''

      BEGIN

            SELECT Employee_Status

                  ,First_Name

                  ,Last_Name

            FROM WFM_Employee_List

            WHERE Employee_Status = @Employee_Status

      END

      ELSE

      BEGIN

            SELECT Employee_Status

                  ,First_Name

                  ,Last_Name

            FROM WFM_Employees_List

      END

END

GO
/****** Object:  StoredProcedure [dbo].[get_Staffing_Week_Dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[get_Staffing_Week_Dotnet] 
(	
	@xCurrent_Week varchar(max)
)
as
begin 
	
	Select convert(varchar, DATEADD(dd, -(DATEPART(dw, @xCurrent_Week)-1), @xCurrent_Week),106) [CURWeekStart],
	convert(varchar, dateadd(wk,-6, DATEADD(dd, -(DATEPART(dw, @xCurrent_Week)-1), @xCurrent_Week)),106) [WeekStart],
	convert(varchar, DATEADD(dd, 8-(DATEPART(dw, @xCurrent_Week)), @xCurrent_Week),106) [WeekEnd]
end



GO
/****** Object:  StoredProcedure [dbo].[getAddress]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAddress]
AS
SELECT * FROM Test_Emp_Details

GO
/****** Object:  StoredProcedure [dbo].[getAllDaysBetweenTwoDate]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[getAllDaysBetweenTwoDate]
(
@FromDate DATETIME,    
@ToDate DATETIME
)
AS
BEGIN
    
    DECLARE @TOTALCount INT
    SET @FromDate = DATEADD(DAY,-1,@FromDate)
    Select  @TOTALCount= DATEDIFF(DD,@FromDate,@ToDate);

    WITH d AS 
            (
              SELECT top (@TOTALCount) AllDays = DATEADD(DAY, ROW_NUMBER() 
                OVER (ORDER BY object_id), REPLACE(@FromDate,'-',''))
              FROM sys.all_objects
            )
        SELECT AllDays From d
        
    RETURN 
END

GO
/****** Object:  StoredProcedure [dbo].[GetEmployees]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployees]

      @Employee_Status nvarchar(255) = NULL

AS

BEGIN



      IF ISNULL(@Employee_Status, '') <> ''

      BEGIN

            SELECT Employee_Status

                  ,FirstName

                  ,LastName

            FROM WFM_Employees_List

            WHERE Employee_Status = @Employee_Status

      END

      ELSE

      BEGIN

            SELECT Employee_Status

                  ,FirstName

                  ,LastName

            FROM WFM_Employees_List

      END

END
GO
/****** Object:  StoredProcedure [dbo].[getName]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getName]
@lastName nvarchar(20),
@firstName nvarchar(20)
as
set nocount on;
select First_Name, Last_Name from Test_Emp_Details
where First_Name=@firstName and Last_Name=@lastName
and City = 'chennai'

GO
/****** Object:  StoredProcedure [dbo].[getUserDetails]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getUserDetails] -- exec getUserDetails '51026'
(
	@UserID nvarchar(50)=null
)

AS
BEGIN

	SELECT Employee.FirstName,Employee.LastName,
	UserTable.[Job Classification Job Level] as JobLevel,
	UserTable.Password,UserTable.UserId,UserTable.sAccessarea,
	UserTable.Accessarea,Employee.dpImage,
	UserTable.BusinessUnitCode 
	from xSPT.Employee Employee 
	inner join xSPT.UserTable UserTable 
	on Employee.EmployeeID=UserTable.EmployeeID

	WHERE UserTable.UserId=@UserID

End

GO
/****** Object:  StoredProcedure [dbo].[GetUserRights]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetUserRights]
As
Begin

Select * from xSPT.UserRights
End

GO
/****** Object:  StoredProcedure [dbo].[GLIDEPATH_HIGHCHART]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GLIDEPATH_HIGHCHART]
(
	@WARROOMID AS INT,
	@Metric_ID AS int,
	@MONTH AS Datetime
)
AS

BEGIN
	DECLARE @StartDate SMALLDATETIME
	DECLARE @ENDDate SMALLDATETIME

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE2'))
	BEGIN
		DROP TABLE #TEMPTABLE2
	END
	
	
	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLE'))
	BEGIN
		DROP TABLE TEMPTABLE
	END

	SELECT DISTINCT X_TYPE [ACTUAL_WEEK]  INTO #TEMPTABLE
	FROM (
		SELECT REPLACE(CONVERT(VARCHAR,MONTHS,106),' ','-') AS MONTHS,
		X_TYPE,X_VALUE
		FROM   TBL_WR_GLIDEPATH TWG
		INNER JOIN WAR_ROOM WR ON WR.WAR_ROOM_ID=TWG.WARROOM_ACC_ID
		WHERE  WARROOM_ACC_ID=@WARROOMID AND METRIC_ID<>0 AND METRIC_ID=@METRIC_ID
		AND MONTHS BETWEEN 
		CASE WHEN  CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) <= LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' THEN CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) ELSE LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' END 
		AND CONVERT(DATE,DATEADD(MONTH, 6, @MONTH))
		AND X_TYPE NOT IN ('GLIDEPATH','GLIDEPATH IMPROVEMENT')
		UNION
		SELECT REPLACE(CONVERT(VARCHAR,MONTHS,106),' ','-') AS MONTHS,
		X_TYPE +'_'+REPLACE(CONVERT(VARCHAR,UPDATION_DATE,106),' ','-'),X_VALUE 
		FROM TBL_WR_GLIDEPATH_HISTORY TWG
		INNER JOIN WAR_ROOM WR ON WR.WAR_ROOM_ID=TWG.WARROOM_ACC_ID
		WHERE  WARROOM_ACC_ID=@WARROOMID AND METRIC_ID<>0 AND METRIC_ID=@METRIC_ID
		AND MONTHS BETWEEN 
		CASE WHEN  CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) <= LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' THEN CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) ELSE LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' END 
		AND CONVERT(DATE,DATEADD(MONTH, 6, @MONTH))
		AND X_TYPE NOT IN ('GLIDEPATH IMPROVEMENT')
	) TMP
	
	If (@@ROWCOUNT = 0)
	BEGIN
		SELECT 'No Record(s) Found' [MONTHS] into TEMPTABLE
	END
	ELSE
	BEGIN
		SELECT * INTO #TEMPTABLE2
		FROM (
			SELECT MONTHS AS MONTHS,
			X_TYPE,X_VALUE
			FROM   TBL_WR_GLIDEPATH TWG
			INNER JOIN WAR_ROOM WR ON WR.WAR_ROOM_ID=TWG.WARROOM_ACC_ID
			WHERE  WARROOM_ACC_ID=@WARROOMID AND METRIC_ID<>0 AND METRIC_ID=@METRIC_ID
			AND MONTHS BETWEEN 
			CASE WHEN  CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) <= LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' THEN CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) ELSE LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' END 
			AND CONVERT(DATE,DATEADD(MONTH, 6, @MONTH))
			AND X_TYPE NOT IN ('GLIDEPATH','GLIDEPATH IMPROVEMENT')
			UNION
			SELECT MONTHS AS MONTHS,
			X_TYPE +'_'+REPLACE(CONVERT(VARCHAR,UPDATION_DATE,106),' ','-'),X_VALUE 
			FROM TBL_WR_GLIDEPATH_HISTORY TWG
			INNER JOIN WAR_ROOM WR ON WR.WAR_ROOM_ID=TWG.WARROOM_ACC_ID
			WHERE  WARROOM_ACC_ID=@WARROOMID AND METRIC_ID<>0 AND METRIC_ID=@METRIC_ID
			AND MONTHS BETWEEN 
			CASE WHEN  CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) <= LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' THEN CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)) ELSE LEFT(CONVERT(VARCHAR,[START_DATE],112),6)+'01' END 
			AND CONVERT(DATE,DATEADD(MONTH, 6, @MONTH))
			AND X_TYPE NOT IN ('GLIDEPATH IMPROVEMENT')
		) TMP

		DECLARE @WeekDate AS VARCHAR(MAX)=''
		DECLARE @xSQL AS VARCHAR(MAX)=''

		
		--SELECT * FROM #TEMPTABLE
		update #TEMPTABLE SET [ACTUAL_WEEK] = REPLACE([ACTUAL_WEEK],'/','_')

		SELECT @WeekDate = '[' + TP.[ACTUAL_WEEK] + '],' + @WeekDate
		FROM #TEMPTABLE TP

		IF LEFT(@WeekDate,1) = ','
		BEGIN
			SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
		END

		IF RIGHT(@WeekDate,1) = ','
		BEGIN
			SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
		END

		--select @WeekDate
	
		update #TEMPTABLE2 set X_VALUE = CASE WHEN X_VALUE = 0 THEN NULL ELSE X_VALUE END
		,X_TYPE = REPLACE(X_TYPE,'/','_')

		SET @xSQL = 'SELECT * INTO TEMPTABLE
			FROM (
				SELECT MONTHS,X_TYPE,X_VALUE
				FROM #TEMPTABLE2
			) AS S
			PIVOT
			(
				max([X_VALUE])
				FOR [X_TYPE] IN ('+ @WEEKDATE +')
			)AS PVT '
		--print @xSQL
		EXEC(@xSQL)
	
		--SELECT * FROM #TEMPTABLE2;
	END
	SELECT * FROM TEMPTABLE ORDER BY 1;
	DROP TABLE TEMPTABLE;
END
GO
/****** Object:  StoredProcedure [dbo].[Glidepath_RCA_Dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Glidepath_RCA_Dotnet] 
(
	@WarRooID AS INT,
	@Matric AS VARCHAR(MAX)
)
AS
BEGIN
	
	DECLARE @xSQL AS VARCHAR(MAX)=''

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLE'))
	BEGIN
	   DROP TABLE XTEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'XTEMPTABLE'))
	BEGIN
	   DROP TABLE XTEMPTABLE
	END

	SELECT [METRICS]
			,CONVERT(VARCHAR,CONVERT(SMALLDATETIME,LEFT(CONVERT(VARCHAR,[MONTHS],112),6) + '01'),106) [MONTHS]
			,[Budget_vs_Target] 
			INTO XTEMPTABLE
			FROM KPI_TARGET WR
			WHERE [SR_NO] = CONVERT(VARCHAR,@WarRooID)
			--AND isnull([METRICS],'') = ''+ @Matric +''
			order by CONVERT(SMALLDATETIME,LEFT(CONVERT(VARCHAR,[MONTHS],112),6) + '01'),
			[METRICS]

				
	SET @xSQL = 'SELECT * INTO TEMPTABLE
		FROM (
			SELECT [METRICS]
			,[MONTHS]
			,[Budget_vs_Target]
			FROM XTEMPTABLE WR 
		) as s
		PIVOT
		(
			SUM([Budget_vs_Target])
		)AS PVT '
	print @xSQL
	--EXEC(@xSQL)
	
	SELECT * FROM TEMPTABLE
	DROP TABLE TEMPTABLE

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'XTEMPTABLE'))
	BEGIN
	   DROP TABLE XTEMPTABLE
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GM_Glidepath_Chart]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GM_Glidepath_Chart]
@War_Room_ID Int
as

Select * from GM_Glidepath where War_room_id = @War_Room_ID



GO
/****** Object:  StoredProcedure [dbo].[GM_Metric_Dynamics]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GM_Metric_Dynamics]

@WR_ID Varchar,
@U_Date date,
@OverallFlag int=0

AS
BEGIN
 
 ------------------------- If Any Error Then Send @OverallFlag=0 by default from code

 IF @OverallFlag=1
    Begin
        SELECT   WRM.Metric_Name as 'Metric Name',convert(varchar,Months,106) as Month,
				 max(case when x_Type = 'Budget/Target' then x_Value end) as 'Budget/Target',
				 max(case when x_Type = 'Forecasted' then x_Value end)as 'Forecasted',
				 max(case when x_Type = 'Actual/Tracker' then x_Value end) as 'Actual/Tracker',
				 max(case when x_Type = 'Glidepath' then x_Value end) as 'Glidepath',
				 max(case when x_Type = 'Glidepath Improvement' then x_Value end) as 'Glidepath Improvement'
        FROM     tbl_WR_Glidepath WRG LEFT JOIN tbl_WR_Metric WRM on WRG.Metric_ID = WRM.Metric_ID
        WHERE    Warroom_acc_ID = @WR_ID AND Updation_date = @U_Date AND ISNULL(WRM.Metric_ID,0)=0
        GROUP BY WRM.Metric_Name, convert(varchar,Months,106),Months
		ORDER BY WRM.Metric_Name, Months
    End

 Else

    Begin
	    SELECT   WRM.Metric_Name as 'Metric Name',convert(varchar,Months,106) as Month,
				 max(case when x_Type = 'Budget/Target' then x_Value end) as 'Budget/Target',
				 max(case when x_Type = 'Forecasted' then x_Value end)as 'Forecasted',
				 max(case when x_Type = 'Actual/Tracker' then x_Value end) as 'Actual/Tracker',
				 max(case when x_Type = 'Glidepath' then x_Value end) as 'Glidepath',
				 max(case when x_Type = 'Glidepath Improvement' then x_Value end) as 'Glidepath Improvement'
        FROM     tbl_WR_Glidepath WRG LEFT JOIN tbl_WR_Metric WRM on WRG.Metric_ID = WRM.Metric_ID
        WHERE    Warroom_acc_ID = @WR_ID AND Updation_date = @U_Date AND ISNULL(WRM.Metric_ID,0)<>0
        GROUP BY WRM.Metric_Name, convert(varchar,Months,106) ,Months
		ORDER BY WRM.Metric_Name, Months
	End 

END
 









 

GO
/****** Object:  StoredProcedure [dbo].[gName]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE PROCEDURE gAddress
--AS
--SELECT * FROM Test_Emp_Details
--GO

--EXEC getAddress
--EXEC gAddress
--gAddress

create procedure [dbo].[gName]
@lastName nvarchar(20),
@firstName nvarchar(20)
as
set nocount on;
select First_Name, Last_Name, Address_Line, Contact_Number from Test_Emp_Details
where First_Name=@firstName and Last_Name=@lastName
and City = 'chennai'

GO
/****** Object:  StoredProcedure [dbo].[Hiring_Plan_Reports]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Hiring_Plan_Reports]

@Projectname varchar(max)

as

(

Select @Projectname as LOB,
[Week of],round([Client Forecasted Calls Offered],0),[Forecasted Calls Offered After Allowance],[Actual Weekly Contacts Offered],[Variance Forecasted Calls Offered to Actual Weekly Contacts Offe],
[Actual SL],round([Forecasted AHT],0),round([Actual Weekly AHT],0),[Forecasted Occu# @ 100 % of Forecast],[Forecasted Occu After Allowance Over Forecast],[Forecasted Abandon Rate],[Actual Weekly Abandon Rate],[Planned Vac],[Planned Abs],[Planned Coaching Est],[Planned Adherence],[Planned Other],[Planned Attr],[Actual Vac#],[Actual Abs#],[Actual Coaching Est##],[Actual Adherence],[Actual Other],[Actual Attr#],[Average Weekly Scheduled Production Hours Per Week],[Heads Required Based on 100 % of Forecast Calls Offered],[Heads Required Based on Average Weekly Scheduled Hours],[FTE's Required],[Probable Root Causes (Forecasting)],[Actual Attrition Percentage],[Actual or Forecasted Heads],[Proficiency of Part Time Equivalency to Full Time],[Proficiency for OCP 1],[Proficiency for OCP 2],[Proficiency for OCP 3],[Actual or Forecasted Head with Proficients Applied to Agents in ],[Forecasted Agents to be in OCP],[Variance in Headcount Requirements at 100 % of Forecast],[Variance Between Headcount Requirements],[Call Capacity Based on Actual FTE's and Service Requirements],[Forecasted Service Level Based on Actual FTE's],[Forecasted ASA Based on Actual FTE's],[Forecasted Weekly Scheduled Hours],[Forecasted Weekly Productive Hours],[Actual Full Time Agents],[Actual Part Time Agents],[SLA],[ASA],[New Hiring],[Probable Root Causes (Staffing)],[Max Abandon Rate],[Actual Attrition],[Total Hours Required 100% of Forecast (B40)],[RCA1],[RCA2],[RCA3]
 
 from Hiring_plan_base_table where code = '0022'
 and [Week of] between dateadd(WEEK, datediff(WEEK, 0, GETDATE()), -90)   AND dateadd(WEEK, datediff(WEEK, 0, getdate()), 90)
 )


GO
/****** Object:  StoredProcedure [dbo].[Hiring_Reports]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Hiring_Reports]
@Projectname varchar(max)
as
(
Select * from Hiring_plan_base_table where code = @Projectname)
GO
/****** Object:  StoredProcedure [dbo].[Insert_Old_GM_Glidepth]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE [dbo].[Insert_Old_GM_Glidepth]
(
  
  @xWR_ID Int,
  @Warroom_acc_Name Varchar(255),
  @Metric Varchar(255),
  @x_Month Date,
  @xBudget float,
  @xForecast float,
  @Act_Vs_Trac float,
  @GM_Glide float
  
  
)
AS

BEGIN
  --This means the record isn't in there already, let's go ahead and add it
    INSERT into GM_Glidepath(Client_Name,
	Metrics,
	[Months],
	Budget_vs_Target,
	Forecasted_GM,
	Actual_vs_Tracker,
	Glidepath_GM,
	War_Room_ID)
	VALUES(@Warroom_acc_Name,@Metric,
	@x_Month,
	@xBudget,
	@xForecast,
	@Act_Vs_Trac,
	@GM_Glide,
	@xWR_ID
	)
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_Old_Ops_Glidepth]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Old_Ops_Glidepth]
(
  
  @xWR_ID Int,
  @Warroom_acc_Name Varchar(255),
  @Metric Varchar(255),
  @x_Month Date,
  @xBudget float,
  @xForecast float,
  @Act_Vs_Trac float,
  @GM_Glide float,
  @Gl_Improv float,
  @Updation_date date,
  @Region Varchar(255)
  
  

  
)
AS

BEGIN
  --This means the record isn't in there already, let's go ahead and add it
    INSERT into KPI_Target(SR_No,Client_Name,
	Metrics,
	[Months],
	Budget_vs_Target,
	Forecasted,
	Actual_vs_Tracker,
	AHT_Glidepath,
	Glidepath_Improvement,
	Updation_Date,
	Region
	)
	VALUES(
  
  @xWR_ID, @Warroom_acc_Name,@Metric,@x_Month, @xBudget, @xForecast,@Act_Vs_Trac,@GM_Glide,
  @Gl_Improv,
  @Updation_date,
  @Region)

END



GO
/****** Object:  StoredProcedure [dbo].[Insert_Water_fall]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Insert_Water_fall]
(
  
  @xWR_ID Int,
  @Warroom_acc_Name Varchar(255),
  @xMetric_ID int,
  @xType Varchar(255),
  @xValue float,
  @x_Date Date,
  @xUser varchar(255),
  @batch_ID varchar(255)
  
  
)
AS
IF EXISTS(SELECT 'true' FROM tbl_WR_Waterfall WHERE Metric_ID = @xMetric_ID and updation_Date =@x_Date and Warroom_acc_ID =@xWR_ID and xType = @xType)
BEGIN
  
  delete from tbl_WR_Waterfall Where Warroom_acc_ID = @xWR_ID and Metric_ID =@xMetric_ID and Updation_date= @x_Date and xType = @xType
 END

BEGIN
  --This means the record isn't in there already, let's go ahead and add it
    INSERT into tbl_WR_Waterfall(Warroom_acc_ID,
	Warroom_acc_Name,
	Metric_ID,
	xType,
	xValue,
	Updation_date,
	Updated_By
	,batch_ID) VALUES(@xWR_ID,
	@Warroom_acc_Name, 
	@xMetric_ID,
	@xType,
	@xValue,
	@x_Date,
	@xUser,
	@batch_ID
	)
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_WR_Glidepath]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_WR_Glidepath]
(
  @xWR_ID Int,
  @x_Month date,
  @xMetric_ID int,
  @xType Varchar(255),
  @xValue float,
  @x_Date Datetime,
  @xUser varchar(255),
  @batch_ID varchar(255)  
)
AS
BEGIN
	delete from tbl_WR_Glidepath Where Warroom_acc_ID = @xWR_ID and Metric_ID =@xMetric_ID and Updation_date= @x_Date and x_Type = @xType and Months = @x_Month ;
	
	  --This means the record isn't in there already, let's go ahead and add it
		INSERT into tbl_WR_Glidepath(Warroom_acc_ID,
		Months,
		Metric_ID,
		x_Type,
		x_Value,
		Updation_date,
		Updated_By
		,batch_ID)
		VALUES(@xWR_ID,
		@x_Month,
	  @xMetric_ID,
	  @xType,
	  @xValue,
	  @x_Date,
	  @xUser,
	  @batch_ID  
		)
END
GO
/****** Object:  StoredProcedure [dbo].[INTERNALDATABASE_VS_LAWSON]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INTERNALDATABASE_VS_LAWSON]
AS
select 
isnull(Employee_ID,0) as Employee_ID,
isnull(First_Name,0) +' '+ isnull(Last_Name,0) as Full_Name,
isnull(Date_of_Joining,'19000101') as Date_of_Joining,
isnull(Department,0)as Department,
isnull(Sub_Department,0) as Sub_Department,
isnull(Designation,0) as Designation,
isnull(Supervisor_ECN,0) as Supervisor_ECN,
isnull([Site],0) as [Site],
isnull(City,0) as City,
isnull(Country,0) as Country
from WFM_Employee_List
where convert(nvarchar,Employee_ID) not in (
Select Employee_ID from WFM_Employee_List
where cast(Employee_ID as nvarchar) in (Select cast(EMPLOYEE as nvarchar) from WFM_Resource_List))

GO
/****** Object:  StoredProcedure [dbo].[LAWSON_VS_INTERNALDATABASE]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LAWSON_VS_INTERNALDATABASE]
AS
select 
isnull(EMPLOYEE,'-')as EMPLOYEE,
isnull(FULL_NAME,'-') as FULL_NAME,
isnull(convert(date,HIRE_DATE,112),'19000101') AS DOJ,
isnull(DEPARTMENT_NAME,'-') as DEPARTMENT_NAME,
isnull(JOB_CODE_DESCRIPTION,0)as JOB_CODE_DESCRIPTION,
isnull(Company1,'-') as Company1,
isnull([REGION 1],'-') as REGION,
isnull(COST_CENTER,'-')as COST_CENTER,
isnull(EMP_STATUS,'-') as EMP_STATUS
from WFM_resource_list
where convert(nvarchar,EMPLOYEE) not in (select convert(nvarchar,Employee_ID) from WFM_Employee_List)

GO
/****** Object:  StoredProcedure [dbo].[LEAVE_BALANCE_HEADINGS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LEAVE_BALANCE_HEADINGS]
AS
select 
case when COLUMN_NAME = 'Compensatory' then 'Comp Off'
when COLUMN_NAME =  'Current Leave' then 'Current Leave'
when COLUMN_NAME =  'Previous Leave' then 'Previous Leave'
when COLUMN_NAME =  'Current Balance' then 'Total Leave Balance'
end as COLUMN_NAME 
from (
SELECT COLUMN_NAME FROM CWFM_Umang.INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = N'Leave_Balance'and 
COLUMN_NAME in ('Compensatory','Current Leave','Previous Leave','Current Balance'))tbl

GO
/****** Object:  StoredProcedure [dbo].[Leave_Balance_summary]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Balance_summary]    
@DESIGNATION AS VARCHAR(255)    
as    
select     
sup_dept, Emp_ID, Emp_name,[Start_Date], End_Date, Leave_Status,    
isnull(Compensatory,0),isnull([Current Leave],0),isnull([Previous Leave],0),isnull(FLOATING_BALANCE,0)    
from     
(select Title,sup_dept,     
Emp_ID,    
Emp_name,    
[Start_Date],    
End_Date,    
Leave_Status     
from User_Leave_Request     
where Title = @DESIGNATION     
and datepart(m,Start_Date) = datepart(M,GETDATE()))tbla    
Left Join    
(Select * from leave_balance)tblb    
on tbla.Emp_ID = tblb.ECN 
GO
/****** Object:  StoredProcedure [dbo].[Leave_Control]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Control]

@Emp_ID AS NVARCHAR(250)
AS

Select [Mon-YYYY],Emp_ID,
case when (0.25-SUM(value))>0 then (0.25-SUM(value)) else 0 end as Value from
(
Select *,
case when Leave_Segment='Unplanned' then (0.25*0.5) else
case when ([Start_Date]-Request_Date)>=30 then 0 else 
case when ([Start_Date]-Request_Date)>=15 then (0.25*0.1) else 
case when ([Start_Date]-Request_Date)>=5 then (0.25*0.2) else 
case when ([Start_Date]-Request_Date)<5 then (0.25*0.3) else 0 end end end end end as 'Value'
from
(
Select  REPLACE(RIGHT(CONVERT(VARCHAR(11), [Start_date], 106), 8), ' ', '-') AS [Mon-YYYY],Emp_ID,Emp_name,Supervisor,Dept,Title,Leave_Type,Request_No,Request_Date,
[Start_Date],[End_Date],WeekOff,No_of_Days,Leave_Status,[Description],Supevisor_Comment, Leave_Segment from User_Leave_Request
)a 
where 
[Mon-YYYY] = 'Jan-2016'
and Emp_ID= @Emp_ID
and Leave_Status='Approved'
)b group by [Mon-YYYY],Emp_ID       


GO
/****** Object:  StoredProcedure [dbo].[Leave_Count]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Leave_Count]
@emp_ID as varchar(255)
as
select left(Datename(m,[Start_date]),3)+ ' ' + (Datename(YEAR,[Start_date])) as Month, sum(no_of_Days) from User_Leave_Request where Emp_ID = @emp_ID group by left(Datename(m,[Start_date]),3)+ ' ' + (Datename(YEAR,[Start_date]))
GO
/****** Object:  StoredProcedure [dbo].[Leave_emp_name]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_emp_name]  
  
@STARTDATE AS DATETIME,  
@ENDDATE AS DATETIME,  
@SUP_ECN NVARCHAR(250)      
  
AS  
  
select distinct Emp_name  
from User_Leave_Request  
where [Start_Date] between @STARTDATE and @ENDDATE   
and Supervison_ECN = @SUP_ECN 
GO
/****** Object:  StoredProcedure [dbo].[Leave_emp_name_AM]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_emp_name_AM]
  
@STARTDATE AS DATETIME,  
@ENDDATE AS DATETIME,  
@SUP_ECN NVARCHAR(250)      
  
AS  
  
select Emp_name  
from User_Leave_Request  
where [Start_Date] between @STARTDATE and @ENDDATE   
and Supervison_ECN = @SUP_ECN AND   
Title = 'Manager 1'

GO
/****** Object:  StoredProcedure [dbo].[Leave_Range]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range]      
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select Emp_ID, Emp_name, Title, Request_Date,[Start_Date],End_Date,No_of_Days,Leave_Status,Leave_Type,
FLOATING_BALANCE
from User_Leave_Request AS A   
LEFT JOIN  
Leave_Balance AS B  
on A.Emp_ID = b.ECN     
where [Start_Date] between @STARTDATE and @ENDDATE       
and Supervison_ECN = @SUP_ECN        
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_AM]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_AM]  
  
@STARTDATE AS DATETIME,  
@ENDDATE AS DATETIME,  
@SUP_ECN NVARCHAR(250)      
  
AS  
  
select Emp_ID, Emp_name, Title, Request_Date,[Start_Date],End_Date,No_of_Days,Leave_Status ,Leave_Type 
from User_Leave_Request  
where [Start_Date] between @STARTDATE and @ENDDATE   
and Supervison_ECN = @SUP_ECN  AND   
Title = 'Manager 1'
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_AM_name]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_AM_name] 
  
@STARTDATE AS DATETIME,  
@ENDDATE AS DATETIME,  
@SUP_ECN NVARCHAR(250)      
  
AS  
  
select Emp_name
from User_Leave_Request  
where [Start_Date] between @STARTDATE and @ENDDATE   
and Supervison_ECN = @SUP_ECN  AND   
Title = 'Manager 1'
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_Director]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_Director]    
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select Emp_ID, Emp_name, Title, Request_Date,[Start_Date],End_Date,No_of_Days,Leave_Status ,Leave_Type,
FLOATING_BALANCE
from User_Leave_Request AS A   
LEFT JOIN  
Leave_Balance AS B  
on A.Emp_ID = b.ECN     
where [Start_Date] between @STARTDATE and @ENDDATE       
and Supervison_ECN = @SUP_ECN  AND       
--Title in ('Manager 1','Manager 2','Senior Manager')    
Title in ('Manager 2','Senior Manager') 
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_Director_Name]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_Director_Name]  
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select distinct Emp_name    
from User_Leave_Request      
where [Start_Date] between @STARTDATE and @ENDDATE     
and Supervison_ECN = @SUP_ECN  AND     
--Title in ('Manager 1','Manager 2','Senior Manager')  
Title in ('Manager 2','Senior Manager')  
  
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_Manager_2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_Manager_2]     
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select Emp_ID, Emp_name, Title, Request_Date,[Start_Date],End_Date,No_of_Days,Leave_Status ,Leave_Type,
FLOATING_BALANCE
from User_Leave_Request AS A   
LEFT JOIN  
Leave_Balance AS B  
on A.Emp_ID = b.ECN  
where [Start_Date] between @STARTDATE and @ENDDATE       
and Supervison_ECN = @SUP_ECN  AND       
Title = 'Manager 1'
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_Manager_2_name]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_Manager_2_name]  
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select distinct Emp_name    
from User_Leave_Request      
where [Start_Date] between @STARTDATE and @ENDDATE     
and Supervison_ECN = @SUP_ECN  AND     
Title = 'Manager 1'
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_Sr_Manager]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_Sr_Manager]    
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select Emp_ID, Emp_name, Title, Request_Date,[Start_Date],End_Date,No_of_Days,Leave_Status ,Leave_Type,
FLOATING_BALANCE
from User_Leave_Request AS A   
LEFT JOIN  
Leave_Balance AS B  
on A.Emp_ID = b.ECN  
where [Start_Date] between @STARTDATE and @ENDDATE       
and Supervison_ECN = @SUP_ECN  AND       
Title in ('Manager 1','Manager 2')  
GO
/****** Object:  StoredProcedure [dbo].[Leave_Range_Sr_Manager_name]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Range_Sr_Manager_name]  
      
@STARTDATE AS DATETIME,      
@ENDDATE AS DATETIME,      
@SUP_ECN NVARCHAR(250)          
      
AS      
      
select DISTINCT Emp_name    
from User_Leave_Request      
where [Start_Date] between @STARTDATE and @ENDDATE     
and Supervison_ECN = @SUP_ECN  AND     
Title in ('Manager 1','Manager 2')
GO
/****** Object:  StoredProcedure [dbo].[leave_status]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[leave_status]  
@EMPID NVARCHAR(250)  
AS  
Select  
isnull(Request_No,0) as [Request No],  
isnull(Request_Date,'19000101') as [Request Date],  
isnull(Emp_name,'') as [Name],  
isnull(Leave_Type,'') as [Leave Type],  
isnull([Start_Date],'19000101') as [Start_Date],  
isnull([End_Date],'19000101') as [End_Date],  
isnull(No_of_Days,0) as [Days],  
isnull(Leave_Status,'') as [Status],  
isnull(Supevisor_Comment,'') as [Mgr Comments]from user_leave_Request  
where   
Emp_ID = @EMPID

GO
/****** Object:  StoredProcedure [dbo].[Leave_Summary]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Summary]
as 
Select 
leave.sup_dept as Department,
isnull(emp_data.No_of_Employees,0) as [No Of Employees],
isnull(Leave.Applied_Leave,0)  as [Employees on Leaves],
cast(isnull(Leave.Applied_Leave,0) as float)/cast(isnull(emp_data.No_of_Employees,0) as float) as [% of Employees on Leaves],
isnull(leave.Pending_Leave,0) as [Leave Pending],
isnull(Leave.Approved_Leave,0) as [Leave Approved]
from
(select sup_dept, SUM(Applied_Leave) as Applied_Leave,
SUM(Pending_Leave) as Pending_Leave,  
SUM(Approved_Leave)as Approved_Leave,
SUM(Rejected_Leave) as Rejeceted_Leave
from (
Select sup_dept, COUNT(*) AS Applied_Leave,
case when Leave_Status = 'Pending' then COUNT(Emp_ID) end as Pending_Leave,
case when Leave_Status = 'Approved' then COUNT(Emp_ID) end as Approved_Leave,
case when Leave_Status = 'Rejected' then COUNT(Emp_ID) end as Rejected_Leave 
from User_Leave_Request
where datepart(m,Start_Date) = datepart(M,GETDATE())
group by sup_dept, Leave_Status, Emp_ID
)leave_summary
group by sup_dept)
Leave
Left Join
(select Sub_Department, COUNT(*) as No_of_Employees from WFM_Employee_List
group by Sub_Department)emp_data
on Leave.sup_dept = emp_data.Sub_Department

GO
/****** Object:  StoredProcedure [dbo].[Leave_Summary_designation]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Summary_designation]
as   
Select
emp_data.Designation as Designation,  
emp_data.No_of_Employees as [No Of Employees],
isnull(Leave.Applied_Leave,0)  as [Employees on Leaves],  
cast(isnull(Leave.Applied_Leave,0) as float)/cast(isnull(emp_data.No_of_Employees,0) as float) as [% of Employees on Leaves],
isnull(leave.Pending_Leave,0) as [Leave Pending],  
isnull(Leave.Approved_Leave,0) as [Leave Approved]  
from  
(select Designation,COUNT(*) as No_of_Employees from WFM_Employee_List
where Designation in ('Manager 1','Manager 2','Senior Manager','Lead Scheduler')
group by Designation)emp_data  
Left Join
(select Title, SUM(Applied_Leave) as Applied_Leave,  
SUM(Pending_Leave) as Pending_Leave,    
SUM(Approved_Leave)as Approved_Leave,  
SUM(Rejected_Leave) as Rejeceted_Leave  
from (  
Select Title, COUNT(*) AS Applied_Leave,  
case when Leave_Status = 'Pending' then COUNT(Emp_ID) end as Pending_Leave,  
case when Leave_Status = 'Approved' then COUNT(Emp_ID) end as Approved_Leave,  
case when Leave_Status = 'Rejected' then COUNT(Emp_ID) end as Rejected_Leave   
from User_Leave_Request  
where datepart(m,Start_Date) = datepart(M,GETDATE())
group by Title, Leave_Status, Emp_ID  
)leave_summary  
group by Title)Leave  
on Leave.Title = emp_data.Designation



GO
/****** Object:  StoredProcedure [dbo].[Leave_Summary_designation_Executive]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Summary_designation_Executive]
as   
Select
emp_data.Designation as Designation,  
emp_data.No_of_Employees as [No Of Employees],
isnull(Leave.Applied_Leave,0)  as [Employees on Leaves],  
cast(isnull(Leave.Applied_Leave,0) as float)/cast(isnull(emp_data.No_of_Employees,0) as float) as [% of Employees on Leaves],
isnull(leave.Pending_Leave,0) as [Leave Pending],  
isnull(Leave.Approved_Leave,0) as [Leave Approved]  
from  
(select Designation,COUNT(*) as No_of_Employees from WFM_Employee_List
where Designation in ('Senior Analyst','Analyst','RTA Coor','Workforce Coorindator Sr','Sr. RTA Coor', 'Coordinator', 'Senior Workforce Coordinator', 'Real Time Analyst', 'Work Force Co-ordinator', 'Desktop support')
group by Designation)emp_data  
Left Join
(select Title, SUM(Applied_Leave) as Applied_Leave,  
SUM(Pending_Leave) as Pending_Leave,    
SUM(Approved_Leave)as Approved_Leave,  
SUM(Rejected_Leave) as Rejeceted_Leave  
from (  
Select Title, COUNT(*) AS Applied_Leave,  
case when Leave_Status = 'Pending' then COUNT(Emp_ID) end as Pending_Leave,  
case when Leave_Status = 'Approved' then COUNT(Emp_ID) end as Approved_Leave,  
case when Leave_Status = 'Rejected' then COUNT(Emp_ID) end as Rejected_Leave   
from User_Leave_Request  
where datepart(m,Start_Date) = datepart(M,GETDATE())
group by Title, Leave_Status, Emp_ID  
)leave_summary  
group by Title)Leave  
on Leave.Title = emp_data.Designation



GO
/****** Object:  StoredProcedure [dbo].[Leave_Summary_Overall]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Leave_Summary_Overall]
as   
Select
isnull(emp_data.Designation,'') as Designation,  
emp_data.No_of_Employees as [No Of Employees],
isnull(Leave.Applied_Leave,0)  as [Employees on Leaves],  
cast(isnull(Leave.Applied_Leave,0) as float)/cast(isnull(emp_data.No_of_Employees,0) as float) as [% of Employees on Leaves],
isnull(leave.Pending_Leave,0) as [Leave Pending],  
isnull(Leave.Approved_Leave,0) as [Leave Approved]  
from  
(select Designation,COUNT(*) as No_of_Employees from WFM_Employee_List
--where Designation in ('Manager 1','Manager 2','Senior Manager','Lead Scheduler')
group by Designation)emp_data  
Left Join
(select Title, SUM(Applied_Leave) as Applied_Leave,  
SUM(Pending_Leave) as Pending_Leave,    
SUM(Approved_Leave)as Approved_Leave,  
SUM(Rejected_Leave) as Rejeceted_Leave  
from (  
Select Title, COUNT(*) AS Applied_Leave,  
case when Leave_Status = 'Pending' then COUNT(Emp_ID) end as Pending_Leave,  
case when Leave_Status = 'Approved' then COUNT(Emp_ID) end as Approved_Leave,  
case when Leave_Status = 'Rejected' then COUNT(Emp_ID) end as Rejected_Leave   
from User_Leave_Request  
where datepart(m,Start_Date) = datepart(M,GETDATE())
group by Title, Leave_Status, Emp_ID  
)leave_summary  
group by Title)Leave  
on Leave.Title = emp_data.Designation

GO
/****** Object:  StoredProcedure [dbo].[LEAVE_TABLE_HEADINGS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LEAVE_TABLE_HEADINGS]    
AS    
select     
case when COLUMN_NAME = 'Leave_Type' then 'Leave Type'    
when COLUMN_NAME = 'Request_Date' then 'Request Date'    
when COLUMN_NAME = 'Start_Date' then 'Start Date'    
when COLUMN_NAME = 'End_Date' then 'End Date'    
when COLUMN_NAME = 'No_of_Days' then 'Leave Applied (Days)'    
when COLUMN_NAME = 'Leave_Status' then 'Leave Status'    
when COLUMN_NAME = 'Description' then 'Description'    
when COLUMN_NAME = 'Week_Before' then 'Week Before'    
when COLUMN_NAME = 'Days_Before' then 'Days Before'    
when COLUMN_NAME = 'Leave_Segment' then 'Leave Segment'    
end as column_name    
from (    
SELECT COLUMN_NAME FROM CWFM_Umang.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'User_Leave_Request'and 
COLUMN_NAME in ('Leave_Type','Request_Date','Start_Date','End_Date','No_of_Days','Leave_Status','Description','Week_Before','Days_Before','Leave_Segment')

)tbl 

GO
/****** Object:  StoredProcedure [dbo].[MOM_Check_Status]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[MOM_Check_Status]
@War_Room_ID Varchar(255)
as

Select ProjectID,

Agreed1,Agreed2,Agreed3,Agreed4,Agreed5,Agreed6,Agreed7, Resp1,Resp2,Resp3,Resp4,Resp5,Resp6,Resp7,CompDate1,CompDate2,
CompDate3,CompDate4,CompDate5,CompDate6,CompDate7,[status]


 from [Warroom_Meeting] where ProjectID = @War_Room_ID
GO
/****** Object:  StoredProcedure [dbo].[month_picker]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[month_picker]
as
(Select left(datename(MONTH,Month_Name),3) +'-'+ convert(nvarchar,DATEPART(YEAR, Month_Name)) as months from tbl_Month_Fill)
GO
/****** Object:  StoredProcedure [dbo].[monthly_Revenue_GM_Sheet2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[monthly_Revenue_GM_Sheet2]
(
@CLIENT_NAME VARCHAR(255),
@REGION VARCHAR(255)  = NULL
)
AS
BEGIN
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''
BEGIN
SET @REGION = 'ALL'
END

--TRUNCATE TABLE 	 CUSTOMIZE_MONTHLY_REVENUE_GM
--INSERT  INTO CUSTOMIZE_MONTHLY_REVENUE_GM

SELECT B.ClientName,
LM.REGION,[MONTH], [YEAR],
ROUND(SUM(ACT_REV),0) AS A_REVENUE,
ROUND(SUM(BGT_REV),0) AS B_REVENUE,
ROUND(SUM(ACT_REV),0) - ROUND(SUM(ACT_COS),0)  AS A_GM,
ROUND(SUM(BGT_REV),0) - ROUND(SUM(BGT_COS),0)  AS B_GM,
MR.[RANK]
FROM (
SELECT PROJECT_CODE,LOCATION_CODE,[MONTH], [YEAR],
CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'REVENUE' THEN (SUM(METRIC_VALUE)*-1) END AS ACT_REV,
CASE WHEN METRIC_CATEGORY =  'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) *-1 END AS BGT_REV,
CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS ACT_COS,
CASE WHEN METRIC_CATEGORY =  'USD BUDGET LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS BGT_COS

FROM FINANCERAW2016
WHERE YEAR IN ('2015','2016')
GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE,LOCATION_CODE,[MONTH], [YEAR]
)A    	LEFT JOIN    (
SELECT DISTINCT CLIENTNAME, PRCODE
FROM CLIENT_MAPPING
)B    	ON A.PROJECT_CODE = B.PRCODE
LEFT JOIN (
SELECT *
FROM LOCATION_MAPPING
)LM   ON  LM.LOC_CODE =  A.LOCATION_CODE
LEFT JOIN  (
SELECT *
FROM MONTHSRANK
)MR  ON A.[MONTH] = MR.[MONTHS]
WHERE  1=1
AND ISNULL(REGION,'') NOT IN('','CORP','GLOBAL')
AND    (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
AND B.ClientName = @CLIENT_NAME
GROUP BY LM.REGION,[MONTH], [YEAR],MR.[RANK],B.ClientName
ORDER BY LM.REGION, A.[YEAR] ASC,MR.[RANK] ASC
END

GO
/****** Object:  StoredProcedure [dbo].[name]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[name]
(@name varchar(20)= '%')
AS
BEGIN
   select First_Name from Test_Emp_Details
   where First_Name like @name
END

GO
/****** Object:  StoredProcedure [dbo].[name1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[name1]
(@name varchar(20)= '%') WITH RECOMPILE
AS
BEGIN
   select First_Name from Test_Emp_Details
   where First_Name like @name
END

GO
/****** Object:  StoredProcedure [dbo].[Operational_Glidepath]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Operational_Glidepath]
@Client Varchar(max)
as

Select * from dbo.KPI_Target where Client_Name = @Client and updation_Date = (select max(updation_date) from KPI_Target where Client_Name = @Client) 




  




GO
/****** Object:  StoredProcedure [dbo].[Operational_Glidepath_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Operational_Glidepath_dotnet] 
(
	@War_Room_ID int,
	@Metric Varchar(max)
)
AS
BEGIN
	DECLARE @WeekDate AS VARCHAR(MAX)=''
	DECLARE @xSQL AS VARCHAR(MAX)=''

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
	   DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLEWR'))
	BEGIN
	   DROP TABLE TEMPTABLEWR
	END

	SELECT DISTINCT [MONTHS] [MONTHS]  INTO #TEMPTABLE
	FROM KPI_TARGET_NORMALISED 
	WHERE 1=1
	and METRICS= @METRIC 
	AND SR_NO = @WAR_ROOM_ID AND UPDATION_DATE = (SELECT MAX(UPDATION_DATE) FROM KPI_TARGET_Normalised WHERE SR_NO = @WAR_ROOM_ID)
	ORDER BY [MONTHS] DESC

	SELECT @WeekDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[MONTHS],106),' ','-') + '],' + @WeekDate
	FROM #TEMPTABLE TP

	IF LEFT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
	END

	IF RIGHT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
	END

	SET @xSQL = 'SELECT * INTO TEMPTABLEWR
		FROM (
			SELECT 
			 [MONTHS]
			,[XVALUE]
			FROM KPI_TARGET_NORMALISED WR 
			where METRICS= '''+ CONVERT(VARCHAR,@METRIC) +''' 
			and 1 = 1'
			
	SET @xSQL = @xSQL + ' AND SR_NO = '''+ CONVERT(VARCHAR,@WAR_ROOM_ID) +''' 
			AND UPDATION_DATE = (SELECT MAX(UPDATION_DATE) FROM KPI_TARGET_Normalised WHERE SR_NO = '''+ CONVERT(VARCHAR,@WAR_ROOM_ID) +''')
		) as s
		PIVOT
		(
			SUM([XVALUE])
			FOR [MONTHS] IN ('+ @WeekDate +')
		)AS PVT '
	print @xSQL
	--EXEC(@xSQL)
	
	SELECT * FROM TEMPTABLEWR
END


GO
/****** Object:  StoredProcedure [dbo].[Operational_Glidepath_dotnet_New]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Operational_Glidepath_dotnet_New] --3,2
(
	@War_Room_ID int,
	@Metric int
)
AS
BEGIN
	DECLARE @WeekDate AS VARCHAR(MAX)=''
	DECLARE @xSQL AS VARCHAR(MAX)=''

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE o.xtype IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
	   DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.xtype IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLEWR'))
	BEGIN
	   DROP TABLE TEMPTABLEWR
	END

	SELECT DISTINCT [MONTHS] [MONTHS]  INTO #TEMPTABLE
	FROM [tbl_WR_Glidepath] 
	WHERE 1=1
	and Metric_ID = @METRIC 
	AND Warroom_acc_ID = @WAR_ROOM_ID 
	AND UPDATION_DATE = (SELECT MAX(UPDATION_DATE) FROM [tbl_WR_Glidepath] WHERE Warroom_acc_ID = @WAR_ROOM_ID)
	ORDER BY [MONTHS] DESC

	SELECT @WeekDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[MONTHS],106),' ','-') + '],' + @WeekDate
	FROM #TEMPTABLE TP

	IF LEFT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
	END

	IF RIGHT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
	END

	SET @xSQL = 'SELECT * INTO TEMPTABLEWR
		FROM (
			SELECT FM.Fin_Metric [CATEGORY]
			,[MONTHS]
			,[x_Value]
			FROM [tbl_WR_Glidepath] WR 
			left join financial_Metrics FM on
			FM.Fin_Metric = WR.x_Type


			where METRIC_ID = '''+ CONVERT(VARCHAR,@METRIC) +''' 
			and 1 = 1'
			
	SET @xSQL = @xSQL + ' AND Warroom_acc_ID = '''+ CONVERT(VARCHAR,@WAR_ROOM_ID) +''' 
			AND UPDATION_DATE = (SELECT MAX(UPDATION_DATE) FROM [tbl_WR_Glidepath] WHERE Warroom_acc_ID = '''+ CONVERT(VARCHAR,@WAR_ROOM_ID) +''')
		) as s
		PIVOT
		(
			SUM([X_VALUE])
			FOR [MONTHS] IN ('+ @WeekDate +')
		)AS PVT '
	--print @xSQL
	EXEC(@xSQL)
	
	SELECT * FROM TEMPTABLEWR
END
GO
/****** Object:  StoredProcedure [dbo].[Operational_Glidepath_ForGraph_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Operational_Glidepath_ForGraph_dotnet] 

	@War_Room_ID int,
	@Metric Varchar(max)

AS

BEGIN


	DECLARE @WeekDate AS VARCHAR(MAX)=''--Dateadd(m,3,convert(varchar,getdate(),112));
	DECLARE @xSQL AS VARCHAR(MAX)=''

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))	
	BEGIN	
	   DROP TABLE #TEMPTABLE
	END
	
	SELECT DISTINCT [x_Type] as Metric
	, [Months]  INTO #TEMPTABLE
	FROM tbl_WR_Glidepath GPM
	INNER JOIN tbl_WR_Metric MTM on GPM.Metric_ID = MTM.Metric_ID
	WHERE 1=1
	AND [x_Type] in ('Budget/Target','Forecasted','Actual/Tracker','Glidepath')
	and MTM.Metric_Name= @METRIC 
	AND Warroom_acc_ID = @WAR_ROOM_ID 
	AND CONVERT(varchar,UPDATION_DATE,106) in (
		SELECT CONVERT(varchar,MAX(UPDATION_DATE),106) 
		FROM tbl_WR_Glidepath GP
		INNER JOIN tbl_WR_Metric MT on GP.Metric_ID = MT.Metric_ID 
		WHERE Warroom_acc_ID = @WAR_ROOM_ID	
		and MT.Metric_Name= @METRIC
		--and [months] in (SELECT XMONTHS FROM [XGETMONTHSGLIDEPATH](@WeekDate))
		)
		ORDER BY [x_Type]-- DESC


	SELECT REPLACE(CONVERT(VARCHAR,TP.[Months],106),' ','-') [xMonths] ,TP.[Months] INTO #TEMPTABLEx
	FROM #TEMPTABLE TP
	group by REPLACE(CONVERT(VARCHAR,TP.[Months],106),' ','-') ,TP.[Months]
	order by TP.[Months] DESC

	Set @WeekDate=''
	SELECT @WeekDate = '[' + TP.[xMonths] + '],' + @WeekDate
	FROM #TEMPTABLEx TP
	--group by REPLACE(CONVERT(VARCHAR,TP.[Months],106),' ','-') 
	--Order by CONVERT(VARCHAR,TP.[Months],112)

	IF LEFT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
	END

	IF RIGHT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
	END
	--SELECT @WeekDate
	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLEWR'))
	BEGIN
		DROP TABLE TEMPTABLEWR
	END	

	SET @xSQL = 'SELECT * INTO TEMPTABLEWR FROM 
	(
			SELECT 
			''01-''+Replace(RIGHT(CONVERT(VARCHAR,CONVERT(SMALLDATETIME,[MONTHS]),106),8),'' '',''-'') [MONTHS]
			,case when [x_TYPE]=''Budget/Target'' then 1 when [x_TYPE]=''Forecasted'' then 2 when [x_TYPE]=''Actual/Tracker'' then 3 when [x_TYPE]=''Glidepath'' then 4 else 5 end as Sort
			,[x_TYPE] as Metric
			,[X_VALUE]			
			FROM tbl_WR_Glidepath GPM
			INNER JOIN tbl_WR_Metric MTM on GPM.Metric_ID = MTM.Metric_ID 
			WHERE 1 = 1			
			AND MTM.Metric_Name= '''+ CONVERT(VARCHAR,@METRIC) +''' 
			AND Warroom_acc_ID = '''+ CONVERT(VARCHAR,@WAR_ROOM_ID) +''' 
			AND CONVERT(varchar,UPDATION_DATE,106)  in (
				SELECT CONVERT(varchar,MAX(UPDATION_DATE),106)  
				FROM tbl_WR_Glidepath GP
				INNER JOIN tbl_WR_Metric MT on GP.Metric_ID = MT.Metric_ID 
				WHERE Warroom_acc_ID = '''+ CONVERT(VARCHAR,@WAR_ROOM_ID) +'''
				and MT.Metric_Name= '''+ @METRIC+'''
				)
		) as s
		PIVOT
		(
			SUM([X_VALUE])
			FOR [Months] IN ('+ @WeekDate +')
		)AS PVT'
	--Print @xSQL
	EXEC(@xSQL)


	SELECT * FROM TEMPTABLEWR ORDER BY Sort
	
	
	-- EXEC Operational_Glidepath_ForGraph_dotnet 1,'AHT'
END
GO
/****** Object:  StoredProcedure [dbo].[Operational_GM_Glidepath]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Operational_GM_Glidepath]  
  
@War_Room_ID Int  
as  
Select * from GM_Glidepath Where War_Room_ID = @War_Room_ID  
GO
/****** Object:  StoredProcedure [dbo].[Operational_GM_Glidepath1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Operational_GM_Glidepath1]
@War_Room_ID Int,
@Metric varchar(max)=null,
@Single_Metric int=0

AS
BEGIN
 --Select  UPPER(REPLACE(RIGHT(CONVERT(VARCHAR(9), [Months], 6), 6), ' ', '')) AS Months_Sel,Budget_vs_Target,Forecasted_GM,Actual_vs_Tracker,Glidepath_GM,Optimal from GM_Glidepath Where War_Room_ID = @War_Room_ID

	if @Metric IS NULL OR @Metric=''
	Begin
	   if @Single_Metric<>1
		Begin
		    Set @Metric = '0' 
		End
		else 
		Begin
			SELECT TOP(1) @Metric = METRICS
			FROM KPI_TARGET  
			WHERE SR_NO = @War_Room_ID AND METRICS<>'0' AND METRICS<>'SELECT METRIC' 
			GROUP BY METRICS,SR_NO,CLIENT_NAME
			ORDER BY METRICS ASC
		 End
	END


	-- EXEC Operational_GM_Glidepath1 1,'',1

	SELECT   UPPER(REPLACE(RIGHT(CONVERT(VARCHAR(9), [Months], 6), 6), ' ', '')) AS Months_Sel,
		max(case when x_Type = 'Budget/Target' then x_Value end) as 'Budget_vs_Target',
		max(case when x_Type = 'Forecasted' then x_Value end)as 'Forecasted_GM',
		max(case when x_Type = 'Actual/Tracker' then x_Value end) as 'Actual_vs_Tracker',
		--max(case when x_Type = 'Actual/Tracker' then x_Value end)  + 
		max(case when x_Type = 'Glidepath' then x_Value end) as 'Glidepath_GM',
		max(case when x_Type = 'Glidepath Improvement' then x_Value end) as 'Optimal'
	FROM     tbl_WR_Glidepath WRG 
	LEFT JOIN tbl_WR_Metric WRM on WRG.Metric_ID = WRM.Metric_ID
	WHERE    Warroom_acc_ID = @War_Room_ID  AND ISNULL(WRM.Metric_Name,'0') = @Metric
	GROUP BY WRM.Metric_Name, UPPER(REPLACE(RIGHT(CONVERT(VARCHAR(9), [Months], 6), 6), ' ', '')) 
	ORDER BY MAX([Months])
	
END


-- EXEC [Operational_GM_Glidepath1] 4,'',1
GO
/****** Object:  StoredProcedure [dbo].[Operational_GM_impact_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Operational_GM_impact_dotnet]

@War_Room_ID int,
@Metric Varchar(max)
as

Select  UPPER(REPLACE(RIGHT(CONVERT(VARCHAR(9), [Months], 6), 6), ' ', '')) AS Months_Sel, Historically,Tracker_Forecast,Glidepath_Improvement from KPI_Target  where Metrics= @Metric and SR_NO = @War_Room_ID and updation_Date = (select max(updation_date) from KPI_Target where SR_NO = @War_Room_ID)
GO
/****** Object:  StoredProcedure [dbo].[Operational_GM_Waterfall]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Operational_GM_Waterfall]

  

@Client_Name varchar(max)  

as  

  

Select * from GM_Waterfall where Client_Name = @Client_Name




GO
/****** Object:  StoredProcedure [dbo].[Operational_GM_Waterfall_Dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[Operational_GM_Waterfall_Dotnet] 
(
	 @Client_Name varchar(max)  
)
AS  
BEGIN
	--DECLARE @Client_Name varchar(max)  = 'PITNEY BOWES'

	DECLARE @MAX_ROWNUMBER INT
	DECLARE @MAX_GM_PERCENTAGE DECIMAL(18,2)
	DECLARE @ONE_LESS_ROWNUMBER INT
	DECLARE @ONE_LESS_PERCENTAGE DECIMAL(18,2)

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE_TMP'))
	BEGIN
		DROP TABLE #TEMPTABLE_TMP
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE_TMPX'))
	BEGIN
		DROP TABLE #TEMPTABLE_TMPX
	END

	SELECT CASE WHEN [METRIC_NAME] = 'Current' THEN 'AAAAA_Current'
	WHEN  [METRIC_NAME] = 'Target' THEN 'ZZZZZ_Target' else 'BBBBB_'+ [METRIC_NAME] end as [METRIC_NAME],
	[GM_PERCENTAGE] 
	INTO #TEMPTABLE
	FROM GM_WATERFALL WA
	WHERE 1 = 1
	AND ISNULL(GM_PERCENTAGE,0) <> 0
	AND REPLACE(REPLACE(CLIENT_NAME,'TOTAL ',''),'GRAND TOTAL ','') = @Client_Name

	SELECT ROW_NUMBER() OVER (ORDER BY [METRIC_NAME]) AS [ROWNUMBER],* 
	INTO #TEMPTABLE_TMP
	FROM #TEMPTABLE
	--WHERE METRIC_NAME <> 'AAAAA_CURRENT'
	ORDER BY [METRIC_NAME];

	
	SELECT @MAX_ROWNUMBER = MAX([ROWNUMBER]),@MAX_GM_PERCENTAGE = ABS([GM_PERCENTAGE])
	FROM #TEMPTABLE_TMP
	WHERE [ROWNUMBER] < @MAX_ROWNUMBER
	GROUP BY [ROWNUMBER],[GM_PERCENTAGE]



	
	SELECT @ONE_LESS_PERCENTAGE = Min(ABS([GM_PERCENTAGE]))
	FROM #TEMPTABLE_TMP
	WHERE [ROWNUMBER] < @MAX_ROWNUMBER
	
	UPDATE #TEMPTABLE_TMP SET [METRIC_NAME] = REPLACE(REPLACE(REPLACE([METRIC_NAME],'AAAAA_',''),'BBBBB_',''),'ZZZZZ_','');
	
	DECLARE @CURR_PERCENTAGE FLOAT
	
	SELECT @CURR_PERCENTAGE = [GM_PERCENTAGE]
	FROM #TEMPTABLE_TMP
	WHERE [METRIC_NAME] = 'CURRENT'

	SELECT [ROWNUMBER],[METRIC_NAME],
	CASE WHEN [METRIC_NAME] IN ('Current','Target') THEN ABS([GM_PERCENTAGE]) ELSE (@MAX_GM_PERCENTAGE - @ONE_LESS_PERCENTAGE) END * 100 AS [BAR1],
	CASE WHEN [GM_PERCENTAGE] < 0 THEN ABS([GM_PERCENTAGE]) * 100 ELSE 0 END AS [BAR2],
	CASE WHEN ([METRIC_NAME] NOT IN ('Current','Target') AND [GM_PERCENTAGE] > 0) THEN ABS([GM_PERCENTAGE]) * 100 ELSE 0 END AS [BAR3]
	--INTO #TEMPTABLE_TMPX
 	FROM #TEMPTABLE_TMP
	ORDER BY [ROWNUMBER];

	SELECT [ROWNUMBER],[METRIC_NAME],
	CASE WHEN [METRIC_NAME] IN ('Current','Target') THEN ABS([GM_PERCENTAGE]) ELSE (@MAX_GM_PERCENTAGE - @ONE_LESS_PERCENTAGE) END * 100 AS [BAR1],
	CASE WHEN [GM_PERCENTAGE] < 0 THEN ABS([GM_PERCENTAGE]) * 100 ELSE 0 END AS [BAR2],
	CASE WHEN ([METRIC_NAME] NOT IN ('Current','Target') AND [GM_PERCENTAGE] > 0) THEN ABS([GM_PERCENTAGE]) * 100 ELSE 0 END AS [BAR3]
	INTO #TEMPTABLE_TMPX
 	FROM #TEMPTABLE_TMP
	ORDER BY [ROWNUMBER];

	TRUNCATE TABLE #TEMPTABLE_TMPX;
	
	--select @MAX_ROWNUMBER,@MAX_GM_PERCENTAGE,@ONE_LESS_ROWNUMBER,@ONE_LESS_PERCENTAGE

	DECLARE @xCursor as CURSOR;
	DECLARE @METRIC_NAME VARCHAR(MAX);
	DECLARE @BAR1 FLOAT;
	DECLARE @BAR2 FLOAT;
	DECLARE @BAR3 FLOAT;
	DECLARE @BARX FLOAT = 0;
	DECLARE @BARY FLOAT = 0;
	DECLARE @BARZ FLOAT = 0;
	DECLARE @ROWNUMBER INT;

	SET @xCursor = CURSOR FOR
	SELECT [ROWNUMBER],[METRIC_NAME],
	CASE WHEN [METRIC_NAME] IN ('Current','Target') THEN ABS([GM_PERCENTAGE]) ELSE 0 END * 100 ,
	CASE WHEN [GM_PERCENTAGE] < 0 THEN ABS([GM_PERCENTAGE]) * 100 ELSE 0 END ,
	CASE WHEN ([METRIC_NAME] NOT IN ('Current','Target') AND [GM_PERCENTAGE] > 0) THEN ABS([GM_PERCENTAGE]) * 100 ELSE 0 END 
 	FROM #TEMPTABLE_TMP
	ORDER BY [ROWNUMBER];

	OPEN @xCursor;
	FETCH NEXT FROM @xCursor INTO @ROWNUMBER,@METRIC_NAME, @BAR1, @BAR2, @BAR3;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@BARX = 0 OR @METRIC_NAME = 'TARGET')
		BEGIN
			SET @BARX = @BAR1
		END 
		
		IF (@BAR2 > 0)
		BEGIN
			SET @BAR1 = ((@BARX - @BAR2) );
		END 
		ELSE
		BEGIN
			SET @BARY = @BARY - @BARZ
			SET @BAR1 = ((@BARX - abs(@BARY) + @BAR3) );
		END 

		--SET @BAR1 = ((@BARX - @BAR2) + @BAR3);
		--SELECT @BARX,@BAR1,@BAR2,@BAR3
		INSERT INTO #TEMPTABLE_TMPX VALUES(@ROWNUMBER,@METRIC_NAME,@BAR1,@BAR2,@BAR3);

		SET @BARX = @BAR1
		SET @BARY = @BAR2
		SET @BARZ = @BAR3
		
		FETCH NEXT FROM @xCursor INTO @ROWNUMBER,@METRIC_NAME, @BAR1, @BAR2, @BAR3;
	END
 
	CLOSE @xCursor;
	DEALLOCATE @xCursor;



	SELECT [METRIC_NAME],[BAR1],[BAR2],[BAR3]
 	FROM #TEMPTABLE_TMPX
	ORDER BY [ROWNUMBER] 

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE_TMP'))
	BEGIN
		DROP TABLE #TEMPTABLE_TMP
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE_TMPX'))
	BEGIN
		DROP TABLE #TEMPTABLE_TMPX
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Operational_GM_Waterfall_Dotnet_BU]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  Procedure [dbo].[Operational_GM_Waterfall_Dotnet_BU] 
(
	 @Client_Name varchar(max)  
)
AS  
BEGIN
	--SELECT [METRIC_NAME],[GM_PERCENTAGE]
	--FROM GM_WATERFALL 
	--WHERE 1 = 1
	--AND ISNULL(GM_PERCENTAGE,0) <> 0
	--AND REPLACE(REPLACE(CLIENT_NAME,'TOTAL ',''),'GRAND TOTAL ','') = @Client_Name

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE_TMP'))
	BEGIN
		DROP TABLE #TEMPTABLE_TMP
	END

	SELECT CASE WHEN [METRIC_NAME] = 'Current' THEN 'AAAAA_Current'
	WHEN  [METRIC_NAME] = 'Target' THEN 'ZZZZZ_Target' else 'BBBBB_'+ [METRIC_NAME] end as [METRIC_NAME],
	[GM_PERCENTAGE] 
	INTO #TEMPTABLE
	FROM GM_WATERFALL WA
	WHERE 1 = 1
	AND ISNULL(GM_PERCENTAGE,0) <> 0
	AND REPLACE(REPLACE(CLIENT_NAME,'TOTAL ',''),'GRAND TOTAL ','') = @Client_Name

	SELECT ROW_NUMBER() OVER (ORDER BY [METRIC_NAME]) AS [ROWNUMBER],* 
	INTO #TEMPTABLE_TMP
	FROM #TEMPTABLE
	--WHERE METRIC_NAME <> 'AAAAA_CURRENT'
	ORDER BY [METRIC_NAME];

	WITH xTMP AS 
	(
		SELECT *
		FROM #TEMPTABLE_TMP
	) 
	select REPLACE(REPLACE(REPLACE(METRIC_NAME,'AAAAA_',''),'BBBBB_',''),'ZZZZZ_','') [METRIC_NAME],
	GM_PERCENTAGE,GM_PERCENTAGE2,GM_PERCENTAGE3,GM_PERCENTAGE4
	FROM (
		SELECT xTMP.[METRIC_NAME],xTMP.[GM_PERCENTAGE]*100 [GM_PERCENTAGE],xTMP.[GM_PERCENTAGE]*100 [GM_PERCENTAGE2],
		xTMP2.[GM_PERCENTAGE]*100 [GM_PERCENTAGE3],xTMP2.[GM_PERCENTAGE]*100 [GM_PERCENTAGE4]
		FROM xTMP INNER JOIN (
			SELECT *
			FROM #TEMPTABLE_TMP
			) AS xTMP2	
		ON xTMP2.[ROWNUMBER] = xTMP.[ROWNUMBER]+1
		UNION
		SELECT METRIC_NAME,GM_PERCENTAGE,GM_PERCENTAGE GM_PERCENTAGE2,GM_PERCENTAGE GM_PERCENTAGE3,GM_PERCENTAGE GM_PERCENTAGE4
		FROM #TEMPTABLE_TMP
		WHERE METRIC_NAME = 'ZZZZZ_Target'
		) TMP

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O 
	WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE_TMP'))
	BEGIN
		DROP TABLE #TEMPTABLE_TMP
	END
END

GO
/****** Object:  StoredProcedure [dbo].[operational_RCA]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[operational_RCA]

@Client_Name Varchar(max)

as

Select distinct Metrics from KPI_Target Where Client_Name = @Client_Name 








GO
/****** Object:  StoredProcedure [dbo].[operational_RCA_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[operational_RCA_dotnet]

@War_Room_ID Varchar(max)

as

Select distinct Metric_Name as Metrics from tbl_WR_Glidepath WG Left Join tbl_WR_Metric WM on WM.Metric_ID = WG.Metric_ID Where Warroom_acc_ID =@War_Room_ID






GO
/****** Object:  StoredProcedure [dbo].[OPP]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[OPP]
@region as varchar(max)

as

Select sum(OPP) from upload
where region = @Region
GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Loss_by_Account]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Opportunity_Loss_by_Account]
@Client_Name as Varchar(max)
as
(Select SUM(FTE_Opp*-1) from 
(Select ob.*,ro.rph, cm.ClientName,

-- Over Under with Cap
CASE WHEN isnull( ob.[Billable KPI Target],0) > 0 then (isnull(ob.[Actual or Forecasted Head with Proficients Applied to Agents in ],1)  /(case when isnull(ob.[HC Call] ,0)= 1 then isnull(ob.[Heads Required Based on 100 % of Forecast Calls Offered],1) else ISNULL(ob.[Heads Required Based on Average Weekly Scheduled Hours],1) end)-isnull(ob.[Billable KPI Target],1) * ISNULL( ro.[RPH],0)) 
-- Over Under without Cap
 when isnull(ob.[HC Call],0) = 1 then isnull([Heads Required Based on 100 % of Forecast Calls Offered],1) 
 else (isnull(ob.[Heads Required Based on Average Weekly Scheduled Hours],1)- isnull(ob.[Actual or Forecasted Head with Proficients Applied to Agents in],1))* isnull(ro.[RPH],0) end as 'FTE_Opp',

-- AHT
--(cap-act aht)*calls/3600*RPH	(For-act aht)*calls/3600*RPH
-- AHT opportunity With CAP
-- CASE WHEN  [Billable KPI Target] > 0 then ( [Billable KPI Target] -[Actual Weekly AHT] * ([Actual Weekly Contacts Offered] - ( [Actual Weekly Contacts Offered] * [Actual Weekly Abandon Rate])) / 3600) * [RPH]
--else 
--AHT opportunity Without CAP
--( [Forecasted AHT] -[Actual Weekly AHT] * ([Actual Weekly Contacts Offered] - ( [Actual Weekly Contacts Offered] * [Actual Weekly Abandon Rate])) / 3600) * [RPH]  'AHT Opportunity' ,
  
--Abandondon Opp

((ob.[Forecasted Abandon Rate] - ob.[Actual Weekly Abandon Rate]) * ob.[Actual Weekly AHT] / 3600 )* ro.[RPH] as 'Abandon_Opportunity'


 from opportunity_base ob

left join rph_opportunity ro on ob.ID =  ro.project_code and ro.[Year] = ob.[Year] and ro.[month] = ob.[month]
left join Client_Mapping cm on cm.PRCode = ob.id

Where ro.RPH <> 'Null'   and ob.code = '0022' and cm.clientName = @Client_Name)  aa group by aa.ClientName)



GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Loss_war_Room]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Opportunity_Loss_war_Room]
as
Select  SUM(FTE_Opp*-1) from 
(Select ob.*,ro.rph, cm.ClientName,

-- Over Under with Cap
CASE WHEN isnull( ob.[Billable KPI Target],0) > 0 then (isnull(ob.[Actual or Forecasted Head with Proficients Applied to Agents in ],1)  /(case when isnull(ob.[HC Call] ,0)= 1 then isnull(ob.[Heads Required Based on 100 % of Forecast Calls Offered],1) else ISNULL(ob.[Heads Required Based on Average Weekly Scheduled Hours],1) end)-isnull(ob.[Billable KPI Target],1) * ISNULL( ro.[RPH],0)) 
-- Over Under without Cap
 when isnull(ob.[HC Call],0) = 1 then isnull([Heads Required Based on 100 % of Forecast Calls Offered],1) 
 else (isnull(ob.[Heads Required Based on Average Weekly Scheduled Hours],1)- isnull(ob.[Actual or Forecasted Head with Proficients Applied to Agents in],1))* isnull(ro.[RPH],0) end as 'FTE_Opp',

-- AHT
--(cap-act aht)*calls/3600*RPH	(For-act aht)*calls/3600*RPH
-- AHT opportunity With CAP
-- CASE WHEN  [Billable KPI Target] > 0 then ( [Billable KPI Target] -[Actual Weekly AHT] * ([Actual Weekly Contacts Offered] - ( [Actual Weekly Contacts Offered] * [Actual Weekly Abandon Rate])) / 3600) * [RPH]
--else 
--AHT opportunity Without CAP
--( [Forecasted AHT] -[Actual Weekly AHT] * ([Actual Weekly Contacts Offered] - ( [Actual Weekly Contacts Offered] * [Actual Weekly Abandon Rate])) / 3600) * [RPH]  'AHT Opportunity' ,
  
--Abandondon Opp

((ob.[Forecasted Abandon Rate] - ob.[Actual Weekly Abandon Rate]) * ob.[Actual Weekly AHT] / 3600 )* ro.[RPH] as 'Abandon_Opportunity'


 from opportunity_base ob

left join rph_opportunity ro on ob.ID =  ro.project_code and ro.[Year] = ob.[Year] and ro.[month] = ob.[month]
left join Client_Mapping cm on cm.PRCode = ob.id

Where ro.RPH <> 'Null'   and ob.code = '0022' )aa 

--group by aa.ClientName





GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Saving_Summary]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Opportunity_Saving_Summary]

as

Select Metrics, sum(abs(Tracker_Forecast)) as Forecasted_Opportunity  from KPI_Target group by metrics

GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Saving_Summary_Global_Ops_Loss]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Opportunity_Saving_Summary_Global_Ops_Loss]

as

Select sum(abs(Tracker_Forecast)) as Forecasted_Opportunity  from KPI_Target 

GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Saving_Summary_Global_Ops_Loss_DOTNET]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Opportunity_Saving_Summary_Global_Ops_Loss_DOTNET]
  @REGION VARCHAR(255)  = NULL,
  @NT_ID as varchar(max) = NULL,
  @AccessType as varchar(max) = NULL 
as


	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
	BEGIN  
	 SET @REGION = 'ALL'  
	END  


		
		Select 
		--ISNULL(SUM(ABS(x_Value)),0) AS FORECASTED_OPPORTUNITY
		case when ISNULL(SUM(ABS(x_Value)),0) > 1000000 then CAST(ROUND(ISNULL(SUM(ABS(x_Value)),0)/1000000,0) as varchar(max))+ 'M'
		when ISNULL(SUM(ABS(x_Value)),0) > 1000 then CAST(ROUND(ISNULL(SUM(ABS(x_Value)),0)/1000,0) as varchar(max))+ 'K' END AS FORECASTED_OPPORTUNITY
		From tbl_WR_Glidepath TWG inner join War_Room WR ON WR.War_Room_ID=TWG.Warroom_acc_ID inner join tbl_WR_Metric TWM ON TWM.Metric_ID=TWG.Metric_ID 
		WHERE 1 = 1 
--		AND x_Type='Forecasted'
		AND x_Type='Glidepath Improvement'
		and [Months] between left(convert(varchar,dateadd(m,-1,GETDATE()),112),6)+'01' and left(convert(varchar,dateadd(m,1,GETDATE()),112),6)+'01'
		AND (
			CONVERT(VARCHAR,WR.REGION) = @REGION  
			OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,WR.REGION) end in 
				(
					select Region from tbl_WR_User_Role
					where NT_ID = @NT_ID
					AND Access_Type = @AccessType
					and Start_Date <= GETDATE() and End_Date is null
				)
			)
		)          



	-----------------------------------------03-01-2017
	--Select 
	--case when sum(abs(Tracker_Forecast))  >= 1000000 then cast(round(sum(abs(Tracker_Forecast)) /1000000,2) as varchar(max))+ 'M'
	--when sum(abs(Tracker_Forecast))  >= 1000 then cast(round(sum(abs(Tracker_Forecast)) /1000,2) as varchar(max))+ 'K' END as [Forecasted_Opportunity]
	--from KPI_Target 
	-- WHERE 1 = 1  
	--			AND (
	--				CONVERT(VARCHAR,REGION) = @REGION  
	--				OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,REGION) end in 
	--					(
	--						select Region from tbl_WR_User_Role
	--						where NT_ID = @NT_ID
	--						AND Access_Type = @AccessType
	--						and Start_Date <= GETDATE() and End_Date is null
	--					)
	--				)
	--			)



GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Saving_Summary_Regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Opportunity_Saving_Summary_Regional]            
@REGION VARCHAR(255)  = NULL,
@NT_ID as varchar(max) = NULL,
@AccessType as varchar(max) = NULL         
AS            
          
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''          
BEGIN          
 SET @REGION = 'ALL'          
END          
     

-- EXEC Opportunity_Saving_Summary_Regional 'North America','vkole003','Regional'	 

-- EXEC Opportunity_Saving_Summary_Regional 'All','vkole003','Regional'	 
	      

Select Metric_Name AS METRICS,ISNULL(SUM(ABS(x_Value)),0) AS FORECASTED_OPPORTUNITY
From tbl_WR_Glidepath TWG inner join War_Room WR ON WR.War_Room_ID=TWG.Warroom_acc_ID inner join tbl_WR_Metric TWM ON TWM.Metric_ID=TWG.Metric_ID 
WHERE 1 = 1 AND x_Type='Forecasted'
  
				AND (
					CONVERT(VARCHAR,WR.REGION) = @REGION  
					OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,WR.REGION) end in 
						(
							select Region from tbl_WR_User_Role
							where NT_ID = @NT_ID
							AND Access_Type = @AccessType
							and Start_Date <= GETDATE() and End_Date is null
						)
					)
				)          
GROUP BY Metric_Name 



--SELECT METRICS, ISNULL(SUM(ABS(TRACKER_FORECAST)/1000),0) AS FORECASTED_OPPORTUNITY            
--FROM KPI_TARGET           
--WHERE 1 = 1  
--				AND (
--					CONVERT(VARCHAR,REGION) = @REGION  
--					OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,REGION) end in 
--						(
--							select Region from tbl_WR_User_Role
--							where NT_ID = @NT_ID
--							AND Access_Type = @AccessType
--							and Start_Date <= GETDATE() and End_Date is null
--						)
--					)
--				)          
--GROUP BY METRICS 
GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Saving_Summary_Regional_Ops_Loss]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Opportunity_Saving_Summary_Regional_Ops_Loss]        
      
@REGION VARCHAR(255)  = NULL        
AS          
        
IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''        
BEGIN        
 SET @REGION = 'ALL'        
END        
        
Select Metrics, sum(abs(Tracker_Forecast)/1000) as Forecasted_Opportunity  from KPI_Target       
WHERE 1 = 1        
AND (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL') 
group by Metrics





GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Savings_By_Warroom]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Opportunity_Savings_By_Warroom]

@War_Room_ID Varchar(255)
as

Select sr_no, abs(sum(glidepath_improvement))as Savings, abs(sum(Tracker_Forecast)) as Forecasted_Opportunity ,Abs(sum(Tracker_Forecast))-abs(sum(glidepath_improvement)) as Projected_Opportunity


 from KPI_Target KT where sr_no = @War_Room_ID group by sr_no

 


GO
/****** Object:  StoredProcedure [dbo].[Opportunity_Top_3_Metrices]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Opportunity_Top_3_Metrices] 
@War_Room_ID Varchar(255)  
AS
BEGIN  
  
     SELECT --SR_NO,CLIENT_NAME,
	 METRICS, SUM(ABS(AHT_GLIDEPATH)) AS FORECASTED_OPPORTUNITY  
	 FROM KPI_TARGET  
     WHERE SR_NO = @War_Room_ID AND METRICS<>'0' AND METRICS<>'SELECT METRIC' 
	 GROUP BY METRICS,SR_NO,CLIENT_NAME
	 ORDER BY METRICS ASC

END


 
GO
/****** Object:  StoredProcedure [dbo].[Ops_GM_Waterfall_Dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Ops_GM_Waterfall_Dotnet]   
(
	@xClient_Name varchar(255)
)
AS  
BEGIN  
	DECLARE @Gross_Margin INT = 0
	DECLARE @xORD INT = 0
	DECLARE @onDate varchar(10)
	DECLARE @xWR_ID INT
	DECLARE @xPos INT

	SELECT @xPos  = CHARINDEX('_', @xClient_Name)  
	
	SELECT @xWR_ID = SUBSTRING(@xClient_Name, 1, @xPos-1)

	SELECT @onDate = Right(@xClient_Name, len(@xClient_Name)-@xPos)

	IF @onDate IS NULL
	BEGIN
		SET @onDate = CONVERT(VARCHAR,GETDATE(),112)
	END

	--insert into xxxxx values(@onDate,getdate());

	SELECT @Gross_Margin = SUM(GM_Percentage)
	FROM GM_Waterfall_History  GW
	INNER JOIN TBL_WR_METRIC TWM ON TWM.METRIC_ID=GW.METRIC_ID
	WHERE GW.WR_ID = @xWR_ID AND GM_Percentage<>0  AND  GW.Metric_Name<>'Tracking' 
	AND CONVERT(VARCHAR,Updation_Date,112) = @onDate
		 
	SELECT @xORD = xORD
	FROM GM_Waterfall_History  GW
	INNER JOIN TBL_WR_METRIC TWM ON TWM.METRIC_ID=GW.METRIC_ID
	WHERE GW.WR_ID = @xWR_ID AND GM_Percentage<>0  AND  GW.Metric_Name='Tracking'	
	AND CONVERT(VARCHAR,Updation_Date,112) = @onDate

	SELECT [name] AS name,y,color
	FROM (
		SELECT TWM.Metric_Name as name,GM_Percentage AS y,
		case when GW.Metric_Name in ('Target','Tracking') then '#000000' else '' end color, XORD	    
		FROM GM_Waterfall_History  GW
		INNER JOIN TBL_WR_METRIC TWM ON TWM.METRIC_ID=GW.METRIC_ID
		WHERE GW.WR_ID = @xWR_ID AND GM_Percentage<>0  
		AND  TWM.Metric_Name<>'Tracking'		
		AND CONVERT(VARCHAR,Updation_Date,112) = @onDate
		) TMP
	ORDER BY XORD
			
End  
  
  
  
  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[Overall_Rev_Home]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Overall_Rev_Home]

@REGION VARCHAR(255)  = NULL  

as  

IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
BEGIN  
 SET @REGION = 'ALL'  
END  

(Select  lm.Region,
round(Sum(Act_Rev),0) as Revenue,
round(sum(Act_COS),0)  as COS,
round(Sum(Act_Rev),0)-round(sum(Act_COS),0)as GM, 
round(sum(Act_Pen),0) as A_Penalties ,
round(SUM(Bgt_Pen),0) as B_Penalties,
round(sum(Act_OT),0) as A_OT ,
round(SUM(Bgt_OT),0) as B_OT,
round(sum(Act_EH),0) as A_EH ,
round(SUM(Act_EHET),0) as A_EHET,
round(sum(Bgt_EH),0) as B_EH ,
round(SUM(Bgt_EHET),0) as B_EHET
 
from 
(Select Project_Code,location_code,
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then (sum(Metric_Value)*-1) end as Act_Rev,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Total Cost of Services' then sum(Metric_Value) end as Act_COS,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Inbound penalties' then sum(Metric_Value) end as Act_Pen,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Inbound penalties' then sum(Metric_Value) end as Bgt_Pen,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Overtime' then sum(Metric_Value) end as Act_OT,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Overtime' then sum(Metric_Value) end as Bgt_OT,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Expense Hours' then sum(Metric_Value) end as Act_EH,
case when Metric_Category =  'USD Actual @ Budget Rate' and Metric_Name = 'Expense Hours Excluding Training' then sum(Metric_Value) end as Act_EHET,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Expense Hours' then sum(Metric_Value) end as Bgt_EH,
case when Metric_Category =  'USD Budget Load' and Metric_Name = 'Expense Hours Excluding Training' then sum(Metric_Value) end as Bgt_EHET

from financeraw2016
where YEAR = datename(YEAR,GETDATE())
group by Metric_Category, Metric_Name,Project_Code,location_code
)a
Left Join
(Select distinct ClientName, PRCode from Client_mapping)b
on a.Project_Code = b.PRCode
left join Location_Mapping LM on  LM.LOC_Code =  a.Location_code
where  Region is not null AND region not in('CORP','GLOBAL') and
(CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
group by LM.Region
)


GO
/****** Object:  StoredProcedure [dbo].[Overall_War_room_Opportunity_Loss]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Overall_War_room_Opportunity_Loss]
as 

Select Metrics,Amount from Opportunity_Loss_Metrics


GO
/****** Object:  StoredProcedure [dbo].[PC_Details_Rating]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[PC_Details_Rating]

@EMP_ID varchar(255)
as
Select mm.Account_ID,mm.Emp_ID, mm.[Employee Name],mm.[Date],mm.Interval,Shift_check, ss.KPI_Target,ss.Targets,ss.Actual_SL,ss.Forecasted_SL,
ss.kpi_Final_Rating,ss.Forecast_Final_rating 
from
(
Select aa.Account_ID, aa.[Employee Name],aa.[Date], aa.Interval, aa.Emp_ID,aa.Shift_24,
aa.Night_Check1,aa.Night_Check2 ,
aa.Night_Check3,
case when aa.Shift_24 = 'OK' and aa.Night_Check1 = 'Not_OK' and aa.Night_Check2='Not_OK' and aa.Night_Check3='Not_OK'  then 1
when aa.shift_24='Not_OK' and aa.Night_Check1 = 'OK' and aa.Night_Check2='Not_OK' and aa.Night_Check3 ='OK' then 1
When aa.shift_24 = 'Not_OK' and aa.Night_Check1 = 'Not_OK' and aa.Night_Check2='OK' and aa.Night_Check3 ='OK' then 1 else 0 
end as 'Shift_Check'

from (

 Select ip.Account_ID,ip.Account,Actual_SL,ip.Forecasted_SL,ip.[Date],convert(char(19),Interval,108) as Interval,
 nn.emp_ID, 
 nn.[Employee Name],
 case when convert(char(19),Interval,108) >= convert(char(19),nn.shift_login,108)  and convert(char(19),Interval,108) <  convert(char(19),nn.Shift_Logout,108) then 'OK' else 'Not_OK' end as 'Shift_24' ,
 case when convert(char(19),nn.Shift_Login,108)>='15:00'  and convert(char(19),Interval,108) >= convert(char(19),nn.shift_login,108) and convert(char(19),nn.Shift_Logout,108)<='09:00' then 'OK' else 'Not_OK' end as 'Night_Check1',
 case when convert(char(19),Interval,108) < convert(char(19),nn.shift_logout,108) and convert(char(19),nn.Shift_Logout,108)<='09:00' and convert(char(19),nn.Shift_Logout,108)< convert(char(19),nn.Shift_Login,108) then 'OK' else 'Not_OK' end as 'Night_Check2',
 case when convert(char(19), nn.Shift_Logout,108)< convert(char(19),nn.Shift_Login,108) then 'OK' else 'Not_OK' end as 'Night_Check3'
 --case when convert(char(19),Interval,108) >= convert(char(19),nn.shift_login,108) and convert(char(19),Interval,108) >=  convert(char(19),nn.Shift_Logout,108) then 'OK' else 'Not_OK' end as 'Shiit_Post_24'
     
   from Interval_Performance ip
left join 
(Select sc.*,am.Account_Code_1 ,am.account_1_Start_Date,am.account_1_end_Date,pkd.KPI_Target,pkd.Targets

 
 from Shift_check sc  left join 

Account_Mapping am on am.ECN = sc.Emp_ID
left join Pacman_KPI_Details pkd on pkd.[Code No] = am.Account_Code_1 Where  Shift_Date >= am.account_1_start_Date   and  Shift_Date <= am.account_1_end_Date) nn on nn.Account_Code_1 = ip.Account_ID where nn.shift_Date = ip.Date) aa where month(aa.[date]) = MONTH('01-Nov-2015')
) mm  

 left join 
 (Select fin.*,

case when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1 /100) then 5
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band2/100) then 4
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band3 / 100) then 3
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1/100) then 2
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= 100 then 1
      else 0 end as 'KPI_Final_Rating',
      
      case when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band1 /100) and fin.Actual_SL < fin.Targets  then 1
      when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band2/100) and  fin.Actual_SL < fin.Targets  then 2
      when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band3 / 100) and fin.Actual_SL < fin.Targets  then 3 
       when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band1/100) and  fin.Actual_SL < fin.Targets  then 4
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1 /100)  then 5
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band2/100)  then 4
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band3 / 100) then 3
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1/100) then 2
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= 100 then 1
      
       else 0 end as 'Forecast_Final_Rating'
      from


(Select pa.Account_ID,pa.Account,pa.LOB,pa.region,pa.[date],pa.Interval,
pa.Actual_SL,
pa.forecasted_sl,KPI_Target, 
Targets,
case when pa.actual_SL >= pa.Targets then round((100- (Targets*100))/ 5,0)
When pa.Actual_SL < pa.targets and pa.Actual_SL  < pa.forecasted_sl then 0
When pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then round((((pa.Targets *100) - (pa.forecasted_sl *100)) / 4),0)
  end as 'Band',
  
case when pa.actual_SL > pa.Targets then 'KPI_Target_Met' 
When pa.Actual_SL < pa.targets and pa.Actual_SL > pa.forecasted_sl then 'Forecast Met'
When pa.Actual_SL < pa.targets and pa.Actual_SL < pa.forecasted_sl then 'Not_Met' end as 'Status',


case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.2),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then (pa.forecasted_sl*100)+  round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .25),0)

  end as 'Band1',
case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.4),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then (pa.forecasted_sl*100)+ round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .5),0)
  end as 'Band2',
case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.6),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then (pa.forecasted_sl*100)+ round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .75),0)  end as 'Band3',
case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.8),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then round((pa.forecasted_sl*100)+ round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .75),0),0)
  end as 'Band4'

from (

Select IP.*, [KPI_Target],[Targets] from Interval_Performance IP

left join pacman_KPI_Details PKD on ip.Account_ID = pkd.[Code No]) pa) fin ) ss on mm.Account_ID = ss.Account_ID
where  ss.[Date] = mm.[Date] and convert(char(19),mm.Interval,108) = convert(char(19),ss.Interval,108)
and mm.shift_check = '1' and mm.Emp_ID = @EMP_ID 
-- and ss.Date = '20151101'



GO
/****** Object:  StoredProcedure [dbo].[PC_Metric_Rating]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PC_Metric_Rating]

@EMP_ID varchar(255)
as
Select era.emp_id,
cast(convert(Float,Sum(era.kpi_Final_Rating)) /convert(Float,Count(era.kpi_Final_Rating)) as decimal(10,2))  as 'KPI_Rating',
cast(convert(Float,Sum(era.Forecast_Final_rating)) /convert(Float,Count(era.Forecast_Final_rating)) as decimal(10,2))  as 'Forecast_Final_Rating'

from
(Select mm.Account_ID,mm.Emp_ID, mm.[Employee Name],mm.[Date],mm.Interval,Shift_check, ss.KPI_Target,ss.Targets,ss.Actual_SL,ss.Forecasted_SL,
ss.kpi_Final_Rating,ss.Forecast_Final_rating 
from
(
Select aa.Account_ID, aa.[Employee Name],aa.[Date], aa.Interval, aa.Emp_ID,aa.Shift_24,
aa.Night_Check1,aa.Night_Check2 ,
aa.Night_Check3,
case when aa.Shift_24 = 'OK' and aa.Night_Check1 = 'Not_OK' and aa.Night_Check2='Not_OK' and aa.Night_Check3='Not_OK'  then 1
when aa.shift_24='Not_OK' and aa.Night_Check1 = 'OK' and aa.Night_Check2='Not_OK' and aa.Night_Check3 ='OK' then 1
When aa.shift_24 = 'Not_OK' and aa.Night_Check1 = 'Not_OK' and aa.Night_Check2='OK' and aa.Night_Check3 ='OK' then 1 else 0 
end as 'Shift_Check'

from (

 Select ip.Account_ID,ip.Account,Actual_SL,ip.Forecasted_SL,ip.[Date],convert(char(19),Interval,108) as Interval,
 nn.emp_ID, 
 nn.[Employee Name],
 case when convert(char(19),Interval,108) >= convert(char(19),nn.shift_login,108)  and convert(char(19),Interval,108) <  convert(char(19),nn.Shift_Logout,108) then 'OK' else 'Not_OK' end as 'Shift_24' ,
 case when convert(char(19),nn.Shift_Login,108)>='15:00'  and convert(char(19),Interval,108) >= convert(char(19),nn.shift_login,108) and convert(char(19),nn.Shift_Logout,108)<='09:00' then 'OK' else 'Not_OK' end as 'Night_Check1',
 case when convert(char(19),Interval,108) < convert(char(19),nn.shift_logout,108) and convert(char(19),nn.Shift_Logout,108)<='09:00' and convert(char(19),nn.Shift_Logout,108)< convert(char(19),nn.Shift_Login,108) then 'OK' else 'Not_OK' end as 'Night_Check2',
 case when convert(char(19), nn.Shift_Logout,108)< convert(char(19),nn.Shift_Login,108) then 'OK' else 'Not_OK' end as 'Night_Check3'
 --case when convert(char(19),Interval,108) >= convert(char(19),nn.shift_login,108) and convert(char(19),Interval,108) >=  convert(char(19),nn.Shift_Logout,108) then 'OK' else 'Not_OK' end as 'Shiit_Post_24'
     
   from Interval_Performance ip
left join 
(Select sc.*,am.Account_Code_1 ,am.account_1_Start_Date,am.account_1_end_Date,pkd.KPI_Target,pkd.Targets

 
 from Shift_check sc  left join 

Account_Mapping am on am.ECN = sc.Emp_ID
left join Pacman_KPI_Details pkd on pkd.[Code No] = am.Account_Code_1 Where  Shift_Date >= am.account_1_start_Date   and  Shift_Date <= am.account_1_end_Date) nn on nn.Account_Code_1 = ip.Account_ID where nn.shift_Date = ip.Date) aa where month(aa.[date]) = MONTH('01-Nov-2015')
) mm  

 left join 
 (Select fin.*,

case when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1 /100) then 5
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band2/100) then 4
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band3 / 100) then 3
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1/100) then 2
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= 100 then 1
      else 0 end as 'KPI_Final_Rating',
      
      case when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band1 /100) and fin.Actual_SL < fin.Targets  then 1
      when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band2/100) and  fin.Actual_SL < fin.Targets  then 2
      when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band3 / 100) and fin.Actual_SL < fin.Targets  then 3 
       when fin.Actual_SL > fin.forecasted_sl and fin.Actual_SL <= (fin.Band1/100) and  fin.Actual_SL < fin.Targets  then 4
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1 /100)  then 5
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band2/100)  then 4
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band3 / 100) then 3
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= (fin.Band1/100) then 2
      when fin.Actual_SL > fin.Targets and fin.Actual_SL <= 100 then 1
      
       else 0 end as 'Forecast_Final_Rating'
      from


(Select pa.Account_ID,pa.Account,pa.LOB,pa.region,pa.[date],pa.Interval,
pa.Actual_SL,
pa.forecasted_sl,KPI_Target, 
Targets,
case when pa.actual_SL >= pa.Targets then round((100- (Targets*100))/ 5,0)
When pa.Actual_SL < pa.targets and pa.Actual_SL  < pa.forecasted_sl then 0
When pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then round((((pa.Targets *100) - (pa.forecasted_sl *100)) / 4),0)
  end as 'Band',
  
case when pa.actual_SL > pa.Targets then 'KPI_Target_Met' 
When pa.Actual_SL < pa.targets and pa.Actual_SL > pa.forecasted_sl then 'Forecast Met'
When pa.Actual_SL < pa.targets and pa.Actual_SL < pa.forecasted_sl then 'Not_Met' end as 'Status',


case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.2),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then (pa.forecasted_sl*100)+  round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .25),0)

  end as 'Band1',
case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.4),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then (pa.forecasted_sl*100)+ round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .5),0)
  end as 'Band2',
case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.6),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then (pa.forecasted_sl*100)+ round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .75),0)  end as 'Band3',
case when pa.actual_SL >= pa.Targets then  (Targets *100) + round(((100- (Targets*100))* 0.8),0)
when pa.Actual_SL < pa.targets and pa.Actual_SL  >= pa.forecasted_sl then round((pa.forecasted_sl*100)+ round((((pa.Targets *100) - (pa.forecasted_sl *100)) * .75),0),0)
  end as 'Band4'

from (

Select IP.*, [KPI_Target],[Targets] from Interval_Performance IP

left join pacman_KPI_Details PKD on ip.Account_ID = pkd.[Code No]) pa) fin ) ss on mm.Account_ID = ss.Account_ID
where  ss.[Date] = mm.[Date] and convert(char(19),mm.Interval,108) = convert(char(19),ss.Interval,108)
and mm.shift_check = '1' )era where Emp_ID=@EMP_ID group by era.emp_id
-- and ss.Date = '20151101'

GO
/****** Object:  StoredProcedure [dbo].[Populate_WAR_ROOMDATA_NORMALISED]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Populate_WAR_ROOMDATA_NORMALISED]
As
BEGIN
	DECLARE @xColumns as varchar(max)=''
	DECLARE @xColumns2 as varchar(max)='' 
	DECLARE @xColumn as varchar(max)=''
	DECLARE @xColumn2 as varchar(max)=''
	DECLARE @xSQL as varchar(max)=''

	SELECT @xColumns =  @xColumns + ', ' + QUOTENAME([COLUMN_NAME])
	FROM CWFM_UMANG.INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = N'XDEL'
	AND [COLUMN_NAME] in ('Code No','CLIENT ID/NAME(COR)','Campaign(ROC)','Facility(ROC)','Sub Region(Capman)','Region(Capman)','ROC Planner(ROC)','ROC Manager(ROC)','Reporting Manager','Run Week','File Name','as LOB','Actual week','Month','Probable Root Causes (Staffing)','Probable Root Causes (Forecasting)','ESSBASEID','LOCID','ClientName','Region','Sub_Region')
	ORDER BY ORDINAL_POSITION

	Set @xColumns = right(@xColumns,LEN(@xColumns)-2)
	--select @xColumns

	DECLARE xCursor CURSOR FOR  
	SELECT COLUMN_NAME
			FROM CWFM_UMANG.INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = N'XDEL'
			AND [COLUMN_NAME] Not in ('Code No','CLIENT ID/NAME(COR)','Campaign(ROC)','Facility(ROC)','Sub Region(Capman)','Region(Capman)','ROC Planner(ROC)','ROC Manager(ROC)','Reporting Manager','Run Week','File Name','as LOB','Actual week','Month','Probable Root Causes (Staffing)','Probable Root Causes (Forecasting)','ESSBASEID','LOCID','ClientName','Region','Sub_Region')
			ORDER BY ORDINAL_POSITION

	OPEN xCursor   
	FETCH NEXT FROM xCursor INTO @xColumn   

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
			Set @xColumn2 = QUOTENAME(ltrim(rtrim(@xColumn)));
			set  @xColumns2 = @xColumns +', ''' + replace(ltrim(rtrim(replace(@xColumn,'''','`'))),' ','_') + ''' AS [xType], ' + @xColumn2 + ' as [xVAL]'

			SEt @xSQL = 'UPDATE CWFM_UMANG..XDEL SET '+ @xColumn2 +' = '
			SEt @xSQL = @xSQL + 'case when '+ @xColumn2 +' not like N''%[^0-9.]%'' and '+ @xColumn2 +' not like N''%.%.%'' and '+ @xColumn2 +' not like ''.'' then ' + @xColumn2 + ' else NULL end'
			EXECUTE(@xSQL)

			set  @xColumns2 = 'INSERT INTO [CWFM_UMANG]..[WAR_ROOMDATA_NORMALISED] SELECT '+ @xColumns2 +' FROM CWFM_UMANG..XDEL'
			--set  @xColumns2 = @xColumns2 + ' where [code no]=1205'
			--set  @xColumns2 = @xColumns2 + ' and [MONTH]=''20160901'''

			--set @xColumns2 = replace(@xColumns2,'''','`')
			--print @xColumn2
			execute(@xColumns2)

		   FETCH NEXT FROM xCursor INTO @xColumn   
	END   

	CLOSE xCursor   
	DEALLOCATE xCursor 
END


GO
/****** Object:  StoredProcedure [dbo].[Rand_Question]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rand_Question]
AS 
BEGIN
	SELECT *,NEWID() NID 
	FROM (
			SELECT TOP 10 *  FROM QUESTIONBANK 
			WHERE Q_SEGMENT = 'APTITUDE' ORDER BY NEWID() DESC 
			UNION ALL
			SELECT TOP 10 *  FROM QUESTIONBANK 
			WHERE Q_SEGMENT = 'RTA' ORDER BY NEWID() DESC 
			UNION ALL
			SELECT TOP 10 * FROM QUESTIONBANK 
			WHERE Q_SEGMENT = 'WFC' ORDER BY NEWID() DESC
			UNION ALL
			SELECT TOP 10 * FROM QUESTIONBANK 
			WHERE Q_SEGMENT = 'PLANNING' ORDER BY NEWID() DESC
			UNION ALL
			SELECT TOP 10 * FROM QUESTIONBANK 
			WHERE Q_SEGMENT = 'SCHEDULING' ORDER BY NEWID() DESC
			UNION ALL
			SELECT TOP 10 *  FROM QUESTIONBANK 
			WHERE Q_SEGMENT = 'ANALYTICS' ORDER BY NEWID() DESC 
		)A ORDER BY  NID DESC 
END
GO
/****** Object:  StoredProcedure [dbo].[Rating_by_KPI]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Rating_by_KPI]
@ECN as NVARCHAR(250),
@Sel_Month as NVARCHAR(250)
AS
Select col, Value as Rating from ( 
SELECT * FROM (
SELECT t.E_ECN, t.Eval_Date,
t.SC_KPI,
t.SC_Optimisation,
t.SC_Team_Player,
t.SC_Absenteeism,
t.SC_Communication,
t.SC_Reporting,
t.SC_Analysis
FROM master_rating AS t ) AS SourceTable UNPIVOT ( Value FOR Col 
IN (SC_KPI,SC_Optimisation,SC_Team_Player,SC_Absenteeism,SC_Communication,SC_Reporting,SC_Analysis) ) AS unpvt)a 
where E_ECN  = @ECN
and left(Datename(m,Eval_Date),3)+ ' ' + (Datename(YEAR,Eval_Date)) =@Sel_Month

GO
/****** Object:  StoredProcedure [dbo].[RATINGBYKPI]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RATINGBYKPI]
@ECN as NVARCHAR(250),
@Sel_Month as NVARCHAR(250)
AS
Select col, Value as Rating from ( 
SELECT * FROM (
SELECT t.E_ECN, t.Eval_Date,
t.SC_KPI,
t.SC_Optimisation,
t.SC_Team_Player,
t.SC_Absenteeism,
t.SC_Communication,
t.SC_Reporting,
t.SC_Analysis
FROM master_rating AS t ) AS SourceTable UNPIVOT ( Value FOR Col 
IN (SC_KPI,SC_Optimisation,SC_Team_Player,SC_Absenteeism,SC_Communication,SC_Reporting,SC_Analysis) ) AS unpvt)a 
where E_ECN  = @ECN
and left(Datename(m,Eval_Date),3)+ ' ' + (Datename(YEAR,Eval_Date)) =@Sel_Month
GO
/****** Object:  StoredProcedure [dbo].[RCA_GLOBAL]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[RCA_GLOBAL]
@region as varchar(max)

as

Select RCA,sum(amt) from upload2
where region = @Region
group by rca
GO
/****** Object:  StoredProcedure [dbo].[RCA_GLOBAL_ALL]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[RCA_GLOBAL_ALL] 

  
as  
  
Select RCA,sum(amt) from upload2  
group by rca


GO
/****** Object:  StoredProcedure [dbo].[rca_opportunity]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[rca_opportunity]
@account_name as varchar(max)

as
(

select  Account_name, RCA, SUM(Opp)   from warroom_opportunity

where [Month] in ('Feb','Mar','Apr','May','Jun') and Account_name =@account_name
group by  Account_name, RCA

)
GO
/****** Object:  StoredProcedure [dbo].[RCA_Opportunity_Data]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[RCA_Opportunity_Data]

@War_Room_ID int

as

select * from RCA_data where War_Room_ID=@War_Room_ID

GO
/****** Object:  StoredProcedure [dbo].[Review]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Review]

(
       @CLIENTNAME AS VARCHAR(max),
       @LOB NVARCHAR(MAX)
)
AS
BEGIN
BEGIN TRY
              DECLARE @WeekDate AS VARCHAR(MAX)=''
              DECLARE @xSQL AS VARCHAR(MAX)=''


              IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
              BEGIN
                 DROP TABLE #TEMPTABLE
              END
              
              SELECT DISTINCT WC_Date WC_Date INTO #TEMPTABLE
              FROM Review_table 
              WHERE WC_Date BETWEEN getdate()-70 and getdate()
              AND Client_Name = @CLIENTNAME
              AND [LOB Name] = @LOB
              ORDER BY WC_Date ASC
       
              SELECT @WeekDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[WC_Date],106),' ','-') + '],' + @WeekDate
              FROM #TEMPTABLE TP

              IF LEFT(@WeekDate,1) = ','
              BEGIN
                     SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
              END

              IF RIGHT(@WeekDate,1) = ','
              BEGIN
                     SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
              END
              
	
			drop table review_output
              SET @xSQL = 'Select * into review_output from
                     (Select *
                           FROM
                           (SELECT distinct NAME
                           ,[Question ID]
                           ,WC_Date FROM Review_table
                           where wc_date between getdate()-70 and getdate()
                           AND Client_Name = ''' + @CLIENTNAME +'''
                           AND [LOB Name] = ''' + @LOB +'''
                     ) AS S
                     PIVOT
                     (
                           Count([Question ID]) 
                           FOR WC_Date IN ('+ @WEEKDATE +')
                     )AS PVT)z'
                     
              --print @xSQL
              EXEC(@xSQL)
       
              select * from review_output
              --DROP TABLE TEMPTABLE
       END TRY
       BEGIN CATCH
            Select 'No record(s) found...' RESULT
       /*
            SELECT ERROR_NUMBER() AS ERRORNUMBER
            ,ERROR_SEVERITY() AS ERRORSEVERITY
            ,ERROR_STATE() AS ERRORSTATE
            ,ERROR_PROCEDURE() AS ERRORPROCEDURE
            ,ERROR_LINE() AS ERRORLINE
            ,ERROR_MESSAGE() AS ERRORMESSAGE;
            */
       END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[Review_Leave]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Review_Leave]    
@SUP_ECN NVARCHAR(250)    
AS    
Select    
ROW_NUMBER() OVER (ORDER BY Request_No) AS [Sr No],
isnull(Emp_ID,0) as Emp_ID,
isnull(Emp_name,'') as Emp_name,
isnull(Supervisor,'') as Supervisor,
isnull(Dept,'')as Dept,
isnull(Title,'') as Title,
isnull(Leave_Type,'') as Leave_Type,
isnull(Request_No,'') as Request_No,
isnull(Request_Date,'19000101') as Request_Date,
isnull([Start_Date],'19000101') as [Start_Date],
isnull(End_Date,'19000101')as End_Date,
isnull(WeekOff,'') as WeekOff,
isnull(No_of_Days,'') as No_of_Days,
isnull(Leave_Status,'') as Leave_Status,
isnull(Description,'') as Description,
isnull(Supevisor_Comment,'') as Supevisor_Comment,
isnull(Week_Before,'') as Week_Before,
isnull(Days_Before,'') as Days_Before,
isnull(Leave_Segment,'') as Days_Before,
isnull(Email,'') as Email,
isnull(Supervison_ECN,'')as Supervison_ECN,
isnull(sup_dept,'') as sup_dept,
isnull(Supervisor_Designation,'') as Supervisor_Designation    
from user_leave_Request    
where Leave_Status='Pending' and Supervison_ECN = @SUP_ECN  
  
GO
/****** Object:  StoredProcedure [dbo].[Review_Leave_Approved]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Review_Leave_Approved]    
(  
@SUP_ECN NVARCHAR(250)
)  
AS      
Select      
ROW_NUMBER() OVER (ORDER BY Request_No) AS [Sr No],      
* from user_leave_Request      
where Leave_Status='Approved' and 
Supervison_ECN = @SUP_ECN  AND
'"& roster.lbl_day1.caption &"' between [Start_Date] and [End_Date]
GO
/****** Object:  StoredProcedure [dbo].[Review_Leave_Approved_Leave_tracker]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Review_Leave_Approved_Leave_tracker]  
(      
@SUP_ECN NVARCHAR(250)    
)      
AS          
Select          
ROW_NUMBER() OVER (ORDER BY Request_No) AS [Sr No],
isnull(Emp_ID,0) as Emp_ID,
isnull(Emp_name,'') as Emp_name,
isnull(Supervisor,'') as Supervisor,
isnull(Dept,'')as Dept,
isnull(Title,'') as Title,
isnull(Leave_Type,'') as Leave_Type,
isnull(Request_No,'') as Request_No,
isnull(Request_Date,'19000101') as Request_Date,
isnull([Start_Date],'19000101') as [Start_Date],
isnull(End_Date,'19000101')as End_Date,
isnull(WeekOff,'') as WeekOff,
isnull(No_of_Days,'') as No_of_Days,
isnull(Leave_Status,'') as Leave_Status,
isnull(Description,'') as Description,
isnull(Supevisor_Comment,'') as Supevisor_Comment,
isnull(Week_Before,'') as Week_Before,
isnull(Days_Before,'') as Days_Before,
isnull(Leave_Segment,'') as Days_Before,
isnull(Email,'') as Email,
isnull(Supervison_ECN,'')as Supervison_ECN,
isnull(sup_dept,'') as sup_dept,
isnull(Supervisor_Designation,'') as Supervisor_Designation    
from user_leave_Request
where Leave_Status='Approved' and     
Supervison_ECN = @SUP_ECN
GO
/****** Object:  StoredProcedure [dbo].[Search_Warrom_For_Glidepath]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Search_Warrom_For_Glidepath]

@War_Room_Acc  Varchar(max)



as

Begin

	if (ltrim(rtrim(isnull(@War_Room_Acc,''))) = '')

	BEGIN

		set @War_Room_Acc = 'xxxxxxxxxxxxx'

	END



	Select distinct WR.War_Room_ID,WR.Client_Name,WR.Region,cl.[Location_ Name] as Location, WR.War_Room_Status,WR.[Start_Date] ,WR.End_Date ,WR.LOB_Name

	from War_Room WR Left join CLIENT_LOC CL on WR.Loc_Code = CL.Location_Code

 

	Where Client_Name like '%'+@War_Room_Acc+'%'

END







GO
/****** Object:  StoredProcedure [dbo].[Search_Warroom_by_Account]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Search_Warroom_by_Account]
@Account_Name Varchar(max)
as
(Select WR.Client_Name,Revenue,Budget,[Over/Under],[Over/Under], Start_Date,
   DATEDIFF(day,Start_Date,getdate()) AS DiffDate
  
   from War_Room wr
 where wr.client_name like '%'+@Account_Name+'%')
GO
/****** Object:  StoredProcedure [dbo].[Shift_swap]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Shift_swap]

@scheduledate date,
@empl1 varchar(255)

as 
Select Shift_Time from 
(
SELECT tt.*
FROM new_roster_entry AS tt
INNER JOIN
    (SELECT ECN, MAX(upload_date) AS MaxDateTime
    FROM new_roster_entry
    GROUP BY ECN) groupedtt 
ON tt.ECN = groupedtt.ECN 
AND tt.upload_date = groupedtt.MaxDateTime
)a
where Schedule_Date = @scheduledate
and Name in(@empl1)


GO
/****** Object:  StoredProcedure [dbo].[Shift_Swap_Submit]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Shift_Swap_Submit]

@Shift1 as varchar(max),
@scheduledate as date,
@name as varchar(max)
as 

Update  New_Roster_Entry set Shift_Time = @Shift1
where Name = @name
and Schedule_Date = @scheduledate
GO
/****** Object:  StoredProcedure [dbo].[Shift_swap1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Procedure [dbo].[Shift_swap1]

@scheduledate date,
@empl2 varchar(255)

as 
Select Shift_Time from 
(
SELECT tt.*
FROM new_roster_entry AS tt
INNER JOIN
    (SELECT ECN, MAX(upload_date) AS MaxDateTime
    FROM new_roster_entry
    GROUP BY ECN) groupedtt 
ON tt.ECN = groupedtt.ECN 
AND tt.upload_date = groupedtt.MaxDateTime
)a
where Schedule_Date = @scheduledate
and Name in(@empl2)

GO
/****** Object:  StoredProcedure [dbo].[sp_AC_Per_Char_morris]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_AC_Per_Char_morris]
	@operation varchar(20)=NULL,
	@Primary_Client_Name varchar(50)=NULL,
	@MBU_Code varchar(50) = NULL,
	@Date SmallDateTime = Null 
AS
BEGIN

    If @operation='SL'
	   Begin
			Select A.Time_Period AS name
			, Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y

			From (

            Select A.Primary_Client_ID
			, A.Primary_Client_Name as account
			, A.MBU_Code as LOB
			, A.MBU_Description
			, A.Date
			, A.Time_Period 
			, A.Acceptable_Calls
			, A.Calls_Offered
  			from TBL_SKILLS_DATA A
			where 1=1 
			--And A.Primary_Client_Name = @Primary_Client_Name 
			--And A.MBU_Code=@MBU_Code 
			--And A.Date=@Date 
			And A.Primary_Client_Name = 'Citizens Bank'
			And A.MBU_Code='Citizens Bank CS' 
			And A.Date='20160901' 


			And A.Calls_Offered<>0
			
			) as A
			Group BY A.Date
			, A.Time_Period 
			--Having a.Time_Period is not null
			--Order by Time_Period
	   End     
   


    If @operation='line'
	   Begin
			Select Top 20 Time_Period AS row_value, SUM(A.Acceptable_Calls) AS column_value
			From (
				   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period  , A.Acceptable_Calls , A.Calls_Offered
						---, 100*case when  isnull(A.Calls_Offered,0) <> 0 then isnull(A.Acceptable_Calls,0) / isnull(A.Calls_Offered,0) else 0 end as SL
  				   from TBL_SKILLS_DATA A where 1=1 
					--and A.Primary_Client_Name = @Primary_Client_Name and A.MBU_Code=@MBU_Code and A.Date=@Date And A.Calls_Offered<>0
					) as A
					Group BY A.Time_Period 
					Having a.Time_Period is not null
					Order by Time_Period DESC
	   End     

   
    If @operation='bar'
	   Begin
			Select Top 20 Time_Period AS row_value, SUM(A.Acceptable_Calls) AS column_value,SUM(A.Acceptable_Calls) + 10 AS column_value2
			From (
				   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period  , A.Acceptable_Calls , A.Calls_Offered
						---, 100*case when  isnull(A.Calls_Offered,0) <> 0 then isnull(A.Acceptable_Calls,0) / isnull(A.Calls_Offered,0) else 0 end as SL
  				   from TBL_SKILLS_DATA A where 1=1 
					--and A.Primary_Client_Name = @Primary_Client_Name and A.MBU_Code=@MBU_Code and A.Date=@Date And A.Calls_Offered<>0
					) as A
					Group BY A.Time_Period 
					Having a.Time_Period is not null
					Order by Time_Period DESC
	   End      
		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_AC_Per_Chart]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_AC_Per_Chart]
	@operation varchar(50)=NULL,
	@Primary_Client_Name varchar(50)=NULL,
	@MBU_Code varchar(50) = NULL,
	@Date datetime = NULL, 
	@Month varchar(20)=NULL,
	@WKDrill int=0,
	@DName varchar(20)=NULL
AS
BEGIN

    
	DECLARE @SDATE SMALLDATETIME = left(CONVERT(VARCHAR,@Date,112),6) + '01';
	DECLARE @EDATE SMALLDATETIME = DATEADD(m,1,left(CONVERT(VARCHAR,@Date,112),6) + '01') - 1

	Declare @AccountPara nvarchar(max)
	Declare @FTE_AccountPara nvarchar(max)
	Declare @CodePara nvarchar(max)
	Declare @MonthPara nvarchar(max)
	Declare @DNamePara nvarchar(max)
	Declare @SqlString nvarchar(max)  
	
	Select @SqlString=''
	Select @AccountPara =''
	Select @FTE_AccountPara=''
	Select @CodePara =''
	Select @MonthPara =''
	Select @DNamePara=''
	  
	
	if @Primary_Client_Name <> '0' and isnull(@Primary_Client_Name,'') <> ''  Select @AccountPara= ' AND A.Primary_Client_Name=''' + @Primary_Client_Name + ''''
	if @Primary_Client_Name <> '0' and isnull(@Primary_Client_Name,'') <> ''  Select @FTE_AccountPara= ' AND A.Project_Name=''' + @Primary_Client_Name + ''''
	if @MBU_Code <> '0' and isnull(@MBU_Code,'') <> ''  Select @CodePara= ' AND A.MBU_Code=''' + @MBU_Code + ''''
    if @Month <> '0' and isnull(@Month,'') <> ''  Select @MonthPara= ' AND DATENAME(MONTH,A.Date)=''' + @Month + ''''
	if @DName <> '0' and isnull(@DName,'') <> ''  Select @DNamePara= ' AND DATENAME(DW,A.Date)=''' + @DName + ''''


	---------------------------Gurdeep TimePass Start----------------------------------------

	If Right(@operation,4)='YEAR'
	Begin
		Select @SqlString = 'Select Left(DATENAME(MONTH,A.Date),3) + '' '+ Right(CONVERT(VARCHAR,year(@Date)),2) +''' AS name , 
							 Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
							 From ( 
									Select A.Primary_Client_ID, A.Primary_Client_Name as account , 
									A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, 
									A.Acceptable_Calls , A.Calls_Offered
  									From   TBL_SKILLS_DATA A
									Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											AND Year(A.Date) = ''' + CONVERT(VARCHAR,year(@Date)) + '''
									) as A 
									Group BY MONTH(A.Date),DATENAME(MONTH,A.Date)
									Order By MONTH(A.Date)'

        -------------------------------- For Avg. Summary
        --Select @SqlString = @SqlString +  '  Select Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
								--From ( 
								--	Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  						--			From   TBL_SKILLS_DATA A
								--	Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
								--			AND Year(A.Date) = ''' + CONVERT(VARCHAR,year(@Date)) + '''
								--	) as A'
									   
	End 

	---------------------------Gurdeep TimePass End----------------------------------------


    -------------------------------------------          FOR SL            -------------------------------------------
    ------------------------------------------- SL Year For Selected Date  -------------------------------------------
    If @operation='SL_YEAR'
	   Begin
			Select @SqlString = 'Select Left(DATENAME(MONTH,A.Date),3) + '' '+ Right(CONVERT(VARCHAR,year(@Date)),2) +''' AS name , Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
								 From ( 
									   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  									   From   TBL_SKILLS_DATA A
									   Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											  AND Year(A.Date) = ''' + CONVERT(VARCHAR,year(@Date)) + '''
									   ) as A 
									   Group BY MONTH(A.Date),DATENAME(MONTH,A.Date)
									   Order By MONTH(A.Date)'

            -------------------------------- For Avg. Summary
            Select @SqlString = @SqlString +  '  Select Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
								 From ( 
									   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  									   From   TBL_SKILLS_DATA A
									   Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											  AND Year(A.Date) = ''' + CONVERT(VARCHAR,year(@Date)) + '''
									   ) as A'
									   
	   End     

       
  	------------------------------------------- SL Month For Selected Date  -------------------------------------------
    If @operation='SL_MONTH'
	   Begin
		    Select @SqlString = 'Select  Left(DATENAME(MONTH,A.Date),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,A.Date)) AS name , Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
								 From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											   AND A.Date BETWEEN '''+ convert(varchar,@SDATE,106) +''' AND  '''+ convert(varchar,@EDATE,106) +'''
											   ' + @MonthPara + '
										) as A 
										Group BY Date
										Order By Date'	
										
										--print @SqlString			  
	   End           
	
		
	------------------------------------------- SL For Selected Date  -------------------------------------------
	If @operation='SL_DAY'
		   Begin
		      if @WKDrill = 1 Select @Date = xDate From [xGetWeekDates] (@Date,0,'d') WHERE DATENAME(DW,xDate)=@Month
			  if @WKDrill = 2 Select @Date = CONVERT(DATETIME,@Month)--[dbo].[xGetDayDate] (@Date,@DName,@Month)
		      
			  Select @SqlString = 'Select  LEFT(Time_Period,5) AS name , Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
									From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '  AND A.Date=''' + CONVERT(VARCHAR,@Date,106) + '''
										) as A 
										Group BY Time_Period
										Order By Time_Period'		  
		   End   
	
	   
	------------------------------------------- SL Week For Selected Date  -------------------------------------------
	If @operation='SL_WEEK'
		   Begin
			    Select @SqlString = 'Select  Left(DATENAME(MONTH,A.Date),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,A.Date)) +'' ''+ LEFT(DATENAME(DW,A.Date),3) AS name , Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
									 From ( 
											Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  											From   TBL_SKILLS_DATA A
											Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
													AND  A.Date BETWEEN dbo.GetWeekStartEndFromDate(''' + CONVERT(VARCHAR,@Date,106) + ''',''S'',1) 
													and dbo.GetWeekStartEndFromDate(''' + CONVERT(VARCHAR,@Date,106) + ''',''E'',1) 
											) as A 
											Group BY A.Date
											Order By A.Date'	
												  
		   End     
	   
	  
	------------------------------------------- SL Week For Selected Date  -------------------------------------------
	If @operation='SL_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select  CONVERT(VARCHAR,Date,106) as name,y,drilldown From (Select   A.Date,DATENAME(DW,A.Date) AS name , Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
									 From ( 
											Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  											From   TBL_SKILLS_DATA A
											Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											       AND DATEPART(YEAR,A.Date) = DATEPART(YEAR,''' + CONVERT(VARCHAR,@Date,106)  + ''')
													' + @DNamePara + '
											) as A 
											Group BY A.Date
											)AS ST ORDER BY Date ASC'				  

											--AND  A.Date <= ''' + CONVERT(VARCHAR,@Date,106)  + '''
		   End 








    -------------------------------------------          FOR ABDN            ------------------------------------------- 
	------------------------------------------- ABDN Year For Selected Date: Done----------------------------------------
    If @operation='ABDN_YEAR'
	   Begin
			Select @SqlString = 'Select DATENAME(MONTH,A.Date) AS name , ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2)  AS y,''true'' as drilldown
								 From ( 
									   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , 
									   A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  									   From   TBL_SKILLS_DATA A
									   Where  1=1 And A.Calls_Offered >0' + @AccountPara + @CodePara + '
											  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
											  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ) as A 
									   Group BY MONTH(A.Date),DATENAME(MONTH,A.Date)
									   Order By MONTH(A.Date)'
	   End     

   
    
	------------------------------------------- ABDN Month For Selected Date: Done---------------------------------------
    If @operation='ABDN_MONTH'
	   Begin
		    Select @SqlString = 'Select  Left(DATENAME(MONTH,A.Date),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,A.Date)) AS name , ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
								 From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered>0' + @AccountPara + @CodePara + '
											   AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
											   AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
											   ' + @MonthPara + '
										) as A 
										Group BY Date
										Order By Date'				  
	   End           
	

	
	------------------------------------------- ABDN For Selected Date: Done---------------------------------------
	If @operation='ABDN_DAY'
		   Begin
		      if @WKDrill = 1 Select @Date = xDate From [xGetWeekDates] (@Date,0,'d') WHERE DATENAME(DW,xDate)=@Month
			  if @WKDrill = 2 Select @Date = CONVERT(DATETIME,@Month) --[dbo].[xGetDayDate] (@Date,@DName,@Month)
		      
			  Select @SqlString = 'Select  LEFT(Time_Period,5) AS name , ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y
									From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered >0' + @AccountPara + @CodePara + '  AND A.Date=''' + CONVERT(VARCHAR,@Date,106) + '''
										) as A 
										Group BY Time_Period
										Order By Time_Period'		  
		   End   
	   
	  
	 ------------------------------------------- ABDN Week For Selected Date: Done-----------------------------------
	 If @operation='ABDN_WEEK'
		   Begin
			    Select @SqlString = 'Select  DATENAME(DW,A.Date) AS name , ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
									 From ( 
											Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  											From   TBL_SKILLS_DATA A
											Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
													AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
													AND A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
											) as A 
											Group BY A.Date
											Order By A.Date'				  
		   End     
	   
  	
	  
	 ------------------------------------------- ABDN Week For Selected Date: Done---------------------------------------
	 If @operation='ABDN_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select CONVERT(VARCHAR,Date,106) as name,y,drilldown 
									 From (
										  Select  A.Date,DATENAME(DW,A.Date) AS name, ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
										  From ( 
											  Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  											  From   TBL_SKILLS_DATA A
											  Where  1=1 And A.Calls_Offered >0' + @AccountPara + @CodePara + '
													 AND DATEPART(YEAR,A.Date) = DATEPART(YEAR,''' + CONVERT(VARCHAR,@Date,106)  + ''')
													 ' + @DNamePara + '
											  ) as A 
												GROUP BY A.Date
											) AS ST ORDER BY Date ASC'			  
		   End








      -------------------------------------------          FOR AHT            -------------------------------------------
	  ------------------------------------------- AHT Year For Selected Date  -------------------------------------------
      If @operation='AHT_YEAR'
	   Begin
			Select @SqlString = 'SELECT DATENAME(MONTH,A.Date) AS name,ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y,''true'' as drilldown
								 FROM (
								      SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									  FROM   TBL_SKILLS_DATA A 
									  WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
									  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
									  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
								 ) AS A
								 GROUP BY MONTH(A.Date),DATENAME(MONTH,A.Date)
								 Order By MONTH(A.Date)'
	   End   


	  ------------------------------------------- AHT Month For Selected Date  -------------------------------------------
      If @operation='AHT_MONTH'
	   Begin
			Select @SqlString = 'SELECT Left(DATENAME(MONTH,A.Date),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,A.Date)) AS name, ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y,''true'' as drilldown
								 FROM (
								      SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									  FROM   TBL_SKILLS_DATA A 
									  WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
									  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
									  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ' + @MonthPara + '
								 ) AS A
								 GROUP BY Date
								 Order By Date'
	   End   


	  ------------------------------------------- AHT Day For Selected Date  -------------------------------------------
      If @operation='AHT_DAY'
	   Begin
	        if @WKDrill = 1 Select @Date = xDate From [xGetWeekDates] (@Date,0,'d') WHERE DATENAME(DW,xDate)=@Month
			if @WKDrill = 2 Select @Date = CONVERT(DATETIME,@Month) --[dbo].[xGetDayDate] (@Date,@DName,@Month)

			Select @SqlString = 'SELECT LEFT(Time_Period,5) AS name, ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y
								 FROM (
								      SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									  FROM   TBL_SKILLS_DATA A 
									  WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '  AND A.Date=''' + CONVERT(VARCHAR,@Date,106) + '''
								 ) AS A
								 GROUP BY Time_Period
								 Order By Time_Period'
	   End   

      
	  ------------------------------------------- AHT Week For Selected Date: Done-----------------------------------
	  If @operation='AHT_WEEK'
		   Begin
			    Select @SqlString = 'Select  DATENAME(DW,A.Date) AS name , ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y,''true'' as drilldown
									 From ( 
										   SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									       FROM   TBL_SKILLS_DATA A 
									       WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
												  AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
												  AND  A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
											) as A 
											Group BY A.Date
											Order By A.Date'				  
		   End     

       
	  ------------------------------------------- AHT Week For Selected Date: Done---------------------------------------
	  If @operation='AHT_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select CONVERT(VARCHAR,Date,106) as name,y,drilldown 
									 From (
				                           Select A.Date,DATENAME(DW,A.Date) AS name, ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y,''true'' as drilldown
									       From ( 
											   SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
											   FROM   TBL_SKILLS_DATA A 
											   WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
													  AND DATEPART(YEAR,A.Date) = DATEPART(YEAR,''' + CONVERT(VARCHAR,@Date,106)  + ''')
													  ' + @DNamePara + '
												) as A 
												GROUP BY A.Date
											) AS ST ORDER BY Date ASC'				  
		   End






      -------------------------------------------          FOR FTE            -------------------------------------------
	  --------------------------------------------- FTE Year For Selected Date  -------------------------------------------
      If @operation='FTE_YEAR'
	   Begin
	     Select @SqlString ='SELECT DATENAME(MONTH,A.Date) AS name,ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y,''true'' as drilldown
					         FROM (
							       SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
						           FROM   TBL_AGENT_DATA A
						           WHERE  1 = 1' + @FTE_AccountPara + ' 
						           AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
						           AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + ''') + 1, -1),106)
							 ) AS A
					         GROUP BY MONTH(A.Date),DATENAME(MONTH,A.Date)
					         ORDER BY MONTH(A.Date)'
	   End   

	  
	   ------------------------------------------- AHT Month For Selected Date  -------------------------------------------
      If @operation='FTE_MONTH'
	   Begin
			Select @SqlString = 'SELECT Left(DATENAME(MONTH,A.Date),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,A.Date)) AS name, ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y,''true'' as drilldown
								 FROM (
								       SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
						               FROM   TBL_AGENT_DATA A
						               WHERE  1 = 1' + @FTE_AccountPara + '
									   AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
									   AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ' + @MonthPara + '
								 ) AS A
								 GROUP BY Date
								 Order By Date'
	   End   



	   ------------------------------------------- AHT Week For Selected Date: Done-----------------------------------
	  If @operation='FTE_WEEK'
		   Begin
			    Select @SqlString = 'Select  DATENAME(DW,A.Date) AS name , ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y,''true'' as drilldown
									 From ( 
										   SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
										   FROM   TBL_AGENT_DATA A
										   WHERE  1 = 1' + @FTE_AccountPara + '
									       AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
										   AND  A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
									 ) as A 
									 Group BY A.Date
									 Order By A.Date'				  
		   End     


       
	    ------------------------------------------- AHT Week For Selected Date: Done---------------------------------------
	  If @operation='FTE_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select CONVERT(VARCHAR,Date,106) as name,y,drilldown 
									 From (
				                           Select  A.Date,DATENAME(DW,A.Date) AS name,  ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y,''true'' as drilldown
									       From ( 
											     SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
											     FROM   TBL_AGENT_DATA A
											     WHERE  1 = 1' + @FTE_AccountPara + '
												 AND DATEPART(YEAR,A.Date) = DATEPART(YEAR,''' + CONVERT(VARCHAR,@Date,106)  + ''')
												 ' + @DNamePara + '
										   ) as A 
										   GROUP BY A.Date
										 ) AS ST ORDER BY Date ASC'				  
		   End



	  EXEC sp_executesql @SqlString
	  
	  --Print @SqlString    
	  
	  -- EXEC  [dbo].[sp_AC_Per_Chart] 'SL_LAST_DAYS','','','20160902','May',0,'Monday'

END
GO
/****** Object:  StoredProcedure [dbo].[sp_AC_Per_Chart_Summary]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_AC_Per_Chart_Summary]
	@operation varchar(50)=NULL,
	@Primary_Client_Name varchar(50)=NULL,
	@MBU_Code varchar(50) = NULL,
	@Date datetime = NULL, 
	@Month varchar(20)=NULL,
	@WKDrill int=0,
	@DName varchar(20)=NULL
AS
BEGIN

      
	Declare @AccountPara nvarchar(max)
	Declare @FTE_AccountPara nvarchar(max)
	Declare @CodePara nvarchar(max)
	Declare @MonthPara nvarchar(max)
	Declare @DNamePara nvarchar(max)
	Declare @SqlString nvarchar(max)  
	
	Select @SqlString=''
	Select @AccountPara =''
	Select @FTE_AccountPara=''
	Select @CodePara =''
	Select @MonthPara =''
	Select @DNamePara=''
	  
	
	if @Primary_Client_Name <> '0' and isnull(@Primary_Client_Name,'') <> ''  Select @AccountPara= ' AND A.Primary_Client_Name=''' + @Primary_Client_Name + ''''
	if @Primary_Client_Name <> '0' and isnull(@Primary_Client_Name,'') <> ''  Select @FTE_AccountPara= ' AND A.Project_Name=''' + @Primary_Client_Name + ''''
	if @MBU_Code <> '0' and isnull(@MBU_Code,'') <> ''  Select @CodePara= ' AND A.MBU_Code=''' + @MBU_Code + ''''
    if @Month <> '0' and isnull(@Month,'') <> ''  Select @MonthPara= ' AND DATENAME(MONTH,A.Date)=''' + @Month + ''''
	if @DName <> '0' and isnull(@DName,'') <> ''  Select @DNamePara= ' AND DATENAME(DW,A.Date)=''' + @DName + ''''





    -------------------------------------------          FOR SL            -------------------------------------------
    ------------------------------------------- SL Year For Selected Date  -------------------------------------------
    If @operation='SL_YEAR'
	   Begin
			Select @SqlString = 'Select Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
								 From ( 
									   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  									   From   TBL_SKILLS_DATA A
									   Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
											  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ) as A' 
	   End     

       
  	------------------------------------------- SL Month For Selected Date  -------------------------------------------
    If @operation='SL_MONTH'
	   Begin
		    Select @SqlString = 'Select  Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
								 From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
											   AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
											   AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
											   ' + @MonthPara + '
										) as A' 
										
	   End           
	
		
	------------------------------------------- SL For Selected Date  -------------------------------------------
	If @operation='SL_DAY'
		   Begin
		      if @WKDrill = 1 Select @Date = xDate From [xGetWeekDates] (@Date,0,'d') WHERE DATENAME(DW,xDate)=@Month
			  if @WKDrill = 2 Select @Date = CONVERT(DATETIME,@Month)--[dbo].[xGetDayDate] (@Date,@DName,@Month)
		      
			  Select @SqlString = 'Select Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
									From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '  AND A.Date=''' + CONVERT(VARCHAR,@Date,106) + '''
										) as A'		  
		   End   
	
	   
	------------------------------------------- SL Week For Selected Date  -------------------------------------------
	If @operation='SL_WEEK'
		   Begin
			    Select @SqlString = 'Select Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
									 From ( 
											Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  											From   TBL_SKILLS_DATA A
											Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
													AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
													AND A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
											) as A' 
											
		   End     
	   
	  
	------------------------------------------- SL Week For Selected Date  -------------------------------------------
	If @operation='SL_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select Round(100*(SUM(A.Acceptable_Calls)/Sum(A.Calls_Offered)),2) AS y
									 From ( 
											Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Acceptable_Calls , A.Calls_Offered
  											From   TBL_SKILLS_DATA A
											Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
													AND DATEPART(YEAR,A.Date) <= DATEPART(YEAR,GETDATE())
													' + @DNamePara + '
											) as A'

											--AND  A.Date <= ''' + CONVERT(VARCHAR,@Date,106)  + '''
		   End 








    -------------------------------------------          FOR ABDN            ------------------------------------------- 
	------------------------------------------- ABDN Year For Selected Date: Done----------------------------------------
    If @operation='ABDN_YEAR'
	   Begin
			Select @SqlString = 'Select ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2)  AS y
								 From ( 
									   Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  									   From   TBL_SKILLS_DATA A
									   Where  1=1 And A.Calls_Offered >0' + @AccountPara + @CodePara + '
											  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
											  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ) as A'
	   End     

   
    
	------------------------------------------- ABDN Month For Selected Date: Done---------------------------------------
    If @operation='ABDN_MONTH'
	   Begin
		    Select @SqlString = 'Select  ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y
								 From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered>0' + @AccountPara + @CodePara + '
											   AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
											   AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
											   ' + @MonthPara + '
										) as A'				  
	   End           
	

	
	------------------------------------------- ABDN For Selected Date: Done---------------------------------------
	If @operation='ABDN_DAY'
		   Begin
		      if @WKDrill = 1 Select @Date = xDate From [xGetWeekDates] (@Date,0,'d') WHERE DATENAME(DW,xDate)=@Month
			  if @WKDrill = 2 Select @Date = CONVERT(DATETIME,@Month) --[dbo].[xGetDayDate] (@Date,@DName,@Month)
		      
			  Select @SqlString = 'Select ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y
									From ( 
										Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  										From   TBL_SKILLS_DATA A
										Where  1=1 And A.Calls_Offered >0' + @AccountPara + @CodePara + '  AND A.Date=''' + CONVERT(VARCHAR,@Date,106) + '''
										) as A'		  
		   End   
	   
	  
	 ------------------------------------------- ABDN Week For Selected Date: Done-----------------------------------
	 If @operation='ABDN_WEEK'
		   Begin
			    Select @SqlString = 'Select  ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y
									 From ( 
											Select  A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  											From   TBL_SKILLS_DATA A
											Where  1=1 And A.Calls_Offered<>0' + @AccountPara + @CodePara + '
													AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
													AND A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
											) as A'				  
		   End     
	   
  	
	  
	 ------------------------------------------- ABDN Week For Selected Date: Done---------------------------------------
	 If @operation='ABDN_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select y 
									 From (
										  Select  ROUND(100*(SUM(A.Abandoned_Calls)/Sum(A.Calls_Offered)),2) AS y,''true'' as drilldown
										  From ( 
											  Select A.Primary_Client_ID, A.Primary_Client_Name as account , A.MBU_Code as LOB , A.MBU_Description , A.Date , A.Time_Period, A.Abandoned_Calls,A.Calls_Offered
  											  From   TBL_SKILLS_DATA A
											  Where  1=1 And A.Calls_Offered >0' + @AccountPara + @CodePara + '
													 AND  A.Date <= ''' + CONVERT(VARCHAR,@Date,106)  + '''
													 ' + @DNamePara + '
											  ) as A) AS ST'
												
		   End








      -------------------------------------------          FOR AHT            -------------------------------------------
	  ------------------------------------------- AHT Year For Selected Date  -------------------------------------------
      If @operation='AHT_YEAR'
	   Begin
			Select @SqlString = 'SELECT ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y
								 FROM (
								      SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									  FROM   TBL_SKILLS_DATA A 
									  WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
									  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
									  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
								 ) AS A'
	   End   


	  ------------------------------------------- AHT Month For Selected Date  -------------------------------------------
      If @operation='AHT_MONTH'
	   Begin
			Select @SqlString = 'SELECT ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y,''true'' as drilldown
								 FROM (
								      SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									  FROM   TBL_SKILLS_DATA A 
									  WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
									  AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
									  AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ' + @MonthPara + '
								 ) AS A'
								
	   End   


	  ------------------------------------------- AHT Day For Selected Date  -------------------------------------------
      If @operation='AHT_DAY'
	   Begin
	        if @WKDrill = 1 Select @Date = xDate From [xGetWeekDates] (@Date,0,'d') WHERE DATENAME(DW,xDate)=@Month
			if @WKDrill = 2 Select @Date = CONVERT(DATETIME,@Month) --[dbo].[xGetDayDate] (@Date,@DName,@Month)

			Select @SqlString = 'SELECT ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y
								 FROM (
								      SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									  FROM   TBL_SKILLS_DATA A 
									  WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '  AND A.Date=''' + CONVERT(VARCHAR,@Date,106) + '''
								 ) AS A'
								 
	   End   

      
	  ------------------------------------------- AHT Week For Selected Date: Done-----------------------------------
	  If @operation='AHT_WEEK'
		   Begin
			    Select @SqlString = 'Select  ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y
									 From ( 
										   SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
									       FROM   TBL_SKILLS_DATA A 
									       WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
												  AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
												  AND  A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
											) as A'															  
		   End     

       
	  ------------------------------------------- AHT Week For Selected Date: Done---------------------------------------
	  If @operation='AHT_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select y
									 From (
				                           Select ROUND(SUM(A.HT) / SUM(A.ANSWERED_CALLS),0) AS y,''true'' as drilldown
									       From ( 
											   SELECT A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.MBU_CODE AS LOB , A.DATE ,A.TIME_PERIOD,A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS HT 
											   FROM   TBL_SKILLS_DATA A 
											   WHERE  1 = 1 AND A.ANSWERED_CALLS >0' + @AccountPara + @CodePara + '
													  AND  A.Date <= ''' + CONVERT(VARCHAR,@Date,106)  + '''
													  ' + @DNamePara + '
												) as A ) AS ST'				  
		   End






      -------------------------------------------          FOR FTE            -------------------------------------------
	  --------------------------------------------- FTE Year For Selected Date  -------------------------------------------
      If @operation='FTE_YEAR'
	   Begin
	     Select @SqlString ='SELECT ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y
					         FROM (
							       SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
						           FROM   TBL_AGENT_DATA A
						           WHERE  1 = 1' + @FTE_AccountPara + ' 
						           AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
						           AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + ''') + 1, -1),106)
							 ) AS A'
					        
	   End   

	  
	   ------------------------------------------- AHT Month For Selected Date  -------------------------------------------
      If @operation='FTE_MONTH'
	   Begin
			Select @SqlString = 'SELECT ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y
								 FROM (
								       SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
						               FROM   TBL_AGENT_DATA A
						               WHERE  1 = 1' + @FTE_AccountPara + '
									   AND CONVERT(VARCHAR,A.Date,106) >= CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106)  + '''), 0),106) 
									   AND CONVERT(VARCHAR,A.Date,106) <=  CONVERT(VARCHAR,DATEADD(yy, DATEDIFF(yy,0,''' + CONVERT(VARCHAR,@Date,106) + ''') + 1, -1),106)
									   ' + @MonthPara + '
								 ) AS A'
	   End   



	   ------------------------------------------- AHT Week For Selected Date: Done-----------------------------------
	  If @operation='FTE_WEEK'
		   Begin
			    Select @SqlString = 'Select ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y
									 From ( 
										   SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
										   FROM   TBL_AGENT_DATA A
										   WHERE  1 = 1' + @FTE_AccountPara + '
									       AND  A.Date >= DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),0) 
										   AND  A.Date <=  DATEADD(wk,DATEDIFF(wk,0,''' + CONVERT(VARCHAR,@Date,106)  + '''),6)
									 ) as A'												  
		   End     


       
	    ------------------------------------------- AHT Week For Selected Date: Done---------------------------------------
	  If @operation='FTE_LAST_DAYS'
		   Begin
			    Select @SqlString = 'Select y
									 From (
				                           Select ROUND(COUNT(DISTINCT A.Employee_ID),0) AS y
									       From ( 
											     SELECT A.Project_Name AS ACCOUNT , A.DATE , A.Employee_ID
											     FROM   TBL_AGENT_DATA A
											     WHERE  1 = 1' + @FTE_AccountPara + '
												 AND  A.Date <= ''' + CONVERT(VARCHAR,@Date,106)  + '''
												 ' + @DNamePara + '
										   ) as A) AS ST'				  
		   End



	  EXEC sp_executesql @SqlString
	  
	  Print @SqlString    
	  
	  -- EXEC  [dbo].[sp_AC_Per_Chart_Summary] 'ABDN_MONTH','Starbucks Coffee Company','','20160902','September',0,'Monday'

END
GO
/****** Object:  StoredProcedure [dbo].[sp_AC_Per_Chart2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AC_Per_Chart2]
(
	@operation VARCHAR(MAX)=NULL,
	@Primary_Client_Name VARCHAR(MAX)=NULL,
	@MBU_Code VARCHAR(MAX) = NULL,
	@Date DATETIME = NULL, 
	@Month VARCHAR(MAX)=NULL,
	@WKDrill INT=0,
	@DName VARCHAR(MAX)=NULL
)
AS
BEGIN
	--[sp_AC_Per_Chart2] 'SL_MONTH', 'CITIZENS BANK', 'CITIZENS BANK CS', '20170914'; 
	
	DECLARE @xSQL varchar(MAX) = '';
	DECLARE @xSQLKPI varchar(MAX) = '';
	DECLARE @xSQLSTART varchar(MAX) = '';
	DECLARE @xSQLWHERE varchar(MAX) = '';
	DECLARE @xSQLGRP varchar(MAX) = '';

	DECLARE @SDATE SMALLDATETIME; 
	DECLARE @EDATE SMALLDATETIME;


	If (Right(@operation,4)='YEAR')
	BEGIN
		SET @xSQLSTART = ' LEFT(DATENAME(MONTH,[DATE]),3) + '' ''+ RIGHT(CONVERT(VARCHAR,YEAR([DATE])),2)  AS [NAME],
						ROUND(100*(SUM(ACCEPTABLE_CALLS)/SUM(CALLS_OFFERED)),2) AS Y,''TRUE'' AS DRILLDOWN';
		SET @xSQLWHERE = ' AND YEAR(A.DATE) = '+ CONVERT(VARCHAR,YEAR(@Date));

		SET @xSQLGRP = ' GROUP BY LEFT(DATENAME(MONTH,[DATE]),3) + '' ''+ RIGHT(CONVERT(VARCHAR,YEAR([DATE])),2)';
	END

	If (Right(@operation,5)='MONTH')
	BEGIN

		SET @xSQLSTART = ' Left(DATENAME(MONTH,[Date]),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,[Date])) AS name , 
							Round(100*(SUM(Acceptable_Calls)/Sum(Calls_Offered)),2) AS y,''true'' as drilldown'

		SET @SDATE = left(CONVERT(VARCHAR,@Date,112),6) + '01';
		SET @EDATE = DATEADD(m,1,left(CONVERT(VARCHAR,@Date,112),6) + '01') - 1;
		SET @xSQLWHERE = ' AND A.Date BETWEEN '''+ convert(varchar,@SDATE,106) +''' AND  '''+ convert(varchar,@EDATE,106) +'''';

		SET @xSQLGRP = ' GROUP BY Left(DATENAME(MONTH,[Date]),3) + '' '' + CONVERT(VARCHAR(2),DATEPART(DAY,[Date]))';
	END


	SET @xSQL = 'SELECT '
	SET @xSQL = @xSQL + @xSQLSTART;
	SET @xSQL = @xSQL + ' FROM(
					SELECT A.PRIMARY_CLIENT_ID, A.PRIMARY_CLIENT_NAME AS ACCOUNT , A.PROJECT_NAME,
					A.MBU_CODE AS LOB , A.MBU_DESCRIPTION , A.DATE , A.TIME_PERIOD, 
					A.ACCEPTABLE_CALLS , A.CALLS_OFFERED,A.ABANDONED_CALLS,
					A.ANSWERED_CALLS , A.ACD_TIME_SECS + A.AFTER_CALL_WORK_TIME_SECS + A.HOLD_TIME_SECS AS AHT 
					FROM   TBL_SKILLS_DATA A
					WHERE  1=1 AND A.CALLS_OFFERED<>0
					AND (ISNULL('''+@Primary_Client_Name+''',''ALL'') = ''ALL'' 
					OR 
					A.PRIMARY_CLIENT_NAME = ISNULL('''+@Primary_Client_Name+''',''ALL''))
					AND (ISNULL('''+@MBU_Code+''',''ALL'') = ''ALL'' OR A.MBU_CODE = ISNULL('''+@MBU_Code+''',''ALL''))'
	SET @xSQL = @xSQL + @xSQLWHERE
	SET @xSQL = @xSQL + ' ) AS TMP'
	SET @xSQL = @xSQL + @xSQLGRP;

	PRINT(@xSQL);
	EXECUTE(@xSQL);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_permission]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_permission]
(
	@Username varchar(10),
	@pagename varchar(50),
	@permission bit OUTPUT
)
AS  
BEGIN
    select @permission = count(permission) 
	from dbo.tblFloorPlanAdmin 
	where permission = 1
	and nt_id = @Username and [page] = @pagename;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_review_output]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_review_output]  
(  
@NAME as nvarchar(200),  
@WC_Date as datetime,  
@Client_Name as nvarchar(500),  
@LOB_Name as nvarchar(max)  
)  
as  
  
select WC_date,Question, Yes_No, Comments   
from Review_Table   
where NAME = @NAME  
and WC_Date = @WC_Date
and Client_Name = @Client_Name  
and [LOB Name] = @LOB_Name  
order by [Question ID]

GO
/****** Object:  StoredProcedure [dbo].[SP_SPT_FINAL_CHETAN]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SPT_FINAL_CHETAN]
AS
Select 
[Client_Name],
[Site] as Final_Site,
sum([Actuals_Agents]) as [Actuals_Agents],
sum([First_HC]) as [First_HC],sum([Second_HC]) as [Second_HC],sum([Third_HC]) as [Third_HC],
sum([Actuals_Coach]+[Actuals_Quality]+[Actuals_Trainer]+[Actuals_Others]) as Total_Support,
isnull(round(sum([Actuals_Agents])/nullif(sum([Actuals_Coach]+[Actuals_Quality]+[Actuals_Trainer]+[Actuals_Others]),0),0),0) as COS_Ratio,

isnull(sum([Actuals_Coach]),0) as [Actuals_Coach],

--isnull(sum([Max_Req_Coach]),0) as [Max_Req_Coach],
isnull([Type_of_max_coach],'-') as [Max_Approved_coach],

case when Type_of_max_coach = 'Gos' then 18 else
isnull(sum([Max_Coach_Ratio]),0) end as [Max_Coach_Ratio],

'17' as Margin_leader_ratio,

isnull(sum(Coach_First_Month_Req),0) as Coach_First_Month_Req,
isnull(sum(Coach_Second_Month_Req),0) as Coach_Second_Month_Req,
isnull(sum(Coach_Third_Month_Req),0) as Coach_Third_Month_Req,

case when isnull(sum([Coach_Second_Month_Req]),0) > isnull(sum([Coach_Third_Month_Req]),0) 
then round(isnull(sum([Coach_Second_Month_Req]),0),0)
else round(isnull(sum([Coach_Third_Month_Req]),0),0) end as Coach_Next_3_months_Req,

sum([Coach_First_Month_OU]) as [Coach_First_Month_OU],
sum([Coach_Second_Month_OU])as [Coach_Second_Month_OU],
sum([Coach_Third_Month_OU])as [Coach_Third_Month_OU],

case when isnull(sum([Coach_Third_Month_Req]),0) > isnull(sum([Coach_Second_Month_Req]),0)
then sum([Actuals_Coach]) - round(isnull(sum([Coach_Third_Month_Req]),0),0)
else sum([Actuals_Coach]) - round(isnull(sum([Coach_Second_Month_Req]),0),0) end as Coach_Next_3_months_OU,

isnull(sum([Actuals_Quality]),0) as [Actuals_Quality],     
      
--isnull(sum([Max_Req_Quality]),0) as [Max_Req_Quality],
isnull([Type_of_max_Quality],'-') as [Max_Approved_Quality],

case when [Type_of_max_Quality] = 'Gos' then 50 else
isnull(sum([Max_Quality_Ratio]),0) end as [Max_Quality_Ratio],

isnull(sum(Quality_First_Month_Req),0) as Quality_First_Month_Req,
isnull(sum(Quality_Second_Month_Req),0) as Quality_Second_Month_Req,
isnull(sum(Quality_Third_Month_Req),0) as Quality_Third_Month_Req,

case when isnull(sum([Quality_Second_Month_Req]),0) > isnull(sum([Quality_Third_Month_Req]),0) 
then round(isnull(sum([Quality_Second_Month_Req]),0),0)
else round(isnull(sum([Quality_Third_Month_Req]),0),0) end as Quality_Next_3_months_Req,

sum([Quality_First_Month_OU])as [Quality_First_Month_OU],
sum([Quality_Second_Month_OU])as [Quality_Second_Month_OU],
SUM([Quality_Third_Month_OU]) as [Quality_Third_Month_OU],

case when isnull(sum([Quality_Second_Month_Req]),0) > isnull(sum([Quality_Third_Month_Req]),0) 
then sum([Actuals_Quality]) - round(isnull(sum([Quality_Second_Month_Req]),0),0)
else sum([Actuals_Quality]) - round(isnull(sum([Quality_Third_Month_Req]),0),0) end as Quality_Next_3_months_OU,

isnull(sum([Actuals_Trainer]),0) as [Actuals_Trainer],      

--isnull(sum([Max_Req_Trainers]),0) as [Max_Req_Trainers],
isnull([Type_of_Max_Trainer],'-') as [Max_Approved_Trainer],

case when [Type_of_Max_Trainer] = 'Gos' then 75 else
isnull(sum([Max_Trainer_Ratio]),0) end as [Max_Trainer_Ratio],

isnull(sum(Trainer_First_Month_Req),0) as Trainer_First_Month_Req,
isnull(sum(Trainer_Second_Month_Req),0) as Trainer_Second_Month_Req,
isnull(sum(Trainer_Third_Month_Req),0) as Trainer_Third_Month_Req,

case when isnull(sum([Trainer_Second_Month_Req]),0) > isnull(sum([Trainer_Third_Month_Req]),0) 
then round(isnull(sum([Trainer_Second_Month_Req]),0),0)
else round(isnull(sum([Trainer_Third_Month_Req]),0),0) end as Trainer_Next_3_months_Req,

SUM([Trainer_First_Month_OU]) as [Trainer_First_Month_OU],
sum([Trainer_Second_Month_OU])as [Trainer_Second_Month_OU],
sum([Trainer_Third_Month_OU])as [Trainer_Third_Month_OU],

case when isnull(sum([Trainer_Second_Month_Req]),0) > isnull(sum([Trainer_Third_Month_Req]),0) 
then sum([Actuals_Trainer]) - round(isnull(sum([Trainer_Second_Month_Req]),0),0)
else sum([Actuals_Trainer]) - round(isnull(sum([Trainer_Third_Month_Req]),0),0) end as Trainer_Next_3_months_OU,


isnull(sum([Actuals_Ops_Mgr]),0) as [Actuals_Ops_Mgr],      

--isnull(sum([Max_Req_Trainers]),0) as [Max_Req_Trainers],
isnull([Type_of_Max_Ops_Mgr],'-') as [Max_Approved_Ops_Mgr],


case when [Type_of_Max_Ops_Mgr] = 'Gos' then 126 else
isnull(sum([Max_Ops_Mgr_Ratio]),0) end as [Max_Ops_Mgr_Ratio],

isnull(sum(Ops_Mgr_First_Month_Req),0) as Ops_Mgr_First_Month_Req,
isnull(sum(Ops_Mgr_Second_Month_Req),0) as Ops_Mgr_Second_Month_Req,
isnull(sum(Ops_Mgr_Third_Month_Req),0) as Ops_Mgr_Third_Month_Req,

case when isnull(sum([Ops_Mgr_Second_Month_Req]),0) > isnull(sum([Ops_Mgr_Third_Month_Req]),0) 
then round(isnull(sum([Ops_Mgr_Second_Month_Req]),0),0)
else round(isnull(sum([Ops_Mgr_Third_Month_Req]),0),0) end as Ops_Mgr_Next_3_months_Req,

SUM([Ops_Mgr_First_Month_OU]) as [Ops_Mgr_First_Month_OU],
sum([Ops_Mgr_Second_Month_OU])as [Ops_Mgr_Second_Month_OU],
sum([Ops_Mgr_Third_Month_OU])as [Ops_Mgr_Third_Month_OU],

case when isnull(sum([Ops_Mgr_Second_Month_Req]),0) > isnull(sum([Ops_Mgr_Third_Month_Req]),0) 
then sum([Actuals_Ops_Mgr]) - round(isnull(sum([Ops_Mgr_Second_Month_Req]),0),0)
else sum([Actuals_Ops_Mgr]) - round(isnull(sum([Ops_Mgr_Third_Month_Req]),0),0) end as Ops_Mgr_Next_3_months_OU,

isnull(sum([Actuals_Others]),0) as [Actuals_Others],

--isnull(sum([Max_Req_Others]),0) as [Max_Req_Others],
isnull([Type_of_Max_Others],'-') as [Max_Approved_Others],
isnull(sum([Max_Others_Ratio]),0) as [Max_Others_Ratio],

isnull(sum(Others_First_Month_Req),0) as Others_First_Month_Req,
isnull(sum(Others_Second_Month_Req),0) as Others_Second_Month_Req,
isnull(sum(Others_Third_Month_Req),0) as Others_Third_Month_Req,

case when isnull(sum([Others_Second_Month_Req]),0) > isnull(sum([Others_Third_Month_Req]),0) 
then round(isnull(sum([Others_Second_Month_Req]),0),0)
else round(isnull(sum([Others_Third_Month_Req]),0),0) end as Others_Next_3_months_Req,


sum([Others_First_Month_OU])as [Others_First_Month_OU],
sum([Others_Second_Month_OU])as [Others_Second_Month_OU],
sum([Others_Third_Month_OU])as [Others_Third_Month_OU],


case when isnull(sum([Others_Second_Month_Req]),0) > isnull(sum([Others_Third_Month_Req]),0) 
then sum([Actuals_Others]) - round(isnull(sum([Others_Second_Month_Req]),0),0)
else sum([Actuals_Others]) - round(isnull(sum([Others_Third_Month_Req]),0),0) end as Others_Next_3_months_OU

from
(
select
*,
isnull(round([Actuals_Coach]- isnull(Coach_First_Month_Req,0),0),0) as [Coach_First_Month_OU],
isnull(round([Actuals_Coach]- isnull(Coach_Second_Month_Req,0),0),0) as [Coach_Second_Month_OU],
isnull(round([Actuals_Coach]- isnull(Coach_Third_Month_Req,0),0),0)as [Coach_Third_Month_OU],

isnull(round([Actuals_Quality]- isnull(Quality_First_Month_Req,0),0),0) as [Quality_First_Month_OU],
isnull(round([Actuals_Quality]- isnull(Quality_Second_Month_Req,0),0),0) as [Quality_Second_Month_OU],
isnull(round([Actuals_Quality]- isnull(Quality_Third_Month_Req,0),0),0)as [Quality_Third_Month_OU],

isnull(round([Actuals_Trainer]- isnull(Trainer_First_Month_Req,0),0),0) as [Trainer_First_Month_OU],
isnull(round([Actuals_Trainer]- isnull(Trainer_Second_Month_Req,0),0),0) as [Trainer_Second_Month_OU],
isnull(round([Actuals_Trainer]- isnull(Trainer_Third_Month_Req,0),0),0)as [Trainer_Third_Month_OU],

isnull(round([Actuals_Ops_Mgr]- isnull(Ops_Mgr_First_Month_Req,0),0),0) as [Ops_Mgr_First_Month_OU],
isnull(round([Actuals_Ops_Mgr]- isnull(Ops_Mgr_Second_Month_Req,0),0),0) as [Ops_Mgr_Second_Month_OU],
isnull(round([Actuals_Ops_Mgr]- isnull(Ops_Mgr_Third_Month_Req,0),0),0)as [Ops_Mgr_Third_Month_OU],

isnull(round([Actuals_Others]- isnull(Others_First_Month_Req,0),0),0) as [Others_First_Month_OU],
isnull(round([Actuals_Others]- isnull(Others_Second_Month_Req,0),0),0) as [Others_Second_Month_OU],
isnull(round([Actuals_Others]- isnull(Others_Third_Month_Req,0),0),0)as [Others_Third_Month_OU]
from 
(
Select      
      Client_Name, 
      --LOB,
      [Site],
      avg(Actuals_Agents)as  Actuals_Agents,
      isnull(round(avg(First_HC),0),0) as First_HC,
      isnull(round(avg(Second_HC),0),0) as Second_HC,
      isnull(round(avg(Third_HC),0),0) as Third_HC,
      isnull(round((avg(First_HC)+avg(Second_HC)+ avg(Third_HC))/ 3,0),0) as [Nxt mth Avg HC],
      isnull(nullif(round((avg(First_HC)+avg(Second_HC)+ avg(Third_HC))/ 3,0),0)/nullif(avg(Actuals_Agents),0),0) as Accuracy,
      
      -- below set of calculation is for Coach
      
      isnull(avg(Actuals_Coach),0) as Actuals_Coach,
      isnull(round(max(Max_Coach),1),0)as Max_Req_Coach,    
      
      case 
      when max(Max_Coach) = MAX(Gos_Required) then 'Gos'
      when max(Max_Coach) = MAX(Legal_Required) then 'Legal'
      when max(Max_Coach) = MAX(Sow_Required) then 'Sow'
      when max(Max_Coach) = MAX(Pricing_Required) then 'Pricing'
      when max(Max_Coach) = MAX(Executive_Approved) then 'Executive'
      else 'Others'
      end as Type_of_max_coach,
      
      case when max(Max_Coach) = 0 then
      18 else
      isnull(round(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Coach)),0),0),0) end as Max_Coach_Ratio,
      
      round(isnull(Max(Gos_Coach),0),0) as Gos_Coach,
      round(isnull(max(SOW_Coach),0),0)as SOW_Coach,
      round(isnull(max(Legal_Coach),0),0)as Legal_Coach,
      round(isnull(max(Pricing_Coach),0),0)as Pricing_Coach,
      round(isnull(max(Executive_Coach),0),0)as Executive_Coach,
      
      isnull(round(avg(Actuals_Agents)/nullif(avg(Actuals_Coach),0),0),0) as Current_Ratio,      
      
      --below change as roundup
      isnull(round(avg(Actuals_Coach)- Max(Max_Coach),0),0) as Coach_GOS_OU,
      
      
      case     
      
      when avg(First_HC)<= 0 or
      avg(Actuals_Coach) <= 0 then 0             
      when avg(First_HC)> 0 and avg(Actuals_Coach) > 0 then            
      round((avg(First_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Coach)),0),0)),2) 
      when avg(First_HC)> 0 then 
      round(avg(First_HC)/18,2)                  
      end as Coach_First_Month_Req,
      
      case 
      when avg(Second_HC)<= 0 or
      avg(Actuals_Coach) <= 0 then 0             
      when avg(Second_HC)> 0 and avg(Actuals_Coach) > 0 then            
      round((avg(Second_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Coach)),0),0)),2) 
      when avg(Second_HC)> 0 then 
      round(avg(Second_HC)/18,2)                  
      end as Coach_Second_Month_Req,
      
      case 
      when avg(Third_HC)<= 0 or
      avg(Actuals_Coach) <= 0 then 0             
      when avg(Third_HC)> 0 and avg(Actuals_Coach) > 0 then            
      round((avg(Third_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Coach)),0),0)),2) 
      when avg(Third_HC)> 0 then 
      round(avg(Third_HC)/18,2)                  
      end as Coach_Third_Month_Req,


-- below set of calculation is for Quality
      
      isnull(avg(Actuals_Quality),0) as Actuals_Quality,
      isnull(round(max(Max_Quality),1),0)as Max_Req_Quality,      
      
      case 
      when max(Max_Quality) = MAX(Gos_Required) then 'Gos'
      when max(Max_Quality) = MAX(Legal_Required) then 'Legal'
      when max(Max_Quality) = MAX(Sow_Required) then 'Sow'
      when max(Max_Quality) = MAX(Pricing_Required) then 'Pricing'
      when max(Max_Quality) = MAX(Executive_Approved) then 'Executive'
      else 'Others'
      end as Type_of_max_Quality,      
            
      isnull(round(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Quality)),0),0) ,0)as Max_Quality_Ratio,
      round(isnull(Max(Gos_Quality),0),0) as Gos_Quality,
      round(isnull(max(SOW_Quality),0),0)as SOW_Quality,
      round(isnull(Max(Legal_Quality),0),0) as Legal_Quality,
      round(isnull(max(Pricing_Quality),0),0)as Pricing_Quality,
      round(isnull(Max(Executive_Quality),0),0) as Executive_Quality,
      
      isnull(round(avg(Actuals_Agents)/nullif(avg(Actuals_Quality),0),0),0) as Current_Quality_Ratio,  
      
      --below change as roundup
      isnull(round(avg(Actuals_Quality)- Max(Max_Quality),0),0) as Quality_GOS_OU,
            
		case       
		when avg(First_HC)<= 0 or
		avg(Actuals_Quality) <= 0 then 0             
		when avg(First_HC)> 0 and avg(Actuals_Quality) > 0 then            
		round((avg(First_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Quality)),0),0)),2) 
		when avg(First_HC)> 0 then 
		round(avg(First_HC)/50,2)
		end as Quality_First_Month_Req,
      
		case 
		when avg(Second_HC)<= 0 or
		avg(Actuals_Quality) <= 0 then 0             
		when avg(Second_HC)> 0 and avg(Actuals_Quality) > 0 then            
		round((avg(Second_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Quality)),0),0)),2) 
		when avg(Second_HC)> 0 then 
		round(avg(Second_HC)/50,2)
		end as Quality_Second_Month_Req,
      
		case 
		when avg(Third_HC)<= 0 or
		avg(Actuals_Quality) <= 0 then 0             
		when avg(Third_HC)> 0 and avg(Actuals_Quality) > 0 then            
		round((avg(Third_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Quality)),0),0)),2) 
		when avg(Third_HC)> 0 then 
		round(avg(Third_HC)/50,2)
		end as Quality_Third_Month_Req,

-- below set of calculation is for Trainers
      
      isnull(avg(Actuals_Trainer),0) as Actuals_Trainer,
      isnull(round(max(Max_Trainer),1),0)as Max_Req_Trainers,     
      
      case 
      when max(Max_Trainer) = MAX(Gos_Required) then 'Gos'
      when max(Max_Trainer) = MAX(Legal_Required) then 'Legal'
      when max(Max_Trainer) = MAX(Sow_Required) then 'Sow'
      when max(Max_Trainer) = MAX(Pricing_Required) then 'Pricing'
      when max(Max_Trainer) = MAX(Executive_Approved) then 'Executive'
      else 'Others'
      end as Type_of_Max_Trainer,
            
      isnull(round(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Trainer)),0),0),0) as Max_Trainer_Ratio,
      round(isnull(Max(Gos_Trainer),0),0) as Gos_Trainer,
      round(isnull(max(SOW_Trainer),0),0)as SOW_Trainer,
      round(isnull(max(Legal_Trainer),0),0)as Legal_Trainer,
      round(isnull(max(Pricing_Trainer),0),0)as Pricing_Trainer,
      round(isnull(max(Executive_Trainer),0),0)as Executive_Trainer,
      
      isnull(round(avg(Actuals_Agents)/nullif(avg(Actuals_Trainer),0),0),0) as Current_Trainer_Ratio,  
      
      --below change as roundup
      isnull(round(avg(Actuals_Trainer)- Max(Max_Trainer),0),0) as Trainer_GOS_OU,
      
            
		case 
		when avg(First_HC)<= 0 or
		avg(Actuals_Trainer) <= 0 then 0 
		when avg(First_HC)> 0 and avg(Actuals_Trainer) > 0 then            
		round((avg(First_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Trainer)),0),0)),2) 
		when avg(First_HC)> 0 then 
		round(avg(First_HC)/75,2)		
		end as Trainer_First_Month_Req,
	      
		case 
		when avg(Second_HC)<= 0 or
		avg(Actuals_Trainer) <= 0 then 0 
		when avg(Second_HC)> 0 and avg(Actuals_Trainer) > 0 then            
		round((avg(Second_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Trainer)),0),0)),2) 
		when avg(Second_HC)> 0 then 
		round(avg(Second_HC)/75,2)		
		end as Trainer_Second_Month_Req,
	      
		case 
		when avg(Third_HC)<= 0 or
		avg(Third_HC) <= 0 then 0 
		when avg(Third_HC)> 0 and avg(Actuals_Trainer) > 0 then            
		round((avg(Third_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Trainer)),0),0)),2) 
		when avg(Third_HC)> 0 then 
		round(avg(Third_HC)/75,2)		
		end as Trainer_Third_Month_Req,

-- below set of calculation is for Ops Manager
      
      isnull(avg(Actuals_Ops_Mgr),0) as Actuals_Ops_Mgr,
      isnull(round(max(Max_Ops_Mgr),1),0)as Max_Req_Ops_Mgr,     
      
      case 
      when max(Max_Ops_Mgr) = MAX(Gos_Required) then 'Gos'
      when max(Max_Ops_Mgr) = MAX(Legal_Required) then 'Legal'
      when max(Max_Ops_Mgr) = MAX(Sow_Required) then 'Sow'
      when max(Max_Ops_Mgr) = MAX(Pricing_Required) then 'Pricing'
      when max(Max_Ops_Mgr) = MAX(Executive_Approved) then 'Executive'
      else 'Others'
      end as Type_of_Max_Ops_Mgr,
            
      isnull(round(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Ops_Mgr)),0),0),0) as Max_Ops_Mgr_Ratio,
      round(isnull(Max(Gos_Ops_Mgr),0),0) as Gos_Ops_Mgr,
      round(isnull(max(SOW_Ops_Mgr),0),0)as SOW_Ops_Mgr,
      round(isnull(max(Legal_Ops_Mgr),0),0)as Legal_Ops_Mgr,
      round(isnull(max(Pricing_Ops_Mgr),0),0)as Pricing_Ops_Mgr,
      round(isnull(max(Executive_Ops_Mgr),0),0)as Executive_Ops_Mgr,
      
      isnull(round(avg(Actuals_Agents)/nullif(avg(Actuals_Ops_Mgr),0),0),0) as Current_Ops_Mgr_Ratio,  
      
      --below change as roundup
      isnull(round(avg(Actuals_Ops_Mgr)- Max(Max_Ops_Mgr),0),0) as Ops_Mgr_GOS_OU,      
            
		case 
		when avg(First_HC)<= 0 or
		avg(Actuals_Ops_Mgr) <= 0 then 0             
		when avg(First_HC)> 0 and avg(Actuals_Ops_Mgr) > 0 then            
		round((avg(First_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Ops_Mgr)),0),0)),2) 
		when avg(First_HC)> 0 then 
		round(avg(First_HC)/126,2)       
		end as Ops_Mgr_First_Month_Req,
      
		case 
		when avg(Second_HC)<= 0 or
		avg(Actuals_Ops_Mgr) <= 0 then 0             
		when avg(Second_HC)> 0 and avg(Actuals_Ops_Mgr) > 0 then            
		round((avg(Second_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Ops_Mgr)),0),0)),2) 
		when avg(Second_HC)> 0 then 
		round(avg(Second_HC)/126,2)       
		end as Ops_Mgr_Second_Month_Req,
      
		case 
		when avg(Third_HC)<= 0 or
		avg(Actuals_Ops_Mgr) <= 0 then 0             
		when avg(Third_HC)> 0 and avg(Actuals_Ops_Mgr) > 0 then            
		round((avg(Third_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Ops_Mgr)),0),0)),2) 
		when avg(Third_HC)> 0 then 
		round(avg(Third_HC)/126,2)       
		end as Ops_Mgr_Third_Month_Req,
      
      -- below set of calculation is for Others
      
      isnull(avg(Actuals_Others),0) as Actuals_Others,
      isnull(round(max(Max_Others),1),0)as Max_Req_Others,  
      
      case 
      when max(Max_Others) = MAX(Gos_Required) then 'Gos'
      when max(Max_Others) = MAX(Legal_Required) then 'Legal'
      when max(Max_Others) = MAX(Sow_Required) then 'Sow'
      when max(Max_Others) = MAX(Pricing_Required) then 'Pricing'
      when max(Max_Others) = MAX(Executive_Approved) then 'Executive'
      else 'Others'
      end as Type_of_Max_Others,
            
      isnull(round(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Others)),0),0),0) as Max_Others_Ratio,
      round(isnull(Max(Gos_Others),0),0) as Gos_Others,
      round(isnull(max(SOW_Others),0),0)as SOW_Others,
      round(isnull(Max(Legal_Others),0),0) as Legal_Others,
      round(isnull(max(Pricing_Others),0),0)as Pricing_Others,
      round(isnull(Max(Executive_Others),0),0) as Executive_Others,      
      isnull(round(avg(Actuals_Agents)/nullif(avg(Actuals_Others),0),0),0) as Current_Others_Ratio,   
      
      --below change as roundup
      isnull(round(avg(Actuals_Others)- Max(Max_Others),0),0) as Others_GOS_OU,
                  
      case
      when avg(First_HC)<= 0 or
      avg(Actuals_Others) <= 0 then 0 
      else 
      round((avg(First_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Others)),0),0)),2) 
      end as Others_First_Month_Req,
      
      case 
      when avg(Second_HC)<= 0 or
      avg(Actuals_Others) <= 0 then 0 
      else 
      round((avg(Second_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Others)),0),0)) ,2)
      end as Others_Second_Month_Req,
      
      case 
      when avg(Third_HC)<= 0 or
      avg(Actuals_Others) <= 0 then 0 
      else 
      round((avg(Third_HC)/nullif(convert(float,avg(Actuals_Agents))/nullif(convert(float,max(Max_Others)),0),0)) ,2)
      end as Others_Third_Month_Req

      from(
      Select SPT.*,
      HC.First_HC,HC.Second_HC,HC.Third_HC
from 
(
      select
      Client_Name,
      --LOB,
      [Site],
      MAX(Gos_Required)as Gos_Required,
      MAX(Legal_Required)as Legal_Required,
      MAX(Sow_Required)as Sow_Required,
      MAX(Pricing_Required)as Pricing_Required,
      MAX(Executive_Approved)as Executive_Approved,      
      
      case when Positions = 'Coach' then MAX(Max_Approved) end as Max_Coach,
      case when Positions = 'Quality' then MAX(Max_Approved) end as Max_Quality,
      case when Positions = 'Trainer' then MAX(Max_Approved) end as Max_Trainer,
      case when Positions = 'Operations Manager' then MAX(Max_Approved) end as Max_Ops_Mgr,
      case when Positions = 'Others' then MAX(Max_Approved) end as Max_Others,
      
      case when Positions = 'Agent' then sum(Essbase_Actual) end as Actuals_Agents,
      case when Positions = 'Coach' then sum(Essbase_Actual) end as Actuals_Coach,
      case when Positions = 'Quality' then sum(Essbase_Actual) end as Actuals_Quality,
      case when Positions = 'Trainer' then sum(Essbase_Actual) end as Actuals_Trainer,
      case when Positions = 'Operations Manager' then sum(Essbase_Actual) end as Actuals_Ops_Mgr,
      case when Positions = 'Others' then sum(Essbase_Actual) end as Actuals_Others,

      case when Positions = 'Agent' then Max(Gos_Required) end as Gos_Agents,
      case when Positions = 'Coach' then Max(Gos_Required) end as Gos_Coach,
      case when Positions = 'Quality' then max(Gos_Required) end as Gos_Quality,
      case when Positions = 'Trainer' then max(Gos_Required) end as Gos_Trainer,
      case when Positions = 'Operations Manager' then max(Gos_Required) end as Gos_Ops_Mgr,
      case when Positions = 'Others' then max(Gos_Required) end as Gos_Others,

      case when Positions = 'Agent' then Max(Sow_Required) end as SOW_Agents,
      case when Positions = 'Coach' then Max(Sow_Required) end as SOW_Coach,
      case when Positions = 'Quality' then max(Sow_Required) end as SOW_Quality,
      case when Positions = 'Trainer' then max(Sow_Required) end as SOW_Trainer,
      case when Positions = 'Operations Manager' then max(Sow_Required) end as SOW_Ops_Mgr,
      case when Positions = 'Others' then max(Sow_Required) end as SOW_Others,
      
      case when Positions = 'Agent' then Max(Legal_Required) end as Legal_Agents,
      case when Positions = 'Coach' then Max(Legal_Required) end as Legal_Coach,
      case when Positions = 'Quality' then max(Legal_Required) end as Legal_Quality,
      case when Positions = 'Trainer' then max(Legal_Required) end as Legal_Trainer,
      case when Positions = 'Operations Manager' then max(Legal_Required) end as Legal_Ops_Mgr,
      case when Positions = 'Others' then max(Legal_Required) end as Legal_Others,
      
      case when Positions = 'Agent' then Max(Pricing_Required) end as Pricing_Agents,
      case when Positions = 'Coach' then Max(Pricing_Required) end as Pricing_Coach,
      case when Positions = 'Quality' then max(Pricing_Required) end as Pricing_Quality,
      case when Positions = 'Trainer' then max(Pricing_Required) end as Pricing_Trainer,
      case when Positions = 'Operations Manager' then max(Pricing_Required) end as Pricing_Ops_Mgr,
      case when Positions = 'Others' then max(Pricing_Required) end as Pricing_Others,
      
      case when Positions = 'Agent' then Max(Executive_Approved) end as Excutive_Agents,
      case when Positions = 'Coach' then Max(Executive_Approved) end as Executive_Coach,
      case when Positions = 'Quality' then max(Executive_Approved) end as Executive_Quality,
      case when Positions = 'Trainer' then max(Executive_Approved) end as Executive_Trainer,
      case when Positions = 'Operations Manager' then max(Executive_Approved) end as Executive_Ops_Mgr,
      case when Positions = 'Others' then max(Executive_Approved) end as Executive_Others
      
      
      from TBL_SPT_Actuals
      group by 
      Client_Name,
      --LOB,
      [Site],Positions
) SPT
left join
(
      Select Client_Name,
      --Final_LOB,
      [Site], 
		case when [Months] = left(datename(month,dateadd(month,0,GETDATE())),3)+'-'+right(datename(Year,dateadd(month,0,GETDATE())),2) then sum(Headcount) end as First_HC,
		case when [Months] = left(datename(month,dateadd(month,1,GETDATE())),3)+'-'+right(datename(Year,dateadd(month,1,GETDATE())),2)then sum(Headcount) end as Second_HC,
		case when [Months] = left(datename(month,dateadd(month,2,GETDATE())),3)+'-'+right(datename(Year,dateadd(month,2,GETDATE())),2)then sum(Headcount) end as Third_HC            

      --case when [Months] = 'Oct-16' THEN avg(Headcount) end as First_HC,
      --case when [Months] = 'Nov-16' THEN avg(Headcount)end as Second_HC,
      --case when [Months] = 'Dec-16' THEN avg(Headcount)end as Third_HC
      
      from 
      (
      Select 
      code,
      Client_Name,
      --Final_LOB,
      [Site],
      [Months], max(HC)as Headcount
      from TBL_SPT_HC_Data
      group by Client_Name,
      --Final_LOB,
      [Site],[Months],code
)aa 
      group by 
      Client_Name,
      --Final_LOB,
      [Site],[Months]) HC
      --ON SPT.Client_Name+''+SPT.LOB+''+SPT.[Site] = HC.Client_Name+''+HC.Final_LOB+''+HC.[Site]
      ON SPT.Client_Name+''+SPT.[Site] = HC.Client_Name+''+HC.[Site]
)aaaa
group by Client_Name,
--LOB,
[Site]
)Semi_final
)Final
group by [Client_Name],
--[LOB],
[Site],[Type_of_max_coach],[Type_of_max_Quality],[Type_of_Max_Trainer],Type_of_Max_Ops_Mgr,[Type_of_Max_Others]

GO
/****** Object:  StoredProcedure [dbo].[sp_War_Room]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_War_Room]
   @operation nvarchar(50)=NULL,
   @nt_id nvarchar(max)=NULL,
   @Emp_Name nvarchar(255)= NULL,
   @Level varchar(50)='Client',
   @Client_Name nvarchar(255),
   @Revenue Float=0,
   @Budget Float=0,
   @War_Room_ID int=0,
   @Region varchar(255)=NULL,
   @Reason nvarchar(255)= NULL,
   @Loc_Name nvarchar(255)= NULL,
   @PRCODE nvarchar(255)= NULL,
   @xSQL nvarchar(max)=Null
AS
BEGIN   	 
	 If @operation='temp_dump'
	    Begin			
			DECLARE @Loc_Code AS VARCHAR(255)

			if (@Loc_Name = 'ALL')
			BEGIN
				SET @Loc_Code = 'ALL'
			END 
			ELSE
			BEGIN
				SELECT TOP 1 @Loc_Code = RTRIM(LTRIM([Loc_Code]))
				FROM War_Room_EssBase_Master_Mapping
				WHERE RTRIM(LTRIM([Location_Name])) = @Loc_Name
			END
			--select @Loc_Name,@Loc_Code
			--select * from War_Room
			--select * from War_Room_temp
			Insert Into dbo.War_Room (nt_id,Emp_name,Levels,Client_Name,Revenue,Budget,[Start_Date],[War_Room_Status],Region,Reason,Loc_Code,Project_Code,Competency_Level)
			Values(@nt_id,@Emp_name,@Level,@Client_Name,@Revenue,@Budget,convert(varchar,getdate(),112),'Active',@Region,@Reason,@Loc_Code,@PRCODE,'Region')
			--select * from truncate table War_Room_temp order by War_Room_ID desc
		End
END



GO
/****** Object:  StoredProcedure [dbo].[sp_War_Room_temp]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_War_Room_temp]
   @operation nvarchar(50)=NULL,
   @nt_id nvarchar(max)=NULL,
   @Emp_Name nvarchar(255)= NULL,
   @Level varchar(50)='Client',
   @Client_Name nvarchar(255),
   @Revenue Float=0,
   @Budget Float=0,
   @War_Room_ID int=0,
   @Region varchar(255)=NULL,
   @Reason nvarchar(255)= NULL,
   @Loc_Name nvarchar(255)= NULL,
   @PRCODE varchar(50),
   @xSQL nvarchar(max)=Null
AS
BEGIN   	 
	 If @operation='temp_dump'
	    Begin
			
			--DECLARE @PRCODE VARCHAR(MAX)

			--Select @PRCODE = FRAW.Project_Code from financeraw2016 FRAW
			--inner join Client_Mapping CM on CM.PRCode=FRAW.Project_Code
			--where Client_Name1 = @Client_Name

			
			DECLARE @Loc_Code AS VARCHAR(255)

			if (@Loc_Name = 'ALL')
			BEGIN
				SET @Loc_Code = 'ALL'
			END 
			ELSE
			BEGIN
				SELECT TOP 1 @Loc_Code = RTRIM(LTRIM([LOCATION_CODE]))
				FROM CLIENT_LOC
				WHERE RTRIM(LTRIM([LOCATION_ NAME])) = @Loc_Name
			END
			--select @Loc_Name,@Loc_Code
			--select * from War_Room
			--select * from War_Room_temp
			Insert Into dbo.War_Room_temp (nt_id,Emp_name,Levels,Client_Name,Revenue,Budget,[Start_Date],[War_Room_Status],Region,Reason,Loc_Code,Project_Code,Competency_Level,xSQL)
			Values(@nt_id,@Emp_name,@Level, @Client_Name,@Revenue,@Budget,convert(varchar,getdate(),112),'Active',@Region,@Reason,@Loc_Code,@PRCODE,'Region',@xSQL)

			--select * from truncate table War_Room_temp order by War_Room_ID desc
		End
END



GO
/****** Object:  StoredProcedure [dbo].[SpBuisnessHeadByCountry]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC [xSPT].[SpBuisnessHeadByCountry] 'India'

CREATE procedure [dbo].[SpBuisnessHeadByCountry]

@sAccessArea nvarchar(50)

AS

Begin

SELECT     10 AS Saving, 45 AS Percentage, 40 AS Risk, xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, 

                      SUM(xSPT.CaptureMonthlyOpportunities.Opportunities) AS Opportunities, xSPT.CaptureMonthlyOpportunities.WorkLocationName AS WorkLocation, 

                      xSPT.BusinessHeads.WorkLocationName, xSPT.BusinessHeads.EmployeeId,Employee.FirstName,Employee.LastName,Employee.dpImage

FROM      xSPT.Employee 
INNER JOIN xSPT.BusinessHeads ON xSPT.Employee.EmployeeID =xSPT.BusinessHeads.EmployeeId INNER JOIN

                      xSPT.CaptureMonthlyOpportunities ON xSPT.BusinessHeads.WorkLocationName = xSPT.CaptureMonthlyOpportunities.WorkLocationName

WHERE     (xSPT.CaptureMonthlyOpportunities.Country = @sAccessArea)

GROUP BY xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, xSPT.CaptureMonthlyOpportunities.WorkLocationName, 

                      xSPT.BusinessHeads.WorkLocationName, xSPT.BusinessHeads.EmployeeId,Employee.FirstName,Employee.LastName,Employee.dpImage



--SELECT 10 AS Saving,45 AS Percentage,40 As Risk,xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, SUM(xSPT.CaptureMonthlyOpportunities.Opportunities) 

--                      AS Opportunities, xSPT.CaptureMonthlyOpportunities.WorkLocationName AS WorkLocation, xSPT.BusinessHeads.EmployeeId AS Expr1, xSPT.Employee.FirstName, 

--                      xSPT.Employee.MiddleName

--FROM         xSPT.Employee RIGHT OUTER JOIN

--                      xSPT.BusinessHeads ON xSPT.Employee.EmployeeID = xSPT.BusinessHeads.EmployeeId RIGHT OUTER JOIN

--                      xSPT.CaptureMonthlyOpportunities ON xSPT.BusinessHeads.WorkLocationCode = xSPT.CaptureMonthlyOpportunities.WorkLocationCode

--WHERE     (xSPT.CaptureMonthlyOpportunities.Country = @sAccessArea)





--GROUP BY xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, xSPT.CaptureMonthlyOpportunities.WorkLocationName, 

--                      xSPT.BusinessHeads.EmployeeId, xSPT.Employee.FirstName, xSPT.Employee.MiddleName



End

GO
/****** Object:  StoredProcedure [dbo].[SpBuisnessHeadByCountry_temp]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC [xSPT].[SpBuisnessHeadByCountry] 'India'
CREATE procedure [dbo].[SpBuisnessHeadByCountry_temp]
@sAccessArea nvarchar(50)
AS
Begin
SELECT 35 AS Saving,45 AS Percentage,xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, SUM(xSPT.CaptureMonthlyOpportunities.Opportunities) 
                      AS Opportunities, xSPT.CaptureMonthlyOpportunities.WorkLocationName AS WorkLocation, xSPT.BusinessHeads.EmployeeId AS Expr1, xSPT.Employee.FirstName, 
                      xSPT.Employee.MiddleName
FROM         xSPT.Employee RIGHT OUTER JOIN
                      xSPT.BusinessHeads ON xSPT.Employee.EmployeeID = xSPT.BusinessHeads.EmployeeId RIGHT OUTER JOIN
                      xSPT.CaptureMonthlyOpportunities ON xSPT.BusinessHeads.WorkLocationCode = xSPT.CaptureMonthlyOpportunities.WorkLocationCode
WHERE     (xSPT.CaptureMonthlyOpportunities.Country = @sAccessArea)

--WHERE     (xSPT.CaptureMonthlyOpportunities.Country = 'INDIA')
GROUP BY xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, xSPT.CaptureMonthlyOpportunities.WorkLocationName, 
                      xSPT.BusinessHeads.EmployeeId, xSPT.Employee.FirstName, xSPT.Employee.MiddleName

End

GO
/****** Object:  StoredProcedure [dbo].[SpBuisnessHeadByRegion]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SpBuisnessHeadByRegion]
@sAccessArea nvarchar(50)
AS
Begin
SELECT     xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, SUM(xSPT.CaptureMonthlyOpportunities.Opportunities) 
                      AS Opportunities, xSPT.CaptureMonthlyOpportunities.WorkLocationName AS WorkLocation, xSPT.BusinessHeads.EmployeeId AS Expr1, xSPT.Employee.FirstName, 
                      xSPT.Employee.MiddleName
FROM         xSPT.Employee RIGHT OUTER JOIN
                      xSPT.BusinessHeads ON xSPT.Employee.EmployeeID = xSPT.BusinessHeads.EmployeeId RIGHT OUTER JOIN
                      xSPT.CaptureMonthlyOpportunities ON xSPT.BusinessHeads.WorkLocationCode = xSPT.CaptureMonthlyOpportunities.WorkLocationCode
WHERE     (xSPT.CaptureMonthlyOpportunities.Country = @sAccessArea)
GROUP BY xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, xSPT.CaptureMonthlyOpportunities.WorkLocationName, 
                      xSPT.BusinessHeads.EmployeeId, xSPT.Employee.FirstName, xSPT.Employee.MiddleName

End

GO
/****** Object:  StoredProcedure [dbo].[SPCaptureHeadByWorkLocation]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPCaptureHeadByWorkLocation]
@WorkLocationName nvarchar(50)
AS
BEGIN
select ProjectName,SUM(Opportunities) AS Opportunities from CaptureMonthlyOpportunities where WorkLocationName=@WorkLocationName group by ProjectName
END

GO
/****** Object:  StoredProcedure [dbo].[spCheck1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCheck1]
@sAccessArea nvarchar(40)
AS
BEGIN
SELECT     xSPT.Employee.dpImage, xSPT.Employee.FirstName, xSPT.Employee.LastName, xSPT.UserTable.SubUserId, xSPT.UserTable.BusinessUnitCode,xSPT.BusinessHeads.WorkLocationName ,
                      xSPT.UserTable.sAccessArea, xSPT.UserTable.Accessarea, xSPT.UserTable.UserId
FROM         xSPT.UserTable INNER JOIN
                   xSPT.Employee  ON xSPT.Employee.EmployeeID = xSPT.UserTable.UserId
                   RIGHT OUTER JOIN
                      xSPT.BusinessHeads ON xSPT.Employee.EmployeeID = xSPT.BusinessHeads.EmployeeId
                      WHERE sAccessArea=@sAccessArea
END

GO
/****** Object:  StoredProcedure [dbo].[SpCheckLogin]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SpCheckLogin]

@UserID nvarchar(50)=null,
@Password nvarchar(12)=null,
@Check int output  



AS
--BEGIN
--SELECT Employee.FirstName,Employee.LastName,UserTable.[Job Classification Job Level],UserTable.Password,UserTable.UserId,UserTable.Accessarea from Employee inner join UserTable on Employee.EmployeeID=UserTable.EmployeeID 
--WHERE UserTable.UserId=@UserID and UserTable.Password=@Password

--END
IF Exists(SELECT * from xSPT.UserTable WHERE xSPT.UserTable.UserId=@UserID and xSPT.UserTable.Password=@Password and xSPT.UserTable.IsActive='True')  
  
 Begin  
  set @Check = 1  
 End  
 Else  
 
 Begin  
  set @Check = 0  
 End

GO
/****** Object:  StoredProcedure [dbo].[SpOpportunitiesRegionBYBuisnessUnitWise]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SpOpportunitiesRegionBYBuisnessUnitWise]
@BusinessUnitCode nvarchar(50)
AS
BEGIN
select  SUM(Opportunities) As Opportunities from xSPT.CaptureMonthlyOpportunities  
where BusinessUnitCode=@BusinessUnitCode
END

GO
/****** Object:  StoredProcedure [dbo].[SPOpportunitiesSiteWise]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPOpportunitiesSiteWise]
@WorkLocationName nvarchar(50)
AS
BEGIN
select  SUM(Opportunities) As Opportunities from xSPT.CaptureMonthlyOpportunities  
where WorkLocationName=@WorkLocationName
END

GO
/****** Object:  StoredProcedure [dbo].[SPREGIONDATASHOW]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPREGIONDATASHOW]
@BusinessUnitCode nvarchar(50)
AS
BEGIN
SELECT     Distinct xSPT.sample.DivisionCode,xSPT.Sample.DivisionName,newTable.Opportunities,newTable.Saving, newTable.Percentage,newTable.Risk from xSPT.Sample
INNER JOIN 
(SELECT 25 AS Saving , 25 as Percentage, 35 as Risk ,xSPT.CaptureMonthlyOpportunities.DivisionCode as bCOdE, SUM(Opportunities) AS Opportunities

FROM         xSPT.CaptureMonthlyOpportunities 
where xSPT.CaptureMonthlyOpportunities.BusinessUnitCode =@BusinessUnitCode
--or xSPT.CaptureMonthlyOpportunities.BusinessUnitCode='OPSNA' or xSPT.CaptureMonthlyOpportunities.BusinessUnitCode='OPSAP' or xSPT.CaptureMonthlyOpportunities.BusinessUnitCode='OPSEM'
GROUP BY DivisionCode
) newTable 

on newTable.bCOdE = xSPT.sample.DivisionCode
END

GO
/****** Object:  StoredProcedure [dbo].[SpSumCountryOpportunities]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SpSumCountryOpportunities]
@Country nvarchar(50)
As
Begin
select  SUM(Opportunities) As Opportunities from xSPT.CaptureMonthlyOpportunities  
where Country=@Country

End

GO
/****** Object:  StoredProcedure [dbo].[SPT_SP_Copy_WFM_Data]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SPT_SP_Copy_WFM_Data]
@xAccount varchar(255),
@xLOB varchar(255),
@xSite varchar(255),
@xMetric varchar(255)


as

BEGIN
	declare @xYear AS varchar(4)=null

	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate())+1)
	End

Select * from (
Select 
 case when convert(varchar,Budgeting_Year)=@xYear then 'WFM_2017' else convert(varchar,Budgeting_Year) end as BudgetingYear,

Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,[Dec]
 from bgt_tbl_Data_upload 
 Where metric = @xMetric
 and Department = 'WFM' and Project_Name = @xAccount and LOB = @xLOB and xSite = @xSite)aa Where aa.BudgetingYear = 'WFM_2017'
 
 end

 


 
GO
/****** Object:  StoredProcedure [dbo].[SPT_SP_View_WFM_Upload]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SPT_SP_View_WFM_Upload] 
@xYear varchar(4)=null
AS

BEGIN
	declare @MaxUploadDT AS datetime

	if isnull(@xYear,'') = ''
	Begin
		set @xYear = Convert(varchar,Year(Getdate())+1)
	End
	
	SELECT CASE WHEN CONVERT(VARCHAR,BUDGETING_YEAR)=@xYear THEN 'WFM_'+@xYear ELSE CONVERT(VARCHAR,BUDGETING_YEAR) END AS BUDGETYEAR,
	JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,[DEC],METRIC
	FROM BGT_TBL_DATA_UPLOAD 
	WHERE METRIC = 'AHT'
	AND DEPARTMENT = 'WFM'
	and Budgeting_For = @xYear
	and xsite = 'RABAT, MOROCCO'

	
END






GO
/****** Object:  StoredProcedure [dbo].[SPT_Unpivot]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPT_Unpivot]

AS
BEGIN

	DECLARE @Positions AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	SELECT DISTINCT Positions Positions INTO #TEMPTABLE
	FROM TBL_SPT_Actuals
	  
	SELECT @Positions = '[' + REPLACE(CONVERT(VARCHAR,TP.Positions,106),' ','-') + '],' + @Positions
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Positions,1) = ','
	BEGIN
		SET @Positions = RIGHT(@Positions,LEN(@Positions) - 1)
	END

	IF RIGHT(@Positions,1) = ','
	BEGIN
		SET @Positions = LEFT(@Positions,LEN(@Positions) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	truncate table tbl_spt_unpivot
	
	SET @xSQL = 'insert into tbl_spt_unpivot select *  from 
	(
		select 
		Client_Name
		,LOB
		,[Site]
		,Positions
		,Essbase_Actual
		from TBL_SPT_Actuals
	) src
		pivot
	(	
		Sum(Essbase_Actual)		
		for Positions in ('+@Positions+')
	) piv'

	print @xSQL
	--execute(@xSQL)
	
	--select Client_Name,LOB,[Site], Trainer as Trainer_Essbase_Actual,Quality as Quality_Essbase_Actual,
	--Others as Others_Essbase_Actual, Coach as Coach_Essbase_Actual, Agent as Agent_Essbase_Actual
	--from tbl_spt_unpivot
	----Drop table tblRosterView
END


GO
/****** Object:  StoredProcedure [dbo].[SPT_Unpivot_Essbase_Actual]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPT_Unpivot_Essbase_Actual]  
  
AS  
BEGIN  
  
 DECLARE @Positions AS VARCHAR(MAX)=''  
  
  
 IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))  
 BEGIN  
  DROP TABLE #TEMPTABLE  
 END  
  
 SELECT DISTINCT Positions Positions INTO #TEMPTABLE  
 FROM TBL_SPT_Actuals  
     
 SELECT @Positions = '[' + REPLACE(CONVERT(VARCHAR,TP.Positions,106),' ','-') + '],' + @Positions  
 FROM #TEMPTABLE TP  
              
              
 IF LEFT(@Positions,1) = ','  
 BEGIN  
  SET @Positions = RIGHT(@Positions,LEN(@Positions) - 1)  
 END  
  
 IF RIGHT(@Positions,1) = ','  
 BEGIN  
  SET @Positions = LEFT(@Positions,LEN(@Positions) - 1)  
 END  
              
              
 --select @Schedule_Date  
  
 declare @xSQL as varchar(max)  
   
 truncate table tbl_spt_unpivot  
   
 SET @xSQL = 'insert into tbl_spt_unpivot select *  from   
 (  
  select   
  Client_Name  
  ,LOB  
  ,[Site]  
  ,Positions  
  ,Essbase_Actual  
  from TBL_SPT_Actuals  
 ) src  
  pivot  
 (   
  Sum(Essbase_Actual)    
  for Positions in ('+@Positions+')  
 ) piv'  
  
print @xSQL  
--execute(@xSQL)  
   
-- Select * from tbl_spt_unpivot  
 --select Client_Name,LOB,[Site], Trainer as Trainer_Essbase_Actual,Quality as Quality_Essbase_Actual,  
 --Others as Others_Essbase_Actual, Coach as Coach_Essbase_Actual, Agent as Agent_Essbase_Actual  
 --from tbl_spt_unpivot  
   
END  
  

GO
/****** Object:  StoredProcedure [dbo].[SPT_Unpivot_Gos_Required]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPT_Unpivot_Gos_Required]

AS
BEGIN

	DECLARE @Positions AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	SELECT DISTINCT Positions Positions INTO #TEMPTABLE
	FROM TBL_SPT_Actuals
	  
	SELECT @Positions = '[' + REPLACE(CONVERT(VARCHAR,TP.Positions,106),' ','-') + '],' + @Positions
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Positions,1) = ','
	BEGIN
		SET @Positions = RIGHT(@Positions,LEN(@Positions) - 1)
	END

	IF RIGHT(@Positions,1) = ','
	BEGIN
		SET @Positions = LEFT(@Positions,LEN(@Positions) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	truncate table tbl_spt_unpivot
	
	SET @xSQL = 'insert into tbl_spt_unpivot select *  from 
	(
		select 
		Client_Name
		,LOB
		,[Site]
		,Positions
		,Gos_Required
		from TBL_SPT_Actuals
	) src
		pivot
	(	
		Max(Gos_Required)		
		for Positions in ('+@Positions+')
	) piv'

	--print @xSQL
	execute(@xSQL)
	
	Select * from tbl_spt_unpivot
	--select Client_Name,LOB,[Site], Trainer as Trainer_Essbase_Actual,Quality as Quality_Essbase_Actual,
	--Others as Others_Essbase_Actual, Coach as Coach_Essbase_Actual, Agent as Agent_Essbase_Actual
	--from tbl_spt_unpivot
	
END


GO
/****** Object:  StoredProcedure [dbo].[SPT_Unpivot_Legal_Required]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPT_Unpivot_Legal_Required]

AS
BEGIN

	DECLARE @Positions AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	SELECT DISTINCT Positions Positions INTO #TEMPTABLE
	FROM TBL_SPT_Actuals
	  
	SELECT @Positions = '[' + REPLACE(CONVERT(VARCHAR,TP.Positions,106),' ','-') + '],' + @Positions
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Positions,1) = ','
	BEGIN
		SET @Positions = RIGHT(@Positions,LEN(@Positions) - 1)
	END

	IF RIGHT(@Positions,1) = ','
	BEGIN
		SET @Positions = LEFT(@Positions,LEN(@Positions) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	truncate table tbl_spt_unpivot
	
	SET @xSQL = 'insert into tbl_spt_unpivot select *  from 
	(
		select 
		Client_Name
		,LOB
		,[Site]
		,Positions
		,Legal_Required
		from TBL_SPT_Actuals
	) src
		pivot
	(	
		Max(Legal_Required)		
		for Positions in ('+@Positions+')
	) piv'

	--print @xSQL
	execute(@xSQL)
	
	Select * from tbl_spt_unpivot
	--select Client_Name,LOB,[Site], Trainer as Trainer_Essbase_Actual,Quality as Quality_Essbase_Actual,
	--Others as Others_Essbase_Actual, Coach as Coach_Essbase_Actual, Agent as Agent_Essbase_Actual
	--from tbl_spt_unpivot
	
END


GO
/****** Object:  StoredProcedure [dbo].[SPT_Unpivot_Sow_Required]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPT_Unpivot_Sow_Required]

AS
BEGIN

	DECLARE @Positions AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	SELECT DISTINCT Positions Positions INTO #TEMPTABLE
	FROM TBL_SPT_Actuals
	  
	SELECT @Positions = '[' + REPLACE(CONVERT(VARCHAR,TP.Positions,106),' ','-') + '],' + @Positions
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Positions,1) = ','
	BEGIN
		SET @Positions = RIGHT(@Positions,LEN(@Positions) - 1)
	END

	IF RIGHT(@Positions,1) = ','
	BEGIN
		SET @Positions = LEFT(@Positions,LEN(@Positions) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	truncate table tbl_spt_unpivot
	
	SET @xSQL = 'insert into tbl_spt_unpivot select *  from 
	(
		select 
		Client_Name
		,LOB
		,[Site]
		,Positions
		,Sow_Required
		from TBL_SPT_Actuals
	) src
		pivot
	(	
		Max(Sow_Required)		
		for Positions in ('+@Positions+')
	) piv'

	--print @xSQL
	execute(@xSQL)
	
	Select * from tbl_spt_unpivot
	--select Client_Name,LOB,[Site], Trainer as Trainer_Essbase_Actual,Quality as Quality_Essbase_Actual,
	--Others as Others_Essbase_Actual, Coach as Coach_Essbase_Actual, Agent as Agent_Essbase_Actual
	--from tbl_spt_unpivot
	
END
GO
/****** Object:  StoredProcedure [dbo].[STAFFING_PLAN]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STAFFING_PLAN]-- @ClientName = 'MEDIA SATURN HOLDING GMBH', @StartDate= '12 Feb 2017',@EndDate ='02 Apr 2017',@Region = ''
(
	@WARROOMID AS INT,
	@StartDate AS SMALLDATETIME,
	@EndDate AS SMALLDATETIME,
	@CAMPAIGN VARCHAR(255)

)
AS

BEGIN
	BEGIN TRY
		
		IF (LTRIM(RTRIM(@CAMPAIGN)) = '')
		BEGIN
			SELECT DISTINCT [Campaign(ROC)][Campaign]
			FROM WAR_ROOMDATA_NORMALISED WRN
			INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = WRN.ESSBASEID AND WREMM.LOC_CODE=WRN.LOCID
			INNER JOIN WAR_ROOM WR ON CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN REPLACE(WREMM.ESSBASE_CLIENT_NAME,'TOTAL ','') ELSE REPLACE(WREMM.PR_NAME,'PR ','') END = WR.CLIENT_NAME 
			AND CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN CLIENT_CODE ELSE PR_CODE END = WR.PROJECT_CODE 
			AND CASE WHEN WR.LOC_CODE = 'ALL' THEN 'ALL' ELSE WREMM.LOC_CODE END = WR.LOC_CODE 
			AND WREMM.REGION=WR.REGION 
			WHERE 1 = 1
			AND WAR_ROOM_ID = @WARROOMID
			AND [ACTUAL WEEK] BETWEEN @STARTDATE AND @ENDDATE 
			ORDER BY 1 ASC;
		END 
		ELSE
		BEGIN
			DECLARE @WeekDate AS VARCHAR(MAX)=''
			DECLARE @xSQL AS VARCHAR(MAX)=''
		
			IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
			BEGIN
			   DROP TABLE #TEMPTABLE
			END

			SELECT DISTINCT [ACTUAL WEEK] [ACTUAL_WEEK]  INTO #TEMPTABLE
			FROM WAR_ROOMDATA_NORMALISED WRN
			INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = WRN.ESSBASEID AND WREMM.LOC_CODE=WRN.LOCID
			INNER JOIN WAR_ROOM WR ON CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN REPLACE(WREMM.ESSBASE_CLIENT_NAME,'TOTAL ','') ELSE REPLACE(WREMM.PR_NAME,'PR ','') END = WR.CLIENT_NAME 
			AND CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN CLIENT_CODE ELSE PR_CODE END = WR.PROJECT_CODE 
			AND CASE WHEN WR.LOC_CODE = 'ALL' THEN 'ALL' ELSE WREMM.LOC_CODE END = WR.LOC_CODE 
			AND WREMM.REGION=WR.REGION 
			WHERE 1 = 1
			AND WAR_ROOM_ID = @WARROOMID
			AND [ACTUAL WEEK] BETWEEN @STARTDATE AND @ENDDATE 
			AND [Campaign(ROC)] = @CAMPAIGN
			ORDER BY [ACTUAL WEEK] ASC;
		
			--SELECT * FROM #TEMPTABLE

			SELECT @WeekDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[ACTUAL_WEEK],106),' ','-') + '],' + @WeekDate
			FROM #TEMPTABLE TP

			IF LEFT(@WeekDate,1) = ','
			BEGIN
				SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
			END

			IF RIGHT(@WeekDate,1) = ','
			BEGIN
				SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
			END

			--select @WeekDate
		
			SET @xSQL = 'SELECT * INTO TEMPTABLE
				FROM (
					SELECT [XTYPE] as Category
					,[ACTUAL WEEK]
					, [XVAL]
					FROM WAR_ROOMDATA_NORMALISED WRN
					INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = WRN.ESSBASEID AND WREMM.LOC_CODE=WRN.LOCID
					INNER JOIN WAR_ROOM WR ON CASE WHEN WR.PROJECT_CODE LIKE ''%TOT%'' THEN REPLACE(WREMM.ESSBASE_CLIENT_NAME,''TOTAL '','''') ELSE REPLACE(WREMM.PR_NAME,''PR '','''') END = WR.CLIENT_NAME 
					AND CASE WHEN WR.PROJECT_CODE LIKE ''%TOT%'' THEN CLIENT_CODE ELSE PR_CODE END = WR.PROJECT_CODE 
					AND CASE WHEN WR.LOC_CODE = ''ALL'' THEN ''ALL'' ELSE WREMM.LOC_CODE END = WR.LOC_CODE 
					AND WREMM.REGION=WR.REGION 
					WHERE 1 = 1
					AND WAR_ROOM_ID = '+ CONVERT(VARCHAR,@WARROOMID) +'
					AND [ACTUAL WEEK] BETWEEN '''+ CONVERT(VARCHAR,@STARTDATE,112) +''' AND '''+ CONVERT(VARCHAR,@ENDDATE,112) +'''
					AND [Campaign(ROC)] = '''+ @CAMPAIGN +'''
				) AS S
				PIVOT
				(
					SUM([XVAL])
					FOR [ACTUAL WEEK] IN ('+ @WEEKDATE +')
				)AS PVT '
			print @xSQL
			EXEC(@xSQL)
	
			SELECT * FROM TEMPTABLE
			DROP TABLE TEMPTABLE
		END
	END TRY
	BEGIN CATCH
		Select 'No record(s) found...' RESULT
	/*
		SELECT ERROR_NUMBER() AS ERRORNUMBER
		,ERROR_SEVERITY() AS ERRORSEVERITY
		,ERROR_STATE() AS ERRORSTATE
		,ERROR_PROCEDURE() AS ERRORPROCEDURE
		,ERROR_LINE() AS ERRORLINE
		,ERROR_MESSAGE() AS ERRORMESSAGE;
		*/
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[STAFFING_PLAN_BU]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STAFFING_PLAN_BU]
-- @ClientName = 'MEDIA SATURN HOLDING GMBH', @StartDate= '12 Feb 2017',@EndDate ='02 Apr 2017',@Region = ''
(
	@CLIENTNAME AS VARCHAR(max),
	@StartDate AS SMALLDATETIME,
	@EndDate AS SMALLDATETIME,
	@REGION VARCHAR(255)  = NULL  
)
AS

BEGIN
	BEGIN TRY
		
		SET @REGION = LTRIM(RTRIM(ISNULL(@REGION,'')))
		
		IF (@REGION = '')
		BEGIN
			SET @REGION = 'ALL'
		END

		DECLARE @WeekDate AS VARCHAR(MAX)=''
		DECLARE @xSQL AS VARCHAR(MAX)=''

		--SET @EndDate = GETDATE()
		--SET @EndDate = DATEADD(DAY, 1 - DATEPART(WEEKDAY, @EndDate), CAST(@EndDate AS SMALLDATETIME))
		--SET @StartDate = DATEADD(WEEK,-12,@EndDate)

		IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
		BEGIN
		   DROP TABLE #TEMPTABLE
		END
		
		Declare @PRCODE varchar(max)

		SELECT top 1 @PRCODE = PRCode FROM Client_Mapping 
		WHERE ISNULL(REPLACE(REPLACE(Client_Name1,'TOTAL ',''),'TOTAL ',''),'') = @CLIENTNAME
		

		SELECT DISTINCT [ACTUAL WEEK] [ACTUAL_WEEK]  INTO #TEMPTABLE
		FROM WAR_ROOMDATA_NORMALISED WR
		WHERE [ACTUAL WEEK] BETWEEN @STARTDATE AND @ENDDATE 
		AND	ESSBASEID = @PRCODE
		AND (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
		ORDER BY [ACTUAL WEEK] ASC;
		
		--SELECT * FROM #TEMPTABLE

		SELECT @WeekDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[ACTUAL_WEEK],106),' ','-') + '],' + @WeekDate
		FROM #TEMPTABLE TP

		IF LEFT(@WeekDate,1) = ','
		BEGIN
			SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
		END

		IF RIGHT(@WeekDate,1) = ','
		BEGIN
			SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
		END

		--select @WeekDate
		
		SET @xSQL = 'SELECT * INTO TEMPTABLE
			FROM (
				SELECT [XTYPE] as Category
				,[ACTUAL WEEK]
				, [XVAL]
				FROM WAR_ROOMDATA_NORMALISED WR 
				INNER JOIN [Client_Mapping] CM on CM.PRCode = WR.ESSBASEID
				WHERE [ACTUAL WEEK] BETWEEN '''+ CONVERT(VARCHAR,@STARTDATE,112) +''' AND '''+ CONVERT(VARCHAR,@ENDDATE,112) +'''
				AND ISNULL(REPLACE(REPLACE(Client_Name1,''TOTAL '',''''),''GRAND '',''''),'''') = ''' + @CLIENTNAME +'''
				AND (REGION = '''+@REGION+'''  OR  '''+@REGION+''' = ''ALL'')
			) AS S
			PIVOT
			(
				SUM([XVAL])
				FOR [ACTUAL WEEK] IN ('+ @WEEKDATE +')
			)AS PVT '
		print @xSQL
		EXEC(@xSQL)
	
		SELECT * FROM TEMPTABLE
		DROP TABLE TEMPTABLE
	END TRY
	BEGIN CATCH
		Select 'No record(s) found...' RESULT
	/*
		SELECT ERROR_NUMBER() AS ERRORNUMBER
		,ERROR_SEVERITY() AS ERRORSEVERITY
		,ERROR_STATE() AS ERRORSTATE
		,ERROR_PROCEDURE() AS ERRORPROCEDURE
		,ERROR_LINE() AS ERRORLINE
		,ERROR_MESSAGE() AS ERRORMESSAGE;
		*/
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SumCountryOpportunities]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SumCountryOpportunities]
@Country nvarchar(50)
As
Begin
select  SUM(Opportunities) As Opportunities from xSPT.CaptureMonthlyOpportunities  
where Country=@Country

End

GO
/****** Object:  StoredProcedure [dbo].[SumOpportunities]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SumOpportunities]
@Country nvarchar(50)
As
Begin
select Country,WorkLocationCode, SUM(Opportunities) As Opportunities from xSPT.CaptureMonthlyOpportunities  
where Country=@Country
Group by   Country ,WorkLocationCode   

End

GO
/****** Object:  StoredProcedure [dbo].[TA_Check_WO]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TA_Check_WO]
(
@ECN AS BIGINT,
@SCHEDULE_DATE AS DATETIME
)
AS

Select SUM(WOCnt)
from (
	SELECT xDate,Case When Shift_Time = 'WO' Then 1 ELSE 0 End AS WOCnt
	FROM NEW_ROSTER_ENTRY NRE
	Inner join [xGetWeekDates](@SCHEDULE_DATE,1,'d') GWD on Schedule_Date = xDate
	WHERE ECN = @ECN
	Union
	select [Date] xDate,Case When Leave_Type = 'WO' Then 1 ELSE 0 End AS WOCnt
	FROM TA_TBL_LEAVE_BY_DATES TTLBD
	Inner join [xGetWeekDates](@SCHEDULE_DATE,1,'d') GWD on [Date] = xDate
	WHERE Username = @ECN
) Tmp

GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TDC_EMP_SKILL_MAPPING_MST]
(
	@WHOUPDATED AS VARCHAR(155),
	@WHENUPDATED AS DATETIME
)
AS
BEGIN
	DECLARE @xEMPCODE AS INT = 0
	DECLARE @xSkill_ID AS INT = 0
	DECLARE @xCnt AS INT = 0
	DECLARE @Heading AS VARCHAR(MAX) = ''
	DECLARE @xSQL AS VARCHAR(MAX) = ''

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TMPTABLE'))	
	BEGIN	
	   DROP TABLE #TMPTABLE
	END	

	CREATE TABLE #TMPTABLE
	(
		[EmpCode] [int] NOT NULL,
		[Skill_ID] [int] NOT NULL,
		[Cal_Capacity] [int] NOT NULL,
		[xRank] [int] NOT NULL,
		[WhoUpdated] [varchar](255) NOT NULL,
		[WhenUpdated] [datetime] NOT NULL
	) ON [PRIMARY]

	DECLARE XCURSOR CURSOR FOR
	SELECT EMPCODE FROM TBL_TDC_EMPMASTER
	WHERE EMPSTATUS = 1

	OPEN XCURSOR   
	FETCH NEXT FROM XCURSOR INTO @xEMPCODE   

	WHILE @@FETCH_STATUS = 0   
	BEGIN 
				INSERT INTO #TMPTABLE 
				SELECT [EMPCODE],[Skill_ID],SUM([Cal_Capacity]) [Cal_Capacity],SUM([xRank]) [xRank], [WHOUPDATED],[WHENUPDATED]
				FROM (
						SELECT @xEMPCODE [EMPCODE],TTE.[Skill_ID],[Cal_Capacity],0 [xRank],@WHOUPDATED [WHOUPDATED],@WHENUPDATED [WHENUPDATED]
						FROM TBL_TDC_EMPSKILLMAPING TTE
						INNER JOIN TBL_TDC_SKILLMST TTS ON TTE.Skill_ID = TTS.Skill_ID
						WHERE EMPCODE = @xEMPCODE
						AND TTS.[ACTIVE] = 1
						UNION ALL
						SELECT @xEMPCODE [EMPCODE],[Skill_ID],0 [Cal_Capacity],0 [xRank],@WHOUPDATED [WHOUPDATED],@WHENUPDATED [WHENUPDATED]
						FROM TBL_TDC_SKILLMST TTS
						WHERE TTS.[ACTIVE] = 1
				) TMP
				GROUP BY [EMPCODE],[Skill_ID],[WHOUPDATED],[WHENUPDATED]

		FETCH NEXT FROM XCURSOR INTO @xEMPCODE   
	END   

	CLOSE XCURSOR   
	DEALLOCATE XCURSOR 

	TRUNCATE TABLE TBL_TDC_EMPSKILLMAPING;
	
	INSERT INTO TBL_TDC_EMPSKILLMAPING SELECT * FROM #TMPTABLE;
	
	SELECT @Heading = @Heading + ',[' + [SKILL_NAME] + ']'
	FROM TBL_TDC_SKILLMST
	WHERE [ACTIVE] = 1

	IF LEFT(@Heading,1) = ','
	BEGIN
		SET @Heading = RIGHT(@Heading,LEN(@Heading) - 1)
	END

	IF RIGHT(@Heading,1) = ','
	BEGIN
		SET @Heading = LEFT(@Heading,LEN(@Heading) - 1)
	END

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLE'))	
	BEGIN	
	   DROP TABLE TEMPTABLE
	END

	SET @xSQL = 'SELECT * INTO TEMPTABLE FROM 
		(
			SELECT TTE.EMPCODE,TTEM.FIRST_NAME+'' ''+TTEM.LAST_NAME [NAME],
			TTS.SKILL_NAME,[Cal_Capacity]
			FROM TBL_TDC_EMPSKILLMAPING TTE
			INNER JOIN TBL_TDC_EMPMASTER TTEM ON TTEM.EMPCODE=TTE.EMPCODE
			INNER JOIN TBL_TDC_SKILLMST TTS ON TTE.SKILL_ID = TTS.SKILL_ID
		) as s
		PIVOT
		(
			SUM([Cal_Capacity])
			FOR [SKILL_NAME] IN ('+ @Heading +')
		)AS PVT'
	--Print @xSQL
	EXEC(@xSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills]
(
	@WHOUPDATED AS VARCHAR(155),
	@WHENUPDATED AS DATETIME,
	@Skill_ID INT,
	@xSTARTDATE AS SMALLDATETIME = null,
	@xENDDATE AS SMALLDATETIME = null
)
AS
BEGIN
	
	IF ISDATE(@xSTARTDATE) = 0
	BEGIN
		Set @xSTARTDATE = GETDATE()
	END

	IF ISDATE(@xENDDATE) = 0
	BEGIN
		Set @xENDDATE = GETDATE()
	END

	DECLARE @xEMPCODE AS INT = 0
	DECLARE @xSkill_ID AS INT = 0
	DECLARE @xCnt AS INT = 0
	DECLARE @Heading AS VARCHAR(MAX) = ''
	DECLARE @xSQL AS VARCHAR(MAX) = ''

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TDC_TEMPTABLE'))	
	BEGIN	
	   DROP TABLE #TDC_TEMPTABLE
	END	

	CREATE TABLE #TDC_TEMPTABLE
	(
		[EmpCode] [int] NOT NULL,
		[Skill_ID] [int] NOT NULL,
		[Cal_Capacity] [int] NOT NULL,
		[xRank] [int] NOT NULL,
		[xWeekCommencing] DATETIME NOT NULL,
		[WhoUpdated] [varchar](255) NOT NULL,
		[WhenUpdated] [datetime] NOT NULL
	) ON [PRIMARY];
	
	DECLARE @STARTDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,0,DATEADD(DD, -(DATEPART(DW, @XSTARTDATE)-1), @XSTARTDATE)),112)
	DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,0,DATEADD(DD, -(DATEPART(DW, @xENDDATE)-1), @xENDDATE)),112)
	--DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,(7 * 13),DATEADD(DD, -(DATEPART(DW, @xENDDATE)-1), GETDATE())),112)
	
	--select @STARTDATE, @ENDDATE

	--DECLARE XCURSOR CURSOR FOR
	--SELECT EMPCODE FROM TBL_TDC_EMPMASTER
	--WHERE EMPSTATUS = 1

	--OPEN XCURSOR   
	--FETCH NEXT FROM XCURSOR INTO @xEMPCODE   

	--WHILE @@FETCH_STATUS = 0   
	--BEGIN
		WHILE @STARTDATE <= @ENDDATE
		BEGIN
			INSERT INTO #TDC_TEMPTABLE 
			SELECT [EMPCODE], @Skill_ID [Skill_ID],0 [Cal_Capacity],0 [xRank],@STARTDATE [xWeekCommencing], @WHOUPDATED [WHOUPDATED],@WHENUPDATED [WHENUPDATED]
			FROM TBL_TDC_EMPMASTER
			WHERE EMPSTATUS = 1
			
			SET @STARTDATE = DATEADD(d,7,@STARTDATE)
		END
		
	--	FETCH NEXT FROM XCURSOR INTO @xEMPCODE   
	--END   

	--CLOSE XCURSOR   
	--DEALLOCATE XCURSOR 
	
	SET @STARTDATE = CONVERT(VARCHAR,DATEADD(DD,0,DATEADD(DD, -(DATEPART(DW, @XSTARTDATE)-1), @XSTARTDATE)),112)
	
	DELETE FROM TBL_TDC_EMPSKILLMAPING
	WHERE 1 = 1
	--AND Skill_ID = @Skill_ID
	AND [xWeekCommencing] BETWEEN @STARTDATE AND  @ENDDATE
	--AND SKILL_ID = @Skill_ID;
	
	INSERT INTO TBL_TDC_EMPSKILLMAPING SELECT * FROM #TDC_TEMPTABLE;
	
	
	WHILE @STARTDATE <= @ENDDATE
	BEGIN
		SET @Heading = @Heading + ',[' + CONVERT(VARCHAR,@STARTDATE,106) + ']' 
		SET @STARTDATE = DATEADD(d,7,@STARTDATE)
	END

	--SELECT @Heading = @Heading + ',[' + [SKILL_NAME] + ']'
	--FROM TBL_TDC_SKILLMST
	--WHERE [ACTIVE] = 1

	IF LEFT(@Heading,1) = ','
	BEGIN
		SET @Heading = RIGHT(@Heading,LEN(@Heading) - 1)
	END

	IF RIGHT(@Heading,1) = ','
	BEGIN
		SET @Heading = LEFT(@Heading,LEN(@Heading) - 1)
	END

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TDC_TEMPTABLE'))	
	BEGIN	
	   DROP TABLE TDC_TEMPTABLE
	END
	
	SET @xSQL = 'SELECT * INTO TDC_TEMPTABLE FROM 
		(
			SELECT TTE.EMPCODE,TTEM.FIRST_NAME+'' ''+TTEM.LAST_NAME [NAME],
			TTS.SKILL_NAME,[Cal_Capacity],[xWeekCommencing]
			FROM TBL_TDC_EMPSKILLMAPING TTE
			INNER JOIN TBL_TDC_EMPMASTER TTEM ON TTEM.EMPCODE=TTE.EMPCODE
			INNER JOIN TBL_TDC_SKILLMST TTS ON TTE.SKILL_ID = TTS.SKILL_ID
			WHERE TTS.SKILL_ID='+ CONVERT(VARCHAR,@Skill_ID) +'
		) as s
		PIVOT
		(
			SUM([Cal_Capacity])
			FOR [xWeekCommencing] IN ('+ @Heading +')
		)AS PVT'
	Print @xSQL
	EXEC(@xSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed]
(
	@Skill_ID INT
)
AS
BEGIN
	
	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TDC_TEMPTABLE2'))	
	BEGIN	
	   DROP TABLE TDC_TEMPTABLE2
	END
	
	DECLARE @STARTDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,-7 * 13,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,(-7),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @MIN INT = 1;
	DECLARE @MAX INT = 5;
	declare @xCnt int = 0;

	WITH CTE AS ( 
		SELECT TTTAD.*,
		DENSE_RANK() OVER(PARTITION BY TTTAD.SKILL_ID ORDER BY TTTAD.AHT ASC ) AS SKILL_RANK
		FROM [TBL_TDC_EMPMASTER] TTE
		INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
		WHERE EMPSTATUS = 1
		AND WEEKCOMMENCING BETWEEN @STARTDATE and @ENDDATE
		and Skill_ID = @Skill_ID
	)


	Select @xCnt = COUNT(*) 
	from CTE;

	SET @XCNT = @XCNT / 5;

	WITH CTE AS ( 
		SELECT TTTAD.*,
		--DENSE_RANK() OVER(PARTITION BY TTTAD.SKILL_ID ORDER BY TTTAD.AHT ASC ) AS SKILL_RANK
		Row_number() OVER(PARTITION BY TTTAD.SKILL_ID ORDER BY TTTAD.AHT ASC ) AS SKILL_RANK
		FROM [TBL_TDC_EMPMASTER] TTE
		INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
		WHERE EMPSTATUS = 1
		AND WEEKCOMMENCING BETWEEN @STARTDATE and @ENDDATE
		and Skill_ID = @Skill_ID
	)


	SELECT * ,
	CASE WHEN SKILL_RANK <= @XCNT * 1 THEN @MIN ELSE 
	CASE WHEN SKILL_RANK <= @XCNT * 2 THEN @MIN + 1 ELSE 
	CASE WHEN SKILL_RANK <= @XCNT * 3 THEN @MIN + 2 ELSE 
	CASE WHEN SKILL_RANK <= @XCNT * 4 THEN @MIN + 3 ELSE @MIN + 4 END END END END AS SKILL_BUCKET
	INTO TDC_TEMPTABLE2
	FROM CTE;
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed_Part2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed_Part2] --'10'
(
	@Skill_ID Varchar(max),
	@xSTARTDATE AS SMALLDATETIME = null,
	@xENDDATE AS SMALLDATETIME = null
)
AS
BEGIN
	DECLARE @xSkill_ID INT = 0

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TDC_TEMPTABLE3'))	
	BEGIN	
		DROP TABLE TDC_TEMPTABLE3
	END

	CREATE TABLE TDC_TEMPTABLE3
	(
		TransID INT IDENTITY(1,1),
		EmpCode INT NOT NULL,
		Skill_ID INT NOT NULL,
		WeekCommencing DATETIME NOT NULL,
		Calls INT NOT NULL,
		AHT INT NOT NULL,
		FCR INT NOT NULL,
		WhoUpdated VARCHAR(10) NOT NULL,
		WhenUpdated DATETIME NOT NULL,
		SKILL_RANK INT NOT NULL,
		SKILL_BUCKET INT NOT NULL
	);

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TDC_TEMPTABLE'))	
	BEGIN	
	   DROP TABLE #TDC_TEMPTABLE
	END	;

	CREATE TABLE #TDC_TEMPTABLE
	(
		TransID INT IDENTITY(1,1),
		EmpCode INT NOT NULL,
		Skill_ID INT NOT NULL,
		WeekCommencing DATETIME NOT NULL,
		Calls INT NOT NULL,
		AHT INT NOT NULL,
		FCR INT NOT NULL,
		WhoUpdated VARCHAR(10) NOT NULL,
		WhenUpdated DATETIME NOT NULL,
		SKILL_RANK INT NOT NULL,
		SKILL_BUCKET INT NOT NULL
	);

	DECLARE @STARTDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,-7 * 13,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,(-7),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @MIN INT = 1;
	DECLARE @MAX INT = 5;
	Declare @xCnt int = 0;
	DECLARE @xAHT INT = 0;
	
	DECLARE xCursor CURSOR  
    FOR SELECT * FROM [SPLITSTRING](@Skill_ID,',')  
	OPEN xCursor  
	FETCH NEXT FROM xCursor INTO @xSkill_ID; 

	WHILE @@FETCH_STATUS = 0  
	BEGIN
		SET @STARTDATE = CONVERT(VARCHAR,DATEADD(DD,-7 * 13,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
		SET @ENDDATE = CONVERT(VARCHAR,DATEADD(DD,(-7),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
		SET @MIN = 1;
		SET @MAX = 5;
		SET @xCnt = 0;
		SET @xAHT = 0;
		
		SELECT @xAHT = (AHT * 75/100) 
		FROM (
			SELECT SUM(Calls) [Calls],
			SUM([Calls]*[AHT])/SUM(Calls) [AHT]
			FROM [TBL_TDC_EMPMASTER] TTE
			INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
			WHERE EMPSTATUS = 1
			AND WEEKCOMMENCING BETWEEN @STARTDATE and @ENDDATE
			AND Skill_ID = @xSkill_ID
			AND TTTAD.EmpCode NOT IN (SELECT EMPCODE FROM #TDC_TEMPTABLE WHERE SKILL_BUCKET = 1)
		) TMP;

		--WITH CTE AS ( 
		--	SELECT TTTADx.*,
		--	DENSE_RANK() OVER(PARTITION BY TTTADx.SKILL_ID ORDER BY TTTADx.AHT ASC ) AS SKILL_RANK,0 SKILL_BUCKET
		--	FROM (
		--		SELECT TTTAD.EMPCODE,TTTAD.SKILL_ID,GETDATE() WEEKCOMMENCING,
		--		SUM(CALLS) [CALLS],
		--		CASE WHEN SUM([CALLS]*[AHT])/SUM(CALLS) < @xAHT/2 THEN @xAHT ELSE SUM([CALLS]*[AHT])/SUM(CALLS) END [AHT],
		--		0 FCR,'' WHOUPDATED,GETDATE() WHENUPDATED
		--		FROM [TBL_TDC_EMPMASTER] TTE
		--		INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
		--		WHERE EMPSTATUS = 1
		--		AND WEEKCOMMENCING BETWEEN @STARTDATE AND @ENDDATE
		--		AND Skill_ID = @xSkill_ID
		--		AND TTTAD.EmpCode NOT IN (SELECT EMPCODE FROM #TDC_TEMPTABLE WHERE SKILL_BUCKET = 1)
		--		GROUP BY TTTAD.EMPCODE,TTTAD.SKILL_ID
		--	) TTTADx
		--)


		--Select @xCnt = COUNT(*) 
		--from CTE;

		--SET @XCNT = @XCNT / 5;
		
		
		WITH CTE AS ( 
			SELECT TTTADx.*,
			Row_number() OVER(PARTITION BY TTTADx.SKILL_ID ORDER BY TTTADx.AHT ASC ) AS SKILL_RANK,0 SKILL_BUCKET
			FROM (
				SELECT TTTAD.EMPCODE,TTTAD.SKILL_ID,GETDATE() WEEKCOMMENCING,
				SUM(CALLS) [CALLS],
				CASE WHEN SUM([CALLS]*[AHT])/SUM(CALLS) < @xAHT THEN @xAHT ELSE SUM([CALLS]*[AHT])/SUM(CALLS) END [AHT],
				0 FCR,'' WHOUPDATED,GETDATE() WHENUPDATED
				FROM [TBL_TDC_EMPMASTER] TTE
				INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
				WHERE EMPSTATUS = 1
				AND WEEKCOMMENCING BETWEEN @STARTDATE AND @ENDDATE
				AND Skill_ID = @xSkill_ID
				AND TTTAD.EmpCode NOT IN (SELECT EMPCODE FROM #TDC_TEMPTABLE WHERE SKILL_BUCKET = 1)
				GROUP BY TTTAD.EMPCODE,TTTAD.SKILL_ID
			) TTTADx
		)

		INSERT INTO #TDC_TEMPTABLE SELECT *
		FROM CTE;

		Select @xCnt = COUNT(*) 
		from #TDC_TEMPTABLE
		WHERE Skill_ID = @xSkill_ID;

		SET @XCNT = @XCNT / 5;
		

		SET @STARTDATE  = CONVERT(VARCHAR,DATEADD(DD,0,DATEADD(DD, -(DATEPART(DW, @XSTARTDATE)-1), @XSTARTDATE)),112)
		SET @ENDDATE = CONVERT(VARCHAR,DATEADD(DD,0,DATEADD(DD, -(DATEPART(DW, @xENDDATE)-1), @xENDDATE)),112)
		--SET @ENDDATE = CONVERT(VARCHAR,DATEADD(DD,(7  * 13),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
		Select @STARTDATE,@ENDDATE
		WHILE (@STARTDATE <= @ENDDATE)
		BEGIN
			INSERT INTO TDC_TEMPTABLE3 
			SELECT [EMPCODE],[SKILL_ID],@STARTDATE [WEEKCOMMENCING],[CALLS],[AHT],[FCR],[WHOUPDATED],[WHENUPDATED],
			[SKILL_RANK],
			CASE WHEN SKILL_RANK <= @XCNT * 1 THEN @MIN ELSE 
			CASE WHEN SKILL_RANK <= @XCNT * 2 THEN @MIN + 1 ELSE 
			CASE WHEN SKILL_RANK <= @XCNT * 3 THEN @MIN + 2 ELSE 
			CASE WHEN SKILL_RANK <= @XCNT * 4 THEN @MIN + 3 ELSE 
			@MIN + 4 END END END END AS SKILL_BUCKET
			FROM #TDC_TEMPTABLE
			WHERE Skill_ID = @xSkill_ID
			AND EMPCODE NOT IN (SELECT EMPCODE FROM #TDC_TEMPTABLE WHERE Skill_ID <> @xSkill_ID and SKILL_BUCKET=1)
			;

			SET @STARTDATE = DATEADD(d,7,@STARTDATE)
		END
	
		FETCH NEXT FROM xCursor INTO @xSkill_ID
	END   
	CLOSE xCursor;  
	DEALLOCATE xCursor
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed_Part2_BU_20170331]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed_Part2_BU_20170331]
(
	@Skill_ID Varchar(max)
)
AS
BEGIN
	
	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLE3'))	
	BEGIN	
		DROP TABLE TEMPTABLE3
	END

	CREATE TABLE TEMPTABLE3
	(
		TransID INT IDENTITY(1,1),
		EmpCode INT NOT NULL,
		Skill_ID INT NOT NULL,
		WeekCommencing DATETIME NOT NULL,
		Calls INT NOT NULL,
		AHT INT NOT NULL,
		FCR INT NOT NULL,
		WhoUpdated VARCHAR(10) NOT NULL,
		WhenUpdated DATETIME NOT NULL,
		SKILL_RANK INT NOT NULL,
		SKILL_BUCKET INT NOT NULL
	);

	DECLARE @STARTDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,-7 * 13,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,(-7),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @MIN INT = 1;
	DECLARE @MAX INT = 5;
	declare @xCnt int = 0;

	WITH CTE AS ( 
		SELECT TTTAD.*,
		DENSE_RANK() OVER(PARTITION BY TTTAD.SKILL_ID ORDER BY TTTAD.AHT ASC ) AS SKILL_RANK
		FROM [TBL_TDC_EMPMASTER] TTE
		INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
		WHERE EMPSTATUS = 1
		AND WEEKCOMMENCING BETWEEN @STARTDATE and @ENDDATE
		--and Skill_ID = @Skill_ID
		and CONVERT(VARCHAR,Skill_ID) in (SELECT * FROM [SPLITSTRING](@Skill_ID,','))
	)


	Select @xCnt = COUNT(*) 
	from CTE;

	SET @XCNT = @XCNT / 5;
	
	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TMPTABLE'))	
	BEGIN	
	   DROP TABLE #TMPTABLE
	END	;

	WITH CTE AS ( 
		SELECT TTTAD.*,
		--DENSE_RANK() OVER(PARTITION BY TTTAD.SKILL_ID ORDER BY TTTAD.AHT ASC ) AS SKILL_RANK
		Row_number() OVER(PARTITION BY TTTAD.SKILL_ID ORDER BY TTTAD.AHT ASC ) AS SKILL_RANK
		FROM [TBL_TDC_EMPMASTER] TTE
		INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
		WHERE EMPSTATUS = 1
		AND WEEKCOMMENCING BETWEEN @STARTDATE and @ENDDATE
		--and Skill_ID = @Skill_ID
		and CONVERT(VARCHAR,Skill_ID) in (SELECT * FROM [SPLITSTRING](@Skill_ID,','))
	)

	SELECT * INTO #TMPTABLE
	FROM CTE;

	SET @STARTDATE = CONVERT(VARCHAR,DATEADD(DD,7,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	SET @ENDDATE = CONVERT(VARCHAR,DATEADD(DD,(7  * 13),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);

	WHILE (@STARTDATE <= @ENDDATE)
	BEGIN
		INSERT INTO TEMPTABLE3 
		SELECT [EMPCODE],[SKILL_ID],@STARTDATE [WEEKCOMMENCING],[CALLS],[AHT],[FCR],[WHOUPDATED],[WHENUPDATED],
		[SKILL_RANK],
		CASE WHEN SKILL_RANK <= @XCNT * 1 THEN @MIN ELSE 
		CASE WHEN SKILL_RANK <= @XCNT * 2 THEN @MIN + 1 ELSE 
		CASE WHEN SKILL_RANK <= @XCNT * 3 THEN @MIN + 2 ELSE 
		CASE WHEN SKILL_RANK <= @XCNT * 4 THEN @MIN + 3 ELSE 
		@MIN + 4 END END END END AS SKILL_BUCKET
		FROM #TMPTABLE;

		SET @STARTDATE = DATEADD(d,7,@STARTDATE)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed_Part3]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Bucket1_Fixed_Part3] --'10'
(
	@Skill_ID Varchar(max)
)
AS
BEGIN
	DECLARE @xSkill_ID INT = 0

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLE3'))	
	BEGIN	
		DROP TABLE TEMPTABLE3
	END

	CREATE TABLE TEMPTABLE3
	(
		TransID INT IDENTITY(1,1),
		EmpCode INT NOT NULL,
		Skill_ID INT NOT NULL,
		WeekCommencing DATETIME NOT NULL,
		Calls INT NOT NULL,
		AHT INT NOT NULL,
		FCR INT NOT NULL,
		WhoUpdated VARCHAR(10) NOT NULL,
		WhenUpdated DATETIME NOT NULL,
		SKILL_RANK INT NOT NULL,
		SKILL_BUCKET INT NOT NULL
	);

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TMPTABLE'))	
	BEGIN	
	   DROP TABLE #TMPTABLE
	END	;

	CREATE TABLE #TMPTABLE
	(
		TransID INT IDENTITY(1,1),
		EmpCode INT NOT NULL,
		Skill_ID INT NOT NULL,
		WeekCommencing DATETIME NOT NULL,
		Calls INT NOT NULL,
		AHT INT NOT NULL,
		FCR INT NOT NULL,
		WhoUpdated VARCHAR(10) NOT NULL,
		WhenUpdated DATETIME NOT NULL,
		SKILL_RANK INT NOT NULL,
		SKILL_BUCKET INT NOT NULL
	);

	DECLARE @STARTDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,-7 * 13,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,(-7),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
	DECLARE @MIN INT = 1;
	DECLARE @MAX INT = 5;
	Declare @xCnt int = 0;
	DECLARE @xAHT INT = 0;
	
	DECLARE xCursor CURSOR  
    FOR SELECT * FROM [SPLITSTRING](@Skill_ID,',')  
	OPEN xCursor  
	FETCH NEXT FROM xCursor INTO @xSkill_ID; 

	WHILE @@FETCH_STATUS = 0  
	BEGIN
		SET @xAHT = 0;
		
		SELECT @xAHT = (AHT * 75/100) 
		FROM (
		SELECT SUM(Calls) [Calls],
		SUM([Calls]*[AHT])/SUM(Calls) [AHT]
		FROM [TBL_TDC_EMPMASTER] TTE
		INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
		WHERE EMPSTATUS = 1
		AND WEEKCOMMENCING BETWEEN @STARTDATE and @ENDDATE
		AND Skill_ID = @xSkill_ID
		) TMP;


		WITH CTE AS ( 
			SELECT TTTADx.*,
			DENSE_RANK() OVER(PARTITION BY TTTADx.SKILL_ID ORDER BY TTTADx.AHT ASC ) AS SKILL_RANK,0 SKILL_BUCKET
			FROM (
				SELECT TTTAD.EMPCODE,TTTAD.SKILL_ID,GETDATE() WEEKCOMMENCING,
				SUM(CALLS) [CALLS],
				CASE WHEN SUM([CALLS]*[AHT])/SUM(CALLS) < @xAHT/2 THEN @xAHT ELSE SUM([CALLS]*[AHT])/SUM(CALLS) END [AHT],
				0 FCR,'' WHOUPDATED,GETDATE() WHENUPDATED
				FROM [TBL_TDC_EMPMASTER] TTE
				INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
				WHERE EMPSTATUS = 1
				AND WEEKCOMMENCING BETWEEN @STARTDATE AND @ENDDATE
				AND Skill_ID = @xSkill_ID
				AND TTTAD.EmpCode NOT IN (SELECT EMPCODE FROM #TMPTABLE WHERE SKILL_BUCKET = 1)
				GROUP BY TTTAD.EMPCODE,TTTAD.SKILL_ID
			) TTTADx
		)


		Select @xCnt = COUNT(*) 
		from CTE;

		SET @XCNT = @XCNT / 5;
	
		WITH CTE AS ( 
			SELECT TTTADx.*,
			Row_number() OVER(PARTITION BY TTTADx.SKILL_ID ORDER BY TTTADx.AHT ASC ) AS SKILL_RANK,0 SKILL_BUCKET
			FROM (
				SELECT TTTAD.EMPCODE,TTTAD.SKILL_ID,GETDATE() WEEKCOMMENCING,
				SUM(CALLS) [CALLS],
				CASE WHEN SUM([CALLS]*[AHT])/SUM(CALLS) < @xAHT/2 THEN @xAHT ELSE SUM([CALLS]*[AHT])/SUM(CALLS) END [AHT],
				0 FCR,'' WHOUPDATED,GETDATE() WHENUPDATED
				FROM [TBL_TDC_EMPMASTER] TTE
				INNER JOIN [TBL_TDC_TELEPHONY_AGENT_DATA] TTTAD ON TTTAD.EMPCODE=TTE.EMPCODE
				WHERE EMPSTATUS = 1
				AND WEEKCOMMENCING BETWEEN @STARTDATE AND @ENDDATE
				AND Skill_ID = @xSkill_ID
				AND TTTAD.EmpCode NOT IN (SELECT EMPCODE FROM #TMPTABLE WHERE SKILL_BUCKET = 1)
				GROUP BY TTTAD.EMPCODE,TTTAD.SKILL_ID
			) TTTADx
		)

		INSERT INTO #TMPTABLE SELECT *
		FROM CTE;

		SET @STARTDATE = CONVERT(VARCHAR,DATEADD(DD,7,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);
		SET @ENDDATE = CONVERT(VARCHAR,DATEADD(DD,(7  * 13),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112);

		WHILE (@STARTDATE <= @ENDDATE)
		BEGIN
			INSERT INTO TEMPTABLE3 
			SELECT [EMPCODE],[SKILL_ID],@STARTDATE [WEEKCOMMENCING],[CALLS],[AHT],[FCR],[WHOUPDATED],[WHENUPDATED],
			[SKILL_RANK],
			CASE WHEN SKILL_RANK <= @XCNT * 1 THEN @MIN ELSE 
			CASE WHEN SKILL_RANK <= @XCNT * 2 THEN @MIN + 1 ELSE 
			CASE WHEN SKILL_RANK <= @XCNT * 3 THEN @MIN + 2 ELSE 
			CASE WHEN SKILL_RANK <= @XCNT * 4 THEN @MIN + 3 ELSE 
			@MIN + 4 END END END END AS SKILL_BUCKET
			FROM #TMPTABLE;

			SET @STARTDATE = DATEADD(d,7,@STARTDATE)
		END
	
		FETCH NEXT FROM xCursor INTO @xSkill_ID
	END   
	CLOSE xCursor;  
	DEALLOCATE xCursor
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Part2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TDC_EMP_SKILL_MAPPING_MST_By_Skills_Part2]
(
	@WHOUPDATED AS VARCHAR(155),
	@WHENUPDATED AS DATETIME,
	@Skill_ID INT
)
AS
BEGIN
	DECLARE @xEMPCODE AS INT = 0
	DECLARE @xSkill_ID AS INT = 0
	DECLARE @xCnt AS INT = 0
	DECLARE @Heading AS VARCHAR(MAX) = ''
	DECLARE @xSQL AS VARCHAR(MAX) = ''

	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TMPTABLE'))	
	BEGIN	
	   DROP TABLE #TMPTABLE
	END	

	CREATE TABLE #TMPTABLE
	(
		[EmpCode] [int] NOT NULL,
		[Skill_ID] [int] NOT NULL,
		[Cal_Capacity] [int] NOT NULL,
		[xRank] [int] NOT NULL,
		[xWeekCommencing] DATETIME NOT NULL,
		[WhoUpdated] [varchar](255) NOT NULL,
		[WhenUpdated] [datetime] NOT NULL
	) ON [PRIMARY]

	DECLARE @STARTDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,7,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112)
	DECLARE @ENDDATE AS SMALLDATETIME = CONVERT(VARCHAR,DATEADD(DD,(7 * 13),DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112)

	--DECLARE XCURSOR CURSOR FOR
	--SELECT EMPCODE FROM TBL_TDC_EMPMASTER
	--WHERE EMPSTATUS = 1

	--OPEN XCURSOR   
	--FETCH NEXT FROM XCURSOR INTO @xEMPCODE   

	--WHILE @@FETCH_STATUS = 0   
	--BEGIN
		WHILE @STARTDATE <= @ENDDATE
		BEGIN
			INSERT INTO #TMPTABLE 
			SELECT [EMPCODE], @Skill_ID [Skill_ID],0 [Cal_Capacity],0 [xRank],@STARTDATE [xWeekCommencing], @WHOUPDATED [WHOUPDATED],@WHENUPDATED [WHENUPDATED]
			FROM TBL_TDC_EMPMASTER
			WHERE EMPSTATUS = 1
			
			SET @STARTDATE = DATEADD(d,7,@STARTDATE)
		END
		
	--	FETCH NEXT FROM XCURSOR INTO @xEMPCODE   
	--END   

	--CLOSE XCURSOR   
	--DEALLOCATE XCURSOR 
	
	SET @STARTDATE = CONVERT(VARCHAR,DATEADD(DD,7,DATEADD(DD, -(DATEPART(DW, GETDATE())-1), GETDATE())),112)
	
	DELETE FROM TBL_TDC_EMPSKILLMAPING
	WHERE 1 = 1
	--AND Skill_ID = @Skill_ID
	AND [xWeekCommencing] BETWEEN @STARTDATE AND  @ENDDATE
	--AND SKILL_ID = @Skill_ID;
	
	INSERT INTO TBL_TDC_EMPSKILLMAPING SELECT * FROM #TMPTABLE;
	
	
	WHILE @STARTDATE <= @ENDDATE
	BEGIN
		SET @Heading = @Heading + ',[' + CONVERT(VARCHAR,@STARTDATE,106) + ']' 
		SET @STARTDATE = DATEADD(d,7,@STARTDATE)
	END

	--SELECT @Heading = @Heading + ',[' + [SKILL_NAME] + ']'
	--FROM TBL_TDC_SKILLMST
	--WHERE [ACTIVE] = 1

	IF LEFT(@Heading,1) = ','
	BEGIN
		SET @Heading = RIGHT(@Heading,LEN(@Heading) - 1)
	END

	IF RIGHT(@Heading,1) = ','
	BEGIN
		SET @Heading = LEFT(@Heading,LEN(@Heading) - 1)
	END

	IF EXISTS(SELECT [NAME] FROM DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPTABLE'))	
	BEGIN	
	   DROP TABLE TEMPTABLE
	END
	
	SET @xSQL = 'SELECT * INTO TEMPTABLE FROM 
		(
			SELECT TTE.EMPCODE,TTEM.FIRST_NAME+'' ''+TTEM.LAST_NAME [NAME],
			TTS.SKILL_NAME,[Cal_Capacity],[xWeekCommencing]
			FROM TBL_TDC_EMPSKILLMAPING TTE
			INNER JOIN TBL_TDC_EMPMASTER TTEM ON TTEM.EMPCODE=TTE.EMPCODE
			INNER JOIN TBL_TDC_SKILLMST TTS ON TTE.SKILL_ID = TTS.SKILL_ID
			WHERE TTS.SKILL_ID='+ CONVERT(VARCHAR,@Skill_ID) +'
		) as s
		PIVOT
		(
			SUM([Cal_Capacity])
			FOR [xWeekCommencing] IN ('+ @Heading +')
		)AS PVT'
	--Print @xSQL
	EXEC(@xSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[TDC_rule_engine]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[TDC_rule_engine]

@HC_Required as int,
--@Skill_set_id as int,
@Skill_1 as int,
@Skill_2 as int,
@Skill_3 as int,
@Skill_4 as int,
@Skill_5 as int,
@Skill_6 as int
AS

Select TOP(@HC_Required)Employee_ID,Employee_Name,Skill_Set_ID,Skill_Name from TDC_Skill_Mapping as x
left Join
(Select a.unique_id,lob_name+' '+Skill_Name as Skill_Name from TDC_matched_skill_lob as a
left join TDC_LOB  as b on a.lob_ID = B.LOB_ID
left join TDC_skillName as c on a.Skill_ID = c.Skill_ID)y
on x.Skill_Set_ID = y.unique_id
left join TDC_Employee_data z
on x.Employee_ID = z.Emp_ID
--where skill_set_id = @Skill_set_id
order by
Case when Skill_Set_ID = @Skill_1 then 1
when Skill_Set_ID = @Skill_2 then 2
when Skill_Set_ID = @Skill_3 then 3
when Skill_Set_ID = @Skill_4 then 4
when Skill_Set_ID = @Skill_5 then 5
when Skill_Set_ID = @Skill_6 then 6
end
GO
/****** Object:  StoredProcedure [dbo].[TDC_RULE_ENGINE2]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TDC_RULE_ENGINE2]
(
	@Skill_Set_ID AS INT,
	@Headcount as Int
)
AS
Select Distinct TOP (@Headcount) A.Employee_ID,
c.Employee_Name, 
A.Skill_Set_ID as Queue_Skill, 
A.Skill_Order as Sequence 
from TDC_Skill_Mapping A
inner join 
TDC_Rule_Table2 B 
on A.Skill_Set_ID = B.Skill_Set_ID
Left join 
TDC_Employee_data C
on A.Employee_ID = c.Emp_ID
where A.Skill_Set_ID = @Skill_Set_ID 
order by A.Skill_order
GO
/****** Object:  StoredProcedure [dbo].[TDC_RULE_ENGINE2_with_AHT]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TDC_RULE_ENGINE2_with_AHT]
(
@Skill_Set_ID AS INT,
@Headcount as Int
)
AS
	Select Distinct TOP (@Headcount) x.*, AHT 
	from
	(
		Select distinct A.Employee_ID,c.Employee_Name, A.Skill_Set_ID as Queue_Skill
		, A.Skill_Order as Sequence from TDC_Skill_Mapping A
		inner join TDC_Rule_Table2 B on A.Skill_Set_ID = B.Skill_Set_ID
		Left join TDC_Employee_data C
		on A.Employee_ID = c.Emp_ID
	)x 
	Left join
	(
		Select Employee_ID, Skill_Set_ID, round(AVG(AHT),2) as AHT from TDC_AHT
		where datepart(wk,WC_Date) between datepart(wk,getdate())-14 and datepart(wk,getdate())-1
		group by Employee_ID, Skill_Set_ID
	)y
--on x.Employee_ID = y.Employee_ID
	on x.Employee_ID+''+x.Queue_Skill = y.Employee_ID+''+y.Skill_Set_ID
	where x.Queue_Skill = @Skill_Set_ID
	order by y.AHT, x.Sequence
GO
/****** Object:  StoredProcedure [dbo].[TDC_SkillMstUpdate]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[TDC_SkillMstUpdate]
(
	@xSkillID Int,
	@xSkill varchar(max),
	@xActive Bit
)
AS
BEGIN
	if ISNULL(@xSkill,'') = '' or ISNULL(CONVERT(VARCHAR,@xActive),'') = ''
	BEGIN
		Select 'All fields are mandatory !!!'
	END
	Else
	BEGIN
		IF EXISTS(SELECT * FROM [tbl_TDC_SkillMst] WHERE SKILL_ID = @xSkillID)
		BEGIN
			UPDATE [tbl_TDC_SkillMst] set Skill_Name = @xSkill, [Active] = @xActive
			WHERE SKILL_ID = @xSkillID
		END
		Else
		BEGIN
			INSERT INTO [tbl_TDC_SkillMst] VALUES(@xSkill,@xActive)
		END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[TextFinder]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[TextFinder]
(@Text varchar(500),@Type varchar(2)=NULL) 
AS
BEGIN



SELECT DISTINCT o.name AS ObjectName,
CASE o.xtype

WHEN 'C' THEN 'CHECK constraint'

WHEN 'D' THEN 'Default or DEFAULT constraint'

WHEN 'F' THEN 'FOREIGN KEY constraint'

WHEN 'FN' THEN 'Scalar function'

WHEN 'IF' THEN 'In-lined table-function'

WHEN 'K' THEN 'PRIMARY KEY or UNIQUE constraint'

WHEN 'L' THEN 'Log'

WHEN 'P' THEN 'Stored procedure'

WHEN 'R' THEN 'Rule'

WHEN 'RF' THEN 'Replication filter stored procedure'

WHEN 'S' THEN 'System table'

WHEN 'TF' THEN 'Table function'

WHEN 'TR' THEN 'Trigger'--enter code here

WHEN 'U' THEN 'User table'

WHEN 'V' THEN 'View'

WHEN 'X' THEN 'Extended stored procedure'

ELSE o.xtype

END AS ObjectType,

ISNULL( p.Name, '[db]') AS Location

FROM syscomments c

INNER JOIN sysobjects o ON c.id=o.id

LEFT JOIN sysobjects p ON o.Parent_obj=p.id

WHERE c.text LIKE '%' + @Text + '%' and

o.xtype = case when @Type IS NULL then o.xtype  else @Type end

ORDER BY Location, ObjectName

END
GO
/****** Object:  StoredProcedure [dbo].[top3RCA]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[top3RCA]

@account_name as varchar(max)

as
(

select top (3) rca from warroom_opportunity

where Account_name = @account_name

)





GO
/****** Object:  StoredProcedure [dbo].[truncate_wr_tables]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[truncate_wr_tables]
as

Truncate table tbl_WR_Glidepath
Truncate table tbl_WR_GM_Glidepath
Truncate table tbl_WR_RCA_Actions
Truncate table tbl_WR_Waterfall
Truncate table KPI_Target
Truncate table MOM_Action_Comments
Truncate table tbl_WR_RCA_Actions
Truncate table War_Room_Action_Comments
Truncate table War_Room_Actions
Truncate table Comments
Truncate table GM_Glidepath
Truncate table GM_Waterfall
GO
/****** Object:  StoredProcedure [dbo].[UNIQUE_CLIENTNAME]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UNIQUE_CLIENTNAME]
AS
Select distinct Client_Name1 from Client_Mapping
GO
/****** Object:  StoredProcedure [dbo].[Update_Employee_Inactive]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Update_Employee_Inactive]  
@emp_id as varchar(255)  
as  
  
Update WFM_Employee_List  
Set Employee_Status = 'Inactive'  
where Employee_ID= @emp_id
  
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_WARROOM_STATUS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_WARROOM_STATUS]

@ACTION_ITEM as varchar(255),
@PROJECTID as varchar(255),
@STATUS as varchar(255)

AS

update Warroom_Meeting set [Status] = 'Closed' 
where Action_item = @ACTION_ITEM and
ProjectID = @PROJECTID and
[Status] = @STATUS

GO
/****** Object:  StoredProcedure [dbo].[USP_BubbleGraphData]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_BubbleGraphData]
AS
BEGIN

CREATE TABLE #tblDummy (BusinessUnitCode VARCHAR(100),BusinessUnitName VARCHAR(100),Opportunities VARCHAR(100),Savings VARCHAR(100))

INSERT INTO #tblDummy (BusinessUnitCode,BusinessUnitName,Opportunities)
SELECT     Distinct xSPT.sample.BusinessUnitCode,xSPT.Sample.BusinessUnitName,newTable.Opportunities from xSPT.Sample
INNER JOIN 
(SELECT     xSPT.CaptureMonthlyOpportunities.BusinessUnitCode as bCOdE, SUM(Opportunities) AS Opportunities

FROM         xSPT.CaptureMonthlyOpportunities 
where xSPT.CaptureMonthlyOpportunities.BusinessUnitCode ='OPSLA' or xSPT.CaptureMonthlyOpportunities.BusinessUnitCode='OPSNA' 
or xSPT.CaptureMonthlyOpportunities.BusinessUnitCode='OPSAP' or xSPT.CaptureMonthlyOpportunities.BusinessUnitCode='OPSEM'
GROUP BY BusinessUnitCode
) newTable 

on newTable.bCOdE = xSPT.sample.BusinessUnitCode


UPDATE #tblDummy SET Savings = '34' WHERE BusinessUnitName = 'Operations LATAM'
UPDATE #tblDummy SET Savings = '56' WHERE BusinessUnitName = 'Operations North America'
UPDATE #tblDummy SET Savings = '32' WHERE BusinessUnitName = 'Operations APAC'
UPDATE #tblDummy SET Savings = '80' WHERE BusinessUnitName = 'Operations EMEA'
SELECT * FROM #tblDummy
DROP TABLE #tblDummy
END

GO
/****** Object:  StoredProcedure [dbo].[USP_CalculateOpportunity]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CalculateOpportunity]
(
	@ProjectCode VARCHAR(250)
)
AS
/**

EXEC USP_CalculateOpportunity '4000-IN2F-1000-1180001'
EXEC USP_CalculateOpportunity '4000-IN2F-1000-1840002'
EXEC USP_CalculateOpportunity '4000-IN3F-1000-UKTRA02'
EXEC USP_CalculateOpportunity '4000-IN3F-1000-3080001'

**/
BEGIN
	
--****************************	VARIABLE DECLARATION ********************	
	DECLARE	@AgentCount	NUMERIC(18,2)
	DECLARE	@GOSRatio	NUMERIC(18,2)

--****************************	SET GOS RATIO ********************		
	SELECT	@GOSRatio	=	B.GOSRatio
	FROM	ProjectResource	A
	JOIN	OpportunityPositions	B	ON	A.ProjectPositions = B.OpportunityCategory
	AND		B.OpportunityBit		=	1
	AND		A.ProjectCode			=	@ProjectCode
	AND		B.OpportunityCategory	=	'COACH'

--****************************	SET AGENT COUNT ********************	
	SELECT	@AgentCount	=	A.ActivePositionsCount
	FROM	ProjectResource	A
	JOIN	OpportunityPositions B ON A.ProjectPositions = B.OpportunityCategory
	AND		A.ProjectCode		=	@ProjectCode
	WHERE	A.ProjectPositions	=	'Agent'

--****************************	SET OPPORTUNITY COUNT ********************	
	SELECT 'July' AS [Month],A.ProjectCode,A.ProjectPositions,A.ActivePositionsCount, 
	CONVERT(NUMERIC(18,2),@AgentCount / @GOSRatio) AS [GOSRatio], '' AS [SOW], '' AS [LEGAL], 
	(CASE WHEN A.ActivePositionsCount < CONVERT(NUMERIC(18,2),@AgentCount / @GOSRatio) THEN A.ActivePositionsCount 
	ELSE CONVERT(NUMERIC(18,2),@AgentCount / @GOSRatio) END) AS [MIN_OF_GOS_SOW_LEGAL],'' AS [Avg_Of_3Months_Forecast],
	CONVERT(NUMERIC(18,2),A.ActivePositionsCount) - CONVERT(NUMERIC(18,2),@AgentCount / @GOSRatio)  AS [Opportunities] 
	FROM ProjectResource A
	JOIN OpportunityPositions B ON A.ProjectPositions = B.OpportunityCategory
	AND B.OpportunityBit = 1
	AND A.ProjectCode = @ProjectCode
	AND B.OpportunityCategory = 'COACH'
	
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Discussion]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Discussion]
AS
BEGIN
select 1
--select intRegionId,intSubRegionId,intCountryCode,Country,* from Sample where intCountryCode = 1
--select DISTINCT BusinessUnitCode,BusinessUnitName from Sample 
--select ProjectId,ProjectCode,WorkLocationId,WorkLocationCode,PayrollDepartmentId,PayrollDepartmentCode from Sample 
--select DISTINCT CATEGORY from Sample

--UPDATE Sample SET HourlyRate  = CONVERT(NUMERIC(18,2),CONVERT(NUMERIC(18,2),REPLACE(value,',','')) / 180)
--SELECT REPLACE(value,',','') from Sample
--select CONVERT(NUMERIC(18,2),CONVERT(NUMERIC(18,2),REPLACE(value,',','')) / 180) FROM SAMPLE

--ProjectResource
--CREATE TABLE ProjectResource (AutoId INT IDENTITY(1,1),ProjectId INT, ProjectCode VARCHAR(250),
--ProjectPositions VARCHAR(500),ActivePositionsCount INT, bitIsActive BIT DEFAULT(1))

--SELECT * from ProjectResource
--select * from OpportunityPositions WHERE OpportunityBit = 1
--ALTER TABLE OpportunityPositions ADD GOSRatio INT
--UPDATE OpportunityPositions SET GOSRatio = 18 WHERE AutoId = 102


--SELECT 'July' AS [Month],A.ProjectCode,A.ProjectPositions,A.ActivePositionsCount, 
--'' AS [GOSRatio], '' AS [SOW], '' AS [LEGAL], '' AS [MIN_OF_GOS_SOW_LEGAL],'' AS [Avg_Of_3Months_Forecast],
--'' AS [Opportunities] 
--FROM ProjectResource A
--JOIN OpportunityPositions B ON A.ProjectPositions = B.OpportunityCategory
--AND B.OpportunityBit = 1
--AND A.ProjectCode = '4000-IN2F-1000-1180001'



--UPDATE OpportunityPositions SET OpportunityBit = 0 where OpportunityCategory NOT IN ('coach','Mgr Ops','Mgr Quality')
--INSERT INTO ProjectResource (ProjectCode,ProjectPositions,ActivePositionsCount)
--SELECT A.ProjectCode AS [ProjectCode],B.CATEGORY AS [ProjectPositions],
-- COUNT(B.CATEGORY) AS [ActivePositionsCount]
--FROM Project A 
--JOIN SAMPLE B ON A.ProjectCode = B.ProjectCode
--GROUP BY B.ProjectCode,A.ProjectCode,B.CATEGORY
--select 172/18

--select * from tblRegions
--
--select * from SubRegion
--select * from Country
--select * from BusinessUnit
--select * from Division
--SELECT * FROM CompanyLegalEntity
--SELECT * FROM ProfitCenter
--select * from CostCenter
--select * from PayrollDepartment
--select * from WorkLocation
--select * from Project
--select * from OpportunityPositions

--ALTER TABLE [SAMPLE] ADD BusinessUnitId INT
--ALTER TABLE [SAMPLE] ADD DivisionId INT
--ALTER TABLE [SAMPLE] ADD CompanyLegalEntityIdFK INT
--ALTER TABLE [SAMPLE] ADD ProfitCenterId INT
--ALTER TABLE [SAMPLE] ADD CostCenterId INT
--ALTER TABLE [SAMPLE] ADD PayrollDepartmentId INT
--ALTER TABLE [SAMPLE] ADD WorkLocationId INT
--ALTER TABLE [SAMPLE] ADD ProjectId INT

--ALTER TABLE [SAMPLE] ADD HourlyRate NUMERIC(18,2)
--select 45*4


--CREATE TABLE OpportunityPositions (AutoId INT IDENTITY(1,1),
--OpportunityCategory VARCHAR(250), OpportunityBit BIT DEFAULT(1))
--INSERT INTO OpportunityPositions(OpportunityCategory)
--select DISTINCT CATEGORY from Sample

--UPDATE  [Sample]
--SET [Sample].BusinessUnitId = B.AutoId
--FROM [Sample] A
--JOIN BusinessUnit B ON A.BusinessUnitCode = B.BusinessUnitCode

--UPDATE  [Sample]
--SET [Sample].BusinessUnitId = B.AutoId
--FROM [Sample] A
--JOIN BusinessUnit B ON A.BusinessUnitCode = B.BusinessUnitCode

--UPDATE  [Sample]
--SET [Sample].DivisionId = B.AutoId
--FROM [Sample] A
--JOIN Division B ON A.DivisionCode = B.DivisionCode

--UPDATE  [Sample]
--SET [Sample].CompanyLegalEntityIdFK = B.AutoId
--FROM [Sample] A
--JOIN CompanyLegalEntity B ON A.CompanyLegalEntityID = B.CompanyLegalEntityID

--UPDATE  [Sample]
--SET [Sample].ProfitCenterId = B.AutoId
--FROM [Sample] A
--JOIN ProfitCenter B ON A.ProfitCenterCode = B.ProfitCenterCode

--UPDATE  [Sample]
--SET [Sample].CostCenterId = B.AutoId
--FROM [Sample] A
--JOIN CostCenter B ON A.CostCenterCode = B.CostCenterCode

--UPDATE  [Sample]
--SET [Sample].PayrollDepartmentId = B.AutoId
--FROM [Sample] A
--JOIN PayrollDepartment B ON A.PayrollDepartmentCode = B.PayrollDepartmentCode

--UPDATE  [Sample]
--SET [Sample].WorkLocationId = B.AutoId
--FROM [Sample] A
--JOIN WorkLocation B ON A.WorkLocationCode = B.WorkLocationCode

--UPDATE  [Sample]
--SET [Sample].ProjectId = B.AutoId
--FROM [Sample] A
--JOIN Project B ON A.ProjectCode = B.ProjectCode

--CREATE TABLE WorkLocation (AutoId INT IDENTITY(1,1), WorkLocationCode VARCHAR(250), 
--WorkLocationName VARCHAR(500), bitIsActive BIT DEFAULT(1))
--INSERT INTO WorkLocation(WorkLocationCode,WorkLocationName)
--SELECT DISTINCT WorkLocationCode,WorkLocationName from Sample 


--INSERT INTO PayrollDepartment(PayrollDepartmentCode,PayrollDepartmentName)
--SELECT DISTINCT PayrollDepartmentCode,PayrollDepartmentName from Sample 

--INSERT INTO Project(ProjectCode,ProjectName)
--SELECT DISTINCT ProjectCode,ProjectName from Sample 

--INSERT INTO CostCenter(CostCenterCode,CostCenterName)
--SELECT DISTINCT CostCenterCode,CostCenterName from Sample 

--CREATE TABLE ProfitCenter (AutoId INT IDENTITY(1,1), ProfitCenterCode VARCHAR(250), 
--ProfitCenterName VARCHAR(500), bitIsActive BIT DEFAULT(1))

--INSERT INTO ProfitCenter(ProfitCenterCode,ProfitCenterName)
--SELECT DISTINCT ProfitCenterCode,ProfitCenterName from Sample 

--INSERT INTO CompanyLegalEntity(CompanyLegalEntityID,CompanyLegalEntityName)
--SELECT DISTINCT CompanyLegalEntityID,CompanyLegalEntityName from Sample 

--ALTER TABLE [Sample] ADD intRegionId TINYINT
--ALTER TABLE [Sample] ADD intSubRegionId INT
--ALTER TABLE [Sample] ADD intCountryCode INT

--INSERT INTO BusinessUnit(BusinessUnitCode,BusinessUnitName)
--SELECT DISTINCT BusinessUnitCode,BusinessUnitName from Sample 

--INSERT INTO Division(DivisionCode,DivisionName)
--SELECT DISTINCT DivisionCode,DivisionName from Sample 


--UPDATE [Sample] SET intRegionId = 1 WHERE [Business Unit Business Unit Code] = 'OPSAP'
--UPDATE [Sample] SET intSubRegionId = CASE WHEN [Division Code] = 'OPS01AP01' THEN 2
--											WHEN [Division Code] = 'OPS01AP02' THEN 3
--											END

--UPDATE [Sample] SET intSubRegionId = 1 where [Division Code] = 'OPS01AP03'
											

--UPDATE [Sample] SET intCountryCode = CASE WHEN [Country] = 'India' THEN 2
--											WHEN [Country] = 'New Zealand' THEN 1
--											WHEN [Country] = 'Philippines' THEN 3	
--											END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAutoCompleteValues]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAutoCompleteValues]
(
	@RoleName  VARCHAR(250)
)
AS
--EXEC USP_GetAutoCompleteValues 'INDIA'
BEGIN
	IF (@RoleName = 'INDIA')
	BEGIN
		SELECT 1 AS intCityId, 'India' AS vcrCityName
		UNION ALL
		SELECT 2 AS intCityId, 'India - Chennai SEZ Call Center' AS vcrCityName
		UNION ALL
		SELECT 3 AS intCityId, 'India - Gurgaon SEZ Call Center' AS vcrCityName
		UNION ALL
		SELECT 4 AS intCityId, 'India - Hyderabad Call Center' AS vcrCityName
		UNION ALL
		SELECT 5 AS intCityId, 'India - Mumbai Call Center' AS vcrCityName
		UNION ALL
		SELECT 6 AS intCityId, 'India - Mumbai Shared Services' AS vcrCityName
		UNION ALL
		SELECT 7 AS intCityId, 'India - Hyderabad Domestic' AS vcrCityName
		UNION ALL
		SELECT 8 AS intCityId, 'India - Mumbai Domestic' AS vcrCityName
	END
	IF (@RoleName = 'GLOBAL')
	BEGIN
		SELECT 1 AS intCityId, 'America' AS vcrCityName
		UNION ALL
		SELECT 2 AS intCityId, 'EMEA' AS vcrCityName
		UNION ALL
		SELECT 3 AS intCityId, 'LATAM' AS vcrCityName
		UNION ALL
		SELECT 4 AS intCityId, 'APAC' AS vcrCityName
		UNION ALL
		SELECT 5 AS intCityId, 'APAC - India' AS vcrCityName
		UNION ALL
		SELECT 6 AS intCityId, 'India - Chennai SEZ Call Center' AS vcrCityName
		UNION ALL
		SELECT 7 AS intCityId, 'India - Gurgaon SEZ Call Center' AS vcrCityName
		UNION ALL
		SELECT 8 AS intCityId, 'India - Hyderabad Call Center' AS vcrCityName
		UNION ALL
		SELECT 9 AS intCityId, 'India - Mumbai Call Center' AS vcrCityName
		UNION ALL
		SELECT 10 AS intCityId, 'India - Mumbai Shared Services' AS vcrCityName
		UNION ALL
		SELECT 11 AS intCityId, 'India - Hyderabad Domestic' AS vcrCityName
		UNION ALL
		SELECT 12 AS intCityId, 'India - Mumbai Domestic' AS vcrCityName
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetDashboardCounts]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetDashboardCounts]
@RoleName	VARCHAR(100),
@MonthName	VARCHAR(100)=NULL
AS
/*
EXEC USP_GetDashboardCounts 'GLOBAL'
EXEC USP_GetDashboardCounts 'INDIA'
**/
BEGIN
	SET	NOCOUNT	ON;
	IF	(@RoleName = 'GLOBAL')
	BEGIN
		SELECT	1000	AS	[intOBTotal],
			20000		AS	[intOBSavingsTotal],
			10000		AS	[intOBOpportunitiesTotal],
			'50%'		AS	[intOBPositionsTotal],
			
			10000		AS	[intBAUSavingsTotal],
			3000		AS	[intBAUOpportunitiesTotal],
			'30%'	AS	[intBAUPositionsTotal],
					
			10000		AS	[intRZSavingsTotal],
			5000		AS	[intRZOpportunitiesTotal],
			'50%'		AS	[intRZPositionsTotal]				
	END
	ELSE
	BEGIN
		SELECT	1000	AS	[intOBTotal],
			5000		AS	[intOBSavingsTotal],
			1000		AS	[intOBOpportunitiesTotal],
			'20%'		AS	[intOBPositionsTotal],
			
			3000	AS	[intBAUSavingsTotal],
			300		AS	[intBAUOpportunitiesTotal],
			'10%'		AS	[intBAUPositionsTotal],
					
			2000	AS	[intRZSavingsTotal],
			200		AS	[intRZOpportunitiesTotal],
			'10%'	AS	[intRZPositionsTotal]
	END
		
	SET	NOCOUNT	OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetGauseChartData]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetGauseChartData]
AS
BEGIN
	SELECT 10 AS [Value], 100 AS [MaxRange]
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetStackedGraph_New]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_GetStackedGraph_New]    
    
AS    
    
BEGIN    
    
   SELECT * FROM    
    
   (SELECT Country,RiskOrSaving,Sum(Amount)Amount    
    
   FROM tblSPTStackedGraph    
    
   GROUP BY Country,RiskOrSaving) AS s    
    
   PIVOT ( Sum(Amount)    
    
   FOR [RiskOrSaving] IN ([Risk],[Savings])    
    
   )AS pv    
    
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetSubDashboardCounts]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetSubDashboardCounts]
@RoleName	VARCHAR(100),
@AreaName	VARCHAR(100)=NULL --OB, BAU, RZ
AS
/*
**/
BEGIN
	SET	NOCOUNT	ON;
	IF	(@RoleName = 'GLOBAL')
	BEGIN
		IF	(@AreaName = 'OB')
		BEGIN
			SELECT	20000	AS	[intOpportunitiesCount],
				10000		AS	[intRecoveredCount],
				'50%'		AS	[intSuccessRate]
		END		
		IF	(@AreaName = 'BAU')
		BEGIN
			SELECT	10000	AS	[intOpportunitiesCount],
				3000		AS	[intRecoveredCount],
				'30%'		AS	[intSuccessRate]
		END
		IF	(@AreaName = 'RZ')
		BEGIN
			SELECT	10000	AS	[intOpportunitiesCount],
				5000		AS	[intRecoveredCount],
				'50%'		AS	[intSuccessRate]
		END		
	END
	ELSE
	BEGIN
		IF	(@AreaName = 'OB')
		BEGIN
			SELECT	5000	AS	[intOpportunitiesCount],
				1000		AS	[intRecoveredCount],
				'20%'		AS	[intSuccessRate]
		END		
		IF	(@AreaName = 'BAU')
		BEGIN
			SELECT	3000	AS	[intOpportunitiesCount],
				300		AS	[intRecoveredCount],
				'10%'		AS	[intSuccessRate]
		END
		IF	(@AreaName = 'RZ')
		BEGIN
			SELECT	2000	AS	[intOpportunitiesCount],
				200		AS	[intRecoveredCount],
				'10%'		AS	[intSuccessRate]
		END	
	END
		
	SET	NOCOUNT	OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[Verify_Access]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Verify_Access] 
@NT_ID varchar(255)

as


Select Region,Access_Type from tbl_WR_User_Role wur
Inner join [User_Role] ur on wur.Access_Type=ur.RoleName where NT_ID = @NT_ID
and Start_Date<=getdate()
and End_Date is null ORDER BY ur.RoleId DESC
GO
/****** Object:  StoredProcedure [dbo].[View_Current_Week_Roster]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[View_Current_Week_Roster]  
(  
@ECN as int,  
@WC_Date as datetime  
)  
AS  
Select Schedule_Date ,Shift_Time   
from New_Roster_Entry   
where ECN = @ECN and WC_Date = @WC_Date
order by Schedule_Date
GO
/****** Object:  StoredProcedure [dbo].[View_roster]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[View_roster]
(
	@WC_Date AS SMALLDATETIME,
	@Supervisor_ECN as int
)
AS
BEGIN

	DECLARE @Schedule_Date AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	SELECT DISTINCT Schedule_Date Schedule_Date  INTO #TEMPTABLE
	FROM New_Roster_Entry 
	WHERE WC_Date = convert(varchar,@WC_Date,112) 
	and Supervisor_ECN = convert(varchar,@Supervisor_ECN)
	ORDER BY Schedule_Date DESC
      
	SELECT @Schedule_Date = '[' + REPLACE(CONVERT(VARCHAR,TP.Schedule_Date,106),' ','-') + '],' + @Schedule_Date
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Schedule_Date,1) = ','
	BEGIN
		SET @Schedule_Date = RIGHT(@Schedule_Date,LEN(@Schedule_Date) - 1)
	END

	IF RIGHT(@Schedule_Date,1) = ','
	BEGIN
		SET @Schedule_Date = LEFT(@Schedule_Date,LEN(@Schedule_Date) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	truncate table tblRosterView
	
	SET @xSQL = 'insert into tblRosterView select *  from 
	(
		select 
		ECN
		,Name
		,Schedule_Date
		,Shift_Time
		from New_Roster_Entry where WC_Date = '''+convert(varchar,@WC_Date,112)+''' and Supervisor_ECN = '''+convert(varchar,@Supervisor_ECN)+'''
	) src
	pivot
	(
		max(Shift_Time)
		for Schedule_Date in ('+@Schedule_Date+')
	) piv'

	--print @xSQL
	execute(@xSQL)
	--Select * from WFM_Employee_List where Employee_ID = '923563'
	--select * from tblRosterView
	--Drop table tblRosterView
END

GO
/****** Object:  StoredProcedure [dbo].[View_TDCSkill]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[View_TDCSkill]

AS
BEGIN

	DECLARE @Schedule_Date AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END
		
	SELECT Distinct Skill_Name   INTO #TEMPTABLE
	from TDC_Skill_Mapping as x 
	Left Join (Select a.unique_id,lob_name+' '+Skill_Name as Skill_Name from TDC_matched_skill_lob as a 
	left join TDC_LOB  as b on a.lob_ID = B.LOB_ID 
	left join TDC_skillName as c on a.Skill_ID = c.Skill_ID)y on x.Skill_Set_ID = y.unique_id 
	order by Skill_Name
      
	SELECT @Schedule_Date = '[' + REPLACE(CONVERT(VARCHAR,TP.Skill_Name,106),' ','-') + '],' + @Schedule_Date
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Schedule_Date,1) = ','
	BEGIN
		SET @Schedule_Date = RIGHT(@Schedule_Date,LEN(@Schedule_Date) - 1)
	END

	IF RIGHT(@Schedule_Date,1) = ','
	BEGIN
		SET @Schedule_Date = LEFT(@Schedule_Date,LEN(@Schedule_Date) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	--truncate table tblTDCSkill
	
	SELECT TSM.EMPLOYEE_ID,SKILLED,SKILL_SET_ID,LOB.LOB_NAME+'-'+SN.SKILL_NAME xSKILL_NAME
	into #Tmp
		FROM TDC_SKILL_MAPPING TSM
		INNER JOIN DBO.TDC_MATCHED_SKILL_LOB TMSL ON TSM.SKILL_SET_ID = UNIQUE_ID
		INNER JOIN DBO.TDC_LOB LOB ON LOB.LOB_ID = TMSL.LOB_ID
		INNER JOIN DBO.TDC_SKILLNAME SN ON SN.SKILL_ID = TMSL.SKILL_ID
	
	
	
	IF OBJECT_ID('TBLTDCSKILL', 'U') IS NOT NULL
	Begin
		DROP TABLE TBLTDCSKILL;
	END
	
	SET @xSQL = 'Select * INTO TBLTDCSKILL  from (
		SELECT EMPLOYEE_ID,Employee_Name,SKILLED,xSKILL_NAME
		FROM #Tmp TMP
		LEFT OUTER JOIN dbo.TDC_Employee_data TED on TED.Emp_ID = TMP.EMPLOYEE_ID
	) src
		pivot
	(
		SUM(SKILLED)
		for xSKILL_NAME in ('+@Schedule_Date+')
	) piv
	ORDER BY EMPLOYEE_ID
	'

	--print @xSQL
	execute(@xSQL)
	
	SELECT * FROM TBLTDCSKILL
	--Drop table tblTDCSkill
END


GO
/****** Object:  StoredProcedure [dbo].[war_room_age_band_Revenue]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[war_room_age_band_Revenue]
as
BEGIN
	
	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	Select ba.age_band,count(ba.age_band) Total_Accounts,sum(ba.revenue) as Total_Revenue ,0 xOrd INTO #TEMPTABLE
	from (
		Select aa.Revenue,
		case when aa.DiffDate <= 7 then '0-7 days'
		When aa.DiffDate > 7 and aa.DiffDate <= 14 then '8-14 days'
		When aa.DiffDate > =15  and aa.DiffDate <= 30 then '15-30 days'
		When aa.DiffDate >=31  and aa.DiffDate <=45 then '31-45 days'
		When aa.DiffDate > =46 and aa.DiffDate < =60 then '46-60 days'
		When aa.DiffDate > =60  then '60+' end as age_Band

		from(
			Select Client_Name,Revenue, DATEDIFF(day,Start_Date,getdate()) AS DiffDate 
			from War_Room wr
		) aa
	) ba group by ba.age_band

	Declare @x as int
	set @x = 1
	
	Declare @xAge_Band as varchar(max)

	
	WHILE @x <= 6   
	BEGIN   
		   Select @xAge_Band = Case When @x = 1 Then '0-7 days'
		   When @x = 2 Then '8-14 days'
		   When @x = 3 Then '15-30 days'
		   When @x = 4 Then '31-45 days'
		   When @x = 5 Then '46-60 days'
		   When @x = 6 Then '60+' End
		   
		   IF NOT EXISTS (Select * from #TEMPTABLE Where age_band = @xAge_Band)
		   BEGIN
				insert into #TEMPTABLE values(@xAge_Band,0,0,@x)
		   END
		   ELSE
		   BEGIN
				update #TEMPTABLE set xOrd = @x Where age_band = @xAge_Band
		   END

		   set @x = @x + 1 
	END  
	
	SELECT * FROM #TEMPTABLE ORDER BY XORD
END
GO
/****** Object:  StoredProcedure [dbo].[war_room_age_band_Revenue_Global]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[war_room_age_band_Revenue_Global]
	@REGION VARCHAR(255)  = NULL,
	@NT_ID as varchar(max) = NULL,
    @AccessType as varchar(max) = NULL    
AS    
BEGIN
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
	BEGIN  

		SET @REGION = 'ALL'  

	END  
	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	Select ba.age_band,count(ba.age_band) Total_Accounts,sum(ba.revenue) as Total_Revenue ,0 xOrd INTO #TEMPTABLE
	from(  
		Select aa.Revenue,  
		case when aa.DiffDate <= 7 then '0-7 days'  
		When aa.DiffDate > 7 and aa.DiffDate <= 14 then '8-14 days'  
		When aa.DiffDate >= 15  and aa.DiffDate <= 30 then '15-30 days'  
		When aa.DiffDate >= 31  and aa.DiffDate <= 45 then '31-45 days'  
		When aa.DiffDate >= 46 and aa.DiffDate <= 60 then '46-60 days'  
		When aa.DiffDate >= 60  then '60+' end as age_Band  
		from(
			Select Client_Name,Revenue, DATEDIFF(day,Start_Date,getdate()) AS DiffDate from War_Room wr  
			WHERE 1 = 1  
				AND (
					CONVERT(VARCHAR,REGION) = @REGION  
					OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,REGION) end in 
						(
							select Region from tbl_WR_User_Role
							where NT_ID = @NT_ID
							AND Access_Type = @AccessType
							and Start_Date <= GETDATE() and End_Date is null
						)
					)
				) 
			) aa
		) ba
	 group by ba.age_band
Declare @x as int
	set @x = 1
	
	Declare @xAge_Band as varchar(max)

	
	WHILE @x <= 6   
	BEGIN   
		   Select @xAge_Band = Case When @x = 1 Then '0-7 days'
		   When @x = 2 Then '8-14 days'
		   When @x = 3 Then '15-30 days'
		   When @x = 4 Then '31-45 days'
		   When @x = 5 Then '46-60 days'
		   When @x = 6 Then '60+' End
		   
		   IF NOT EXISTS (Select * from #TEMPTABLE Where age_band = @xAge_Band)
		   BEGIN
				insert into #TEMPTABLE values(@xAge_Band,0,0,@x)
		   END
		   ELSE
		   BEGIN
				update #TEMPTABLE set xOrd = @x Where age_band = @xAge_Band
		   END

		   set @x = @x + 1 
	END  
	
	SELECT * FROM #TEMPTABLE ORDER BY XORD
END
GO
/****** Object:  StoredProcedure [dbo].[war_room_age_band_Revenue_Regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[war_room_age_band_Revenue_Regional]
@Region Varchar(255)
as
(Select ba.age_band,count(ba.age_band),sum(ba.revenue) from(
Select aa.Revenue,
case when aa.DiffDate <= 7 then '0-7 days'
  When aa.DiffDate > 7 and aa.DiffDate <= 14 then '8-14 days'
  When aa.DiffDate > =15  and aa.DiffDate <= 30 then '15-30 days'
  When aa.DiffDate >=31  and aa.DiffDate <=45 then '31-45 days'
  When aa.DiffDate > =46 and aa.DiffDate < =60 then '46-60 days'
  When aa.DiffDate > =60  then '60+' end as age_Band

from(Select Client_Name,Region,Revenue, DATEDIFF(day,Start_Date,getdate()) AS DiffDate from War_Room wr where Region = @Region) aa) ba group by ba.age_band)


GO
/****** Object:  StoredProcedure [dbo].[War_room_authenticate]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[War_room_authenticate]
@NT_ID varchar(255)

as


Select wur.NT_ID,wur.WR_Password,wur.Full_Name,wur.Access_Type,wur.Region from tbl_WR_User_Role wur
Inner join [User_Role] ur on wur.Access_Type=ur.RoleName where NT_ID =@NT_ID-- 'vkole003'
and Start_Date<=getdate() and End_Date  is null
and End_Date is null ORDER BY ur.RoleId DESC
GO
/****** Object:  StoredProcedure [dbo].[War_room_common]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[War_room_common]
	@OPERATION NVARCHAR(50)=NULL,
	@WARROOM_ID INT=0,
	@METRIC_ID INT=0
AS
BEGIN
	

	IF @OPERATION='METRIC_RETURN'
	   BEGIN
	      SELECT WW.BATCH_ID, WW.METRIC_ID,WM.METRIC_NAME AS 'METRIC_NAME', WW.WARROOM_ACC_ID,WW.WARROOM_ACC_NAME,
		         MAX(CASE WHEN XTYPE = 'REVENUE' THEN XVALUE END) AS 'METRIC_REV',MAX(CASE WHEN XTYPE = 'GROSS MARGIN' THEN XVALUE END) AS 'METRIC_GM', MAX(CASE WHEN XTYPE = 'GROSS MARGIN PER' THEN XVALUE END) AS 'METRIC_GM_PER'
          FROM  [TBL_WR_WATERFALL] WW LEFT JOIN TBL_WR_METRIC WM ON WM.METRIC_ID = WW.METRIC_ID 
		  WHERE WARROOM_ACC_ID=@WARROOM_ID AND WW.METRIC_ID=@METRIC_ID
          GROUP BY WW.METRIC_ID,WM.METRIC_NAME,  WARROOM_ACC_ID,WARROOM_ACC_NAME,WW.BATCH_ID
	   END 
END

GO
/****** Object:  StoredProcedure [dbo].[War_Room_GetRegions_NTID]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[War_Room_List_DOTNET] null,null,'EMEA,INDIA'

CREATE Procedure [dbo].[War_Room_GetRegions_NTID]
(
	@ntName varchar(50)
)
AS
BEGIN
	DECLARE @xOUTPUT VARCHAR(MAX)=''

	Select @xOUTPUT = @xOUTPUT+','+ xRegion
	FROM (
		SELECT distinct(CASE WHEN REGION = 'GLOBAL' THEN 'ALL' ELSE REGION END )xRegion
		FROM 
		TBL_WR_USER_ROLE
		WHERE NT_ID = @ntName
	) TMP

	IF LEFT(@xOUTPUT,1) = ','
	BEGIN
		SET @xOUTPUT = RIGHT(@xOUTPUT,len(@xOUTPUT) - 1)
	END

	IF RIGHT(@xOUTPUT,1) = ','
	BEGIN
		SET @xOUTPUT = LEFT(@xOUTPUT,len(@xOUTPUT) - 1)
	END

	SELECT @xOUTPUT REGIONS;
END
GO
/****** Object:  StoredProcedure [dbo].[War_Room_List]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[War_Room_List]  
(
	@XSORT AS VARCHAR(MAX) = NULL,
	@XSORTORD AS VARCHAR(MAX) = '[ASC]',
	@XREGION AS VARCHAR(MAX)=NULL
)
AS  
BEGIN
	--SELECT U.WAR_ROOM_ID , I.CLIENTNAME,U.REGION,U.BUDGET,  
 --  --I.OPTIMAL,I.BUDGET,   
	--U.START_DATE,   '' AS EXPECTED_SAVING,    U.REASON,
	--case when DATEDIFF(D,U.START_DATE,GETDATE())/7<=1 then 'Week1 (NEW)' else 
	--case when DATEDIFF(D,U.START_DATE,GETDATE())/7<4 then  '<1' else 
	--case when DATEDIFF(D,U.START_DATE,GETDATE())/7>5 and  DATEDIFF(D,U.START_DATE,GETDATE())/7<8 then  '<2' else '' end AS AGEING
 --   FROM  
	--(
	--	SELECT CLIENTNAME, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
	--	(SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT 
	--	FROM   
	--	(
	--		SELECT PROJECT_CODE,  
	--		CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS ACT_REV,  
	--		CASE WHEN METRIC_CATEGORY = 'USD OPTIMAL LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
	--		CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS BUDGET  
	--		FROM FINANCERAW2016  
	--		WHERE YEAR = '2016' AND METRIC_NAME = 'REVENUE'  
	--		AND [MONTH] IN ('JAN','FEB','MAR')  
	--		GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE
	--	)   A  
	--	LEFT JOIN  
	--	(
	--		SELECT * FROM CLIENT_MAPPING
	--	) B ON A.PROJECT_CODE = B.PRCODE  
	--	WHERE CLIENTNAME IS NOT NULL  
	--	GROUP BY CLIENTNAME  
	--	)I LEFT JOIN WAR_ROOM U ON I.CLIENTNAME=U.CLIENT_NAME  
	--WHERE U.CLIENT_NAME IS NOT NULL  
 -- )ORDER BY 1



	IF LTRIM(RTRIM(ISNULL(@XSORT,''))) = ''
	BEGIN
		SET @XSORT = '  '
	END
	ELSE
	BEGIN
		SET @XSORT = ' ORDER BY '+ @XSORT
	END

	IF (LTRIM(RTRIM(ISNULL(@XSORTORD,''))) = '[ASC]')
	BEGIN
		SET @XSORTORD = '  '
	END
	ELSE
	BEGIN
		SET @XSORTORD = ' DESC'
	END

	DECLARE @XSQL AS VARCHAR(MAX) = ''
  --I.OPTIMAL,I.BUDGET,
	SET @XSQL = 'SELECT I.Client_Name1 [A/C NAME],
	U.REGION,
	convert(decimal(18,2),U.BUDGET / 1000000) [ACT_GM_VS_BGT],  
	U.START_DATE [START DATE],
	'''' AS [SAVING(EXP)],
	isnull(U.REASON,'''') [REASON],
	case when DATEDIFF(D,U.START_DATE,GETDATE())/7 <= 1 then ''Week1 (NEW)''  
	when DATEDIFF(D,U.START_DATE,GETDATE())/7 < 4 then  ''<1 Month'' 
	when DATEDIFF(D,U.START_DATE,GETDATE())/7 > 4 and  DATEDIFF(D,U.START_DATE,GETDATE())/7 <= 8 then  ''1 to 2 Months'' else ''>2 Months'' end  AS [AGEING],
	CASE when DATEDIFF(D,U.START_DATE,GETDATE())/7 < =1 then ''NEW''  
	when DATEDIFF(D,U.START_DATE,GETDATE())/7 < 4 then  ''LOW''  
	when DATEDIFF(D,U.START_DATE,GETDATE())/7 > 4 and  DATEDIFF(D,U.START_DATE,GETDATE())/7 <= 8 then  ''MEDIUM'' else ''HIGH'' end  AS [PRIORITY],
	U.Competency_Level [Measured At Level],
	U.WAR_ROOM_ID
    FROM  
	(
		SELECT Client_Name1, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
		(SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT 
		FROM   
		(
			SELECT PROJECT_CODE,  
			CASE WHEN METRIC_CATEGORY = ''USD ACTUAL @ BUDGET RATE'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS ACT_REV,  
			CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
			CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS BUDGET  
			FROM FINANCERAW2016  
			WHERE YEAR = ''2016'' AND METRIC_NAME = ''REVENUE''  
			AND [MONTH] IN (''JAN'',''FEB'',''MAR'')  
			GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE
		)   A  
		LEFT JOIN  
		(
			SELECT * FROM CLIENT_MAPPING
		) B ON A.PROJECT_CODE = B.PRCODE  
		WHERE Client_Name1 IS NOT NULL 
		GROUP BY Client_Name1  
		)I LEFT JOIN WAR_ROOM U ON I.Client_Name1=U.CLIENT_NAME
	WHERE U.CLIENT_NAME IS NOT NULL  '

	if ltrim(rtrim(ISNULL(@XREGION,''))) <> ''
	BEGIN
		SET @XSQL = @XSQL + ' AND (U.REGION = '''+ @XREGION +''' or ''ALL'' = '''+ @XREGION +''')'
	End
	
	SET @XSQL = @XSQL + @XSORT  + @XSORTORD
	EXECUTE(@XSQL)

	--PRINT(@XSQL)  
 END
 
 
--EXEC War_Room_List '[1]','[ASC]','EMEA'
GO
/****** Object:  StoredProcedure [dbo].[War_Room_List_DOTNET]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[War_Room_List_DOTNET]
 (
  @XSORT AS VARCHAR(MAX)=NULL,
  @XSORTORD AS VARCHAR(MAX)='[ASC]',
  @XREGION AS VARCHAR(MAX)=NULL
 )
AS 
BEGIN
     IF @XSORT IS NULL SELECT @XSORT='CLIENT_NAME'
     
     IF LTRIM(RTRIM(ISNULL(@XSORT,'')))=''
     BEGIN
         SET @XSORT='  '
     END
     ELSE
     BEGIN
         SET @XSORT=' ORDER BY '+@XSORT
     END
     
     IF(LTRIM(RTRIM(ISNULL(@XSORTORD,'')))='[ASC]')
     BEGIN
         SET @XSORTORD='  '
     END
     ELSE
     BEGIN
         SET @XSORTORD=' DESC'
     END
     
     DECLARE @XSQL AS VARCHAR(MAX)=''
             
--I.OPTIMAL,I.BUDGET,
             
     SET @XSQL='SELECT Levels,Project_Code,CLIENT_NAME,REGION,LOCATION_NAME,LOC_CODE,
		CASE WHEN SUM(BGT_GM) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(ACT_GM) / SUM(BGT_GM) * 100) END [ACTUAL GM VS BGT],	
		[START DATE],REASON,AGEING,PRIORITY,WAR_ROOM_ID
		FROM (
			
			SELECT CASE WHEN WR.Levels like ''%Client%'' then ''Client'' else ''Project'' END as Levels, WR.Project_Code, CLIENT_NAME, WR.REGION,
			CASE WHEN WR.LOC_CODE=''ALL'' THEN WR.LOC_CODE ELSE LOCATION_NAME END [LOCATION_NAME], 
			WR.LOC_CODE, '
			--CONVERT(DECIMAL(18,2),TMP.BUDGET / 1000000) [ACTUAL GM VS BGT],
	SET @XSQL = @XSQL + ' ACT_GM, BGT_GM,
			CONVERT(VARCHAR,START_DATE,106) [START DATE],
			ISNULL(REASON,'''') [REASON],
			CASE WHEN DATEDIFF(D,START_DATE,GETDATE())/7 <= 1 THEN ''WEEK1 (NEW)''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < 4 THEN  ''<1 MONTH'' 
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 > 4 AND  DATEDIFF(D,START_DATE,GETDATE())/7 <= 8 THEN  
			''1 TO 2 MONTHS'' ELSE ''>2 MONTHS'' END  AS [AGEING],
			CASE WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < =1 THEN ''NEW''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < 4 THEN  ''LOW''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 > 4 AND  DATEDIFF(D,START_DATE,GETDATE())/7 <= 8 THEN  
			''MEDIUM'' ELSE ''HIGH'' END  AS [PRIORITY],WAR_ROOM_ID
			FROM WAR_ROOM WR 
			INNER JOIN (
			SELECT PROJECT_Code,Client_ID,PROJECT_Name,[CLIENT NAME], LOCATION_CODE,REGION,LOCATION_NAME, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , 
		 ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
         (SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT,
		 SUM(isnull(xACT_REV,0)*-1) - SUM(isnull(xACT_COS,0)) AS ACT_GM,
		 SUM(isnull(xBGT_REV,0)*-1) - SUM(isnull(xBGT_COS,0)) AS BGT_GM
         FROM   
         (
             SELECT PROJECT_CODE,Client_ID,PROJECT_NAME,FW.[CLIENT NAME], LOCATION_CODE,FW.REGION,LOCATION_NAME,
             CASE WHEN METRIC_CATEGORY = ''USD ACTUAL @ BUDGET RATE'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS ACT_REV,  
             CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
             CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS BUDGET ,
			 CASE WHEN METRIC_CATEGORY = ''USD Actual'' AND METRIC_NAME = ''Revenue'' 
			 THEN SUM(METRIC_VALUE) END AS xACT_REV,
			 CASE WHEN METRIC_CATEGORY = ''USD Actual'' AND METRIC_NAME = ''Total Cost of Services'' 
			 THEN SUM(METRIC_VALUE) END AS xACT_COS,  
			 CASE WHEN METRIC_CATEGORY = ''USD Budget Load'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS xBGT_REV, 
			 CASE WHEN METRIC_CATEGORY = ''USD Budget Load'' AND METRIC_NAME = ''Total Cost of Services'' 
			 THEN SUM(METRIC_VALUE) END AS xBGT_COS
             FROM TBLEPM  FW
			 
             WHERE YEAR = '''+CONVERT(VARCHAR,year(GETDATE()))+''' AND METRIC_NAME IN (''REVENUE'',''Total Cost of Services'')  
             AND [MONTH] IN (UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -3, GETDATE()-DAY(GETDATE())+1)),3)),      
             UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -2, GETDATE()-DAY(GETDATE())+1)),3)),      
             UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -1, GETDATE()-DAY(GETDATE())+1)),3)))  
             GROUP BY PROJECT_CODE,Client_ID,PROJECT_NAME,METRIC_CATEGORY, METRIC_NAME,FW.[CLIENT NAME], LOCATION_CODE,FW.REGION,LOCATION_NAME
         )   A  
		 GROUP BY PROJECT_CODE,CLIENT_ID,PROJECT_NAME,[CLIENT NAME], LOCATION_CODE,REGION,LOCATION_NAME
	) TMP ON CASE WHEN WR.Levels like ''%Client%'' then REPLACE(TMP.[CLIENT NAME],''TOTAL '','''') else REPLACE(TMP.PROJECT_Name,''PR '','''') END = CLIENT_NAME 
	and CASE WHEN WR.Levels like ''%Client%'' then Client_ID else TMP.Project_Code END = WR.Project_Code 
	AND CASE WHEN WR.LOC_CODE = ''ALL'' then ''ALL'' ELSE TMP.LOCATION_CODE END = WR.LOC_CODE 
	AND TMP.REGION=WR.REGION 
	WHERE CLIENT_NAME IS NOT NULL  '
     
     IF ltrim(rtrim(ISNULL(@XREGION,'')))<>''
     BEGIN
         SET @XSQL=@XSQL+' AND (WR.REGION IN (SELECT * FROM [SPLITSTRING]('''+ @XREGION + ''','','''+')) or ''ALL'' IN  (SELECT * FROM [SPLITSTRING]('''+ @XREGION + ''','','''+')))'
     END
   SET @XSQL=@XSQL+' ) xTmp
	GROUP BY Levels,Project_Code, CLIENT_NAME,REGION,LOCATION_NAME,LOC_CODE,
	[START DATE],REASON,AGEING,PRIORITY,WAR_ROOM_ID  '

     SET @XSQL=@XSQL+@XSORT+@XSORTORD
     
	 --PRINT(@XSQL)
     EXECUTE(@XSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[War_Room_List_DOTNET_BU_GS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[War_Room_List_DOTNET_BU_GS]
 (
  @XSORT AS VARCHAR(MAX)=NULL,
  @XSORTORD AS VARCHAR(MAX)='[ASC]',
  @XREGION AS VARCHAR(MAX)=NULL
 )
AS 
BEGIN
     IF @XSORT IS NULL SELECT @XSORT='CLIENTNAME'
     
     IF LTRIM(RTRIM(ISNULL(@XSORT,'')))=''
     BEGIN
         SET @XSORT='  '
     END
     ELSE
     BEGIN
         SET @XSORT=' ORDER BY '+@XSORT
     END
     
     IF(LTRIM(RTRIM(ISNULL(@XSORTORD,'')))='[ASC]')
     BEGIN
         SET @XSORTORD='  '
     END
     ELSE
     BEGIN
         SET @XSORTORD=' DESC'
     END
     
     DECLARE @XSQL AS VARCHAR(MAX)=''
             
--I.OPTIMAL,I.BUDGET,
             
     SET @XSQL=' SELECT REPLACE(REPLACE(I.Client_Name1,''TOTAL '',''''),''GRAND TOTAL '','''') [CLIENTNAME] ,U.REGION,
     convert(decimal(18,2),U.BUDGET / 1000000) [ACT GM VS BGT],  
     CONVERT(VARCHAR,U.START_DATE,106) [START DATE],'''' AS [SAVING(EXP)],isnull(U.REASON,'''') [REASON],
     case when DATEDIFF(D,U.START_DATE,GETDATE())/7 <= 1 then ''Week1 (NEW)''  
     when DATEDIFF(D,U.START_DATE,GETDATE())/7 < 4 then  ''<1 Month'' 
     when DATEDIFF(D,U.START_DATE,GETDATE())/7 > 4 and  DATEDIFF(D,U.START_DATE,GETDATE())/7 <= 8 then  
	 ''1 to 2 Months'' else ''>2 Months'' end  AS [AGEING],
     CASE when DATEDIFF(D,U.START_DATE,GETDATE())/7 < =1 then ''NEW''  
     when DATEDIFF(D,U.START_DATE,GETDATE())/7 < 4 then  ''LOW''  
     when DATEDIFF(D,U.START_DATE,GETDATE())/7 > 4 and  DATEDIFF(D,U.START_DATE,GETDATE())/7 <= 8 then  
	 ''MEDIUM'' else ''HIGH'' end  AS [PRIORITY],
	 U.WAR_ROOM_ID,'''' [x],I.Client_Name1, Location_Code
     FROM  
     (
         SELECT Client_Name1, Location_Code, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , 
		 ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
         (SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT 
         FROM   
         (
             SELECT PROJECT_CODE, Location_Code,  
             CASE WHEN METRIC_CATEGORY = ''USD ACTUAL @ BUDGET RATE'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS ACT_REV,  
             CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
             CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS BUDGET  
             FROM FINANCERAW2016  
             WHERE YEAR = '''+CONVERT(VARCHAR,year(GETDATE()))+''' AND METRIC_NAME = ''REVENUE''  
             AND [MONTH] IN (upper(left(datename(MONTH,DATEADD(MONTH, -3, GETDATE()-DAY(getdate())+1)),3)),      
             upper(left(datename(MONTH,DATEADD(MONTH, -2, GETDATE()-DAY(getdate())+1)),3)),      
             upper(left(datename(MONTH,DATEADD(MONTH, -1, GETDATE()-DAY(getdate())+1)),3)))  
             GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE, Location_Code
         )   A  
         LEFT JOIN 
         (
             SELECT * FROM CLIENT_MAPPING
         ) B ON A.PROJECT_CODE = B.PRCODE  
         WHERE Client_Name1 IS NOT NULL 
         GROUP BY Client_Name1, Location_Code  
         )I LEFT JOIN WAR_ROOM U ON I.Client_Name1=U.CLIENT_NAME  AND (ISNULL(LOC_CODE,''All'') = LOCATION_CODE or ISNULL(LOC_CODE,''All'') = ''All'')

     WHERE U.CLIENT_NAME IS NOT NULL  '
     
     IF ltrim(rtrim(ISNULL(@XREGION,'')))<>''
     BEGIN
         SET @XSQL=@XSQL+' AND (U.REGION = '''+@XREGION+''' or ''ALL'' = '''+@XREGION+''')'
     END
     
     SET @XSQL=@XSQL+@XSORT+@XSORTORD
     
     EXECUTE(@XSQL)
     
     PRINT(@XSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[War_Room_List_DOTNET_BU+20170817]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[War_Room_List_DOTNET_BU+20170817]
 (
  @XSORT AS VARCHAR(MAX)=NULL,
  @XSORTORD AS VARCHAR(MAX)='[ASC]',
  @XREGION AS VARCHAR(MAX)=NULL
 )
AS 
BEGIN
     IF @XSORT IS NULL SELECT @XSORT='CLIENT_NAME'
     
     IF LTRIM(RTRIM(ISNULL(@XSORT,'')))=''
     BEGIN
         SET @XSORT='  '
     END
     ELSE
     BEGIN
         SET @XSORT=' ORDER BY '+@XSORT
     END
     
     IF(LTRIM(RTRIM(ISNULL(@XSORTORD,'')))='[ASC]')
     BEGIN
         SET @XSORTORD='  '
     END
     ELSE
     BEGIN
         SET @XSORTORD=' DESC'
     END
     
     DECLARE @XSQL AS VARCHAR(MAX)=''
             
--I.OPTIMAL,I.BUDGET,
             
     SET @XSQL='SELECT Levels,Project_Code,CLIENT_NAME,REGION,LOCATION_NAME,LOC_CODE,
		CASE WHEN SUM(BGT_GM) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(ACT_GM) / SUM(BGT_GM) * 100) END [ACTUAL GM VS BGT],	
		[START DATE],REASON,AGEING,PRIORITY,WAR_ROOM_ID
		FROM (
			
			SELECT CASE WHEN WR.Project_Code like ''%TOT%'' then ''Client'' else ''Project'' END as Levels, WR.Project_Code, CLIENT_NAME, WR.REGION,
			CASE WHEN WR.LOC_CODE=''ALL'' THEN WR.LOC_CODE ELSE LOCATION_NAME END [LOCATION_NAME], 
			WR.LOC_CODE, '
			--CONVERT(DECIMAL(18,2),TMP.BUDGET / 1000000) [ACTUAL GM VS BGT],
	SET @XSQL = @XSQL + ' ACT_GM, BGT_GM,
			CONVERT(VARCHAR,START_DATE,106) [START DATE],
			ISNULL(REASON,'''') [REASON],
			CASE WHEN DATEDIFF(D,START_DATE,GETDATE())/7 <= 1 THEN ''WEEK1 (NEW)''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < 4 THEN  ''<1 MONTH'' 
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 > 4 AND  DATEDIFF(D,START_DATE,GETDATE())/7 <= 8 THEN  
			''1 TO 2 MONTHS'' ELSE ''>2 MONTHS'' END  AS [AGEING],
			CASE WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < =1 THEN ''NEW''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < 4 THEN  ''LOW''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 > 4 AND  DATEDIFF(D,START_DATE,GETDATE())/7 <= 8 THEN  
			''MEDIUM'' ELSE ''HIGH'' END  AS [PRIORITY],WAR_ROOM_ID
			FROM WAR_ROOM WR 
			INNER JOIN (
			SELECT PR_Code,Client_Code,PR_Name,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , 
		 ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
         (SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT,
		 SUM(isnull(xACT_REV,0)*-1) - SUM(isnull(xACT_COS,0)) AS ACT_GM,
		 SUM(isnull(xBGT_REV,0)*-1) - SUM(isnull(xBGT_COS,0)) AS BGT_GM
         FROM   
         (
             SELECT WREMM.PR_Code,WREMM.Client_Code,WREMM.PR_Name,ESSBASE_CLIENT_NAME, LOC_CODE,WREMM.REGION,LOCATION_NAME,
             CASE WHEN METRIC_CATEGORY = ''USD ACTUAL @ BUDGET RATE'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS ACT_REV,  
             CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
             CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS BUDGET ,
			 CASE WHEN METRIC_CATEGORY = ''USD Actual'' AND METRIC_NAME = ''Revenue'' 
			 THEN SUM(METRIC_VALUE) END AS xACT_REV,
			 CASE WHEN METRIC_CATEGORY = ''USD Actual'' AND METRIC_NAME = ''Total Cost of Services'' 
			 THEN SUM(METRIC_VALUE) END AS xACT_COS,  
			 CASE WHEN METRIC_CATEGORY = ''USD Budget Load'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS xBGT_REV, 
			 CASE WHEN METRIC_CATEGORY = ''USD Budget Load'' AND METRIC_NAME = ''Total Cost of Services'' 
			 THEN SUM(METRIC_VALUE) END AS xBGT_COS
             FROM FINANCERAW2016  FW
			 INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = FW.PROJECT_CODE AND WREMM.LOC_CODE=FW.LOCATION_CODE
             WHERE YEAR = '''+CONVERT(VARCHAR,year(GETDATE()))+''' AND METRIC_NAME IN (''REVENUE'',''Total Cost of Services'')  
             AND [MONTH] IN (UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -3, GETDATE()-DAY(GETDATE())+1)),3)),      
             UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -2, GETDATE()-DAY(GETDATE())+1)),3)),      
             UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -1, GETDATE()-DAY(GETDATE())+1)),3)))  
             GROUP BY WREMM.PR_Code,WREMM.Client_Code,WREMM.PR_Name,METRIC_CATEGORY, METRIC_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,WREMM.REGION,LOCATION_NAME
         )   A  
		 GROUP BY PR_Code,Client_Code,PR_Name,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME
	) TMP ON CASE WHEN WR.Project_Code like ''%TOT%'' then REPLACE(TMP.ESSBASE_CLIENT_NAME,''TOTAL '','''') else REPLACE(TMP.PR_Name,''PR '','''') END = CLIENT_NAME 
	and CASE WHEN WR.Project_Code like ''%TOT%'' then Client_Code else PR_Code END = WR.Project_Code 
	AND CASE WHEN WR.LOC_CODE = ''ALL'' then ''ALL'' ELSE TMP.LOC_CODE END = WR.LOC_CODE 
	AND TMP.REGION=WR.REGION 
	WHERE CLIENT_NAME IS NOT NULL  '
     
     IF ltrim(rtrim(ISNULL(@XREGION,'')))<>''
     BEGIN
         SET @XSQL=@XSQL+' AND (WR.REGION IN (SELECT * FROM [SPLITSTRING]('''+ @XREGION + ''','','''+')) or ''ALL'' IN  (SELECT * FROM [SPLITSTRING]('''+ @XREGION + ''','','''+')))'
     END
   SET @XSQL=@XSQL+' ) xTmp
	GROUP BY Levels,Project_Code, CLIENT_NAME,REGION,LOCATION_NAME,LOC_CODE,
	[START DATE],REASON,AGEING,PRIORITY,WAR_ROOM_ID  '

     SET @XSQL=@XSQL+@XSORT+@XSORTORD
     
	 --PRINT(@XSQL)
     EXECUTE(@XSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[War_Room_List_Region]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[War_Room_List_Region]  
  
  
  
@Region Varchar(max)  
  
 as  
  
  (Select u.War_Room_ID , i.ClientName,u.Region,u.Budget,  
  
  --i.Optimal,i.Budget,   
  
  u.[Start_Date], 
'' as Expected_Saving,  
  u.reason  from  
  
(select ClientName, ((sum(Act_Rev)*-1)-(sum(Optimal)*-1)) as Optimal , ((sum(Act_Rev)*-1)-(sum(Budget)*-1)) as Budget,(sum(Act_Rev)*-1) - (sum(Budget)*-1) as SurplusDeficit from   
  
(Select project_code,  
  
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,  
  
case when Metric_Category = 'USD Optimal Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Optimal,  
  
case when Metric_Category = 'USD Budget Load' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Budget  
  
from financeraw2016  
  
where YEAR = '2016' and Metric_Name = 'Revenue'  
  
and [month] in ('Jan','Feb')  
  
group by Metric_Category, Metric_Name,Project_Code)  
  
a  
  
Left Join  
  
(Select * from Client_mapping)b  
  
on a.Project_Code = b.PRCode  
  
where ClientName is not null  
  
group by ClientName  
  
  
  
  
  
)i left join war_room u on i.ClientName=u.Client_Name  
  
  
  
where u.Client_Name is not null and u.region = @Region  
  
)order by Client_Name  
  
  
  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[War_Room_List1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[War_Room_List1]  
(
@XSORT AS VARCHAR(MAX) = NULL,
@XSORTORD AS VARCHAR(MAX) = ' ASC'
)
 AS  
BEGIN
	--SELECT U.WAR_ROOM_ID , I.CLIENTNAME,U.REGION,U.BUDGET,  
 --  --I.OPTIMAL,I.BUDGET,   
	--U.START_DATE,   '' AS EXPECTED_SAVING,    U.REASON,DATEDIFF(D,U.START_DATE,GETDATE())  AS AGEING
 --   FROM  
	--(
	--	SELECT CLIENTNAME, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
	--	(SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT 
	--	FROM   
	--	(
	--		SELECT PROJECT_CODE,  
	--		CASE WHEN METRIC_CATEGORY = 'USD ACTUAL @ BUDGET RATE' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS ACT_REV,  
	--		CASE WHEN METRIC_CATEGORY = 'USD OPTIMAL LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
	--		CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS BUDGET  
	--		FROM FINANCERAW2016  
	--		WHERE YEAR = '2016' AND METRIC_NAME = 'REVENUE'  
	--		AND [MONTH] IN ('JAN','FEB','MAR')  
	--		GROUP BY METRIC_CATEGORY, METRIC_NAME,PROJECT_CODE
	--	)   A  
	--	LEFT JOIN  
	--	(
	--		SELECT * FROM CLIENT_MAPPING
	--	) B ON A.PROJECT_CODE = B.PRCODE  
	--	WHERE CLIENTNAME IS NOT NULL  
	--	GROUP BY CLIENTNAME  
	--	)I LEFT JOIN WAR_ROOM U ON I.CLIENTNAME=U.CLIENT_NAME  
	--WHERE U.CLIENT_NAME IS NOT NULL  
 -- )ORDER BY 1

	IF LTRIM(RTRIM(ISNULL(@XSORT,''))) = ''
	BEGIN
		SET @XSORT = '  '
	END
	ELSE
	BEGIN
		SET @XSORT = ' ORDER BY '+ @XSORT
	END
	
	IF (LTRIM(RTRIM(ISNULL(@XSORTORD,''))) = '[ASC]')
	BEGIN
		SET @XSORTORD = '  '
	END
	ELSE
	BEGIN
		SET @XSORTORD = ' DESC'
	END
	
	DECLARE @XSQL AS VARCHAR(MAX) = ''
  --I.OPTIMAL,I.BUDGET,
	SET @XSQL = 'Select War_Room_ID,Client_Name,Region, Revenue,[Start_Date] ,datediff(d,[start_date],getdate()) as ageing,Reason  from War_Room '

	SET @XSQL = @XSQL + @XSORT  + @XSORTORD
  EXECUTE(@XSQL)
PRINT(@XSQL)  
 END


GO
/****** Object:  StoredProcedure [dbo].[War_Room_RCA_Actions]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[War_Room_RCA_Actions]

@War_Room_ID int,
@Metric_ID int
as
(

Select sr_no,War_room_ID,Metric_ID,Action_Item,Key_Dependency,Owner_of_Action,

convert(varchar(11),convert(date,[Start_Date],106),106) as [Start_Date],
convert(varchar(11),convert(date,Planned_completion_Date,106),106) as Planned_Completion_Date,
convert(varchar(11),convert(date,Actual_completion_Date,106),106) as Actual_Completion_Date,
Expected_Benefit,
Actual_Benefit,
Action_RAG_Status,
Action_Open_or_Closed
 from tbl_WR_RCA_Actions where War_room_ID = @War_Room_ID and Metric_ID = @Metric_ID)

 

GO
/****** Object:  StoredProcedure [dbo].[War_room_Region]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[War_room_Region]
as

Select distinct region from War_Room where region not in ('Corp','Global')
GO
/****** Object:  StoredProcedure [dbo].[Warroom_Ageing]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Warroom_Ageing]
as
(Select AVG(aa.DiffDate) from(Select DATEDIFF(day,Start_Date,getdate()) AS DiffDate
  
   from War_Room wr)aa)


GO
/****** Object:  StoredProcedure [dbo].[Warroom_Ageing_Regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[Warroom_Ageing_Regional]
@Region varchar(max)

as
 (Select AVG(aa.DiffDate) from(Select DATEDIFF(day,Start_Date,getdate()) AS DiffDate
  
   from War_Room wr where Region = @Region)aa)
   
  Select AVG(aa.DiffDate) from(Select DATEDIFF(day,Start_Date,getdate()) AS DiffDate
  
   from War_Room wr where Region = 'EMEA')aa

GO
/****** Object:  StoredProcedure [dbo].[Warroom_Count_Summary]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Warroom_Count_Summary]
as
(Select count(aa.ClientName) as Total_Account,(Select count(Client_Name) from War_Room) as War_room_Account

 from
(
Select ClientName,Region, [YEAR],[MONTH], 
       sum (Revenue) as Revenue,
       sum(Cost_of_service)as Total_Cost_of_Service,
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',
       SUM([Billable hours]) as Billable_Hours,
       sum([Expense Hours]) as Expense_Hours,
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',
       
       SUM(Inbound_Penalties) as 'Inbound_Penalties',
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',
       
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',
       SUM(Overtime) as 'Overtime',
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',
       SUM([Regular Wages]) as 'Regular Wages',
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'
       
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],
case when [Month] in ('Jan','Feb','Mar') then 'Q1'
     when [Month] in ('Apr','May','Jun') then 'Q2'
     when [Month] in ('Jul','Aug','Sep') then 'Q3'
     when [Month] in ('Oct','Nov','Dec') then 'Q4'
     else '' end as 'Quarter',

Country,Sub_Region,Region,
     
     SUM(Revenue) as Revenue, 
     sum([Cost of Services]) as Cost_of_service , 
    
                SUM([Billable Hours]) as [Billable hours],
                SUM([Expense Hours]) as [Expense Hours],
                                
                                
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,
                                
                                
                
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,
                
                Sum([OVERTIME]) as Overtime,
                SUM([REGULAR WAGES]) as 'Regular Wages',
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'         
                
                

from 
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],
ClientName,
Country,
Sub_Region,Region,

case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],

case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]


from
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],
ClientName,
Country,Sub_Region,Region,
sum(Metric_Value) as Metric_Value
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code 
where 
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')
--and [Year] in ('2014','2015')
and len (location_code) = 6
group by Location_Code,[Location_ Name]
,Metric_Category,Metric_Name,[Year],[Month],ClientName,
Country,Sub_Region,Region) aa) bb
where Metric_Category ='USD Budget Load'
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null' 

--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'
--and Metric_Category
--='USD Actual @ Budget Rate'
----USD Actual
----USD Actual @ Budget Rate
----USD Budget Load
----USD Optimal Load
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn

  where [YEAR] = '2016' and [Month] = 'Jan' group by ClientName,Region, [YEAR],[Month])aa)
GO
/****** Object:  StoredProcedure [dbo].[Warroom_Count_Summary_Regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Warroom_Count_Summary_Regional]
@region varchar(255)
as

Select count(aa.ClientName) as Total_Account,(Select count(Client_Name) from War_Room where Region = @region) as War_room_Account

 from
(
Select ClientName,Region, [YEAR],[MONTH], 
       sum (Revenue) as Revenue,
       sum(Cost_of_service)as Total_Cost_of_Service,
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',
       SUM([Billable hours]) as Billable_Hours,
       sum([Expense Hours]) as Expense_Hours,
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',
       
       SUM(Inbound_Penalties) as 'Inbound_Penalties',
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',
       
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',
       SUM(Overtime) as 'Overtime',
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',
       SUM([Regular Wages]) as 'Regular Wages',
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'
       
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],
case when [Month] in ('Jan','Feb','Mar') then 'Q1'
     when [Month] in ('Apr','May','Jun') then 'Q2'
     when [Month] in ('Jul','Aug','Sep') then 'Q3'
     when [Month] in ('Oct','Nov','Dec') then 'Q4'
     else '' end as 'Quarter',

Country,Sub_Region,Region,
     
     SUM(Revenue) as Revenue, 
     sum([Cost of Services]) as Cost_of_service , 
    
                SUM([Billable Hours]) as [Billable hours],
                SUM([Expense Hours]) as [Expense Hours],
                                
                                
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,
                                
                                
                
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,
                
                Sum([OVERTIME]) as Overtime,
                SUM([REGULAR WAGES]) as 'Regular Wages',
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'         
                
                

from 
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],
ClientName,
Country,
Sub_Region,Region,

case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],

case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]


from
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],
ClientName,
Country,Sub_Region,Region,
sum(Metric_Value) as Metric_Value
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code 
where 
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')
--and [Year] in ('2014','2015')
and len (location_code) = 6
group by Location_Code,[Location_ Name]
,Metric_Category,Metric_Name,[Year],[Month],ClientName,
Country,Sub_Region,Region) aa) bb
where Metric_Category ='USD Budget Load'
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null' 

--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'
--and Metric_Category
--='USD Actual @ Budget Rate'
----USD Actual
----USD Actual @ Budget Rate
----USD Budget Load
----USD Optimal Load
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn

  where [YEAR] = '2016' and [Month] = 'Jan' and Region = @region group by ClientName,Region, [YEAR],[Month])aa
GO
/****** Object:  StoredProcedure [dbo].[Warroom_fill_region]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Warroom_fill_region]
	@NT_ID varchar(max),
	@Access_Type varchar(max)
AS
BEGIN
	Select 'All' Region, 'All' RegionValue
	UNION
	Select DR.* From distinct_region DR
	Inner Join [tbl_WR_User_Role] UR on DR.Region = Case when UR.Region = 'Global' THEN DR.Region else UR.Region END
	WHERE UR.NT_ID = @NT_ID--'vkole003'
	and UR.Access_Type = @Access_Type--'Regional'
END

GO
/****** Object:  StoredProcedure [dbo].[Warroom_Glidepath_data]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Warroom_Glidepath_data]

@ProjectName as varchar(255)
as
(

Select * from KPI_Target
where Client_Name = @ProjectName
)


GO
/****** Object:  StoredProcedure [dbo].[Warroom_global_Count]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Warroom_global_Count]  
  
@REGION VARCHAR(255)  = NULL,
@NT_ID as varchar(max) = NULL,
@AccessType as varchar(max) = NULL 

as  

Begin
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''  
	BEGIN  
	 SET @REGION = 'ALL'  
	END  

	-- EXEC [Warroom_global_Count] 'All','rkuch001','global'

		Select count(Client_Name) from War_Room 
	    --where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
		 WHERE 1 = 1  
			AND (
				CONVERT(VARCHAR,REGION) = @REGION  
				OR  (@REGION = 'ALL' AND case when @AccessType = 'Global' then @AccessType else CONVERT(VARCHAR,REGION) end in 
					(
						select Region from tbl_WR_User_Role
						where NT_ID = @NT_ID
						AND Access_Type = @AccessType
						and Start_Date <= GETDATE() and End_Date is null
					)
				)
			)









	------------------------------------------------------ bakcup 26-12-2016
	--Select count(aa.ClientName) as Total_Account,
	--(
	--	Select count(Client_Name) from War_Room 
	--	where (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
	--) as War_room_Account  
	--from  
	--(  
	--	Select ClientName,Region, [YEAR],[MONTH],   
	--	sum (Revenue) as Revenue,  
	--	sum(Cost_of_service)as Total_Cost_of_Service,  
	--	sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',  
	--	(sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',  
	--	SUM([Billable hours]) as Billable_Hours,  
	--	sum([Expense Hours]) as Expense_Hours,  
	--	SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',  
	--	SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,  
	--	SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,  
	--	SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
	--	sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',  
         
	--	SUM(Inbound_Penalties) as 'Inbound_Penalties',  
	--	SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',  
	--	SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
         
	--	SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',  
	--	SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',  
	--	sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',  
	--	SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
	--	(SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',  
	--	SUM(Overtime) as 'Overtime',  
	--	SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',  
	--	SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',  
	--	SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',  
	--	SUM([Regular Wages]) as 'Regular Wages',  
	--	SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'  
         
	--	From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],  
	--	case when [Month] in ('Jan','Feb','Mar') then 'Q1'  
	--	 when [Month] in ('Apr','May','Jun') then 'Q2'  
	--	 when [Month] in ('Jul','Aug','Sep') then 'Q3'  
	--	 when [Month] in ('Oct','Nov','Dec') then 'Q4'  
	--	 else '' end as 'Quarter',  
  
	--Country,Sub_Region,Region,  
       
	--	 SUM(Revenue) as Revenue,   
	--	 sum([Cost of Services]) as Cost_of_service ,   
      
	--				SUM([Billable Hours]) as [Billable hours],  
	--				SUM([Expense Hours]) as [Expense Hours],  
                                  
                                  
	--				SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
	--				SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                                  
                                  
                  
	--				SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
	--				Sum([OVERTIME]) as Overtime,  
	--				SUM([REGULAR WAGES]) as 'Regular Wages',  
	--				sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'           
                  
                  
  
	--from   
	--(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
	--ClientName,  
	--Country,  
	--Sub_Region,Region,  
  
	--case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,  
	--case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],  
  
	--case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],  
	--case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],  
	--case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],  
	--case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],  
	--case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],  
	--case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],  
	--case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],  
	--case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]  
  
  
	--from  
	--(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
	--ClientName,  
	--Country,Sub_Region,Region,  
	--sum(Metric_Value) as Metric_Value  
	--from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code  
	--left join Location_Mapping lm on lm.LOC_Code = f.Location_Code   
	--where   
	--Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',  
	--'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')  
	----and [Year] in ('2014','2015')  
	--and len (location_code) = 6  
	--group by Location_Code,[Location_ Name]  
	--,Metric_Category,Metric_Name,[Year],[Month],ClientName,  
	--Country,Sub_Region,Region) aa) bb  
	--where Metric_Category ='USD Budget Load'  
	----and region not in ('Corp','Global', 'Null') and ClientName <> 'null'   
  
	----ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'  
	----and Metric_Category  
	----='USD Actual @ Budget Rate'  
	------USD Actual  
	------USD Actual @ Budget Rate  
	------USD Budget Load  
	------USD Optimal Load  
	--group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn  
  
	--  where [YEAR] = DATEPART(Year,getdate()) and [Month] = left(DATENAME("MONTH",GETDATE()),3) and 
	--  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')
	--  group by ClientName,Region, [YEAR],[Month])aa
END
GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_FILL]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WARROOM_METRIC_FILL]
  @Warroom_acc_ID int=0,   
  @Metric_ID int=0, 
  @MONTH AS Datetime=null
AS
BEGIN
   
   SELECT TRANS_ID,WARROOM_ACC_ID,	'01-'+ CONVERT(VARCHAR,LEFT(DATENAME(MM,MONTHS),3))+'-'+CONVERT(VARCHAR,DATEPART(YEAR,MONTHS)) AS MONTHS,METRIC_ID,X_TYPE,X_VALUE,UPDATION_DATE,UPDATED_BY,BATCH_ID
   FROM   TBL_WR_GLIDEPATH 
   WHERE  WARROOM_ACC_ID=@Warroom_acc_ID AND METRIC_ID<>0 AND METRIC_ID=@Metric_ID
          AND MONTHS IN (  SELECT XMONTHS FROM [XGETMONTHSGLIDEPATH](@MONTH)
		  --CONVERT(DATE,DATEADD(MONTH, -2, @MONTH)),      
		  --CONVERT(DATE,DATEADD(MONTH, -1, @MONTH)),      
		  --CONVERT(DATE,DATEADD(MONTH, 0, @MONTH)),      
		  --CONVERT(DATE,DATEADD(MONTH, 1, @MONTH)),      
		  --CONVERT(DATE,DATEADD(MONTH, 2, @MONTH)),
		  --CONVERT(DATE,DATEADD(MONTH, 3, @MONTH)),
		  --CONVERT(DATE,DATEADD(MONTH, 4, @MONTH)),
		  --CONVERT(DATE,DATEADD(MONTH, 5, @MONTH)),
		  --CONVERT(DATE,DATEADD(MONTH, 6, @MONTH))
		  )       

END

GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER] --3,'20170201'

(
	@WARROOMID INT,
	@MONTH AS SMALLDATETIME = NULL
)
AS

BEGIN
	if @MONTH is null
	BEGIN
		SET @MONTH = CONVERT(VARCHAR,Getdate(),112)
	END

	SELECT [XMONTH],
	CASE WHEN SUM(BUDGET_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(BUDGET_GM) / SUM(BUDGET_REV) * 100) END [BUDGET_GM_PER],
	CASE WHEN SUM(FORECAST_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(FORECAST_GM) / SUM(FORECAST_REV) * 100) END [FORECAST_GM_PER],
	CASE WHEN SUM(ACTUAL_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(ACTUAL_GM) / SUM(ACTUAL_REV) * 100) END [ACTUAL_GM_PER],
	WAR_ROOM_ID
	FROM (
		SELECT
		SUM(BUDGET_GM) [BUDGET_GM],
		SUM(BUDGET_REV) [BUDGET_REV],
		SUM(FORECAST_GM) [FORECAST_GM],
		SUM(FORECAST_REV) [FORECAST_REV],
		SUM(ACTUAL_GM) [ACTUAL_GM],
		SUM(ACTUAL_REV) [ACTUAL_REV],
		WAR_ROOM_ID,[XMONTH]
		FROM  
		(
			SELECT --PR_CODE,CLIENT_CODE,PR_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME, 
			WAR_ROOM_ID,
			((SUM(BUDGET_REVENUE)*-1)-(SUM(BUDGET_COS))) AS BUDGET_GM,
			((SUM(FORECAST_REVENUE)*-1)-(SUM(FORECAST_COS))) AS FORECAST_GM,
			((SUM(ACTUAL_REVENUE)*-1)-(SUM(ACTUAL_COS))) AS ACTUAL_GM,
			(SUM(BUDGET_REVENUE)*-1) BUDGET_REV,
			(SUM(FORECAST_REVENUE)*-1) FORECAST_REV,
			(SUM(ACTUAL_REVENUE)*-1) ACTUAL_REV,
			[XMONTH]
			FROM   
			(
				SELECT FW.Project_Code PR_CODE, CLIENT_ID CLIENT_CODE,Project_Name PR_NAME,[CLIENT NAME] ESSBASE_CLIENT_NAME, Location_Code LOC_CODE,
				FW.REGION,Location_Name LOCATION_NAME,
				WAR_ROOM_ID,
				CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS BUDGET_REVENUE,  
				CASE WHEN METRIC_CATEGORY = 'USD FORECAST LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS FORECAST_REVENUE ,
				CASE WHEN METRIC_CATEGORY = 'USD ACTUAL' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS ACTUAL_REVENUE,

				CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS BUDGET_COS,  
				CASE WHEN METRIC_CATEGORY = 'USD FORECAST LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS FORECAST_COS,  
				CASE WHEN METRIC_CATEGORY = 'USD ACTUAL' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS ACTUAL_COS,  
			
				CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))) [XMONTH]
				FROM TBLEPM  FW
				
				INNER JOIN WAR_ROOM WR ON CASE WHEN WR.Levels like '%Client%' then REPLACE(FW.[CLIENT NAME],'TOTAL ','') else REPLACE(FW.PROJECT_Name,'PR ','') END = CLIENT_NAME 
				and CASE WHEN WR.Levels like '%Client%' then Client_ID else FW.Project_Code END = WR.Project_Code 
				AND CASE WHEN WR.LOC_CODE = 'ALL' then 'ALL' ELSE FW.LOCATION_CODE END = WR.LOC_CODE 
				AND FW.REGION=WR.REGION 

				WHERE 1 = 1
				AND WAR_ROOM_ID = 1
				AND CLIENT_NAME IS NOT NULL  
				AND METRIC_CATEGORY IN ('USD FORECAST LOAD','USD BUDGET LOAD','USD ACTUAL','USD ACTUAL @ BUDGET RATE' )
				AND METRIC_NAME IN ('REVENUE','TOTAL COST OF SERVICES')      
				AND CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR])))  
				IN (SELECT XMONTHS FROM [XGETMONTHSGLIDEPATH](@MONTH))
				GROUP BY CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))),
				FW.Project_Code , CLIENT_ID ,Project_Name ,[CLIENT NAME] , Location_Code ,
				FW.REGION,Location_Name ,
				WAR_ROOM_ID,METRIC_CATEGORY,METRIC_NAME
			)   A  
			GROUP BY --PR_CODE,CLIENT_CODE,PR_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME,
			WAR_ROOM_ID,[XMONTH]
		) TMP 
		GROUP BY WAR_ROOM_ID,[XMONTH]
	
	) XTMP
	GROUP BY [XMONTH],WAR_ROOM_ID
	ORDER BY 1
----------------------------------------------------------------------
--GS Start
---------------------------------------------------------------------
/*
	SELECT [XMONTH],
	CASE WHEN SUM(BUDGET_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(BUDGET_GM) / SUM(BUDGET_REV) * 100) END [BUDGET_GM_PER],
	CASE WHEN SUM(FORECAST_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(FORECAST_GM) / SUM(FORECAST_REV) * 100) END [FORECAST_GM_PER],
	CASE WHEN SUM(ACTUAL_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(ACTUAL_GM) / SUM(ACTUAL_REV) * 100) END [ACTUAL_GM_PER],
	WAR_ROOM_ID
	FROM (
		SELECT
		SUM(BUDGET_GM) [BUDGET_GM],
		SUM(BUDGET_REV) [BUDGET_REV],
		SUM(FORECAST_GM) [FORECAST_GM],
		SUM(FORECAST_REV) [FORECAST_REV],
		SUM(ACTUAL_GM) [ACTUAL_GM],
		SUM(ACTUAL_REV) [ACTUAL_REV],
		WAR_ROOM_ID,[XMONTH]
		FROM  
		(
			SELECT --PR_CODE,CLIENT_CODE,PR_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME, 
			WAR_ROOM_ID,
			((SUM(BUDGET_REVENUE)*-1)-(SUM(BUDGET_COS))) AS BUDGET_GM,
			((SUM(FORECAST_REVENUE)*-1)-(SUM(FORECAST_COS))) AS FORECAST_GM,
			((SUM(ACTUAL_REVENUE)*-1)-(SUM(ACTUAL_COS))) AS ACTUAL_GM,
			(SUM(BUDGET_REVENUE)*-1) BUDGET_REV,
			(SUM(FORECAST_REVENUE)*-1) FORECAST_REV,
			(SUM(ACTUAL_REVENUE)*-1) ACTUAL_REV,
			[XMONTH]
			FROM   
			(
				SELECT WREMM.PR_CODE,WREMM.CLIENT_CODE,WREMM.PR_NAME,ESSBASE_CLIENT_NAME, WREMM.LOC_CODE,WREMM.REGION,LOCATION_NAME,
				WAR_ROOM_ID,
				CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS BUDGET_REVENUE,  
				CASE WHEN METRIC_CATEGORY = 'USD FORECAST LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS FORECAST_REVENUE ,
				CASE WHEN METRIC_CATEGORY = 'USD ACTUAL' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS ACTUAL_REVENUE,

				CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS BUDGET_COS,  
				CASE WHEN METRIC_CATEGORY = 'USD FORECAST LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS FORECAST_COS,  
				CASE WHEN METRIC_CATEGORY = 'USD ACTUAL' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS ACTUAL_COS,  
			
				CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))) [XMONTH]
				FROM FINANCERAW2016  FW
				INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = FW.PROJECT_CODE AND WREMM.LOC_CODE=FW.LOCATION_CODE
				INNER JOIN WAR_ROOM WR ON CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN REPLACE(WREMM.ESSBASE_CLIENT_NAME,'TOTAL ','') ELSE REPLACE(WREMM.PR_NAME,'PR ','') END = WR.CLIENT_NAME 
				AND CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN CLIENT_CODE ELSE PR_CODE END = WR.PROJECT_CODE 
				AND CASE WHEN WR.LOC_CODE = 'ALL' THEN 'ALL' ELSE WREMM.LOC_CODE END = WR.LOC_CODE 
				AND WREMM.REGION=WR.REGION 
				WHERE 1 = 1
				AND WAR_ROOM_ID = @WARROOMID
				AND METRIC_CATEGORY IN ('USD FORECAST LOAD','USD BUDGET LOAD','USD ACTUAL','USD ACTUAL @ BUDGET RATE' )
				AND METRIC_NAME IN ('REVENUE','TOTAL COST OF SERVICES')      
				AND CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))) 
				IN (SELECT XMONTHS FROM [XGETMONTHSGLIDEPATH](@MONTH))
				GROUP BY CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))),
				WREMM.PR_CODE,WREMM.CLIENT_CODE,WREMM.PR_NAME,METRIC_CATEGORY, METRIC_NAME,ESSBASE_CLIENT_NAME, 
				WREMM.LOC_CODE,WREMM.REGION,LOCATION_NAME,WAR_ROOM_ID
			)   A  
			GROUP BY --PR_CODE,CLIENT_CODE,PR_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME,
			WAR_ROOM_ID,[XMONTH]
		) TMP 
		GROUP BY WAR_ROOM_ID,[XMONTH]
	
	) XTMP
	GROUP BY [XMONTH],WAR_ROOM_ID
	ORDER BY 1
*/
----------------------------------------------------------------------
--GS END
---------------------------------------------------------------------
/*
----------------------------------------------------------------------
--OLD
---------------------------------------------------------------------

@CLIENT_NAME as NVARCHAR(500),    
@LOCATION AS NVARCHAR(500)= null,
@Region AS NVARCHAR(500),
@LOB AS NVARCHAR(500) = null,
@MONTH AS Datetime =null
AS      
BEGIN      
	if isnull(@LOB,'') = ''
	begin
		set @LOB = 'ALL'
	end
	
	if isnull(@LOCATION,'') = ''
	begin
		set @LOCATION = 'ALL'
	end

select  
CLIENTNAME,Metric_Category,      
dateme,      
sum(R_Val) as Revenue,sum(GM_VAL) as Gross_Margin,      
--round(sum(GM_VAL)/isnull(sum(R_Val),4),0) AS GM_PERCENTAGE,   
CASE WHEN SUM(R_Val) = 0 THEN 0 ELSE 
round(nullif(sum(GM_VAL),0)/nullif(sum(R_Val),0),4) *100 END  AS GM_PERCENTAGE      
--(SUM(R_VAL)-SUM(COS_VALUE))/SUM(R_VAL) AS GM_PERCENTAGE      
from       
(      
  Select       
  REPLACE(REPLACE(c.Client_Name1,'TOTAL ',''),'GRAND TOTAL ','') [CLIENTNAME],      
  --c.Client_Name1,  
  l.Country,      
  l.Sub_Region,      
  l.Region,      
  Project_Code,      
  Project_Name,      
  Location_Code,      
  [Location_ Name],      
  Metric_Category,      
  dateme,      
  R_Val,      
  COS_VALUE,      
  GM_Val,      
  GM_Per      
  from       
  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,      
  SUM(rev_value) as R_Val,      
  SUM(cos_value) AS COS_VALUE,      
  CASE WHEN SUM(rev_value)= 0 THEN 0 ELSE
  SUM(rev_value)-SUM(cos_value) END AS GM_Val,      
  round((SUM(rev_value)-SUM(cos_value))/nullif(SUM(rev_value),0),2)  as GM_Per,      
  dateme      
  from       
  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,      
  Case when Metric_Name = 'Revenue' then round((Metric_Value)*-1,0) else 0 end as 'rev_value',      
  Case when Metric_Name = 'Total Cost of Services' then round((Metric_Value),0) else 0 end as 'cos_value',      
  '01-'+CONVERT(varchar,[Month])+'-'+CONVERT(varchar,[year]) as dateme      
  --CONVERT(varchar,[year])+''+convert(varchar,(CONVERT(int,[Month]))) as dateme      
  from financeraw2016      
  --where Metric_Category in ('USD Actual @ Budget Rate','USD Forecast Load','USD Budget Load','USD Actual')      
  where Metric_Category in ('USD Forecast Load','USD Budget Load','USD Actual','USD Actual @ Budget Rate' )      
  and Metric_Name in ('Revenue','Total Cost of Services')      
  and Year = datepart(YEAR,@MONTH)      
  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,Metric_Name,[month],[year],Metric_Value      
  )a      
  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,dateme,dateme)d      
  left join client_mapping c      
  on d.Project_Code = c.PRCode      
  left join Location_Mapping l      
  on d.Location_Code = l.LOC_Code      
  where 1=1      
  and c.Client_Name1 = @CLIENT_NAME      
  and (LOC_Name = @LOCATION OR @LOCATION = 'ALL')
  and  (l.Region = @Region or @Region ='ALL') 
  and (d.Project_Name = @LOB or @LOB = 'ALL')
  --AND d.Project_Name = @LOB

  and dateme in (  
  convert(date,DATEADD(MONTH, -2, @MONTH)),      
  convert(date,DATEADD(MONTH, -1, @MONTH)),      
  convert(date,DATEADD(MONTH, 0, @MONTH)),      
  convert(date,DATEADD(MONTH, 1, @MONTH)),      
  convert(date,DATEADD(MONTH, 2, @MONTH)),
  convert(date,DATEADD(MONTH, 3, @MONTH)),
  convert(date,DATEADD(MONTH, 4, @MONTH)),
  convert(date,DATEADD(MONTH, 5, @MONTH)),
  convert(date,DATEADD(MONTH, 6, @MONTH))
  )       

--order by Project_Code,[Location_ Name],Metric_Category,dateme      

)final_data      

--WHERE Metric_Category = 'USD Budget Load'      
GROUP BY       
CLIENTNAME,Metric_Category,dateme      
END

*/
END

GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER_dotnet]  --'PITNEY BOWES','LOC PH_BAGUIO_Panorama Building'   
    
@CLIENT_NAME as NVARCHAR(500),  
@LOCATION AS NVARCHAR(500)  
AS    
BEGIN

	BEGIN TRY
		
		DECLARE @MonthDate AS VARCHAR(MAX)=''
		DECLARE @MonthDate2 AS VARCHAR(MAX)=''
		DECLARE @xSQL AS VARCHAR(MAX)=''

		--SET @EndDate = GETDATE()
		--SET @EndDate = DATEADD(DAY, 1 - DATEPART(WEEKDAY, @EndDate), CAST(@EndDate AS SMALLDATETIME))
		--SET @StartDate = DATEADD(WEEK,-12,@EndDate)

		IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
		BEGIN
		   DROP TABLE TEMPTABLE2
		END
		
		

		Declare @xDate as Smalldatetime =  GETDATE();

		select     
		 CLIENTNAME,
		 Metric_Category,    
		 convert(smalldatetime,dateme) dateme,    
		 sum(R_Val) as Revenue,sum(GM_VAL) as Gross_Margin,    
		 --round(sum(GM_VAL)/isnull(sum(R_Val),4),0) AS GM_PERCENTAGE,    
		 round(nullif(sum(GM_VAL),0)/nullif(sum(R_Val),0),4)*100 AS GM_PERCENTAGE    
		 --(SUM(R_VAL)-SUM(COS_VALUE))/SUM(R_VAL)*100 AS GM_PERCENTAGE    
		into TEMPTABLE2
		 from     
		 (    
		  Select     
		  REPLACE(REPLACE(c.Client_Name1,'TOTAL ',''),'GRAND TOTAL ','') [CLIENTNAME],    
		  --c.Client_Name1,    
		  l.Country,    
		  l.Sub_Region,    
		  l.Region,    
		  Project_Code,    
		  Project_Name,    
		  Location_Code,    
		  [Location_ Name],    
		  case when Metric_Category = 'USD Actual @ Budget Rate' then 'Target/Budget GM%'
		  When Metric_Category = 'USD Budget Load' then 'Actual Tracker GM%'
		  When Metric_Category = 'USD Forecast Load' then 'Forecasted GM%' end as Metric_Category
		  ,    
		  dateme,    
		  R_Val,    
		  COS_VALUE,    
		  GM_Val,    
		  GM_Per    
		  from     
		  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
		  SUM(rev_value) as R_Val,    
		  SUM(cos_value) AS COS_VALUE,    
		  SUM(rev_value)-SUM(cos_value) as GM_Val,    
		  round((SUM(rev_value)-SUM(cos_value))/nullif(SUM(rev_value),0),2)  as GM_Per,    
		  dateme    
		  from     
		  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
		  Case when Metric_Name = 'Revenue' then round((Metric_Value)*-1,0) else 0 end as 'rev_value',    
		  Case when Metric_Name = 'Total Cost of Services' then round((Metric_Value),0) else 0 end as 'cos_value',    
		  '01-'+CONVERT(varchar,[Month])+'-'+CONVERT(varchar,[year]) as dateme    
		  --CONVERT(varchar,[year])+''+convert(varchar,(CONVERT(int,[Month]))) as dateme    
		  from financeraw2016    
		  where Metric_Category in ('USD Actual @ Budget Rate','USD Forecast Load','USD Budget Load')    
		  and Metric_Name in ('Revenue','Total Cost of Services')    
		  and Year = datepart(YEAR,GETDATE())    
		  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,Metric_Name,[month],[year],Metric_Value    
		  )a    
		  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,dateme,dateme)d    
		  left join client_mapping c    
		  on d.Project_Code = c.PRCode    
		  left join Location_Mapping l    
		  on d.Location_Code = l.LOC_Code    
		  where 1=1    
		  and c.Client_Name1 = @CLIENT_NAME    
		  and LOC_Name = @LOCATION    
		  and CONVERT(SMALLDATETIME,dateme) in (select xMonths from [xGetMonthsGlidePath](GETDATE()))     
		 --order by Project_Code,[Location_ Name],Metric_Category,dateme    
		 )final_data    
		 --WHERE Metric_Category = 'USD Budget Load'    
		 GROUP BY     
		 CLIENTNAME,Metric_Category,    
		 dateme 
		 order by 3 ASC
		
		
		SELECT @MonthDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[dateme],106),' ','-') + '],' + @MonthDate
		FROM TEMPTABLE2 TP
		GROUP BY REPLACE(CONVERT(VARCHAR,TP.[dateme],106),' ','-'),TP.[dateme]
		ORDER BY CONVERT(SMALLDATETIME,TP.[dateme]) DESC
		

		--select @MonthDate

		IF LEFT(@MonthDate,1) = ','
		BEGIN
			SET @MonthDate = RIGHT(@MonthDate,LEN(@MonthDate) - 1)
		END

		IF RIGHT(@MonthDate,1) = ','
		BEGIN
			SET @MonthDate = LEFT(@MonthDate,LEN(@MonthDate) - 1)
		END

		
		SET @xSQL = 'SELECT * INTO TEMPTABLE
			FROM (
				SELECT [Metric_Category] 
				,[dateme]
				,[GM_PERCENTAGE]
				FROM TEMPTABLE2

			) AS S
			PIVOT
			(
				SUM([GM_PERCENTAGE])
				FOR [dateme] IN ('+ @MonthDate +')
				
			)AS PVT'
		print @xSQL
		EXEC(@xSQL)
		
		IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
		BEGIN
		   DROP TABLE TEMPTABLE2
		END

		SELECT * FROM TEMPTABLE
		DROP TABLE TEMPTABLE
	END TRY
	BEGIN CATCH
		Select 'No record(s) found...'    
END catch
end

GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER_dotnet_GS_TEST]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER_dotnet_GS_TEST]  --'PITNEY BOWES','LOC PH_BAGUIO_Panorama Building'   
(
  @XSORT AS VARCHAR(MAX)=NULL,
  @XSORTORD AS VARCHAR(MAX)='[ASC]',
  @XREGION AS VARCHAR(MAX)=NULL
 )
AS 
BEGIN
     IF @XSORT IS NULL SELECT @XSORT='CLIENT_NAME'
     
     IF LTRIM(RTRIM(ISNULL(@XSORT,'')))=''
     BEGIN
         SET @XSORT='  '
     END
     ELSE
     BEGIN
         SET @XSORT=' ORDER BY '+@XSORT
     END
     
     IF(LTRIM(RTRIM(ISNULL(@XSORTORD,'')))='[ASC]')
     BEGIN
         SET @XSORTORD='  '
     END
     ELSE
     BEGIN
         SET @XSORTORD=' DESC'
     END
     
     DECLARE @XSQL AS VARCHAR(MAX)=''
             
--I.OPTIMAL,I.BUDGET,
             
     SET @XSQL='SELECT Levels,Project_Code,CLIENT_NAME,REGION,LOCATION_NAME,LOC_CODE,
		CASE WHEN SUM(BGT_GM) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(ACT_GM) / SUM(BGT_GM) * 100) END [ACTUAL GM VS BGT],	
		[START DATE],REASON,AGEING,PRIORITY,WAR_ROOM_ID
		FROM (
			
			SELECT CASE WHEN WR.Project_Code like ''%TOT%'' then ''Client'' else ''Project'' END as Levels, WR.Project_Code, CLIENT_NAME, WR.REGION,
			CASE WHEN WR.LOC_CODE=''ALL'' THEN WR.LOC_CODE ELSE LOCATION_NAME END [LOCATION_NAME], 
			WR.LOC_CODE, '
			--CONVERT(DECIMAL(18,2),TMP.BUDGET / 1000000) [ACTUAL GM VS BGT],
	SET @XSQL = @XSQL + ' ACT_GM, BGT_GM,
			CONVERT(VARCHAR,START_DATE,106) [START DATE],
			ISNULL(REASON,'''') [REASON],
			CASE WHEN DATEDIFF(D,START_DATE,GETDATE())/7 <= 1 THEN ''WEEK1 (NEW)''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < 4 THEN  ''<1 MONTH'' 
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 > 4 AND  DATEDIFF(D,START_DATE,GETDATE())/7 <= 8 THEN  
			''1 TO 2 MONTHS'' ELSE ''>2 MONTHS'' END  AS [AGEING],
			CASE WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < =1 THEN ''NEW''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 < 4 THEN  ''LOW''  
			WHEN DATEDIFF(D,START_DATE,GETDATE())/7 > 4 AND  DATEDIFF(D,START_DATE,GETDATE())/7 <= 8 THEN  
			''MEDIUM'' ELSE ''HIGH'' END  AS [PRIORITY],WAR_ROOM_ID
			FROM WAR_ROOM WR 
			INNER JOIN (
			SELECT PR_Code,Client_Code,PR_Name,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME, ((SUM(ACT_REV)*-1)-(SUM(OPTIMAL)*-1)) AS OPTIMAL , 
		 ((SUM(ACT_REV)*-1)-(SUM(BUDGET)*-1)) AS BUDGET,
         (SUM(ACT_REV)*-1) - (SUM(BUDGET)*-1) AS SURPLUSDEFICIT,
		 SUM(isnull(xACT_REV,0)*-1) - SUM(isnull(xACT_COS,0)) AS ACT_GM,
		 SUM(isnull(xBGT_REV,0)*-1) - SUM(isnull(xBGT_COS,0)) AS BGT_GM
         FROM   
         (
             SELECT WREMM.PR_Code,WREMM.Client_Code,WREMM.PR_Name,ESSBASE_CLIENT_NAME, LOC_CODE,WREMM.REGION,LOCATION_NAME,
             CASE WHEN METRIC_CATEGORY = ''USD ACTUAL @ BUDGET RATE'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS ACT_REV,  
             CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS OPTIMAL,  
             CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME = ''REVENUE'' THEN SUM(METRIC_VALUE) END AS BUDGET ,
			 CASE WHEN METRIC_CATEGORY = ''USD Actual'' AND METRIC_NAME = ''Revenue'' 
			 THEN SUM(METRIC_VALUE) END AS xACT_REV,
			 CASE WHEN METRIC_CATEGORY = ''USD Actual'' AND METRIC_NAME = ''Total Cost of Services'' 
			 THEN SUM(METRIC_VALUE) END AS xACT_COS,  
			 CASE WHEN METRIC_CATEGORY = ''USD Budget Load'' AND METRIC_NAME = ''REVENUE'' 
			 THEN SUM(METRIC_VALUE) END AS xBGT_REV, 
			 CASE WHEN METRIC_CATEGORY = ''USD Budget Load'' AND METRIC_NAME = ''Total Cost of Services'' 
			 THEN SUM(METRIC_VALUE) END AS xBGT_COS
             FROM FINANCERAW2016  FW
			 INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = FW.PROJECT_CODE AND WREMM.LOC_CODE=FW.LOCATION_CODE
             WHERE YEAR = '''+CONVERT(VARCHAR,year(GETDATE()))+''' AND METRIC_NAME IN (''REVENUE'',''Total Cost of Services'')  
             AND [MONTH] IN (UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -3, GETDATE()-DAY(GETDATE())+1)),3)),      
             UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -2, GETDATE()-DAY(GETDATE())+1)),3)),      
             UPPER(LEFT(DATENAME(MONTH,DATEADD(MONTH, -1, GETDATE()-DAY(GETDATE())+1)),3)))  
             GROUP BY WREMM.PR_Code,WREMM.Client_Code,WREMM.PR_Name,METRIC_CATEGORY, METRIC_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,WREMM.REGION,LOCATION_NAME
         )   A  
		 GROUP BY PR_Code,Client_Code,PR_Name,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME
	) TMP ON CASE WHEN WR.Project_Code like ''%TOT%'' then REPLACE(TMP.ESSBASE_CLIENT_NAME,''TOTAL '','''') else REPLACE(TMP.PR_Name,''PR '','''') END = CLIENT_NAME 
	and CASE WHEN WR.Project_Code like ''%TOT%'' then Client_Code else PR_Code END = WR.Project_Code 
	AND CASE WHEN WR.LOC_CODE = ''ALL'' then ''ALL'' ELSE TMP.LOC_CODE END = WR.LOC_CODE 
	AND TMP.REGION=WR.REGION 
	WHERE CLIENT_NAME IS NOT NULL  '
     
     IF ltrim(rtrim(ISNULL(@XREGION,'')))<>''
     BEGIN
         SET @XSQL=@XSQL+' AND (WR.REGION IN (SELECT * FROM [SPLITSTRING]('''+ @XREGION + ''','','''+')) or ''ALL'' IN  (SELECT * FROM [SPLITSTRING]('''+ @XREGION + ''','','''+')))'
     END
   SET @XSQL=@XSQL+' ) xTmp
	GROUP BY Levels,Project_Code, CLIENT_NAME,REGION,LOCATION_NAME,LOC_CODE,
	[START DATE],REASON,AGEING,PRIORITY,WAR_ROOM_ID  '

     SET @XSQL=@XSQL+@XSORT+@XSORTORD
     
	 ---PRINT(@XSQL)
     EXECUTE(@XSQL)
END
GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER_dotnet_REGION]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER_dotnet_REGION]
(
	@CLIENT_NAME as NVARCHAR(500),  
	@REGION AS NVARCHAR(500)  
)
AS    

BEGIN
	IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
	BEGIN    
	 SET @REGION = 'ALL'    
	END 

	BEGIN
		BEGIN TRY
			DECLARE @MonthDate AS VARCHAR(MAX)=''
			DECLARE @MonthDate2 AS VARCHAR(MAX)=''
			DECLARE @xSQL AS VARCHAR(MAX)=''
			--SET @EndDate = GETDATE()
			--SET @EndDate = DATEADD(DAY, 1 - DATEPART(WEEKDAY, @EndDate), CAST(@EndDate AS SMALLDATETIME))
			--SET @StartDate = DATEADD(WEEK,-12,@EndDate)

			IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
			BEGIN
			   DROP TABLE TEMPTABLE2
			END

			IF OBJECT_ID('dbo.TEMPTABLE', 'U') IS NOT NULL 
			BEGIN
			   DROP TABLE TEMPTABLE
			END
		
			Declare @xDate as Smalldatetime =  GETDATE();

			select     CLIENTNAME,Metric_Category,CONVERT(VARCHAR,convert(smalldatetime,[MONTH]),106) [MONTH],    
			sum(R_Val) as Revenue,sum(GM_VAL) as Gross_Margin,    
			 --round(sum(GM_VAL)/isnull(sum(R_Val),4),0) AS GM_PERCENTAGE,    
			 round(nullif(sum(GM_VAL),0)/nullif(sum(R_Val),0),4)*100 AS GM_PERCENTAGE    
			 --(SUM(R_VAL)-SUM(COS_VALUE))/SUM(R_VAL)*100 AS GM_PERCENTAGE    
			into TEMPTABLE2
			from     
			(    
				Select REPLACE(REPLACE(c.Client_Name1,'TOTAL ',''),'GRAND TOTAL ','') [CLIENTNAME],    
				--c.Client_Name1,    

				l.Country,l.Sub_Region,l.Region,Project_Code,Project_Name,Location_Code,[Location_ Name],    
				case when Metric_Category = 'USD Actual @ Budget Rate' then 'Target/Budget GM%'
				When Metric_Category = 'USD Budget Load' then 'Actual Tracker GM%'
				When Metric_Category = 'USD Forecast Load' then 'Forecasted GM%' end as Metric_Category,    
				[MONTH],R_Val,COS_VALUE,GM_Val,GM_Per    
				from     
				(
					Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
					SUM(rev_value) as R_Val,    
					SUM(cos_value) AS COS_VALUE,    
					SUM(rev_value)-SUM(cos_value) as GM_Val,    
					round((SUM(rev_value)-SUM(cos_value))/nullif(SUM(rev_value),0),2)  as GM_Per,    
					dateme    [MONTH]
					from     
					(
						Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
						Case when Metric_Name = 'Revenue' then round((Metric_Value)*-1,0) else 0 end as 'rev_value',    
						Case when Metric_Name = 'Total Cost of Services' then round((Metric_Value),0) else 0 end as 'cos_value',    
						'01-'+CONVERT(varchar,[Month])+'-'+CONVERT(varchar,[year]) as dateme    
						--CONVERT(varchar,[year])+''+convert(varchar,(CONVERT(int,[Month]))) as dateme    
						from financeraw2016    
						where Metric_Category in ('USD Actual @ Budget Rate','USD Forecast Load','USD Budget Load')    
						and Metric_Name in ('Revenue','Total Cost of Services')    
						and Year = datepart(YEAR,GETDATE())    
						group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,Metric_Name,[month],[year],Metric_Value    
					)a    
				  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,dateme,dateme)d    
				  left join client_mapping c    
				  on d.Project_Code = c.PRCode    
				  left join Location_Mapping l    
				  on d.Location_Code = l.LOC_Code    
				  where 1=1    
				  and c.Client_Name1 = @CLIENT_NAME    
				  and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
				  and CONVERT(SMALLDATETIME,[MONTH]) in (select xMonths from [xGetMonthsGlidePath](GETDATE()))     
				 --order by Project_Code,[Location_ Name],Metric_Category,dateme    
				 )final_data    
			 --WHERE Metric_Category = 'USD Budget Load'    
			 GROUP BY CLIENTNAME,Metric_Category,[MONTH] 
			 order by 3 ASC;

			SELECT @MonthDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[MONTH],106),' ','-') + '],' + @MonthDate
			FROM TEMPTABLE2 TP
			GROUP BY REPLACE(CONVERT(VARCHAR,TP.[MONTH],106),' ','-'),TP.[MONTH]
			ORDER BY CONVERT(SMALLDATETIME,TP.[MONTH]) DESC

			--select @MonthDate
			IF LEFT(@MonthDate,1) = ','
			BEGIN
				SET @MonthDate = RIGHT(@MonthDate,LEN(@MonthDate) - 1)
			END

			IF RIGHT(@MonthDate,1) = ','
			BEGIN
				SET @MonthDate = LEFT(@MonthDate,LEN(@MonthDate) - 1)
			END

			SET @xSQL = 'SELECT * INTO TEMPTABLE
				FROM (
					SELECT [Metric_Category] 
					,[MONTH]
					,[GM_PERCENTAGE]
					FROM TEMPTABLE2
				) AS S'

			--print @xSQL
			EXEC(@xSQL)

			IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
			BEGIN
			   DROP TABLE TEMPTABLE2
			END

			SELECT * FROM TEMPTABLE
			DROP TABLE TEMPTABLE
		END TRY

		BEGIN CATCH
			Select 'No record(s) found...'    

		END catch

	END
END
GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER_dotnet1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER_dotnet1] 
    
@CLIENT_NAME as NVARCHAR(500),  
@LOCATION AS NVARCHAR(500)  
AS    
BEGIN

	BEGIN TRY
		
		DECLARE @MonthDate AS VARCHAR(MAX)=''
		DECLARE @MonthDate2 AS VARCHAR(MAX)=''
		DECLARE @xSQL AS VARCHAR(MAX)=''

		--SET @EndDate = GETDATE()
		--SET @EndDate = DATEADD(DAY, 1 - DATEPART(WEEKDAY, @EndDate), CAST(@EndDate AS SMALLDATETIME))
		--SET @StartDate = DATEADD(WEEK,-12,@EndDate)

		IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
		BEGIN
		   DROP TABLE TEMPTABLE2
		END
		
		

		Declare @xDate as Smalldatetime =  GETDATE();

		select     
		 CLIENTNAME,
		 Metric_Category,    
		 convert(smalldatetime,dateme) dateme,    
		 isnull(sum(R_Val),0) as Revenue,
		 isnull(sum(GM_VAL),0) as Gross_Margin,    
		 --round(sum(GM_VAL)/isnull(sum(R_Val),4),0) AS GM_PERCENTAGE,    
		 isnull(round(nullif(sum(GM_VAL),0)/nullif(sum(R_Val),0),4)*100,0) AS GM_PERCENTAGE    
		 --(SUM(R_VAL)-SUM(COS_VALUE))/SUM(R_VAL)*100 AS GM_PERCENTAGE    
		into TEMPTABLE2
		 from     
		 (    
		  Select     
		  REPLACE(REPLACE(c.Client_Name1,'TOTAL ',''),'GRAND TOTAL ','') [CLIENTNAME],    
		  --c.Client_Name1,    
		  l.Country,    
		  l.Sub_Region,    
		  l.Region,    
		  Project_Code,    
		  Project_Name,    
		  Location_Code,    
		  [Location_ Name],    
		  case when Metric_Category = 'USD Actual @ Budget Rate' then 'Target/Budget GM%'
		  When Metric_Category = 'USD Budget Load' then 'Actual Tracker GM%'
		  When Metric_Category = 'USD Forecast Load' then 'Forecasted GM%' end as Metric_Category
		  ,    
		  dateme,    
		  nullif(R_Val,0) as R_Val,    
		  nullif(COS_VALUE,0) as COS_VALUE ,    
		  nullif(GM_Val,0) as   GM_Val,
		  nullif(GM_Per,0) as GM_Per    
		  from     
		  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
		  nullif(SUM(rev_value),0) as R_Val,    
		  nullif(SUM(cos_value),0) AS COS_VALUE,    
		  nullif(SUM(rev_value),0)-nullif(SUM(cos_value),0) as GM_Val,    
		  nullif(round((SUM(rev_value)-SUM(cos_value))/nullif(SUM(rev_value),0),2),0)  as GM_Per,    
		  dateme    
		  from     
		  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
		  Case when Metric_Name = 'Revenue' then round((Metric_Value)*-1,0) else 0 end as 'rev_value',    
		  Case when Metric_Name = 'Total Cost of Services' then round((Metric_Value),0) else 0 end as 'cos_value',    
		  '01-'+CONVERT(varchar,[Month])+'-'+CONVERT(varchar,[year]) as dateme    
		  --CONVERT(varchar,[year])+''+convert(varchar,(CONVERT(int,[Month]))) as dateme    
		  from financeraw2016    
		  where Metric_Category in ('USD Actual @ Budget Rate','USD Forecast Load','USD Budget Load')    
		  and Metric_Name in ('Revenue','Total Cost of Services')    
		  and Year = datepart(YEAR,GETDATE())    
		  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,Metric_Name,[month],[year],Metric_Value    
		  )a    
		  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,dateme,dateme)d    
		  left join client_mapping c    
		  on d.Project_Code = c.PRCode    
		  left join Location_Mapping l    
		  on d.Location_Code = l.LOC_Code    
		  where 1=1    
		  and c.Client_Name1 = @CLIENT_NAME   
		  and Region = @LOCATION    
		  and CONVERT(SMALLDATETIME,dateme) in (select xMonths from [xGetMonthsGlidePath](GETDATE()))     
		 --order by Project_Code,[Location_ Name],Metric_Category,dateme    
		 )final_data    
		 --WHERE Metric_Category = 'USD Budget Load'    
		 GROUP BY     
		 CLIENTNAME,Metric_Category,    
		 dateme 
		 order by 3 ASC
		
		
		SELECT @MonthDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[dateme],106),' ','-') + '],' + @MonthDate
		FROM TEMPTABLE2 TP
		GROUP BY REPLACE(CONVERT(VARCHAR,TP.[dateme],106),' ','-'),TP.[dateme]
		ORDER BY CONVERT(SMALLDATETIME,TP.[dateme]) DESC
		

		--select @MonthDate

		IF LEFT(@MonthDate,1) = ','
		BEGIN
			SET @MonthDate = RIGHT(@MonthDate,LEN(@MonthDate) - 1)
		END

		IF RIGHT(@MonthDate,1) = ','
		BEGIN
			SET @MonthDate = LEFT(@MonthDate,LEN(@MonthDate) - 1)
		END

		
		SET @xSQL = 'SELECT * INTO TEMPTABLE
			FROM TEMPTABLE2'
				
		print @xSQL
		EXEC(@xSQL)
		
		IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
		BEGIN
		   DROP TABLE TEMPTABLE2
		END

		SELECT * FROM TEMPTABLE
		DROP TABLE TEMPTABLE
	END TRY
	BEGIN CATCH
		Select 'No record(s) found...'    
END catch
end

GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER_Paras_TODELETE]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER_Paras_TODELETE] 
(
	@WARROOMID INT,
	@MONTH AS SMALLDATETIME = NULL
)
AS

BEGIN
	if @MONTH is null
	BEGIN
		SET @MONTH = CONVERT(VARCHAR,Getdate(),112)
	END
	SELECT [XMONTH],
	CASE WHEN SUM(BUDGET_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(BUDGET_GM) / SUM(BUDGET_REV) * 100) END [BUDGET_GM_PER],
	CASE WHEN SUM(FORECAST_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(FORECAST_GM) / SUM(FORECAST_REV) * 100) END [FORECAST_GM_PER],
	CASE WHEN SUM(ACTUAL_REV) = 0 THEN 0 ELSE CONVERT(DECIMAL(18,2),SUM(ACTUAL_GM) / SUM(ACTUAL_REV) * 100) END [ACTUAL_GM_PER],
	WAR_ROOM_ID
	FROM (
		SELECT
		SUM(BUDGET_GM) [BUDGET_GM],
		SUM(BUDGET_REV) [BUDGET_REV],
		SUM(FORECAST_GM) [FORECAST_GM],
		SUM(FORECAST_REV) [FORECAST_REV],
		SUM(ACTUAL_GM) [ACTUAL_GM],
		SUM(ACTUAL_REV) [ACTUAL_REV],
		WAR_ROOM_ID,[XMONTH]
		FROM  
		(
			SELECT --PR_CODE,CLIENT_CODE,PR_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME, 
			WAR_ROOM_ID,
			((SUM(BUDGET_REVENUE)*-1)-(SUM(BUDGET_COS))) AS BUDGET_GM,
			((SUM(FORECAST_REVENUE)*-1)-(SUM(FORECAST_COS))) AS FORECAST_GM,
			((SUM(ACTUAL_REVENUE)*-1)-(SUM(ACTUAL_COS))) AS ACTUAL_GM,
			(SUM(BUDGET_REVENUE)*-1) BUDGET_REV,
			(SUM(FORECAST_REVENUE)*-1) FORECAST_REV,
			(SUM(ACTUAL_REVENUE)*-1) ACTUAL_REV,
			[XMONTH]
			FROM   
			(
				SELECT WREMM.PR_CODE,WREMM.CLIENT_CODE,WREMM.PR_NAME,ESSBASE_CLIENT_NAME, WREMM.LOC_CODE,WREMM.REGION,LOCATION_NAME,
				WAR_ROOM_ID,
				CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS BUDGET_REVENUE,  
				CASE WHEN METRIC_CATEGORY = 'USD FORECAST LOAD' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS FORECAST_REVENUE ,
				CASE WHEN METRIC_CATEGORY = 'USD ACTUAL' AND METRIC_NAME = 'REVENUE' THEN SUM(METRIC_VALUE) END AS ACTUAL_REVENUE,

				CASE WHEN METRIC_CATEGORY = 'USD BUDGET LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS BUDGET_COS,  
				CASE WHEN METRIC_CATEGORY = 'USD FORECAST LOAD' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS FORECAST_COS,  
				CASE WHEN METRIC_CATEGORY = 'USD ACTUAL' AND METRIC_NAME = 'TOTAL COST OF SERVICES' THEN SUM(METRIC_VALUE) END AS ACTUAL_COS,  
			
				CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))) [XMONTH]
				FROM FINANCERAW2016  FW
				INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = FW.PROJECT_CODE AND WREMM.LOC_CODE=FW.LOCATION_CODE
				INNER JOIN WAR_ROOM WR ON CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN REPLACE(WREMM.ESSBASE_CLIENT_NAME,'TOTAL ','') ELSE REPLACE(WREMM.PR_NAME,'PR ','') END = WR.CLIENT_NAME 
				AND CASE WHEN WR.PROJECT_CODE LIKE '%TOT%' THEN CLIENT_CODE ELSE PR_CODE END = WR.PROJECT_CODE 
				AND CASE WHEN WR.LOC_CODE = 'ALL' THEN 'ALL' ELSE WREMM.LOC_CODE END = WR.LOC_CODE 
				AND WREMM.REGION=WR.REGION 
				WHERE 1 = 1
				AND WAR_ROOM_ID = @WARROOMID
				AND METRIC_CATEGORY IN ('USD FORECAST LOAD','USD BUDGET LOAD','USD ACTUAL','USD ACTUAL @ BUDGET RATE' )
				AND METRIC_NAME IN ('REVENUE','TOTAL COST OF SERVICES')      
				AND CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))) 
				IN (SELECT XMONTHS FROM [XGETMONTHSGLIDEPATH](@MONTH))
				GROUP BY CONVERT(SMALLDATETIME,('01-'+[MONTH]+'-'+CONVERT(VARCHAR,[YEAR]))),
				WREMM.PR_CODE,WREMM.CLIENT_CODE,WREMM.PR_NAME,METRIC_CATEGORY, METRIC_NAME,ESSBASE_CLIENT_NAME, 
				WREMM.LOC_CODE,WREMM.REGION,LOCATION_NAME,WAR_ROOM_ID
			)   A  
			GROUP BY --PR_CODE,CLIENT_CODE,PR_NAME,ESSBASE_CLIENT_NAME, LOC_CODE,REGION,LOCATION_NAME,
			WAR_ROOM_ID,[XMONTH]
		) TMP 
		GROUP BY WAR_ROOM_ID,[XMONTH]
	
	) XTMP
	GROUP BY [XMONTH],WAR_ROOM_ID
	ORDER BY 1

END
GO
/****** Object:  StoredProcedure [dbo].[WARROOM_METRIC_UPLOADER_REGION]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WARROOM_METRIC_UPLOADER_REGION]
      
@CLIENT_NAME as NVARCHAR(500),    
@REGION AS NVARCHAR(500)    
AS      

IF LTRIM(RTRIM(ISNULL(@REGION,''))) = ''    
BEGIN    
 SET @REGION = 'ALL'    
END 


BEGIN      
 select       
 CLIENTNAME,Metric_Category,      
 dateme,      
 sum(R_Val) as Revenue,sum(GM_VAL) as Gross_Margin,      
 --round(sum(GM_VAL)/isnull(sum(R_Val),4),0) AS GM_PERCENTAGE,   
CASE WHEN SUM(R_Val) = 0 THEN 0 ELSE 
round(nullif(sum(GM_VAL),0)/nullif(sum(R_Val),0),4) END AS GM_PERCENTAGE      
 --(SUM(R_VAL)-SUM(COS_VALUE))/SUM(R_VAL) AS GM_PERCENTAGE      
      
 from       
 (      
  Select       
  REPLACE(REPLACE(c.Client_Name1,'TOTAL ',''),'GRAND TOTAL ','') [CLIENTNAME],      
  --c.Client_Name1,      
  l.Country,      
  l.Sub_Region,      
  l.Region,      
  Project_Code,      
  Project_Name,      
  Location_Code,      
  [Location_ Name],      
  Metric_Category,      
  dateme,      
  R_Val,      
  COS_VALUE,      
  GM_Val,      
  GM_Per      
  from       
  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,      
  SUM(rev_value) as R_Val,      
  SUM(cos_value) AS COS_VALUE,      
  CASE WHEN SUM(rev_value)= 0 THEN 0 ELSE
  SUM(rev_value)-SUM(cos_value) END AS GM_Val,      
  round((SUM(rev_value)-SUM(cos_value))/nullif(SUM(rev_value),0),2)  as GM_Per,      
  dateme      
  from       
  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,      
  Case when Metric_Name = 'Revenue' then round((Metric_Value)*-1,0) else 0 end as 'rev_value',      
  Case when Metric_Name = 'Total Cost of Services' then round((Metric_Value),0) else 0 end as 'cos_value',      
  '01-'+CONVERT(varchar,[Month])+'-'+CONVERT(varchar,[year]) as dateme      
  --CONVERT(varchar,[year])+''+convert(varchar,(CONVERT(int,[Month]))) as dateme      
  from financeraw2016      
  where Metric_Category in ('USD Actual @ Budget Rate','USD Forecast Load','USD Budget Load')      
  and Metric_Name in ('Revenue','Total Cost of Services')      
  and Year = datepart(YEAR,GETDATE())      
  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,Metric_Name,[month],[year],Metric_Value      
  )a      
  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,dateme,dateme)d      
  left join client_mapping c      
  on d.Project_Code = c.PRCode      
  left join Location_Mapping l      
  on d.Location_Code = l.LOC_Code      
  where 1=1      
  and c.Client_Name1 = @CLIENT_NAME      
 and  (CONVERT(VARCHAR,REGION) = @REGION  OR  @REGION = 'ALL')  
  and dateme in (convert(date,DATEADD(MONTH, -3, GETDATE()-DAY(getdate())+1)),      
  convert(date,DATEADD(MONTH, -2, GETDATE()-DAY(getdate())+1)),      
  convert(date,DATEADD(MONTH, -1, GETDATE()-DAY(getdate())+1)),      
  convert(date,DATEADD(MONTH, 0, GETDATE()-DAY(getdate())+1)),      
  convert(date,DATEADD(MONTH, 1, GETDATE()-DAY(getdate())+1)),      
  convert(date,DATEADD(MONTH, 2, GETDATE()-DAY(getdate())+1)))       
 --order by Project_Code,[Location_ Name],Metric_Category,dateme      
 )final_data      
 --WHERE Metric_Category = 'USD Budget Load'      
 GROUP BY       
 CLIENTNAME,Metric_Category,      
 dateme      
END

GO
/****** Object:  StoredProcedure [dbo].[Warroom_mom_date]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Warroom_mom_date]  

@ProjectName as varchar(255)  
as  

(  

select convert(varchar(11),[Date],106) as MOM_Date,
ROW_NUMBER() OVER(PARTITION BY Project_Name ORDER BY [Date] DESC) AS Row
from Warroom_Meeting 
where project_name = @ProjectName
group by Project_Name, [Date]
  

)order by [date] desc





GO
/****** Object:  StoredProcedure [dbo].[Warroom_mom_date_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Warroom_mom_date_dotnet]  

  

@ProjectID as varchar(255)  

as  

(  

  

select convert(varchar(11),[Date],106) as MOM_Date,
ROW_NUMBER() OVER(PARTITION BY ProjectID ORDER BY [Date] DESC) AS Row
from Warroom_Meeting 
where ProjectID = @ProjectID
group by ProjectID, [Date]
  

)order by [date] desc



GO
/****** Object:  StoredProcedure [dbo].[Warroom_Operational_Comments]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Warroom_Operational_Comments]
@Client_Name Varchar(255)
as
Select * from Comments Where [Client Name]= @Client_Name

GO
/****** Object:  StoredProcedure [dbo].[Warroom_Operational_Comments_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Warroom_Operational_Comments_dotnet]

@Client_Name Varchar(255),

@Metric Varchar(255)

as

Select sr_No,[Client Name],Metrics,Action_Item,Owner_of_Action,Expected_Benefit,_Action_Open_or_Closed from Comments Where [Client Name] like '%'+@Client_Name+'%' and Metrics = @Metric
GO
/****** Object:  StoredProcedure [dbo].[Warroom_Sum_Summary]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Warroom_Sum_Summary]  
as  
(Select Sum(aa.Revenue) as Total_Account,(Select Sum(Revenue) from War_Room) as War_room_Account  
  
 from  
(  
Select ClientName,Region, [YEAR],[MONTH],   
       sum (Revenue) as Revenue,  
       sum(Cost_of_service)as Total_Cost_of_Service,  
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',  
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',  
       SUM([Billable hours]) as Billable_Hours,  
       sum([Expense Hours]) as Expense_Hours,  
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,  
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,  
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',  
         
       SUM(Inbound_Penalties) as 'Inbound_Penalties',  
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',  
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
         
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',  
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',  
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',  
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',  
       SUM(Overtime) as 'Overtime',  
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',  
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',  
       SUM([Regular Wages]) as 'Regular Wages',  
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'  
         
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],  
case when [Month] in ('Jan','Feb','Mar') then 'Q1'  
     when [Month] in ('Apr','May','Jun') then 'Q2'  
     when [Month] in ('Jul','Aug','Sep') then 'Q3'  
     when [Month] in ('Oct','Nov','Dec') then 'Q4'  
     else '' end as 'Quarter',  
  
Country,Sub_Region,Region,  
       
     SUM(Revenue) as Revenue,   
     sum([Cost of Services]) as Cost_of_service ,   
      
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                                  
                                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                                  
                                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'           
                  
                  
  
from   
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
ClientName,  
Country,  
Sub_Region,Region,  
  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,  
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],  
  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],  
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],  
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],  
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],  
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],  
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]  
  
  
from  
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
ClientName,  
Country,Sub_Region,Region,  
sum(Metric_Value) as Metric_Value  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code  
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code   
where   
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',  
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')  
--and [Year] in ('2014','2015')  
and len (location_code) = 6  
group by Location_Code,[Location_ Name]  
,Metric_Category,Metric_Name,[Year],[Month],ClientName,  
Country,Sub_Region,Region) aa) bb  
where Metric_Category ='USD Budget Load'  

group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn  
  
  where [YEAR] = '2016' and [Month] = datename(M,getdate()) group by ClientName,Region, [YEAR],[Month])aa)  
  
  
GO
/****** Object:  StoredProcedure [dbo].[Warroom_Sum_Summary_dotnet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[Warroom_Sum_Summary_dotnet]
  
as  
Select Total_Account,
case when War_room_Account >= 1000000 then Cast(round(sUM(War_room_Account)/1000000,2) AS varchar(max))+' M'  
when War_room_Account < 1000000 then Cast(round(sUM(War_room_Account)/1000,2) AS varchar(max))+' K'   end AS War_room_accounts

from 
(Select Sum(aa.Revenue) as Total_Account,(Select Sum(Revenue) from War_Room) as War_room_Account  
  
 from  
(  
Select ClientName,Region, [YEAR],[MONTH],   
       sum (Revenue) as Revenue,  
       sum(Cost_of_service)as Total_Cost_of_Service,  
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',  
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',  
       SUM([Billable hours]) as Billable_Hours,  
       sum([Expense Hours]) as Expense_Hours,  
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',  
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,  
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,  
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',  
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',  
         
       SUM(Inbound_Penalties) as 'Inbound_Penalties',  
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',  
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',  
         
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',  
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',  
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',  
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',  
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',  
       SUM(Overtime) as 'Overtime',  
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',  
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',  
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',  
       SUM([Regular Wages]) as 'Regular Wages',  
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'  
         
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],  
case when [Month] in ('Jan','Feb','Mar') then 'Q1'  
     when [Month] in ('Apr','May','Jun') then 'Q2'  
     when [Month] in ('Jul','Aug','Sep') then 'Q3'  
     when [Month] in ('Oct','Nov','Dec') then 'Q4'  
     else '' end as 'Quarter',  
  
Country,Sub_Region,Region,  
       
     SUM(Revenue) as Revenue,   
     sum([Cost of Services]) as Cost_of_service ,   
      
                SUM([Billable Hours]) as [Billable hours],  
                SUM([Expense Hours]) as [Expense Hours],  
                                  
                                  
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,  
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,  
                                  
                                  
                  
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,  
                  
                Sum([OVERTIME]) as Overtime,  
                SUM([REGULAR WAGES]) as 'Regular Wages',  
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'           
                  
                  
  
from   
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],  
ClientName,  
Country,  
Sub_Region,Region,  
  
case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,  
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],  
  
case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],  
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],  
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],  
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],  
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],  
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],  
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],  
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]  
  
  
from  
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],  
ClientName,  
Country,Sub_Region,Region,  
sum(Metric_Value) as Metric_Value  
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code  
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code   
where   
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',  
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')  
--and [Year] in ('2014','2015')  
and len (location_code) = 6  
group by Location_Code,[Location_ Name]  
,Metric_Category,Metric_Name,[Year],[Month],ClientName,  
Country,Sub_Region,Region) aa) bb  
where Metric_Category ='USD Budget Load'  
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn    
  where [YEAR] = '2016' and [Month] = datename(M,getdate()) group by ClientName,Region, [YEAR],[Month])aa)zz
group by Total_Account , War_room_Account
GO
/****** Object:  StoredProcedure [dbo].[Warroom_Sum_Summary_Regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Warroom_Sum_Summary_Regional]
@Region varchar(max)
as
(Select Sum(aa.Revenue) as Total_Account,(Select Sum(Revenue) from War_Room Where Region = @Region) as War_room_Account

 from
(
Select ClientName,Region, [YEAR],[MONTH], 
       sum (Revenue) as Revenue,
       sum(Cost_of_service)as Total_Cost_of_Service,
       sum(Revenue)-sum(Cost_of_service) as 'Gross_Margin',
       (sum(Revenue)-sum(Cost_of_service)) / nullif(sum(Revenue),0) as 'Gross_Margin%',
       SUM([Billable hours]) as Billable_Hours,
       sum([Expense Hours]) as Expense_Hours,
       SUM([Billable hours]) /nullif(sum([Expense Hours]),0) as 'BTP with Training%',
       SUM(Billable_Hours_Excluding_Training) as Billable_Hours_Excluding_Training,
       SUM(Expence_Hours_Excluding_Training) as Expence_Hours_Excluding_Training,
       SUM(Billable_Hours_Excluding_Training) /nullif(SUM(Expence_Hours_Excluding_Training),0) as  'BTP without Training%',
       sum([Expense Hours]) - SUM(Expence_Hours_Excluding_Training) as 'Training Hours',
       
       SUM(Inbound_Penalties) as 'Inbound_Penalties',
       SUM(Revenue) /nullif(SUM(Expence_Hours_Excluding_Training),0)   as 'RPEHWOTRG',
       SUM(Revenue) /nullif(sum([Expense Hours]),0) as 'RPEHWITHTRG',
       
       SUM(Revenue) / nullif(SUM(Billable_Hours_Excluding_Training),0)  as  'RPBHEXTRG',
       SUM(Revenue) / nullif(SUM([Billable hours]),0) as 'RPBHINCTRG',
       sum(Cost_of_service) /nullif(sum([Expense Hours]),0) as 'COSPEXHWITHTRG',
       SUM(Inbound_Penalties) / nullif(SUM(Revenue),0)  as 'PENALTY%',
       (SUM([Expense Hours]) - SUM(Expence_Hours_Excluding_Training))/nullif(sum([Expense Hours]),0) as  'Trg Hrs vs Tot Exp Hrs',
       SUM(Overtime) as 'Overtime',
       SUM(Overtime)/nullif(sum(Cost_of_service),0) as 'Overtime % to COS',
       SUM([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help',
       SUM([COS_Salaries & Temporary Help])/ nullif(sum(Cost_of_service),0)  as 'COS_Salaries% to COS',
       SUM([Regular Wages]) as 'Regular Wages',
       SUM([Regular Wages])/ nullif(SUM(Cost_of_service),0) as 'Regular Wages % to COS'
       
       From (Select ClientName,[Location_ Name],metric_category,metric_name,[year],[month],
case when [Month] in ('Jan','Feb','Mar') then 'Q1'
     when [Month] in ('Apr','May','Jun') then 'Q2'
     when [Month] in ('Jul','Aug','Sep') then 'Q3'
     when [Month] in ('Oct','Nov','Dec') then 'Q4'
     else '' end as 'Quarter',

Country,Sub_Region,Region,
     
     SUM(Revenue) as Revenue, 
     sum([Cost of Services]) as Cost_of_service , 
    
                SUM([Billable Hours]) as [Billable hours],
                SUM([Expense Hours]) as [Expense Hours],
                                
                                
                SUM([Billable Hours Excluding Training]) as Billable_Hours_Excluding_Training,
                SUM([Expense Hours Excluding Training]) as Expence_Hours_Excluding_Training,
                                
                                
                
                SUM([INBOUND PENALTIES]) as Inbound_Penalties,
                
                Sum([OVERTIME]) as Overtime,
                SUM([REGULAR WAGES]) as 'Regular Wages',
                sum([COS_Salaries & Temporary Help]) as 'COS_Salaries & Temporary Help'         
                
                

from 
(select aa.location_code, aa.[Location_ Name], aa.metric_category, aa.metric_name, aa.[year], aa.[month],
ClientName,
Country,
Sub_Region,Region,

case when aa.metric_name = 'Revenue' then (aa.Metric_Value* -1) else null end as Revenue,
case when aa.metric_name = 'Total Cost of Services' then aa.Metric_Value else null end as [Cost of Services],

case when aa.Metric_Name = 'REGULAR WAGES' then aa.Metric_Value else null end as [REGULAR WAGES],
case when aa.Metric_Name = 'OVERTIME' then aa.Metric_Value else null end as [OVERTIME],
case when aa.Metric_Name = 'INBOUND PENALTIES' then aa.Metric_Value else null end as [INBOUND PENALTIES],
case when aa.Metric_Name = 'Expense Hours Excluding Training' then aa.Metric_Value else null end as [Expense Hours Excluding Training],
case when aa.Metric_Name = 'Expense Hours' then aa.Metric_Value else null end as [Expense Hours],
case when aa.Metric_Name = 'Billable Hours Excluding Training' then aa.Metric_Value else null end as [Billable Hours Excluding Training],
case when aa.Metric_Name = 'Billable Hours' then aa.Metric_Value else null end as [Billable Hours],
case when aa.Metric_Name = 'COS_Salaries & Temporary Help' then aa.Metric_Value else null end as [COS_Salaries & Temporary Help]


from
(select Location_Code,[Location_ Name],Metric_Category,Metric_Name,[Year],[Month],
ClientName,
Country,Sub_Region,Region,
sum(Metric_Value) as Metric_Value
from financeraw2016 f left join Client_mapping cm on cm.PRCode = f.Project_Code
left join Location_Mapping lm on lm.LOC_Code = f.Location_Code 
where 
Metric_Name in ('Total Cost of Services','Revenue','REGULAR WAGES','OVERTIME','INBOUND PENALTIES',
'Expense Hours Excluding Training','Expense Hours','Billable Hours Excluding Training','Billable Hours','COS_Salaries & Temporary Help')
--and [Year] in ('2014','2015')
and len (location_code) = 6
group by Location_Code,[Location_ Name]
,Metric_Category,Metric_Name,[Year],[Month],ClientName,
Country,Sub_Region,Region) aa) bb
where Metric_Category ='USD Budget Load'
--and region not in ('Corp','Global', 'Null') and ClientName <> 'null' 

--ClientName like 'TOTAL AT%' and [Year] = '2014' and [Month] = 'Jun'
--and Metric_Category
--='USD Actual @ Budget Rate'
----USD Actual
----USD Actual @ Budget Rate
----USD Budget Load
----USD Optimal Load
group by ClientName,[Location_ Name],metric_category,metric_name,[year],[month],ClientName,Country,Sub_Region,Region)nn

  where [YEAR] = '2016' and [Month] = 'Feb' and Region = @Region group by ClientName,Region, [YEAR],[Month])aa)



  


GO
/****** Object:  StoredProcedure [dbo].[Warroom_View_mom_details]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Warroom_View_mom_details]
@PROJECTID as varchar(255),
@Date as date

as

(

Select Action_ID, Action_Item,Responsible_Person,Completion_Date from [Warroom_Meeting] where [Date] = @Date and ProjectID =  @PROJECTID

)


GO
/****** Object:  StoredProcedure [dbo].[Warroom_View_mom_details_All]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Warroom_View_mom_details_All]  
@WAR_ROOM_ID AS VARCHAR(255)  
AS  
BEGIN
	SELECT ProjectID, ACTION_ID,Action_Flag,ACTION_ITEM, RESPONSIBLE_PERSON,[STATUS],
	case when CONVERT(VARCHAR,COMPLETION_DATE,106) = '01 Jan 1900' then ''  else CONVERT(VARCHAR,COMPLETION_DATE,106) END AS [COMPLETION_DATE]
	FROM [WARROOM_MEETING] 
	WHERE  PROJECTID = @WAR_ROOM_ID  
	--AND [STATUS] = 'PENDING'  
	ORDER BY [STATUS] DESC, COMPLETION_DATE
END


GO
/****** Object:  StoredProcedure [dbo].[Warroom_View_mom_details_DOTNET]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Warroom_View_mom_details_DOTNET]
	@PROJECTID as varchar(255),
	@Date as date
as
BEGIN
	SELECT ACTION_ID [MOM ACTION ID], ACTION_ITEM [ACTIONS],RESPONSIBLE_PERSON [RESPONSIBLITY],
	CASE WHEN REPLACE(CONVERT(VARCHAR,COMPLETION_DATE,106),' ','-') = '01-Jan-1900' THEN '' ELSE
	REPLACE(CONVERT(VARCHAR,COMPLETION_DATE,106),' ','-') END AS [COMPLETION DATE]
	FROM [WARROOM_MEETING] 
	WHERE [DATE] = @DATE AND PROJECTID =  @PROJECTID
END



GO
/****** Object:  StoredProcedure [dbo].[warrroom_bridge]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[warrroom_bridge]

@clientname as varchar(max)

as

select ClientName, sum(Act_Rev)*-1 as Revenue from   

(Select project_code,  

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev

from financeraw2016  

where YEAR = datename(year,GETDATE()) and 
Metric_Name = 'Revenue'  and
[month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+30),3),left(datename(M,GETDATE()+60),3))
group by Metric_Category, Metric_Name,Project_Code)a  

Left Join  

(Select * from Client_mapping)b  

on a.Project_Code = b.PRCode 
Where ClientName= @clientname
group by ClientName


GO
/****** Object:  StoredProcedure [dbo].[warrroom_bridge_regional]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[warrroom_bridge_regional]

@clientname as varchar(max),
@REGION as varchar(255)

as

select ClientName, sum(Revenue) as Revenue from 
(
select ClientName, sum(Act_Rev)*-1 as Revenue,Location_Code from   

(Select project_code,  

case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name = 'Revenue' then sum(Metric_Value) end as Act_Rev,
Location_Code
from financeraw2016  

where YEAR = datename(year,GETDATE()) and 
Metric_Name = 'Revenue'  and
[month] in (left(datename(M,GETDATE()-41),3),left(datename(M,GETDATE()),3), left(datename(M,GETDATE()+30),3),left(datename(M,GETDATE()+60),3))

group by Metric_Category, Metric_Name,Project_Code,Location_Code)a  

Left Join  

(Select * from Client_mapping)b  

on a.Project_Code = b.PRCode 
Where ClientName= @clientname
group by ClientName,Location_Code)Revenue
Left Join
(Select * from Location_Mapping)Location
on Revenue.Location_Code = Location.LOC_Code
where Location.Region = @REGION
group by ClientName

GO
/****** Object:  StoredProcedure [dbo].[WFM_EMPLOYEE_LIST_HEADING]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WFM_EMPLOYEE_LIST_HEADING]
AS
SELECT
CASE WHEN COLUMN_NAME = 'Employee_ID' THEN 'ECN'
WHEN COLUMN_NAME = 'NT_ID' THEN 'NT ID'
WHEN COLUMN_NAME = 'First_Name' THEN 'First Name'
WHEN COLUMN_NAME = 'Middle_Name' THEN 'Middle Name'
WHEN COLUMN_NAME = 'Last_Name' THEN 'Last Name'
WHEN COLUMN_NAME = 'Gender' THEN 'Gender'
WHEN COLUMN_NAME = 'Date_of_Birth' THEN 'DOB'
WHEN COLUMN_NAME = 'Marital_Status' THEN 'Marital Status'
WHEN COLUMN_NAME = 'Anniversary_Date' THEN 'Anniversary Date'
WHEN COLUMN_NAME = 'Address_Country' THEN 'Address Country'
WHEN COLUMN_NAME = 'Address_City' THEN 'City'
WHEN COLUMN_NAME = 'Address_Line_1' THEN 'Address 1'
WHEN COLUMN_NAME = 'Address_Line_2' THEN 'Address 2'
WHEN COLUMN_NAME = 'Address_Landmark' THEN 'Landmark'
WHEN COLUMN_NAME = 'Permanent_Address_City' THEN 'Permanent City'
WHEN COLUMN_NAME = 'Contact_Number' THEN 'Contact Number'
WHEN COLUMN_NAME = 'Alternate_Contact' THEN 'Alternate Contact'
WHEN COLUMN_NAME = 'Email_id' THEN 'Email id'
WHEN COLUMN_NAME = 'Transport_User' THEN 'Transport User'
WHEN COLUMN_NAME = 'Country' THEN 'Country'
WHEN COLUMN_NAME = 'City' THEN 'Current City'
WHEN COLUMN_NAME = 'Site' THEN 'Site'
WHEN COLUMN_NAME = 'Department' THEN 'Department'
WHEN COLUMN_NAME = 'Sub_Department' THEN 'Sub Department'
WHEN COLUMN_NAME = 'Designation' THEN 'Designation'
WHEN COLUMN_NAME = 'Supervisor' THEN 'Supervisor'
WHEN COLUMN_NAME = 'Date_of_Joining' THEN 'DOJ'
WHEN COLUMN_NAME = 'Employee_Role' THEN 'Employee Role'
WHEN COLUMN_NAME = 'Employee_Type' THEN 'Employee Type'
WHEN COLUMN_NAME = 'Employee_Status' THEN 'Employee Status'
WHEN COLUMN_NAME = 'Total_Work_Experience' THEN 'Total Experience (in months)'
WHEN COLUMN_NAME = 'Highest_Qualificatin' THEN 'Highest Qualificatin'
WHEN COLUMN_NAME = 'Skill_Set_1' THEN 'Skill Set 1'
WHEN COLUMN_NAME = 'Skill_Set_2' THEN 'Skill Set 2'
WHEN COLUMN_NAME = 'Skill_Set_3' THEN 'Skill Set 3'
WHEN COLUMN_NAME = 'Updated_by' THEN 'Updated By'
WHEN COLUMN_NAME = 'Update_Date' THEN 'Update Date'
WHEN COLUMN_NAME = 'Supervisor_ECN' THEN 'Supervisor ECN'
END AS COLUMN_NAME
FROM 
(
SELECT COLUMN_NAME FROM CWFM_Umang.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'WFM_Employee_List'
)tbl
GO
/****** Object:  StoredProcedure [dbo].[WR_Business_Rule]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[WR_Business_Rule]

as


select 
zz.Client_Name1,
zz.Region,
zz.[Month],
zz.[Year],
nullif(round(sum(zz.Actual)*-1,0),0) as Actual,
nullif(round(sum(zz.Budget)*-1,0),0) as Budget,
nullif(round(sum(zz.Optimal)*-1,0),0)as Optimal,
nullif(round(sum(zz.Actual)*-1-sum(zz.ActualC),0),0) as GM,
nullif(round((sum(zz.Actual)*-1-sum(zz.ActualC))/nullif(sum(zz.Actual)*-1,0),2),0) as GM_per
from
(Select base.Client_Name1,base.Region,base.[Month],base.[Year],
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name='Revenue' then SUM(value) end AS Actual,
case when Metric_Category = 'USD Budget Load' and Metric_Name='Revenue' then SUM(value) end AS Budget,
case when Metric_Category = 'USD Optimal Load' and Metric_Name='Revenue' then SUM(value) end AS Optimal,
case when Metric_Category = 'USD Actual @ Budget Rate' and Metric_Name='Total Cost Of Services' then SUM(value) end AS ActualC
from
(
Select c.Client_Name1,l.Region,a.Month,a.Year,
--a.Project_Name,a.Location_Code,a.[Location_ Name],
a.Metric_Category,a.Metric_Name,sum(a.Metric_Value) as value from financeraw2016 a 
left join Client_Mapping c
on a.Project_Code = c.PRCode
left join Location_Mapping l
on a.Location_Code = l.LOC_Code
where Metric_Name in ('Revenue','Total Cost Of Services')
and a.Year = datepart(YYYY,GETDATE())
and Client_Name1 is not null
and Metric_Category in ('USD Budget Load','USD Actual @ Budget Rate','USD Optimal Load')
group by  c.Client_Name1,l.Region,a.Month,a.Year,a.Metric_Category,a.Metric_Name
)base
group by base.Client_Name1,base.Region,base.[Month],base.[Year],Metric_Category,Metric_Name
)zz
where zz.Region not in('Global','Corp')
group by zz.Client_Name1,zz.Region,zz.[Month],zz.[Year]
order by Client_Name1,zz.Region


GO
/****** Object:  StoredProcedure [dbo].[WR_Business_Rule_DotNet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WR_Business_Rule_DotNet]

(
	@Level varchar(50),
	@REGION varchar(255),
	@Mon varchar(255),
	@Year Int,
	@Metric Varchar(255),
	@xOperator Varchar(2),
	@xValue Varchar(100),
	@xView Varchar(100)
)
AS
BEGIN

   -- EXEC WR_Business_Rule_DotNet 'NORTH AMERICA','November',2016,'GM_Per','<','50' 

	SET @Mon = left(@Mon,3)
	DECLARE @xSQL AS VARCHAR(MAX)=''
	DECLARE @xSQL1 as Varchar(max)=''  	

	--SELECT upper(@xView)
	SET @xSQL = 'Select * From (
		select 
		zz.PR_CODE,
		zz.[CLIENT_NAME],
		zz.REGION,'	
	if upper(@xView) = upper('Facility-wise')
	Begin
		SET @xSQL = @xSQL + '[LOCATION_NAME],' 
	end
	else
	Begin
		SET @xSQL = @xSQL + '''ALL'' [LOCATION_NAME],' 
	end


	SET @xSQL = @xSQL + ' ROUND(SUM(ISNULL(ZZ.ACTUAL,0)) * -1 ,0) AS [ACTUAL REVENUE],

		ROUND(ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0),0)  AS GM,
		CASE WHEN ISNULL(SUM(ZZ.ACTUAL),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0)) / ISNULL(SUM(ZZ.ACTUAL),0) * -1  * 100,2)  END AS [GM_PER],

		ROUND(SUM(ISNULL(ZZ.OPTIMAL,0)) * -1 ,0) AS [OPTIMAL REVENUE],
		
		ROUND(SUM(ISNULL(ZZ.BUDGET,0)) * -1 ,0) AS [BUDGET REVENUE],
		ROUND(ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0),0)  AS GM_Budget,
		CASE WHEN ISNULL(SUM(ZZ.BUDGET),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0)) / ISNULL(SUM(ZZ.BUDGET),0) * -1  * 100,2)  END AS [GM_PER_Budget],
		(
		ROUND(CASE WHEN ISNULL(SUM(ZZ.ACTUAL),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0)) / ISNULL(SUM(ZZ.ACTUAL),0) * -1  * 100,2)  END -
		CASE WHEN ISNULL(SUM(ZZ.BUDGET),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0)) / ISNULL(SUM(ZZ.BUDGET),0) * -1  * 100,2)  END,2)
		) AS [GM_PER_Variance],
		ROUND((
		CASE WHEN ISNULL(SUM(ZZ.ACTUAL),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0)) / ISNULL(SUM(ZZ.ACTUAL),0) * -1  * 100,2)  END -
		CASE WHEN ISNULL(SUM(ZZ.BUDGET),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0)) / ISNULL(SUM(ZZ.BUDGET),0) * -1  * 100,2)  END
		)
		* ROUND(SUM(ISNULL(ZZ.ACTUAL,0)) * -1 ,0),0) AS [Impact]
		FROM
		(
			SELECT Base.PR_CODE,BASE.CLIENT_NAME,BASE.REGION,BASE.[MONTH],BASE.[YEAR],'
			if upper(@xView) = upper('Facility-wise')
			Begin
				SET @xSQL = @xSQL + '[LOCATION_NAME],' 
			end
			SET @xSQL = @xSQL + '
			CASE WHEN METRIC_CATEGORY = ''USD ACTUAL'' AND METRIC_NAME=''REVENUE'' THEN SUM(VALUE) END AS ACTUAL,
			CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME=''REVENUE'' THEN SUM(VALUE) END AS BUDGET,
			CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME=''REVENUE'' THEN SUM(VALUE) END AS OPTIMAL,
			CASE WHEN METRIC_CATEGORY = ''USD ACTUAL'' AND METRIC_NAME=''TOTAL COST OF SERVICES'' THEN SUM(VALUE) END AS ACTUALC,
			CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME=''TOTAL COST OF SERVICES'' THEN SUM(VALUE) END AS BUDGETCOS
			FROM
			(
				Select Case When ''' + @Level+'''=''Client'' then CLIENT_ID 
				Else Project_Code End [PR_CODE]				
				,Case When ''' + @Level+'''=''Client'' then REPLACE([CLIENT NAME],''TOTAL '','''') 
				Else Project_Name End [CLIENT_NAME]
				,REGION,[MONTH],[YEAR],'

				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + '[LOCATION_NAME],'
				end

				SET @xSQL = @xSQL + '
				METRIC_CATEGORY,METRIC_NAME,SUM(METRIC_VALUE) [VALUE]
				FROM TBLEPM FW 
				
				WHERE METRIC_NAME IN (''REVENUE'',''TOTAL COST OF SERVICES'') AND FW.YEAR = '''+ Convert(varchar,@Year) +''' AND FW.MONTH = ''' + @Mon + '''
				AND REPLACE([CLIENT NAME],''TOTAL '','''') IS NOT NULL
				AND METRIC_CATEGORY IN (''USD BUDGET LOAD'',''USD ACTUAL'',''USD OPTIMAL LOAD'')
				GROUP BY Case When  ''' + @Level+'''=''Client'' then CLIENT_ID 
				Else Project_Code End
				, Case When  ''' + @Level+'''=''Client'' then REPLACE([CLIENT NAME],''TOTAL '','''') 
				Else Project_Name End ,REGION,[MONTH],[YEAR],METRIC_CATEGORY,METRIC_NAME'
				
				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + ',[LOCATION_NAME]'
				end
				SET @xSQL = @xSQL + ' 
				)BASE
				GROUP BY  Base.PR_CODE, BASE.CLIENT_NAME,BASE.REGION,BASE.[MONTH],BASE.[YEAR],METRIC_CATEGORY,METRIC_NAME'
				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + ',[LOCATION_NAME]'
				end
				SET @xSQL = @xSQL + ' 
			)zz
			WHERE ZZ.REGION NOT IN(''GLOBAL'',''CORP'')
			AND [MONTH] = ''' + @Mon + '''
			AND [YEAR] = ''' + CONVERT(VArchar,@Year) + '''
			AND (REGION = ''' + @REGION + ''' or ''ALL'' = ''' + Upper(@REGION) + ''')
			GROUP BY zz.PR_CODE,ZZ.[CLIENT_NAME]'
			if upper(@xView) = upper('Facility-wise')
			Begin
				SET @xSQL = @xSQL + ',[LOCATION_NAME]'
			end
			SET @xSQL = @xSQL + ' 
			,ZZ.REGION,ZZ.[MONTH],ZZ.[YEAR]'

	SET @xSQL = @xSQL + ' 
	) TMP
	WHERE [' + @Metric + '] ' + @xOperator + ' ' + CONVERT(VARCHAR,@xValue) + ' 
	ORDER BY [' + @Metric + '] '
	--[CLIENT_NAME],REGION'
	
	if upper(@xView) = upper('Facility-wise')
	Begin
		SET @xSQL = @xSQL + ',[LOCATION_NAME]' 
	end
		
	--PRINT(@xSQL)

	EXECUTE(@xSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[WR_Business_Rule_DotNet_BU_20170817]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[WR_Business_Rule_DotNet_BU_20170817]

(
	@Level varchar(50),
	@REGION varchar(255),
	@Mon varchar(255),
	@Year Int,
	@Metric Varchar(255),
	@xOperator Varchar(2),
	@xValue Varchar(100),
	@xView Varchar(100)
)
AS
BEGIN

   -- EXEC WR_Business_Rule_DotNet 'NORTH AMERICA','November',2016,'GM_Per','<','50' 

	SET @Mon = left(@Mon,3)
	DECLARE @xSQL AS VARCHAR(MAX)=''
	DECLARE @xSQL1 as Varchar(max)=''  	

	--SELECT upper(@xView)
	SET @xSQL = 'Select * From (
		select 
		zz.PR_CODE,
		zz.[CLIENT_NAME],
		zz.REGION,'	
	if upper(@xView) = upper('Facility-wise')
	Begin
		SET @xSQL = @xSQL + '[LOCATION_NAME],' 
	end
	else
	Begin
		SET @xSQL = @xSQL + '''ALL'' [LOCATION_NAME],' 
	end


	SET @xSQL = @xSQL + ' ROUND(SUM(ISNULL(ZZ.ACTUAL,0)) * -1 ,0) AS [ACTUAL REVENUE],

		ROUND(ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0),0)  AS GM,
		CASE WHEN ISNULL(SUM(ZZ.ACTUAL),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0)) / ISNULL(SUM(ZZ.ACTUAL),0) * -1  * 100,2)  END AS [GM_PER],

		ROUND(SUM(ISNULL(ZZ.OPTIMAL,0)) * -1 ,0) AS [OPTIMAL REVENUE],
		
		ROUND(SUM(ISNULL(ZZ.BUDGET,0)) * -1 ,0) AS [BUDGET REVENUE],
		ROUND(ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0),0)  AS GM_Budget,
		CASE WHEN ISNULL(SUM(ZZ.BUDGET),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0)) / ISNULL(SUM(ZZ.BUDGET),0) * -1  * 100,2)  END AS [GM_PER_Budget],
		(
		ROUND(CASE WHEN ISNULL(SUM(ZZ.ACTUAL),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0)) / ISNULL(SUM(ZZ.ACTUAL),0) * -1  * 100,2)  END -
		CASE WHEN ISNULL(SUM(ZZ.BUDGET),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0)) / ISNULL(SUM(ZZ.BUDGET),0) * -1  * 100,2)  END,2)
		) AS [GM_PER_Variance],
		ROUND((
		CASE WHEN ISNULL(SUM(ZZ.ACTUAL),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.ACTUAL),0) * -1 - ISNULL(SUM(ZZ.ACTUALC),0)) / ISNULL(SUM(ZZ.ACTUAL),0) * -1  * 100,2)  END -
		CASE WHEN ISNULL(SUM(ZZ.BUDGET),0) = 0 THEN 0 ELSE 
		ROUND((ISNULL(SUM(ZZ.BUDGET),0) * -1 - ISNULL(SUM(ZZ.BUDGETCOS),0)) / ISNULL(SUM(ZZ.BUDGET),0) * -1  * 100,2)  END
		)
		* ROUND(SUM(ISNULL(ZZ.ACTUAL,0)) * -1 ,0),0) AS [Impact]
		FROM
		(
			SELECT Base.PR_CODE,BASE.CLIENT_NAME,BASE.REGION,BASE.[MONTH],BASE.[YEAR],'
			if upper(@xView) = upper('Facility-wise')
			Begin
				SET @xSQL = @xSQL + '[LOCATION_NAME],' 
			end
			SET @xSQL = @xSQL + '
			CASE WHEN METRIC_CATEGORY = ''USD ACTUAL'' AND METRIC_NAME=''REVENUE'' THEN SUM(VALUE) END AS ACTUAL,
			CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME=''REVENUE'' THEN SUM(VALUE) END AS BUDGET,
			CASE WHEN METRIC_CATEGORY = ''USD OPTIMAL LOAD'' AND METRIC_NAME=''REVENUE'' THEN SUM(VALUE) END AS OPTIMAL,
			CASE WHEN METRIC_CATEGORY = ''USD ACTUAL'' AND METRIC_NAME=''TOTAL COST OF SERVICES'' THEN SUM(VALUE) END AS ACTUALC,
			CASE WHEN METRIC_CATEGORY = ''USD BUDGET LOAD'' AND METRIC_NAME=''TOTAL COST OF SERVICES'' THEN SUM(VALUE) END AS BUDGETCOS
			FROM
			(
				Select Case When ''' + @Level+'''=''Client'' then Client_Code 
				Else WREMM.PR_Code End [PR_CODE]				
				,Case When ''' + @Level+'''=''Client'' then REPLACE(ESSBASE_CLIENT_NAME,''TOTAL '','''') 
				Else REPLACE(WREMM.PR_Name,''PR '','''') End [CLIENT_NAME]
				,REGION,[MONTH],[YEAR],'

				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + '[LOCATION_NAME],'
				end

				SET @xSQL = @xSQL + '
				METRIC_CATEGORY,METRIC_NAME,SUM(METRIC_VALUE) [VALUE]
				FROM FINANCERAW2016 FW 
				INNER JOIN WAR_ROOM_ESSBASE_MASTER_MAPPING WREMM ON WREMM.PR_CODE = FW.PROJECT_CODE AND WREMM.LOC_CODE=FW.LOCATION_CODE
				WHERE METRIC_NAME IN (''REVENUE'',''TOTAL COST OF SERVICES'') AND FW.YEAR = '''+ Convert(varchar,@Year) +''' AND FW.MONTH = ''' + @Mon + '''
				AND REPLACE(ESSBASE_CLIENT_NAME,''TOTAL '','''') IS NOT NULL
				AND METRIC_CATEGORY IN (''USD BUDGET LOAD'',''USD ACTUAL'',''USD OPTIMAL LOAD'')
				GROUP BY Case When  ''' + @Level+'''=''Client'' then Client_Code 
				Else WREMM.PR_Code End
				, Case When  ''' + @Level+'''=''Client'' then REPLACE(ESSBASE_CLIENT_NAME,''TOTAL '','''') 
				Else REPLACE(WREMM.PR_Name,''PR '','''') End ,REGION,[MONTH],[YEAR],METRIC_CATEGORY,METRIC_NAME'
				
				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + ',[LOCATION_NAME]'
				end
				SET @xSQL = @xSQL + ' 
				)BASE
				GROUP BY  Base.PR_CODE, BASE.CLIENT_NAME,BASE.REGION,BASE.[MONTH],BASE.[YEAR],METRIC_CATEGORY,METRIC_NAME'
				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + ',[LOCATION_NAME]'
				end
				SET @xSQL = @xSQL + ' 
			)zz
			WHERE ZZ.REGION NOT IN(''GLOBAL'',''CORP'')
			AND [MONTH] = ''' + @Mon + '''
			AND [YEAR] = ''' + CONVERT(VArchar,@Year) + '''
			AND (REGION = ''' + @REGION + ''' or ''ALL'' = ''' + Upper(@REGION) + ''')
			GROUP BY zz.PR_CODE,ZZ.[CLIENT_NAME]'
			if upper(@xView) = upper('Facility-wise')
			Begin
				SET @xSQL = @xSQL + ',[LOCATION_NAME]'
			end
			SET @xSQL = @xSQL + ' 
			,ZZ.REGION,ZZ.[MONTH],ZZ.[YEAR]'

	SET @xSQL = @xSQL + ' 
	) TMP
	WHERE [' + @Metric + '] ' + @xOperator + ' ' + CONVERT(VARCHAR,@xValue) + ' 
	ORDER BY [' + @Metric + '] '
	--[CLIENT_NAME],REGION'
	
	if upper(@xView) = upper('Facility-wise')
	Begin
		SET @xSQL = @xSQL + ',[LOCATION_NAME]' 
	end
		
	--PRINT(@xSQL)

	EXECUTE(@xSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[WR_Business_Rule_DotNet_BU_GS]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[WR_Business_Rule_DotNet_BU_GS]

(
	@Region varchar(255),
	@Mon varchar(255),
	@Year Int,
	@Metric Varchar(255),
	@xOperator Varchar(2),
	@xValue Varchar(100),
	@xView Varchar(100)
)
AS
BEGIN

   -- EXEC WR_Business_Rule_DotNet 'NORTH AMERICA','November',2016,'GM_Per','<','50' 

	SET @Mon = left(@Mon,3)
	DECLARE @xSQL AS VARCHAR(MAX)=''
	DECLARE @xSQL1 as Varchar(max)=''  	

	--SELECT upper(@xView)
	SET @xSQL = 'Select * From (
		select 
		zz.[Client Name],
		zz.Region,'	
	if upper(@xView) = upper('Facility-wise')
	Begin
		SET @xSQL = @xSQL + '[Location_ Name],' 
	end
	else
	Begin
		SET @xSQL = @xSQL + '''ALL'' [Location_ Name],' 
	end


	SET @xSQL = @xSQL + ' round(sum(isnull(zz.Actual,0)) * -1 ,0) as Actual,
		round(sum(isnull(zz.Budget,0)) * -1 ,0) as Budget,
		round(sum(isnull(zz.Optimal,0)) * -1 ,0) as Optimal,
		ROUND(ISNULL(sum(zz.Actual),0) * -1 - ISNULL(sum(zz.ActualC),0),0)  as GM,
		case when ISNULL(sum(zz.Actual),0) = 0 then 0 else 
		round((ISNULL(sum(zz.Actual),0) * -1 - ISNULL(sum(zz.ActualC),0)) / ISNULL(sum(zz.Actual),0) * -1  * 100,2)  end AS "GM_Per"
		from
		(
			Select base.Client_Name1 as "Client Name",base.Region,base.[Month],base.[Year],'
			if upper(@xView) = upper('Facility-wise')
			Begin
				SET @xSQL = @xSQL + '[Location_ Name],' 
			end
			SET @xSQL = @xSQL + '
			case when Metric_Category = ''USD Actual'' and Metric_Name=''Revenue'' then SUM(value) end AS Actual,
			case when Metric_Category = ''USD Budget Load'' and Metric_Name=''Revenue'' then SUM(value) end AS Budget,
			case when Metric_Category = ''USD Optimal Load'' and Metric_Name=''Revenue'' then SUM(value) end AS Optimal,
			case when Metric_Category = ''USD Actual'' and Metric_Name=''Total Cost Of Services'' then SUM(value) end AS ActualC
			from
			(
				Select c.Client_Name1,l.Region,a.Month,a.Year,'

				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + '[Location_ Name],'
				end

				SET @xSQL = @xSQL + '
				--a.Project_Name,a.Location_Code,a.[Location_ Name],
				a.Metric_Category,a.Metric_Name,sum(a.Metric_Value) as value from financeraw2016 a 
				left join Client_Mapping c
				on a.Project_Code = c.PRCode
				left join Location_Mapping l
				on a.Location_Code = l.LOC_Code
				where Metric_Name in (''Revenue'',''Total Cost Of Services'')'
				
				--and a.Year = datepart(YYYY,GETDATE())
				SET @xSQL = @xSQL + ' and a.Year = '+ Convert(varchar,@Year) +' and a.Month = ''' + @Mon + '''
				and Client_Name1 is not null
				and Metric_Category in (''USD Budget Load'',''USD Actual'',''USD Optimal Load'')
				group by  c.Client_Name1,l.Region,a.Month,a.Year,a.Metric_Category,a.Metric_Name'
				
				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + ',a.[Location_ Name]'
				end
				SET @xSQL = @xSQL + ' 
				)base
				group by base.Client_Name1,base.Region,base.[Month],base.[Year],Metric_Category,Metric_Name'
				if upper(@xView) = upper('Facility-wise')
				Begin
					SET @xSQL = @xSQL + ',[Location_ Name]'
				end
				SET @xSQL = @xSQL + ' 
			)zz
			where zz.Region not in(''Global'',''Corp'')
			and Month = ''' + @Mon + '''
			and Year = ''' + CONVERT(VArchar,@Year) + '''
			AND (Region = ''' + @Region + ''' or ''ALL'' = ''' + Upper(@Region) + ''')
			group by zz.[Client Name]'
			if upper(@xView) = upper('Facility-wise')
			Begin
				SET @xSQL = @xSQL + ',[Location_ Name]'
			end
			SET @xSQL = @xSQL + ' 
			,zz.Region,zz.[Month],zz.[Year]'

	SET @xSQL = @xSQL + ' 
	) tmp
	WHERE ' + @Metric + ' ' + @xOperator + ' ' + CONVERT(VARCHAR,@xValue) + ' 
	order by [Client Name],Region'
	
	if upper(@xView) = upper('Facility-wise')
	Begin
		SET @xSQL = @xSQL + ',[Location_ Name]' 
	end
		
	PRINT(@xSQL)

	EXECUTE(@xSQL)

END
GO
/****** Object:  StoredProcedure [dbo].[WR_GM_WATERFALL]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WR_GM_WATERFALL]
   @operation nvarchar(50)=NULL,
   @TransID bigint=0,
   @Client_Name varchar(max)=NULL,
   @Metric_Name	varchar(max)=NULL,
   @Revenue	float=0,
   @Gross_Margin float=0,
   @GM_Percentage float=0,
   @Updation_Date datetime=null,
   @Location varchar(max)=NULL,
   @LOB varchar(max)=NULL,
   @Region varchar(max)=NULL,
   @WR_ID varchar(max)=NULL,
   @Metric_Id int=0,
   @UpdatedBy varchar(10)  
AS
BEGIN
	

	If @operation='Insert'
	 Begin
	    Insert Into GM_WATERFALL(Client_Name,WR_ID,Location,LOB,Region,Updation_Date,UpdatedBy,UpdatedOn) 
		Values(@Client_Name,@WR_ID,@Location,@LOB,@Region,@Updation_Date,@UpdatedBy,GETDATE())
	 End

   If @operation='Update'
	 Begin
	   Update GM_WATERFALL Set Metric_Name=@Metric_Name,Revenue=@Revenue,Gross_Margin=@Gross_Margin,
	   GM_Percentage=@GM_Percentage,Metric_Id=@Metric_Id,UpdatedBy=@UpdatedBy,
	   UpdatedOn = GETDATE(),Updation_Date=@Updation_Date
	   WHERE TransID=@TransID
	 End

   If @operation='Load_Target'
	Begin
		--If not exists(Select * From GM_WATERFALL WHERE Client_Name=@Client_Name)
		If not exists(Select * From GM_WATERFALL WHERE WR_ID=@WR_ID)
		begin
			Insert Into GM_WATERFALL(Client_Name,WR_ID,Location,LOB,Region,Updation_Date,Metric_Name,Metric_Id,UpdatedBy,UpdatedOn) 
			Values(@Client_Name,@WR_ID,@Location,@LOB,@Region,@Updation_Date,'Target',22,@UpdatedBy,GETDATE())

			Insert Into GM_WATERFALL(Client_Name,WR_ID,Location,LOB,Region,Updation_Date,Metric_Name,Metric_Id,UpdatedBy,UpdatedOn) 
			Values(@Client_Name,@WR_ID,@Location,@LOB,@Region,@Updation_Date,'Tracking',23,@UpdatedBy,GETDATE())

			Insert Into GM_WATERFALL(Client_Name,WR_ID,Location,LOB,Region,Updation_Date,Metric_Name,Metric_Id,UpdatedBy,UpdatedOn) 
			Values(@Client_Name,@WR_ID,@Location,@LOB,@Region,@Updation_Date,'Others',11,@UpdatedBy,GETDATE())
		end	
	End
END

GO
/****** Object:  StoredProcedure [dbo].[WR_List_For_Glidepath]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WR_List_For_Glidepath]
    @XREGION AS VARCHAR(MAX)=NULL
as

Begin
    if @XREGION IS NULL OR @XREGION='' OR @XREGION='All'
	  Begin
	    Select DISTINCT WR.War_Room_ID
		, WR.Levels
		, WR.Client_Name
		, WR.Region
		, cl.[Location_ Name] as Location
		, WR.War_Room_Status,WR.[Start_Date] 
		, WR.End_Date,WR.LOB_Name
		from War_Room WR Left join CLIENT_LOC CL on WR.Loc_Code = CL.Location_Code
      End 
    Else
	 Begin
	    Select DISTINCT WR.War_Room_ID
		, WR.Levels
		, WR.Client_Name
		, WR.Region
		, cl.[Location_ Name] as Location
		, WR.War_Room_Status,WR.[Start_Date] 
		, WR.End_Date
		, WR.LOB_Name
		from War_Room WR Left join CLIENT_LOC CL on WR.Loc_Code = CL.Location_Code
		Where 1=1 
		AND WR.Region=@XREGION
      End
END
GO
/****** Object:  StoredProcedure [dbo].[WR_Operational_GM]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[WR_Operational_GM]
@xWR_ID Varchar(55)
as

Select Client_Name,Loc_Code,Region,LOB_Name from War_Room Where War_Room_Status ='Active' and War_Room_ID = @xWR_ID
GO
/****** Object:  StoredProcedure [dbo].[WR_SP_Chart_Summary1]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[WR_SP_Chart_Summary1] 

@xRegion varchar(255)=null
as

BEGIN
    
	if isnull(@xRegion,'') = ''
	begin
		set @xRegion = 'ALL'
	end


(

Select fin_Year, sum(Revenue)as Revenue from wr_tbl_Revenue where (Region= @xRegion or @xRegion='ALL') and fin_Year >=2010
group by Fin_year
)
end




GO
/****** Object:  StoredProcedure [dbo].[WR_Waterfall_Input]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WR_Waterfall_Input]

@xWR_ID as int

as

Select ww.batch_ID, WW.Metric_ID,WM.Metric_Name as 'Metric_Name', ww.Warroom_acc_ID,ww.warroom_acc_Name,

max(case when xType = 'Revenue' then xvalue end) as 'Metric_Rev',
max(case when xType = 'Gross Margin' then xvalue end) as 'Metric_GM',
max(case when xType = 'Gross Margin Per' then xvalue end) as 'Metric_GM_Per'

from [tbl_WR_Waterfall] WW
left join 
tbl_WR_Metric WM on WM.Metric_ID = WW.Metric_ID 
where Warroom_acc_ID=@xWR_ID
group by WW.Metric_ID,WM.Metric_Name,  Warroom_acc_ID,warroom_acc_Name,ww.batch_ID






GO
/****** Object:  StoredProcedure [dbo].[x_WARROOM_METRIC_UPLOADER]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[x_WARROOM_METRIC_UPLOADER]-- 'CAPITAL ONE','','North America','' 
    
@CLIENT_NAME as NVARCHAR(500),  
@LOCATION AS NVARCHAR(500)=null,
@Region AS NVARCHAR(500),
@LOB AS NVARCHAR(500) = null

 
AS    

BEGIN
    
	if isnull(@LOB,'') = ''
	begin
		set @LOB = 'ALL'
	end
	
	if isnull(@LOCATION,'') = ''
	begin
		set @LOCATION = 'ALL'
	end

	BEGIN TRY
		
		DECLARE @MonthDate AS VARCHAR(MAX)=''
		DECLARE @MonthDate2 AS VARCHAR(MAX)=''
		DECLARE @xSQL AS VARCHAR(MAX)=''

		--SET @EndDate = GETDATE()
		--SET @EndDate = DATEADD(DAY, 1 - DATEPART(WEEKDAY, @EndDate), CAST(@EndDate AS SMALLDATETIME))
		--SET @StartDate = DATEADD(WEEK,-12,@EndDate)

		IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
		BEGIN
		   DROP TABLE TEMPTABLE2
		END
		
		

		Declare @xDate as Smalldatetime =  GETDATE();

		select     
		 CLIENTNAME,
		 Metric_Category,    
		 convert(smalldatetime,dateme) dateme,    
		 sum(R_Val) as Revenue,sum(GM_VAL) as Gross_Margin,    
		 --round(sum(GM_VAL)/isnull(sum(R_Val),4),0) AS GM_PERCENTAGE,    
		 round(nullif(sum(GM_VAL),0)/nullif(sum(R_Val),0),4)*100 AS GM_PERCENTAGE    
		 --(SUM(R_VAL)-SUM(COS_VALUE))/SUM(R_VAL)*100 AS GM_PERCENTAGE    
		into TEMPTABLE2
		 from     
		 (    
		  Select     
		  REPLACE(REPLACE(c.Client_Name1,'TOTAL ',''),'GRAND TOTAL ','') [CLIENTNAME],    
		  --c.Client_Name1,    
		  l.Country,    
		  l.Sub_Region,    
		  l.Region,    
		  Project_Code,    
		  Project_Name,    
		  Location_Code,    
		  [Location_ Name],    
		  case when Metric_Category = 'USD Actual' then 'Actual Tracker GM%' 
		  When Metric_Category = 'USD Budget Load' then 'Target/Budget GM%'
		  When Metric_Category = 'USD Forecast Load' then 'Forecasted GM%' end as Metric_Category
		  ,    
		  dateme,    
		  R_Val,    
		  COS_VALUE,    
		  GM_Val,    
		  GM_Per    
		  from     
		  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
		  SUM(rev_value) as R_Val,    
		  SUM(cos_value) AS COS_VALUE,    
		  SUM(rev_value)-SUM(cos_value) as GM_Val,    
		  round((SUM(rev_value)-SUM(cos_value))/nullif(SUM(rev_value),0),2)  as GM_Per,    
		  dateme    
		  from     
		  (Select Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,    
		  Case when Metric_Name = 'Revenue' then round((Metric_Value)*-1,0) else 0 end as 'rev_value',    
		  Case when Metric_Name = 'Total Cost of Services' then round((Metric_Value),0) else 0 end as 'cos_value',    
		  '01-'+CONVERT(varchar,[Month])+'-'+CONVERT(varchar,[year]) as dateme    
		  --CONVERT(varchar,[year])+''+convert(varchar,(CONVERT(int,[Month]))) as dateme    
		  from financeraw2016    
		  where Metric_Category in ('USD Actual','USD Forecast Load','USD Budget Load')    
		  and Metric_Name in ('Revenue','Total Cost of Services')    
		  and Year = datepart(YEAR,GETDATE())    
		  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,Metric_Name,[month],[year],Metric_Value    
		  )a    
		  group by Project_Code,Project_Name,Location_Code,[Location_ Name],Metric_Category,dateme,dateme)d    
		  left join client_mapping c    
		  on d.Project_Code = c.PRCode    
		  left join Location_Mapping l    
		  on d.Location_Code = l.LOC_Code    
		  where 1=1    
		    and c.Client_Name1 = @CLIENT_NAME      
			 and (LOC_Name = @LOCATION OR @LOCATION = 'ALL')
			and(l.Region = @Region or @Region ='ALL') 
			and (d.Project_Name = @LOB or @LOB = 'ALL')
		--AND d.Project_Name = @LOB
  and CONVERT(SMALLDATETIME,dateme) in (select xMonths from [xGetMonthsGlidePath](GETDATE()))     
		 --order by Project_Code,[Location_ Name],Metric_Category,dateme    
		 )final_data    
		 --WHERE Metric_Category = 'USD Budget Load'    
		 GROUP BY     
		 CLIENTNAME,Metric_Category,    
		 dateme 
		 order by 3 ASC
		
		
		SELECT @MonthDate = '[' + REPLACE(CONVERT(VARCHAR,TP.[dateme],106),' ','-') + '],' + @MonthDate
		FROM TEMPTABLE2 TP
		GROUP BY REPLACE(CONVERT(VARCHAR,TP.[dateme],106),' ','-'),TP.[dateme]
		ORDER BY CONVERT(SMALLDATETIME,TP.[dateme]) DESC
		

		--select @MonthDate

		IF LEFT(@MonthDate,1) = ','
		BEGIN
			SET @MonthDate = RIGHT(@MonthDate,LEN(@MonthDate) - 1)
		END

		IF RIGHT(@MonthDate,1) = ','
		BEGIN
			SET @MonthDate = LEFT(@MonthDate,LEN(@MonthDate) - 1)
		END

		
		SET @xSQL = 'SELECT * INTO TEMPTABLE
			FROM (
				SELECT [Metric_Category] 
				,[dateme]
				,[GM_PERCENTAGE]
				FROM TEMPTABLE2

			) AS S
			PIVOT
			(
				SUM([GM_PERCENTAGE])
				FOR [dateme] IN ('+ @MonthDate +')
				
			)AS PVT'
		print @xSQL
		EXEC(@xSQL)
		
		IF OBJECT_ID('dbo.TEMPTABLE2', 'U') IS NOT NULL 
		BEGIN
		   DROP TABLE TEMPTABLE2
		END

		SELECT * FROM TEMPTABLE
		DROP TABLE TEMPTABLE
	END TRY
	BEGIN CATCH
		Select 'No record(s) found...'    
END catch
end

GO
/****** Object:  StoredProcedure [dbo].[xTDCViewSave]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[xTDCViewSave]
(
	@xSKILL_NAME as varchar(MAX),
	@xEmpID as INT,
	@xCheckBoxVal as int,
	@ntName as varchar(max)
)
AS
BEGIN
	DECLARE @xSKILLED as int = 0
	DECLARE @xSkill_Set_ID as int = 0

		Select @xSKILLED = ISNULL(Skilled,0)
		FROM TDC_SKILL_MAPPING TSM 
		INNER JOIN DBO.TDC_MATCHED_SKILL_LOB TMSL ON TSM.SKILL_SET_ID = UNIQUE_ID 
		INNER JOIN DBO.TDC_LOB LOB ON LOB.LOB_ID = TMSL.LOB_ID 
		INNER JOIN DBO.TDC_SKILLNAME SN ON SN.SKILL_ID = TMSL.SKILL_ID 
		where LOB.LOB_NAME+'-'+SN.SKILL_NAME = @xSKILL_NAME AND Employee_ID = @xEmpID
		
		Select @xSkill_Set_ID = isnull(Unique_ID,0)
		FROM DBO.TDC_MATCHED_SKILL_LOB TMSL 
		INNER JOIN DBO.TDC_LOB LOB ON LOB.LOB_ID = TMSL.LOB_ID 
		INNER JOIN DBO.TDC_SKILLNAME SN ON SN.SKILL_ID = TMSL.SKILL_ID 
		where LOB.LOB_NAME+'-'+SN.SKILL_NAME = @xSKILL_NAME 
		
		--Select @xSKILLED,@xCheckBoxVal,@xSkill_Set_ID
		
		IF (@xSKILLED <> @xCheckBoxVal )
		BEGIN
			--Select *  FROM TDC_Skill_Mapping WHERE [Employee_ID] = @xEmpID AND  [Skill_Set_ID] = @xSkill_Set_ID
			DELETE FROM TDC_Skill_Mapping WHERE [Employee_ID] = @xEmpID AND  [Skill_Set_ID] = @xSkill_Set_ID
			
			INSERT INTO [TDC_Skill_Mapping]([Employee_ID],[Skill_Set_ID],[Skilled],[Changed_By],[Update_Date]) 
			values ( @xEmpID, @xSkill_Set_ID,@xCheckBoxVal,@ntName, GETDATE())
			
			--Select *  FROM TDC_Skill_Mapping WHERE [Employee_ID] = @xEmpID AND  [Skill_Set_ID] = @xSkill_Set_ID

	END
END
GO
/****** Object:  StoredProcedure [dbo].[xUWork_Done]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[xUWork_Done]
@Project_ID Int
as


Update Pr_Management set Work_Done = 
(select N.workdone from(Select  Project_ID , SUM(Weightage_avg)as workdone from
(
select step_ID, Project_ID, Step, A_Start_Date, A_End_Date ,Start_Date, End_Date, 
DATEDIFF(D,Start_Date,End_Date)as Days,
convert(float,DATEDIFF(D,Start_Date,End_Date))/
convert(float,(Select sum(DATEDIFF(D,Start_Date,End_Date))
from Pr_Steps where Project_ID = @Project_ID)) as Weightage_avg
from Pr_Steps
where Project_ID = @Project_ID
)a
where A_End_Date is not null
group by  Project_ID)N)
where Project_ID = @Project_ID










GO
/****** Object:  StoredProcedure [dbo].[xWFM_Planner_LOB]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[xWFM_Planner_LOB] 
(
	@xNT_ID as varchar(255),
	@xAccount as Varchar(255)= null,
	@xLob as varchar(255)= null,
	@xSite as varchar(255) =null
	
)
AS

BEGIN      
	IF isnull(@xAccount,'') = ''
	BEGIN
		set @xAccount = 'ALL'
	END
	
	IF isnull(@xLob,'') = ''
	BEGIN
		set @xLob = 'ALL'
	END

	IF isnull(@xSite,'') = ''
	BEGIN
		set @xSite = 'ALL'
	END

	Select distinct bt.ASLID, bt.[Region],
	bt.HH as 'Country', 
	bt.Client_Name as 'Account',
	bt.Campaign as 'LOB',
	bt.Facility as 'Site',
	isnull(bdu.xUpload_type,'1st Upload')as [Status]

	--,datediff(D,max(Upload_Date),getdate()) as no_of_daysCurrent_Status
	from bgt_tbl_LOBs bt 
	left join 
	(Select ab.Project_ID, ab.Action_Phase,bus.xUpload_type from (Select aa.Project_ID, max(aa.xOrd) as 'Action_Phase'
		 from 
		(Select distinct Project_ID, upload_type,bus.xOrd from bgt_tbl_Data_upload bdu 
		left join BGT_TBL_Unit bus on bus.Unit_Name = bdu.upload_type) aa
		left join BGT_TBL_Unit bus on bus.xOrd = aa.xOrd
		group by aa.Project_ID) ab left join bgt_upload_sequence bus on bus.xOrderID = ab.Action_Phase
	)bdu
	on bdu.Project_ID = bt.ASLID
	Where bt.Planner_NT_ID = @xNT_ID
	
	and (CLIENT_NAME = @xAccount or @xAccount ='ALL')
	and (bt.Campaign = @xLob OR @xLob = 'ALL')
	and (bt.Facility = @xSite or @xSite = 'ALL')
	group by bt.Region,
	bt.HH, bt.ASLID, bt.Client_Name, bt.Campaign, bt.Facility,bdu.xUpload_type
--,Upload_Date
END





GO
/****** Object:  StoredProcedure [dbo].[yearly_pacman]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[yearly_pacman]
@Emp_ID AS NVARCHAR(250)
as
Select Left(Datename(m,Eval_Date),3)+ ' ' + (Datename(YEAR,Eval_Date))AS [Month],
pm_Rating from master_rating
where E_ECN = @Emp_ID
and Datename(YEAR,Eval_Date) = '2016'
GO
/****** Object:  StoredProcedure [Debug].[sp_errors_login]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [Debug].[sp_errors_login]     
(   
	@ExceptionMsg varchar(100)=null,   
	@ExceptionType varchar(100)=null,   
	@ExceptionSource nvarchar(max)=null,   
	@ExceptionURL varchar(100)=null  ,
	@user_id varchar(20)=null,
    @machine_name varchar(20)=null
)   
AS   
Begin 
  	Insert into [Debug].[errors](ExceptionMsg,ExceptionType,ExceptionSource,ExceptionURL,Logdate,[user_id],machine_name)Values(@ExceptionMsg,@ExceptionType,@ExceptionSource,@ExceptionURL,getdate(),@user_id,@machine_name)    
End
GO
/****** Object:  StoredProcedure [Debug].[sp_filldropdown]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Debug].[sp_filldropdown]
   @operation varchar(20)=NULL,
   @exec_type varchar(250)=null,
   @user_id varchar(20)=null
AS
BEGIN

  If @operation = 'errors_select'
    begin
	  Select * From [Debug].[errors] Where ExceptionType=@exec_type AND [user_id]=@user_id
	end

  
    If @operation = 'select'
    begin
	  Select * From [Debug].[errors]
	end
END

GO
/****** Object:  StoredProcedure [FDT].[Delete_Temp]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [FDT].[Delete_Temp]
(
	@NtName varchar(8)
)
AS
BEGIN
	
	DELETE FROM [dbo].[tblEPM_Temp]
	WHERE [UPLOADEDBY] = @NtName;

END;
GO
/****** Object:  StoredProcedure [FDT].[EPMRaw2EPM]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [FDT].[EPMRaw2EPM]
(
	@NtName varchar(8),
	@RowsDeleted int output,
	@RowsAffected int output
)
AS
BEGIN
	Declare @xCnt int = 0;

	SELECT @xCnt = Count(*)
	FROM TBLEPM_TEMP
	WHERE [UPLOADEDBY] = @NtName;

	if (@xCnt > 0)
	BEGIN
		
		DECLARE @Year INT;
		DECLARE @Month VARCHAR(3);

		Set @RowsDeleted = 0;

		Declare xCursor Cursor for SELECT 
		LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH]
		FROM TBLEPM_TEMP
		WHERE [UPLOADEDBY] = @NtName
		GROUP BY LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))),
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3)
		;

		OPEN xCursor  

		FETCH NEXT FROM xCursor   
		INTO @Year,@Month

		WHILE @@FETCH_STATUS = 0  
		BEGIN
			
			DELETE FROM tblEPM
			WHERE [YEAR] = @Year
			and [Month] = @Month;

			Set @RowsDeleted = @RowsDeleted + @@ROWCOUNT;

			FETCH NEXT FROM xCursor   
		INTO @Year,@Month
		END   
		CLOSE xCursor;  
		DEALLOCATE xCursor;  

		INSERT INTO tblEPM 
				Select 
		REPLACE(LTRIM(RTRIM(LEFT([PROJECT], CHARINDEX('-', [PROJECT])-1))),'_','') [PROJECT_CODE],
		LTRIM(RTRIM(RIGHT([PROJECT], LEN([PROJECT])-CHARINDEX('-', [PROJECT])))) [PROJECT_NAME],
		LTRIM(RTRIM(LEFT([PROFITCTR], CHARINDEX('-', [PROFITCTR])-1))) [LOCATION_CODE],[LOCATION] [LOCATION_NAME],
		REPLACE([CLIENT ID],'_','') [CLIENT_ID],
		LTRIM(RTRIM(REPLACE([CLIENT NAME],'TOTAL',''))) [CLIENT NAME],
		TMP.[COUNTRY],CR.[REGION],
		MC.EssBase [Metric_Category], ISNULL(MN.EssBase,TMP.ACCOUNT) [Metric_Name],
		LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH],
		[DATA] [Metric_Value],@NtName,getdate(),1
		
		FROM TBLEPM_TEMP TMP
		LEFT OUTER JOIN TBLCOUNTRYREGION CR on CR.COUNTRY = TMP.COUNTRY
		LEFT OUTER JOIN TBLMETRIC_CATEGORY MC on MC.EPM1 = TMP.Category and MC.EPM2 = [Currency Type]
		LEFT OUTER JOIN TBLMETRIC_NAME MN on MN.EPM = TMP.ACCOUNT
		WHERE ISNULL([DATA],0) <> 0
		AND [UPLOADEDBY] = @NtName;

		Set @RowsAffected = @@ROWCOUNT;
	END
END
GO
/****** Object:  StoredProcedure [FDT].[EPMTemp2EPMRaw]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [FDT].[EPMTemp2EPMRaw]
(
	@NtName varchar(8),
	@RowsDeleted int output,
	@RowsAffected int output
)
AS
BEGIN
	Declare @xCnt int = 0;

	SELECT @xCnt = Count(*)
	FROM TBLEPM_TEMP
	WHERE [UPLOADEDBY] = @NtName;

	if (@xCnt > 0)
	BEGIN
		
		DECLARE @Year INT;
		DECLARE @Month VARCHAR(3);

		Set @RowsDeleted = 0;

		Declare xCursor Cursor for SELECT 
		LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH]
		FROM TBLEPM_TEMP
		WHERE [UPLOADEDBY] = @NtName
		GROUP BY LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))),
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3)
		;

		OPEN xCursor  

		FETCH NEXT FROM xCursor   
		INTO @Year,@Month

		WHILE @@FETCH_STATUS = 0  
		BEGIN
			
			DELETE FROM tblEPMRaw
			WHERE [YEAR] = @Year
			and [Month] = @Month;

			Set @RowsDeleted = @RowsDeleted + @@ROWCOUNT;

			FETCH NEXT FROM xCursor   
		INTO @Year,@Month
		END   
		CLOSE xCursor;  
		DEALLOCATE xCursor;  

		INSERT INTO tblEPMRaw 
		SELECT LTRIM(RTRIM(LEFT([MONTH], CHARINDEX('.', [MONTH])-1))) [YEAR],
		LEFT(DATENAME(MONTH,CONVERT(DATETIME,[MONTH] + '.01')),3) [MONTH],
		[CATEGORY],[CURRENCY TYPE],REPLACE([CLIENT ID],'_','') [CLIENT_ID],
		LTRIM(RTRIM(REPLACE([CLIENT NAME],'TOTAL',''))) [CLIENT NAME],
		[LOB_NAME],
		LTRIM(RTRIM(LEFT([PROFITCTR], CHARINDEX('-', [PROFITCTR])-1))) [LOCATION_CODE],
		[LOCATION],TMP.[COUNTRY],CR.[REGION],
		REPLACE(LTRIM(RTRIM(LEFT([PROJECT], CHARINDEX('-', [PROJECT])-1))),'_','') [PROJECT_CODE],
		LTRIM(RTRIM(RIGHT([PROJECT], LEN([PROJECT])-CHARINDEX('-', [PROJECT])))) [PROJECT],[PROFITCTR],[ACCOUNT],[DATA]
		FROM TBLEPM_TEMP TMP
		LEFT OUTER JOIN TBLCOUNTRYREGION CR on CR.COUNTRY = TMP.COUNTRY
		WHERE ISNULL([DATA],0) <> 0
		AND [UPLOADEDBY] = @NtName;

		Set @RowsAffected = @@ROWCOUNT;
	END
END
GO
/****** Object:  StoredProcedure [FDT].[sp_DeDuplicator]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paras Parmar (support : paras.parmar@sitel.com, parasparmar@gmail.com)
-- Create date: 18-July-2017 08.21 PM
-- Description:	Provides a fast de-duplicator to data being uploaded to table dbo.financeraw2016
-- Background : The table financeraw2016 is key to correctly projecting Finance data from Essbase  on the Analytics app
--			  : WarRoom. Ashok updates the table several times a week with the Finance Data Uploader that I developed.
--			  : The problem is that this breeds duplicates in the table causing misaligned Financial Projections.
-- Problem Analysis : The duplicates are of 3 types Let's define Primary Key(PK) as the fields [Project_Code],[Metric_Category]
---- ,[Metric_Name],[Year],[Month] from financeraw2016.
---- Case 1 (Freshness). Data being uploaded is fresher than the one in the DB as evidenced by the Entered_On date column.
---- Case 2 (Multiple Instances). Data in the Table has Multiple records with identical PK.
---- Case 3 (Uncertainity). Data being Uploaded has PK that already exist in the DB but have null entries in the Entered_On date column.
-- =============================================
CREATE PROCEDURE [FDT].[sp_DeDuplicator]
	----@rowsInserted bigint output
AS
Begin
	SET NOCOUNT ON;

---Set @rowsInserted =  (Select count(*) from financeraw2016_staging)

--------Freshness, Multiple Instances & Uncertainity--------
		Delete from financeraw2016 where 
		[Project_Code] in (Select Distinct [Project_Code] from financeraw2016_staging)
		and [Metric_Category] in (Select Distinct [Metric_Category] from financeraw2016_staging)
		and [Metric_Name] in (Select Distinct [Metric_Name] from financeraw2016_staging)
		and [Year] in (Select Distinct [Year] from financeraw2016_staging)
		and [Month] in (Select Distinct [Month] from financeraw2016_staging)
--------Freshness, Multiple Instances & Uncertainity--------

Insert into financeraw2016 Select * from financeraw2016_staging

truncate table financeraw2016_staging

---Return @rowsInserted
End
GO
/****** Object:  StoredProcedure [HiringModule].[List_of_Pending_Interviews]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paras Parmar
-- Create date: 16-May-2017 12.54 AM
-- Description:	List of Pending Candidates is part of the hiring Module Project and gets a list of all candidates
-- who have yet to take a single interview.
-- =============================================
CREATE PROCEDURE [HiringModule].[List_of_Pending_Interviews] 
	@From_Date as Date = null,
	@To_Date as Date = null,
	@Round int=0	
AS
BEGIN
	SET NOCOUNT ON;
	IF @From_Date is null
	Begin
	Set	@From_Date=getdate()
	End

	IF @To_Date is null
	Begin
	Set @To_Date = getdate()
	End

	SELECT        A.ID, B.Round, A.First_Name, A.Middle_Name, A.Last_Name
				, A.Source, A.Location, A.Current_Employment, A.CV, A.Entered_Date
				, A.Entered_By, A.Is_Valid,  C.Position, C.Role, C.Location AS For_Location
	FROM        HiringModule.tblCandidate AS A 
	INNER JOIN	HiringModule.tblInterview AS B ON B.Candidate_ID = A.ID 
	INNER JOIN	HiringModule.tblVacancy AS C ON C.ID = B.Vacancy_ID
	WHERE       (1 = 1) 
				AND A.Entered_Date between @From_Date and @To_Date
				AND (B.Round < @Round+1) 
				AND (A.Is_Valid = 1)


END

GO
/****** Object:  StoredProcedure [HiringModule].[SaveImage]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [HiringModule].[SaveImage]
(
	---@Id int OUTPUT,
	@Candidate_ID int,
	@FileName nvarchar(50),
	@Document_Type nvarchar(50),
	@Entered_Date date,
		
	@Data varbinary(MAX)
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

--IF @Id IS NULL OR @Id <= 0
--BEGIN
--	SELECT @Id = ISNULL(MAX([Id]),0) + 1 FROM HiringModule.tblImages
--END

INSERT INTO [HiringModule].[tblImages]
           ([Candidate_ID]
           ,[FileName]
           ,[Document_Type]
           ,[Entered_Date]
           ,[Data]
           ,[Is_Valid])
     VALUES
           (@Candidate_ID
           ,@FileName
           ,@Document_Type
           ,@Entered_Date
           ,@Data
           ,1)

GO
/****** Object:  StoredProcedure [HiringModule].[sp_CandidateDataUpload]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paras Parmar
-- Create date: 14-July-2017 02.12 AM
-- Description:	Inserts or Updates Candidate and Interview data to the correct tables.
-- =============================================
CREATE PROCEDURE [HiringModule].[sp_CandidateDataUpload]
	@Mode as nvarchar(10) = 'update'
	,@First_Name as nvarchar(255) = null
	,@Middle_Name as nvarchar(255) = null
	,@Last_Name as nvarchar(255) = null
	,@Mobile as nvarchar(255) = null
	,@Source as nvarchar(255) = null
	,@Source_Details as nvarchar(255) = null
	,@Location as nvarchar(255) = null
	,@Entered_Date as Datetime = null
	,@Entered_By as nvarchar(255) = null
	,@Is_Valid as bit = true
	,@Round int=0
	
	, @Vacancy_ID as int =null
	, @Interview_Date  as Datetime =null
	, @Interview_Type as nvarchar(255)=null
	, @Interviewer as nvarchar(255)=null
	, @Interviewer_Domain as nvarchar(255)=null
	, @Current_Salary as int=null
	, @Expected_Salary as int=null
	, @Languages as nvarchar(255)=null
	, @Candidate_ID as int =0 output 
	
AS
BEGIN
	SET NOCOUNT ON;
	if  @Entered_Date is null
	Begin
	Select @Entered_Date = Getdate()
	End

	If LOWER(@Mode) = 'update'
	Begin
		UPDATE HiringModule.tblCandidate
		SET [First_Name] = @First_Name,[Middle_Name] = @Middle_Name,[Last_Name] = @Last_Name,[Mobile] = @Mobile
		,[Source] = @Source,[Source_Details] = @Source_Details,[Location] = @Location,[Entered_Date] = @Entered_Date
		WHERE ID=@Candidate_ID;
	---Print 'Update Mode, Candidate : ' + @Candidate_ID	
	END

	if LOWER(@Mode) = 'insert'
	Begin
	INSERT INTO [HiringModule].[tblCandidate]
           ([First_Name],[Middle_Name],[Last_Name],[Mobile],[Source],[Source_Details],[Location]
		   ,[Entered_Date],[Entered_By],[Is_Valid])
     VALUES
           (@First_Name,@Middle_Name,@Last_Name,@Mobile,@Source,@Source_Details,@Location
		   ,@Entered_Date,@Entered_By,@Is_Valid );
		   
		   Select @Candidate_ID = SCOPE_IDENTITY();
--		   Print @Candidate_ID; 

		   INSERT INTO [HiringModule].[tblInterview]
           ([Round],[Candidate_ID],[Vacancy_ID],[Interview_Date],[Interview_Type],[Interviewer],[Interviewer_Domain]
           ,[Current_Salary],[Expected_Salary],[Languages],[Entered_Date],[Entered_By],[Is_Valid])
     VALUES
           (@Round,@Candidate_ID,@Vacancy_ID,@Interview_Date, @Interview_Type, @Interviewer,@Interviewer_Domain
		   ,@Current_Salary,@Expected_Salary, @Languages,@Entered_Date, @Entered_By,@Is_Valid);
	----Print 'Insert Interview Mode, Candidate : ' ;
	RETURN @Candidate_ID;
	End
End
	



GO
/****** Object:  StoredProcedure [IA].[SaveClientInfo]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [IA].[SaveClientInfo] 
	-- Add the parameters for the stored procedure here
	@ClientName nvarchar(50), 
	@ClientLocation nvarchar(50),
	@isIdle tinyint,
	@EnteredOn datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @EnteredOn is null 
	Begin
	Set @EnteredOn = GETDATE();
	end
	
    -- Insert statements for procedure here
	Begin
	INSERT INTO [IA].[ClientInfo]([ClientName],[ClientLocation],[isIdle],[EnteredOn])
     VALUES (@ClientName ,@ClientLocation, @isIdle, @EnteredOn)
	End
END

GO
/****** Object:  StoredProcedure [IA].[sp_CheckUser]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [IA].[sp_CheckUser]
(
	@ntName as varchar(10),
	@xFlag as bit OUTPUT
)
AS
Begin
	SELECT @xFlag = ISNULL(CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END, 0)
	FROM IA.UserEnabled
	WHERE xActive = 1
	AND [NTNAME] = @ntName;
End
GO
/****** Object:  StoredProcedure [IA].[sp_GetInitialLimit]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [IA].[sp_GetInitialLimit]
(@xTime as int OUTPUT)
AS
Begin
	SELECT @xTime = XVAL FROM IA.GETINITIALLIMIT;
End
GO
/****** Object:  StoredProcedure [LA].[GetReport]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [LA].[GetReport]
(
	@MarketID int,
	@SiteID int,
	@AccountID int,
	@LOBID int,
	@ForDate smalldatetime
)
AS
BEGIN
	DECLARE @MstID INT
	DECLARE @ScenarioID INT
	DECLARE @Target FLOAT
	DECLARE @LOWER_LIMIT FLOAT
	DECLARE @UPPER_LIMIT  FLOAT
	DECLARE @ScenarioQry VARCHAR(2000)
	DECLARE @ScenarioFlag VARCHAR(2000)
	DECLARE @xSQL_Start VARCHAR(MAX) = ''
	DECLARE @xSQL_Middle VARCHAR(MAX) = ''
	DECLARE @xSQL_MiddleFlag VARCHAR(MAX) = ''
	DECLARE @xSQL_End VARCHAR(MAX) = ''
	DECLARE @xSQL VARCHAR(MAX) = ''


	IF EXISTS(SELECT * FROM [LA].[tblMaster] WHERE [ACTIVE] = 1
	AND MarketID = @MarketID
	AND SiteID = @SiteID
	AND AccountID = @AccountID
	AND LOBID = @LOBID)
	BEGIN
		
		SELECT @MstID = MstID
		FROM [LA].[tblMaster] WHERE [ACTIVE] = 1
		AND MarketID = @MarketID
		AND SiteID = @SiteID
		AND AccountID = @AccountID
		AND LOBID = @LOBID;

		SET @xSQL_Start = 'SELECT LEFT(CONVERT(VARCHAR,[INTERVAL],108),5) [INTERVAL]';

		DECLARE RuleCursor CURSOR FOR SELECT [ScenarioID],[Target],[Lower_Limit],[Upper_Limit]
		FROM [LA].[TBLRULEMST]	
		WHERE [MSTID] = @MstID
		ORDER BY [ScenarioID];

		OPEN RuleCursor;
		FETCH NEXT FROM RuleCursor INTO @ScenarioID,@Target,@Lower_Limit,@Upper_Limit;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @ScenarioQry = [ScenarioQry],@ScenarioFlag = [ScenarioFlag]
			FROM [LA].[TBLSCENARIOMST]
			WHERE [ACTIVE] = 1
			ORDER BY [ScenarioID];

			IF @Target IS NULL
			BEGIN
				SET @xSQL_Middle = @xSQL_Middle + ',' + @ScenarioQry
				SET @xSQL_MiddleFlag = @xSQL_MiddleFlag + ',' + REPLACE(@ScenarioFlag,'BETWEEN @LOWER_LIMIT AND @UPPER_LIMIT','BETWEEN '+ CONVERT(VARCHAR,@Lower_Limit) + ' AND '+ CONVERT(VARCHAR,@Upper_Limit))
			END

			FETCH NEXT FROM RuleCursor INTO @ScenarioID,@Target,@Lower_Limit,@Upper_Limit;
		END
		CLOSE RuleCursor
		DEALLOCATE RuleCursor

		SET @xSQL_End = ' FROM [LA].[TBLDATA] TD'
		SET @xSQL_End = @xSQL_End + ' WHERE [FORDATE] = '''+ CONVERT(VARCHAR,@ForDate,112) + ''';'

		SET @xSQL = UPPER(@xSQL_Start + @xSQL_Middle + @xSQL_MiddleFlag + @xSQL_End);

		EXECUTE(@xSQL);
	END
END
GO
/****** Object:  StoredProcedure [PM].[Update_dtProjectsTableadapter]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paras Parmar, paras.parmar@sitel.com, parasparmar@gmail.com
-- Create date: 08-June-2017 9.30 PM
-- Description:	This SP acts as an Update for the dtProjectsTableadapter in Project Projects Management.
-- =============================================
CREATE PROCEDURE [PM].[Update_dtProjectsTableadapter]
	
	@Project_Id int,
	@NAME nvarchar(255),
	@DESCRIPTION nvarchar(MAX),
	@OBJECTIVE nvarchar(MAX),
	@TYPE nvarchar(50),
	@SORT_ORDER int,
	@DELIVERABLE_ID int,
	@PLANNED_START_DATE datetime,
	@PLANNED_END_DATE datetime,
	@PLANNED_DAYS int,
	@DELIVERABLE_DESCRIPTION nvarchar(255),
	@DELEGATED_TO nvarchar(50),
	@STATUS  nvarchar(255)
	--,@ENTERED_BY nvarchar(50),
	--@ENTERED_DATE datetime = GETDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE PM.TBLPROJECTS
	SET NAME = @NAME, DESCRIPTION = @DESCRIPTION, OBJECTIVE = @OBJECTIVE, TYPE = @TYPE, SORT_ORDER = @SORT_ORDER	
	WHERE (PROJECT_ID = @PROJECT_ID)
	
	UPDATE PM.TBLMAPPING
	SET DELIVERABLE_ID = @DELIVERABLE_ID
	WHERE (PROJECT_ID = @PROJECT_ID)

	UPDATE PM.TBLDELIVERABLES 
	SET PLANNED_START_DATE = @PLANNED_START_DATE, PLANNED_END_DATE = @PLANNED_END_DATE, PLANNED_DAYS = @PLANNED_DAYS, 
	DESCRIPTION = @DELIVERABLE_DESCRIPTION, DELEGATED_TO = @DELEGATED_TO, STATUS = @STATUS
	WHERE (TASK_ID = @PROJECT_ID)
	
END

GO
/****** Object:  StoredProcedure [TA].[getEmployeeData]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 04-Aug-2017 1.59 AM
-- Description:	This stored procedure gets the specific row of the employee for the Team Anatomy profile page.
-- =============================================
CREATE PROCEDURE [TA].[getEmployeeData] 
	-- Add the parameters for the stored procedure here
	@NT_ID varchar(50)  
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select top 1 * from cwfm_umang..WFM_Employee_List where NT_ID = @NT_ID
END

GO
/****** Object:  StoredProcedure [TA].[updateEmployeeProfileData]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paras Parmar
-- Create date: 05-August-2017 12.35 AM
-- Description:	Updates the entries for an employee in the Team Anatomy Profile page
-- =============================================
CREATE PROCEDURE [TA].[updateEmployeeProfileData] 
		@Employee_ID  int,
		@NT_ID  nvarchar(255),
		@First_Name  nvarchar(255),
		@Middle_Name  nvarchar(255),
		@Last_Name  nvarchar(255),
		@Gender  nvarchar(255),
		@Date_of_Birth  datetime,
		@Marital_Status  nvarchar(255),
		@Anniversary_Date  datetime,
		@Address_Country  nvarchar(255),
		@Address_City  nvarchar(255),
		@Address_Line_1  nvarchar(255),
		@Address_Line_2  nvarchar(255),
		@Address_Landmark  nvarchar(255),
		@Permanent_Address_City  nvarchar(255),
		@Contact_Number  nvarchar(255),
		@Alternate_Contact  nvarchar(255),
		@Email_id  nvarchar(255),
		@Transport_User  nvarchar(255),
		@Country  nvarchar(255),
		@City  nvarchar(255),
		@Site  nvarchar(255),
		@Department  nvarchar(255),
		@Sub_Department  nvarchar(255),
		@Designation  nvarchar(255),
		@Supervisor  nvarchar(255),
		@Date_of_Joining  datetime,
		@Employee_Role  nvarchar(255),
		@Employee_Type  nvarchar(255),
		@Employee_Status  nvarchar(255),
		@Total_Work_Experience  nvarchar(255),
		@Highest_Qualificatin  nvarchar(255),
		@Skill_Set_1  nvarchar(255),
		@Skill_Set_2  nvarchar(255),
		@Skill_Set_3  nvarchar(255),
		@Updated_by  nvarchar(255),
		@Update_Date  datetime,
		@Supervisor_ECN  nvarchar(255),
		@UserImage  nvarchar(500)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
UPDATE [dbo].[WFM_Employee_List]
   SET [Employee_ID] =@Employee_ID
      ,[NT_ID] =@NT_ID
      ,[First_Name] =@First_Name
      ,[Middle_Name] =@Middle_Name
      ,[Last_Name] =@Last_Name
      ,[Gender] =@Gender
      ,[Date_of_Birth] =@Date_of_Birth
      ,[Marital_Status] =@Marital_Status
      ,[Anniversary_Date] =@Anniversary_Date
      ,[Address_Country] =@Address_Country
      ,[Address_City] =@Address_City
      ,[Address_Line_1] =@Address_Line_1
      ,[Address_Line_2] =@Address_Line_2
      ,[Address_Landmark] =@Address_Landmark
      ,[Permanent_Address_City] =@Permanent_Address_City
      ,[Contact_Number] =@Contact_Number
      ,[Alternate_Contact] =@Alternate_Contact
      ,[Email_id] =@Email_id
      ,[Transport_User] =@Transport_User
      ,[Country] =@Country
      ,[City] =@City
      ,[Site] =@Site
      ,[Department] =@Department
      ,[Sub_Department] =@Sub_Department
      ,[Designation] =@Designation
      ,[Supervisor] =@Supervisor
      ,[Date_of_Joining] =@Date_of_Joining
      ,[Employee_Role] =@Employee_Role
      ,[Employee_Type] =@Employee_Type
      ,[Employee_Status] =@Employee_Status
      ,[Total_Work_Experience] =@Total_Work_Experience
      ,[Highest_Qualificatin] =@Highest_Qualificatin
      ,[Skill_Set_1] =@Skill_Set_1
      ,[Skill_Set_2] =@Skill_Set_2
      ,[Skill_Set_3] =@Skill_Set_3
      ,[Updated_by] =@Updated_by
      ,[Update_Date] =@Update_Date
      ,[Supervisor_ECN] =@Supervisor_ECN
      ,[UserImage] =@UserImage
 WHERE [NT_ID] = @NT_ID

END

GO
/****** Object:  StoredProcedure [WFMP].[buildBadges]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [WFMP].[buildBadges] 
	-- Add the parameters for the stored procedure here
	@ECN int 

AS
BEGIN
declare @Name varchar(50), @CancelDate varchar(25), @RpN varchar(max),@RvN varchar(max), @r1 int, @r2 int
    --WFMP.buildBadges 918031
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--set @r1= (select * from wfmp.tbl_leave_request  )
	set @Name = (select FIRST_NAME+' '+ MIDDLE_NAME +' '+ LAST_NAME AS Name from [WFMP].[tblMaster] where [Employee_ID]=@ECN)
	--set @CancelDate =(select CONVERT(VARCHAR, [CancelDate],114) as CancelDate from [WFMP].[tbl_leave_request] where [ecn]=@ECN)
	--set @RpN= ()
	--set @RvN= (select b.FIRST_NAME+' '+ b.MIDDLE_NAME +' '+ b.LAST_NAME AS Name from [WFMP].[tblMaster] b inner join [WFMP].[tbl_leave_request] a on b.[Employee_ID]= a.[Level2_actioned_by])

SELECT 
			CONVERT(VARCHAR,a.from_date,106) as From_Date, CONVERT(VARCHAR,a.to_date,106) as To_Date,a.[leave_reason], 
			CONVERT(VARCHAR,a.applied_on,106)+' '+CONVERT(VARCHAR,a.applied_on,114) as Applied_on,

			CASE WHEN a.[Level1_Action] = 3 THEN 'Cancelled' 
			WHEN a.[Level1_Action] IS NULL THEN 'Pending'
			WHEN a.[Level1_Action] = 0 THEN 'Declined' 
			WHEN a.[Level1_Action] = 1 THEN 'Approved' END as [Level1_Action],
			b.FIRST_NAME+' '+ b.MIDDLE_NAME +' '+ b.LAST_NAME AS Name,
			a.[Level1_actioned_by],a.[Level1_comments],
			CONVERT(VARCHAR,a.Level1_actioned_on,106) as [Level1_actioned_on], --//[cancel_reason]
			CASE WHEN a.[Level2_Action] IS NULL THEN 'Pending' 
			WHEN a.[Level2_Action] = 0 THEN 'Declined' 
			WHEN a.[Level2_Action] = 1 THEN 'Approved' END as [Level2_Action],
			a.[Level2_actioned_by],a.[Level2_comments],
			CONVERT(VARCHAR,a.Level2_actioned_on,106) as [Level2_actioned_on],
			 CONVERT(VARCHAR,a.CancelDate,114) as [CancelDate],

			a.[ID], ISNULL(CASE WHEN a.[CancelDate] > 0 THEN '<span data-toggle="tooltip" title="Cancelled by '+@Name +' on '+CONVERT(VARCHAR,a.CancelDate,120)+'" class="badge bg-red">X</span>' Else '<span class="badge">X</span>' END,'<span class="badge">X</span>') + '  '+
			CASE WHEN a.[Level1_Action] IS NULL THEN '<span class="badge">1</span>' 
			WHEN a.[Level1_Action] = 0 THEN '<span data-toggle="tooltip" title="Declined by '+c.FIRST_NAME+' '+ c.MIDDLE_NAME +' '+ c.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level1_actioned_on,120)+' stating : '+a.[Level1_comments]+'" class="badge bg-red">1</span>' 
			WHEN a.[Level1_Action] = 3 THEN '<span class="badge">1</span>'
			WHEN a.[Level1_Action] = 1 THEN '<span data-toggle="tooltip" title="Approved by '+c.FIRST_NAME+' '+ c.MIDDLE_NAME +' '+ c.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level1_actioned_on,120)+'" class="badge bg-green">1</span>' END
			+ '  '+
			CASE WHEN a.[Level2_Action] IS NULL THEN '<span class="badge">2</span>'  
			WHEN a.[Level2_Action] = 0 THEN '<span data-toggle="tooltip" title="Declined by '+d.FIRST_NAME+' '+ d.MIDDLE_NAME +' '+ d.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level2_actioned_on,120)+' stating : '+a.[Level2_comments]+'" class="badge bg-red">2</span>' 
			WHEN a.[Level2_Action] = 1 THEN  '<span data-toggle="tooltip" title="Approved by '+d.FIRST_NAME+' '+ d.MIDDLE_NAME +' '+ d.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level2_actioned_on,120)+'" class="badge bg-green">2</span>'  END 
			as Status
			FROM [WFMP].[tbl_leave_request] a
			left join WFMP.TBLMASTER AS B
			ON A.[Level1_actioned_by] = B.EMPLOYEE_ID
			left join WFMP.TBLMASTER AS c on A.[Level1_actioned_by] = c.EMPLOYEE_ID
			left join WFMP.TBLMASTER AS d on A.[Level2_actioned_by] = d.EMPLOYEE_ID
			WHERE [ECN] = @ECN
			ORDER BY CONVERT(Datetime,[applied_on]) DESC



END

GO
/****** Object:  StoredProcedure [WFMP].[CE]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WFMP].[CE]
(
	@XEMP AS INT,  
	@FNAME AS VARCHAR(20) = NULL  
)
AS  
DECLARE @XSTR AS VARCHAR(1000)  
IF ISNULL(@FNAME,'') = ''  
BEGIN  
	SELECT * FROM [WFMP].[TBLMASTER] WHERE EMPCODE = @XEMP  
END  
ELSE  
BEGIN  
	SET @XSTR = 'SELECT * FROM [WFMP].[TBLMASTER] WHERE (FNAME+'' ''+MNAME+'' ''+LNAME LIKE ''' + @FNAME + '%'') OR (NTNAME LIKE ''%' + @FNAME + '%'') ORDER BY FNAME,MNAME,LNAME'  
	--PRINT @XSTR
	EXECUTE(@XSTR)  
END
GO
/****** Object:  StoredProcedure [WFMP].[fillModal]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WFMP].[fillModal]
	-- Add the parameters for the stored procedure here
	@LeaveId int, @EmployeeId int, @ApproverId int
AS
BEGIN
--[wfmp].[fillModal] 4,827810,918031
---[WFMP].[fillModal] 55, 774874, 825967
declare @CancelDate datetime, @level1action int, @level2action int

	SET NOCOUNT ON;
				
				set @CancelDate = (select CancelDate from wfmp.tbl_leave_request where id=@LeaveId)

				if(@CancelDate is not null)
					begin
							select 
						--LEAVEID,a.REPMGRCAN,a.revmgrcan,
						case when @ApproverId=a.REPMGRCODE  then a.REPMGRCAN else
						case when @ApproverId IN (SELECT EMPLOYEEID  FROM [WFMP].[TBLMASTERAPPROVER])  then a.revmgrcan end end as can
						--		case when @ApproverId=a.REPMGRCODE  then 'a.REPMGRCAN' else
						--case when @ApproverId IN (SELECT EMPLOYEEID  FROM [WFMP].[TBLMASTERAPPROVER])  then 'a.revmgrcan' end end as can2 
			
							from (
						SELECT
						A.EMPLOYEE_ID, A.REPMGRCODE, B.REPMGRCODE AS REVMGR
						, C.ID AS LEAVEID,  c.CancelDate,d.REPMGRCAN, d.REVMGRCAN


						FROM WFMP.TBLMASTER A
						INNER JOIN WFMP.TBLMASTER B ON B.EMPLOYEE_ID = A.REPMGRCODE
						INNER JOIN [WFMP].[TBL_LEAVE_REQUEST] C ON C.ECN=A.EMPLOYEE_ID
						INNER JOIN [WFMP].[TBLENABLEDISABLE] D ON A.LEVELID BETWEEN D.MINLEVEL AND D.MAXLEVEL 

						where d.RepMgrCan=3 and d.RevMgrCan=3
						)  a
			
						WHERE 
						1=1 and
						A.EMPLOYEE_ID = @EmployeeId and
						LEAVEID=@LeaveId
				end
			else if (@CancelDate is null )
			begin


			select 
			LEAVEID,a.REPMGRCAN,a.revmgrcan,
			case when @ApproverId=a.REPMGRCODE  then a.REPMGRCAN----reporting manager
				when @ApproverId=b.REPMGRCODE  then a.REVMGRCAN 
				--when @ApproverId=b.REPMGRCODE  then a.REVMGRCAN else

				------when AM and above level approval classification is to be made use following commented lines
					---start	(As discussed with chetan on 9/11/2017 removing levelwise approval by commenting out the code)		
				--when a.LevelID <=80 and @ApproverId IN (SELECT EMPLOYEEID  FROM [WFMP].[TBLMASTERAPPROVER])then a.revmgrcan

				----reviewing manager for below AM level
				--when a.LevelID >80 and @ApproverId= b.RepMgrCode then a.RevMgrCan
				---end
			end as can --master approver
			
			
			 from (
			SELECT
			A.EMPLOYEE_ID, A.REPMGRCODE, B.REPMGRCODE AS REVMGR
			, A.LEVELID , C.ID AS LEAVEID,  C.LEVEL1_ACTION, C.LEVEL2_ACTION
			, REPMGRACTION, REVMGRACTION, RESULT,REPMGRCAN, REVMGRCAN


			FROM WFMP.TBLMASTER A
			INNER JOIN WFMP.TBLMASTER B ON B.EMPLOYEE_ID = A.REPMGRCODE
			INNER JOIN [WFMP].[TBL_LEAVE_REQUEST] C ON C.ECN=A.EMPLOYEE_ID
			INNER JOIN [WFMP].[TBLENABLEDISABLE] D ON A.LEVELID BETWEEN D.MINLEVEL AND D.MAXLEVEL 
			AND ISNULL( C.LEVEL1_ACTION,4) = ISNULL( D.REPMGRACTION, 4)
			AND ISNULL( C.Level2_Action,4) = ISNULL( D.RevMgrAction, 4)
			)  a
			INNER JOIN WFMP.TBLMASTER B ON B.EMPLOYEE_ID = A.REPMGRCODE

			
WHERE 
			1=1 and ---Level2_Action = RevMgrAction  AND
			A.EMPLOYEE_ID = @EmployeeId and
			LEAVEID=@LeaveId
			end

END
GO
/****** Object:  StoredProcedure [WFMP].[getDefaultLeaveType]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [WFMP].[getDefaultLeaveType]
as
begin
	select LeaveId, LeaveText 
	from WFMP.tblLeaveType
	where Active=1
	order by 2;
end
GO
/****** Object:  StoredProcedure [WFMP].[GetDeptValues]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [WFMP].[GetDeptValues]
(
	@FunctionID int = null,
	@DepartmentID int = null,	
	@LOBID	 int = null,
	@SkillSetID	 int = null,
	@SubSkillSetID int = null
)
AS
Begin
	
	DECLARE @xSQL varchar(max) = ''
	DECLARE @xSQLStart varchar(max) = ''
	DECLARE @xSQLGrp varchar(max) = ''
	DECLARE @xSQLOrd varchar(max) = ''
	DECLARE @xSQLWhere varchar(max) = ''

	Set @xSQLStart = ' TF.TransID, TF.[Function]'
	Set @xSQLGrp = ' TF.TransID, TF.[Function]'
	Set @xSQLOrd = ' TF.[Function], TF.TransID'

	If @FunctionID is not null
	BEGIN 
		Set @xSQLStart = ' TD.TransID, TD.[Account]'
		Set @xSQLGrp = ' TD.TransID, TD.[Account]'
		Set @xSQLOrd = ' TD.[Account], TD.TransID'
		Set @xSQLWhere = ' AND TDLM.FunctionID = '''+ convert(varchar,@FunctionID) +''''
	END

	If @DepartmentID is not null
	BEGIN 
		Set @xSQLStart = ' LOB.TransID, LOB.[LOB]'
		Set @xSQLGrp = ' LOB.TransID, LOB.[LOB]'
		Set @xSQLOrd = ' LOB.[LOB],LOB.TransID'
		Set @xSQLWhere = ' AND TDLM.FunctionID = '''+ convert(varchar,@FunctionID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.DEPARTMENTID = '''+ convert(varchar,@DepartmentID) +''''
	END

	If @LOBID is not null
	BEGIN 
		Set @xSQLStart = ' SS.TransID, SS.[SkillSet]'
		Set @xSQLGrp = ' SS.TransID, SS.[SkillSet]'
		Set @xSQLOrd = ' SS.[SkillSet],SS.TransID'
		Set @xSQLWhere = ' AND TDLM.FunctionID = '''+ convert(varchar,@FunctionID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.DEPARTMENTID = '''+ convert(varchar,@DepartmentID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.LOBID = '''+ convert(varchar,@LOBID) +''''
	END

	If @SkillSetID is not null
	BEGIN 
		Set @xSQLStart = ' SSS.TransID, SSS.[SubSkillSet]'
		Set @xSQLGrp = ' SSS.TransID, SSS.[SubSkillSet]'
		Set @xSQLOrd = ' SSS.[SubSkillSet],SSS.TransID'
		Set @xSQLWhere = ' AND TDLM.FunctionID = '''+ convert(varchar,@FunctionID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.DEPARTMENTID = '''+ convert(varchar,@DepartmentID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.LOBID = '''+ convert(varchar,@LOBID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.SkillSetID = '''+ convert(varchar,@SkillSetID) +''''
	END

	If @SubSkillSetID is not null
	BEGIN 
		Set @xSQLStart = ' TDLM.TransID'
		Set @xSQLGrp = ' TDLM.TransID'
		Set @xSQLOrd = ' TDLM.TransID'
		Set @xSQLWhere = ' AND TDLM.FunctionID = '''+ convert(varchar,@FunctionID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.DEPARTMENTID = '''+ convert(varchar,@DepartmentID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.LOBID = '''+ convert(varchar,@LOBID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.SkillSetID = '''+ convert(varchar,@SkillSetID) +''''
		Set @xSQLWhere = @xSQLWhere + ' AND TDLM.SubSkillSetID = '''+ convert(varchar,@SubSkillSetID) +''''
	END

	SET @xSQL = 'Select  '+ @xSQLStart + '
	from WFMP.tbldepartmentlinkmst TDLM
	Inner join WFMP.tblFunction TF on TF.TransID = TDLM.FunctionID
	Inner Join WFMP.tblDepartment TD on TD.TransID = TDLM.DepartmentID
	INNER JOIN WFMP.tblLOB LOB on LOB.TransID = TDLM.LOBID
	INNER JOIN WFMP.tblSkillSet SS on SS.TransID = TDLM.SkillSetID
	INNER JOIN WFMP.tblSubSkillSet SSS on SSS.TransID=TDLM.SubSkillSetID
	where 1 = 1 
	and TF.Active = 1 and TDLM.Active = 1 and LOB.Active=1 and SS.Active=1 and SSS.active=1
	'+ @xSQLWhere  +'
	group by '+@xSQLGrp+'
	order by '+@xSQLOrd

	--Print @xSQL
	exec(@xSQL)
End
GO
/****** Object:  StoredProcedure [WFMP].[getEmployeeData]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 04-Aug-2017 1.59 AM
-- Description:	This stored procedure gets the specific row of the employee for the Team Anatomy profile page.
-- Modification date : 23-08-2017 12.51 AM
-- The table cwfm_umang..WFM_Employee_List was broken up into several tables at Gurdeeps request. 2
-- such are WFMP.tblMaster & WFMP.tblProfile which form the basis for this procedure.
-- =============================================
CREATE PROCEDURE [WFMP].[getEmployeeData] 
	-- Add the parameters for the stored procedure here
	@NT_ID varchar(50)  
	---[WFMP].[getEmployeeData] ktriv003
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	----Select top 1 * from cwfm_umang..WFM_Employee_List where NT_ID = @NT_ID
	--select 
	--A.Employee_ID, A.First_Name, A.Middle_Name, A.Last_Name, C.Designation as DesignationID
	--, D.Level as LevelID, A.DOJ, A.DOP, A.DOR, A.DPT, A.DOPS, E.EmpStatus, H.TrngStatus
	--, I.Type as Job_Type, J.Country as CountryID, K.Site as SiteID, L.[Function] as FunctionId, M.LOB as LOBID, F.SkillSet
	--, G.SubSkillSet, A.RepMgrCode, A.TeamID, A.ntName, A.ResType
	--, A.BusinessID, A.Employee_ID, B.Date_of_Birth, B.Gender, A.Email_Office
	--, B.Email_Personal, B.Contact_Number, B.AnniversaryDate, B.HighestQualification
	--, B.Transport, B.Address1, B.Address2, B.Landmark, B.City, B.Total_Work_Experience
	--, B.Skill1, B.Skill2, B.Skill3, B.Alternate_Contact, B.EmergencyContactPerson
	--, B.UserImage, B.Updated_by, B.Update_Date
	--from WFMP.tblMaster A inner join WFMP.tblProfile B on B.Employee_ID = A.Employee_ID
	--left join WFMP.tblDesignation C on C.TransID = A.DesignationID
	--left join WFMP.tblLevel D on D.TransID = A.LevelID
	--left join WFMP.tblEmpStatus E on E.Id = A.EmpStatus
	--left join WFMP.tblSkillSet F on F.TransID = A.SkillSet
	--left join WFMP.tblSubSkillSet G on G.TransID = A.SubSkillSet
	--left join WFMP.tblTrainingStatus H on H.TransID = A.TrngStatus
	--left join WFMP.tblJob_Type I on I.Id = A.Job_Type
	--left join WFMP.tblCountry J on J.TransID = A.CountryID
	--left join WFMP.tblSite K on K.TransID = A.SiteID
	--left join WFMP.tblFunction L on L.TransID = A.FunctionId
	--left join WFMP.tblLOB M on M.TransID = A.LOBID
	--where ntName = @NT_ID

	select
	A.Employee_ID, A.First_Name, A.Middle_Name, A.Last_Name, C.Designation as DesignationID
	, D.Level as LevelID, A.DOJ, A.DOP, A.DOR, A.DPT, A.DOPS, E.EmpStatus, H.TrngStatus
	, I.Type as Job_Type, J.Country as CountryID, K.Site as SiteID, L.[Function] as FunctionId, M.LOB as LOBID, F.SkillSet
	, G.SubSkillSet, A.RepMgrCode, A.TeamID, A.ntName, A.ResType
	, A.BusinessID, A.Employee_ID, B.Date_of_Birth, B.Gender, A.Email_Office
	, B.Email_Personal, B.Contact_Number, B.MaritalStatus, B.AnniversaryDate, B.HighestQualification
	, B.Transport, B.Address1, B.Address2, B.Landmark, B.City, B.Total_Work_Experience
	, B.Skill1, B.Skill2, B.Skill3, B.Alternate_Contact, B.EmergencyContactName, B.EmergencyContactPerson
	, B.UserImage, B.Updated_by, B.Update_Date
	, A.DeptLinkId, N.First_Name +' '+N.Middle_Name+' '+N.Last_Name as RepMgrName
	from WFMP.tblMaster A 
	left join WFMP.tblProfile B on B.Employee_ID = A.Employee_ID
	left join WFMP.tblDesignation C on C.ID = A.DesignationID
	left join WFMP.tblLevel D on D.LevelID = A.LevelID
	left join WFMP.tblEmpStatus E on E.Id = A.EmpStatus
	
	left join WFMP.tblDepartmentLinkMst TDLM on TDLM.[TransID] = A.[DeptLinkId] AND TDLM.Active=1
	Left Join WFMP.tblDepartment TD on TD.[TransID] = TDLM.[DepartmentID] AND TDLM.Active=1
	left join WFMP.tblFunction L on L.TransID = TDLM.[FunctionID] AND TDLM.Active=1
	left join WFMP.tblLOB M on M.TransID = TDLM.[LOBID] AND TDLM.Active=1
	left join WFMP.tblSkillSet F on F.TransID = TDLM.[SkillSetID] AND TDLM.Active=1
	left join WFMP.tblSubSkillSet G on G.TransID = TDLM.[SubSkillSetID] AND TDLM.Active=1
	
	left join WFMP.tblTrainingStatus H on H.TransID = A.TrngStatus
	left join WFMP.tblJob_Type I on I.Id = A.Job_Type
	left join WFMP.tblCountry J on J.TransID = A.CountryID
	left join WFMP.tblSite K on K.TransID = A.SiteID
	left join WFMP.tblMaster N on A.RepMgrCode=N.Employee_ID
	where A.ntName = @NT_ID
END

GO
/****** Object:  StoredProcedure [WFMP].[GetEmployeeLeaveRequestes]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [WFMP].[GetEmployeeLeaveRequestes]
(
	@EmpCode int = 0
)
AS
BEGIN

	--WFMP.GetEmployeeLeaveRequestes 918031
	SELECT
	 A.ECN, B.FIRST_NAME +' '+ B.MIDDLE_NAME+' '+ B.LAST_NAME AS NAME, 

	CONVERT(VARCHAR,from_date,106) as From_Date, CONVERT(VARCHAR,a.to_date,106) as To_Date,a.[leave_reason], 
			CONVERT(VARCHAR,a.applied_on,106)+' '+CONVERT(VARCHAR,a.applied_on,114) as Applied_on,

			CASE WHEN a.[Level1_Action] = 3 THEN 'Cancelled' 
			WHEN a.[Level2_Action] IS NULL THEN 'Pending'
			WHEN a.[Level1_Action] = 0 THEN 'Declined' 
			WHEN a.[Level1_Action] = 1 THEN 'Approved' END as [Level1_Action],
			a.[Level1_actioned_by],a.[Level1_comments],
			CONVERT(VARCHAR,a.Level1_actioned_on,106) as [Level1_actioned_on], --//[cancel_reason]

			CASE WHEN a.[Level2_Action] IS NULL THEN 'Pending' 
			WHEN a.[Level2_Action] = 0 THEN 'Declined' 
			WHEN a.[Level2_Action] = 1 THEN 'Approved' END as [Level2_Action],
			a.[Level2_actioned_by],a.[Level2_comments],
			CONVERT(VARCHAR,a.Level2_actioned_on,106) as [Level2_actioned_on],

			CONVERT(VARCHAR,a.CancelDate,114) as [CancelDate],

			a.[ID], ISNULL(CASE WHEN a.[CancelDate] > 0 THEN '<span data-toggle="tooltip" title="Cancelled by '+B.FIRST_NAME + B.MIDDLE_NAME+ B.LAST_NAME +' on '+CONVERT(VARCHAR,a.CancelDate,120)+'" class="badge bg-red">X</span>' Else '<span class="badge">X</span>' END,'<span class="badge">X</span>') + '  '+
			CASE WHEN a.[Level1_Action] IS NULL THEN '<span class="badge">1</span>' 
			WHEN a.[Level1_Action] = 0 THEN '<span data-toggle="tooltip" title="Declined by '+c.FIRST_NAME+' '+ c.MIDDLE_NAME +' '+ c.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level1_actioned_on,120)+' stating : '+a.[Level1_comments]+'" class="badge bg-red">1</span>' 
			WHEN a.[Level1_Action] = 1 THEN '<span data-toggle="tooltip" title="Approved by '+c.FIRST_NAME+' '+ c.MIDDLE_NAME +' '+ c.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level1_actioned_on,120)+'" class="badge bg-green">1</span>' END
			+ '  '+
			CASE WHEN a.[Level2_Action] IS NULL THEN '<span class="badge">2</span>'  
			WHEN a.[Level2_Action] = 0 THEN '<span data-toggle="tooltip" title="Declined by '+d.FIRST_NAME+' '+ d.MIDDLE_NAME +' '+ d.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level2_actioned_on,120)+' stating : '+a.[Level2_comments]+'" class="badge bg-red">2</span>' 
			WHEN a.[Level2_Action] = 1 THEN  '<span data-toggle="tooltip" title="Approved by '+d.FIRST_NAME+' '+ d.MIDDLE_NAME +' '+ d.LAST_NAME +' on '+CONVERT(VARCHAR,a.Level2_actioned_on,120)+'" class="badge bg-green">2</span>'  END 
			as Status

	--CASE WHEN a.[Level1_action] = 3 THEN a.[CANCEL_REASON] END AS [COMMENTS], 

	FROM [WFMP].[TBL_LEAVE_REQUEST] A
	INNER JOIN WFMP.TBLMASTER B ON B.EMPLOYEE_ID= A.ECN
	left join WFMP.TBLMASTER AS c on A.[Level1_actioned_by] = c.EMPLOYEE_ID
	left join WFMP.TBLMASTER AS d on A.[Level2_actioned_by] = d.EMPLOYEE_ID
	WHERE B.REPMGRCODE = @EmpCode and A.CancelDate is null 
	ORDER BY CONVERT(DATETIME,[APPLIED_ON]) DESC;
END


GO
/****** Object:  StoredProcedure [WFMP].[getMinDateforLeaveRequest]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Komal Trivedi
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [WFMP].[getMinDateforLeaveRequest]
	

AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT DATEADD(D, (select minDate from WFMP.tblMinDateForLeaveApproval), GETDATE()) AS MINDATE FROM WFMP.TBLMINDATEFORLEAVEAPPROVAL

END

GO
/****** Object:  StoredProcedure [WFMP].[GetRepRevMgr]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [WFMP].[GetRepRevMgr]
(
	@EmpCode int = 0
)
AS
Begin
	SELECT DISTINCT A.EMPLOYEE_ID MgrID, A.FIRST_NAME+' '+ A.MIDDLE_NAME +' '+ A.LAST_NAME AS MgrName , 0 xOrd
	FROM WFMP.TBLMASTER AS A 
	INNER JOIN  WFMP.TBLMASTER AS B
	ON A.EMPLOYEE_ID = B.REPMGRCODE
	WHERE A.EMPSTATUS = 1 AND B.EMPSTATUS=1
	AND A.EMPLOYEE_ID = @EmpCode
	UNION 
	SELECT DISTINCT b.EMPLOYEE_ID MgrID, b.FIRST_NAME+' '+ b.MIDDLE_NAME +' '+ b.LAST_NAME AS MgrName , 1 xOrd
	FROM WFMP.TBLMASTER AS A 
	INNER JOIN  WFMP.TBLMASTER AS B
	ON A.EMPLOYEE_ID = B.REPMGRCODE
	where a.Employee_ID=@EmpCode
	ORDER BY 3,2
END


	--SELECT DISTINCT A.EMPLOYEE_ID MgrID, A.FIRST_NAME+' '+ A.MIDDLE_NAME +' '+ A.LAST_NAME AS MgrName , 0 xOrd
	--FROM WFMP.TBLMASTER AS A 
	--INNER JOIN  WFMP.TBLMASTER AS B
	--ON A.EMPLOYEE_ID = B.REPMGRCODE
	--WHERE A.EMPSTATUS = 1 AND B.EMPSTATUS=1
	--AND A.EMPLOYEE_ID = @EmpCode
	--UNION 
	--SELECT DISTINCT A.EMPLOYEE_ID MgrID, A.FIRST_NAME+' '+ A.MIDDLE_NAME +' '+ A.LAST_NAME AS MgrName , 1 xOrd
	--FROM WFMP.TBLMASTER AS A 
	--INNER JOIN  WFMP.TBLMASTER AS B
	--ON A.EMPLOYEE_ID = B.REPMGRCODE
	--WHERE A.EMPSTATUS = 1 AND B.EMPSTATUS=1
	--AND A.REPMGRCODE = @EmpCode
	--ORDER BY 3,2
GO
/****** Object:  StoredProcedure [WFMP].[GetRosterAdmin]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WFMP].[GetRosterAdmin]
(
	@CountryID int,
	@SiteID int,
	@StartDate AS smalldatetime,
	@EndDate AS smalldatetime
)
AS
BEGIN

	DECLARE @Schedule_Date AS VARCHAR(MAX)=''


	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE'))
	BEGIN
		DROP TABLE #TEMPTABLE
	END

	SELECT DISTINCT RDATE Schedule_Date  INTO #TEMPTABLE
	FROM WFMP.ROSTERMST RM
	INNER JOIN [WFMP].[TBLSHIFTCODE] TSC ON TSC.[SHIFTID]=RM.SHIFTID
	INNER JOIN WFMP.TBLMASTER TM ON TM.EMPLOYEE_ID=RM.EMPCODE
	INNER JOIN WFMP.TBLMASTER TM2 ON TM2.EMPLOYEE_ID=TM.REPMGRCODE
	WHERE TM.EMPSTATUS = 1
	AND TM.COUNTRYID = convert(varchar,@CountryID)
	AND (convert(varchar,TM.SITEID) = convert(varchar,@SiteID) or convert(varchar,@SiteID) = 0)
	AND RDATE BETWEEN @StartDate AND @EndDate
	ORDER BY RDATE DESc
      
	SELECT @Schedule_Date = '[' + REPLACE(CONVERT(VARCHAR,TP.Schedule_Date,106),' ','-') + '],' + @Schedule_Date
	FROM #TEMPTABLE TP
            
            
	IF LEFT(@Schedule_Date,1) = ','
	BEGIN
		SET @Schedule_Date = RIGHT(@Schedule_Date,LEN(@Schedule_Date) - 1)
	END

	IF RIGHT(@Schedule_Date,1) = ','
	BEGIN
		SET @Schedule_Date = LEFT(@Schedule_Date,LEN(@Schedule_Date) - 1)
	END
            
            
	--select @Schedule_Date

	declare @xSQL as varchar(max)
	
	IF EXISTS(SELECT [NAME] FROM TEMPDB.DBO.SYSOBJECTS O WHERE O.XTYPE IN ('U') AND O.ID = OBJECT_ID(N'TEMPDB..#TEMPTABLE2'))
	BEGIN
		DROP TABLE #TEMPTABLE2
	END
	
	SET @xSQL = 'select *  from 
	(
		SELECT RM.EMPCODE,REPLACE((DBO.TOPROPERCASE(TM.FIRST_NAME)+'' ''+
		DBO.TOPROPERCASE(TM.MIDDLE_NAME) +'' ''+ 
		DBO.TOPROPERCASE(TM.LAST_NAME)),''  '','' '') AS EMPNAME,

		TM.REPMGRCODE AS REPMGRCODE, REPLACE((DBO.TOPROPERCASE(TM2.FIRST_NAME)+'' ''+
		DBO.TOPROPERCASE(TM2.MIDDLE_NAME) +'' ''+ 
		DBO.TOPROPERCASE(TM2.LAST_NAME)),''  '','' '') AS REPMGRNAME,
		RDATE ,SHIFTCODE
		FROM WFMP.ROSTERMST RM
		INNER JOIN [WFMP].[TBLSHIFTCODE] TSC ON TSC.[SHIFTID]=RM.SHIFTID
		INNER JOIN WFMP.TBLMASTER TM ON TM.EMPLOYEE_ID=RM.EMPCODE
		INNER JOIN WFMP.TBLMASTER TM2 ON TM2.EMPLOYEE_ID=TM.REPMGRCODE
		WHERE TM.EMPSTATUS = 1
		AND TM.COUNTRYID = '''+ convert(varchar,@CountryID) +'''
		AND (convert(varchar,TM.SITEID) = '''+ convert(varchar,@SiteID) +''' or '''+ convert(varchar,@SiteID) +'''= ''0'')
		AND TM.SITEID = 1
		AND RDATE BETWEEN '''+ CONVERT(VARCHAR,@StartDate,112) +''' AND '''+ CONVERT(VARCHAR,@EndDate,112) +'''
	) src
	pivot
	(
		max(SHIFTCODE)
		for RDATE in ('+@Schedule_Date+')
	) piv'

	--print @xSQL
	execute(@xSQL)
	--Select * from WFM_Employee_List where Employee_ID = '923563'
	--select * from #TEMPTABLE2
	--Drop table tblRosterView
END

GO
/****** Object:  StoredProcedure [WFMP].[GetRosterInformation]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 21-Sep-2017 12.04
-- Description:	This stored procedure expects the employee id of a reporting manager and week id
-- while returning the roster for each reportee and sub reportee for a given week.
-- =============================================
CREATE PROCEDURE [WFMP].[GetRosterInformation] 
 @RepMgrCode int = null,
	@WeekID int = null
AS
BEGIN
	SET NOCOUNT ON;
	Declare @WeekNumber as int=0;
	DECLARE @WeekDate AS VARCHAR(MAX)='';
	DECLARE @xSQL AS VARCHAR(MAX)='';
	DECLARE @FrDate AS DATE;
	DECLARE @ToDate AS DATE;

	select @FrDate = FrDate,@ToDate = ToDate
	from [CWFM_Umang].[WFMP].[tblRstWeeks]
	where [WeekId] = @WeekID


	select 
	@WeekDate = '[' + REPLACE(CONVERT(VARCHAR,[xDate],106),' ','-') + '],' + @WeekDate
	from [dbo].[xGetdateBetween]('d',@FrDate, @ToDate) DT
	ORDER BY [xDate] DESC
	
	IF LEFT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = RIGHT(@WeekDate,LEN(@WeekDate) - 1)
	END

	IF RIGHT(@WeekDate,1) = ','
	BEGIN
		SET @WeekDate = LEFT(@WeekDate,LEN(@WeekDate) - 1)
	END

	SET @xSQL = 'SELECT * 
				FROM (
					SELECT A.Employee_ID as EmpID,A.First_Name +'' ''+A.Middle_Name+'' ''+A.Last_Name as EmpName,
					RM.[rDate],RM.[ShiftID]
					
					FROM [CWFM_Umang].[WFMP].[tblMaster] A 
					LEFT OUTER JOIN [CWFM_Umang].[WFMP].[RosterMst] RM on RM.EmpCode = a.Employee_ID
					
					WHERE 1=1 
					and A.RepMgrCode = '+ CONVERT(varchar,@RepMgrCode) + '
					----and isnull(RM.WeekID,'+ CONVERT(varchar,@WeekID) +') = '+ CONVERT(varchar,@WeekID) +'
				) AS S
				PIVOT
				(
					SUM([ShiftID])
					FOR [rDate] IN ('+ @WEEKDATE +')
				)AS PVT ';

	----Print @xSQL;
	exec(@xSQL);
END

----[WFMP].[GetRosterInformation] 931040 , 40

GO
/****** Object:  StoredProcedure [WFMP].[GetWeeks]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 19-Sep-2017 01.19 AM
-- Description:	This stored procedure expects the year  
-- and returns the weeks in that year.
-- =============================================
CREATE PROCEDURE [WFMP].[GetWeeks] 
	-- Add the parameters for the stored procedure here
	@Year int 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @Year>0
	Begin
    -- Insert statements for procedure here
	SELECT [WeekId] as Id,[rYear] as Year 
	,'Week' + Convert(nvarchar,[rWeek]) as Weeks
	, 'WK '+CONVERT(VARCHAR,[rWeek]) + ' --- ' +Convert(nvarchar,[FrDate],106) + ' to ' + Convert(nvarchar,[ToDate],106) as [Dates]
	, FrDate
	, ToDate
	   
	FROM [CWFM_Umang].[WFMP].[tblRstWeeks]
	  where rYear = @Year;
	End
	Else
	Begin
	SELECT [WeekId] as Id,[rYear] as Year
	,'Week' + Convert(nvarchar,[rWeek]) as Weeks
	, 'WK '+CONVERT(VARCHAR,[rWeek]) + ' --- ' +Convert(nvarchar,[FrDate],106) + ' to ' + Convert(nvarchar,[ToDate],106) as [Dates]  
	, FrDate
	, ToDate
	FROM [CWFM_Umang].[WFMP].[tblRstWeeks]
	End
END

GO
/****** Object:  StoredProcedure [WFMP].[InsertLeaveRecords]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [WFMP].[InsertLeaveRecords] 
(
	@EmpCode int,
	@from_date smalldatetime,
	@to_date smalldatetime,
	@leave_reason nVarchar(MAX),
	@xLEAVE_BATCH_ID varchar(max) output
)
AS
BEGIN
	INSERT INTO [WFMP].[TBL_LEAVE_REQUEST] ([ECN],[FROM_DATE],[TO_DATE],[LEAVE_REASON],[APPLIED_ON])
	VALUES (@EMPCODE,@FROM_DATE,@TO_DATE,@LEAVE_REASON,GETDATE());


	Select @xLEAVE_BATCH_ID  = CONVERT(VARCHAR,SCOPE_IDENTITY())

	--Select @xLEAVE_BATCH_ID = [LEAVE_BATCH_ID] 
	--FROM [WFMP].[TBL_LEAVE_REQUEST]
	--WHERE [ID] = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [WFMP].[Profile_SaveUserImage]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 27-Oct-2017 07.21 PM
-- Description:	This stored procedure updates the User Profile Image the logged in employee for the Team Anatomy profile page.
-- =============================================
CREATE PROCEDURE [WFMP].[Profile_SaveUserImage] 
	
	@UserImage nvarchar(500),
	@Updated_by nvarchar(50),
	@Employee_ID int
AS
BEGIN
	SET NOCOUNT ON;
	if Exists (Select * from [WFMP].[tblProfile] WHERE [Employee_ID] = @Employee_ID)
		BEGIN	    
			UPDATE [WFMP].[tblProfile]
			SET [UserImage] = @UserImage, [Updated_by] = @Updated_by,[Update_Date] = GETDATE()
			WHERE [Employee_ID] = @Employee_ID;
		END
	ELSE
		BEGIN
			INSERT INTO [WFMP].[tblProfile]([Employee_ID],[UserImage],[Updated_by],[Update_Date])
			VALUES(@Employee_ID, @UserImage ,@Updated_by ,GETDATE())
		END	
END

GO
/****** Object:  StoredProcedure [WFMP].[Roster_GetAdminFormatRoster]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 04-nov-2017 02.21 AM
-- Description:	This stored procedure gets the rosters for Project Team Anatomy as per the Admin's Format.
-- 
-- =============================================
Create PROCEDURE [WFMP].[Roster_GetAdminFormatRoster] 
	-- Add the parameters for the stored procedure here
	@FromDate Date,
	@ToDate Date  
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select A.Employee_ID as ECN, REPLACE((dbo.ToPropercase(A.First_Name)+' '+
	dbo.ToPropercase(A.Middle_Name) +' '+ 
	dbo.ToPropercase(A.Last_Name)),'  ',' ') AS NAME
	, A.RepMgrCode as TL_ECN, REPLACE((dbo.ToPropercase(B.First_Name)+' '+
	dbo.ToPropercase(B.Middle_Name) +' '+ 
	dbo.ToPropercase(B.Last_Name)),'  ',' ') AS TEAM_LEADER
	,N.rDate as ShiftDate, N.ShiftID, P.ShiftCode 
	, J.Country as CountryID
	, K.Site as SiteID	
	, M.LOB as LOBID
	, A.TeamID, A.ResType
	from WFMP.tblMaster A 
	left join WFMP.tblMaster B on B.Employee_ID = A.RepMgrCode
	left join WFMP.tblLevel D on D.LevelID = A.LevelID
	left join WFMP.tblEmpStatus E on E.Id = A.EmpStatus	
	left join WFMP.tblDepartmentLinkMst TDLM on TDLM.TransID = A.DeptLinkId AND TDLM.Active=1
	Left Join WFMP.tblDepartment TD on TD.TransID = TDLM.DepartmentID AND TDLM.Active=1
	left join WFMP.tblFunction L on L.TransID = TDLM.FunctionID AND TDLM.Active=1
	left join WFMP.tblLOB M on M.TransID = TDLM.LOBID AND TDLM.Active=1
	left join WFMP.tblSkillSet F on F.TransID = TDLM.SkillSetID AND TDLM.Active=1
	left join WFMP.tblSubSkillSet G on G.TransID = TDLM.SubSkillSetID AND TDLM.Active=1	
	left join WFMP.tblTrainingStatus H on H.TransID = A.TrngStatus
	left join WFMP.tblJob_Type I on I.Id = A.Job_Type
	left join WFMP.tblCountry J on J.TransID = A.CountryID
	left join WFMP.tblSite K on K.TransID = A.SiteID
	inner join WFMP.RosterMst N on N.EmpCode = A.Employee_ID
	inner join WFMP.tblShiftCode P on P.ShiftID = N.ShiftID
	where
	N.rDate between @FromDate and @ToDate
	----N.rDate between '20171010' and '20171012'-- @FromDate and @ToDate
END

GO
/****** Object:  StoredProcedure [WFMP].[Roster_GetEmployeeSpecificRoster]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com; parasparmar@gmail.com
-- Create date: 08-Nov-2017 02.21 AM
-- Description:	This stored procedure gets the rosters for Project Team Anatomy for a given employee.
-- 
-- =============================================
CREATE PROCEDURE [WFMP].[Roster_GetEmployeeSpecificRoster]
	-- Add the parameters for the stored procedure here
	@EmpID int,
	@FromDate Date,
	@ToDate Date  
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select distinct A.Employee_ID as ECN, REPLACE((dbo.ToPropercase(A.First_Name)+' '+
	dbo.ToPropercase(A.Middle_Name) +' '+ 
	dbo.ToPropercase(A.Last_Name)),'  ',' ') AS NAME
	, A.RepMgrCode as TL_ECN, REPLACE((dbo.ToPropercase(B.First_Name)+' '+
	dbo.ToPropercase(B.Middle_Name) +' '+ 
	dbo.ToPropercase(B.Last_Name)),'  ',' ') AS TEAM_LEADER
	,N.rDate as ShiftDate, N.ShiftID, P.ShiftCode 
	, J.Country as CountryID
	, K.Site as SiteID	
	, M.LOB as LOBID
	, A.TeamID, A.ResType
	, case when A.Employee_ID = @EmpID then 1 else A.Employee_ID end as CustomSort
	from WFMP.tblMaster A 
	left join WFMP.tblMaster B on B.Employee_ID = A.RepMgrCode
	left join WFMP.tblLevel D on D.LevelID = A.LevelID
	left join WFMP.tblEmpStatus E on E.Id = A.EmpStatus	
	left join WFMP.tblDepartmentLinkMst TDLM on TDLM.TransID = A.DeptLinkId AND TDLM.Active=1
	Left Join WFMP.tblDepartment TD on TD.TransID = TDLM.DepartmentID AND TDLM.Active=1
	left join WFMP.tblFunction L on L.TransID = TDLM.FunctionID AND TDLM.Active=1
	left join WFMP.tblLOB M on M.TransID = TDLM.LOBID AND TDLM.Active=1
	left join WFMP.tblSkillSet F on F.TransID = TDLM.SkillSetID AND TDLM.Active=1
	left join WFMP.tblSubSkillSet G on G.TransID = TDLM.SubSkillSetID AND TDLM.Active=1	
	left join WFMP.tblTrainingStatus H on H.TransID = A.TrngStatus
	left join WFMP.tblJob_Type I on I.Id = A.Job_Type
	left join WFMP.tblCountry J on J.TransID = A.CountryID
	left join WFMP.tblSite K on K.TransID = A.SiteID
	
	inner join WFMP.tblMaster Q on Q.RepMgrCode = A.RepMgrCode
	inner join WFMP.RosterMst N on N.EmpCode = A.Employee_ID
	inner join WFMP.tblShiftCode P on P.ShiftID = N.ShiftID

	where
	A.Employee_ID = @EmpID
	and N.rDate between @FromDate and @ToDate
	----N.rDate between '20171010' and '20171012'-- @FromDate and @ToDate
	order by  case when A.Employee_ID = @EmpID then 1 else A.Employee_ID end, N.rDate
END

GO
/****** Object:  StoredProcedure [WFMP].[Roster_loadCancelledLeaves]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 06-Oct-2017 08.21 PM
-- Description:	This stored procedure expects the employee id of a reporting manager and week id
-- while returning the cancelled leaves for each reportee in the given week id.
-- Parameters : @status : Status of the leaves, Null is pending, 0 is declined, 1 is approved
-- 2 is not provisioned yet, 3 is self-cancelled.
-- =============================================
CREATE PROCEDURE [WFMP].[Roster_loadCancelledLeaves]
	-- Add the parameters for the stored procedure here
	@RepMgrCode int, 
	@WeekId int
	
AS
BEGIN
	SET NOCOUNT ON;
		SELECT 
			A.ECN
			,D.WEEKID
			,E.LeaveDate
			,D.RWEEK as WeekNum
			,A.id as LeaveBatchID
			,B.REPMGRCODE
			,F.ShiftCode as LeaveShiftCode
			,F.LeaveText as LeaveType
			FROM [CWFM_UMANG].[WFMP].[TBL_LEAVE_REQUEST] A
			INNER JOIN [WFMP].[TBLMASTER] B ON B.EMPLOYEE_ID = A.ECN
			INNER JOIN [WFMP].[TBL_DATEWISE_LEAVE] C  ON A.ID = C.LEAVE_BATCH_ID
			INNER JOIN [CWFM_UMANG].[WFMP].[TBLRSTWEEKS] D
			ON A.FROM_DATE BETWEEN D.FRDATE AND D.TODATE OR A.TO_DATE BETWEEN D.FRDATE AND D.TODATE
			INNER JOIN [CWFM_UMANG].[WFMP].[TBL_DATEWISE_LEAVE] E ON E.LEAVE_BATCH_ID = A.ID
			Inner Join [CWFM_Umang].[WFMP].[tblLeaveType] F on F.LeaveID = E.leave_type 
			where  
				1=1 			
				AND A.CancelDate is not null 
				AND B.REPMGRCODE = @RepMgrCode 
				AND D.WEEKID = @WeekId
				And E.LeaveDate between D.FrDate and D.ToDate 
			group by 
				A.ECN
				,D.WEEKID
				,E.LeaveDate
				,D.RWEEK 
				,A.id 
				,B.REPMGRCODE
				,F.ShiftCode
				,F.LeaveText
			order by 
				A.ecn, E.LeaveDate
END

GO
/****** Object:  StoredProcedure [WFMP].[Roster_loadLeaves]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 04-Oct-2017 08.21 PM
-- Description:	This stored procedure expects the employee id of a reporting manager and week id
-- while returning the approved leaves for each reportee in the given week id.
-- Parameters : @status : Status of the leaves, Null is pending, 0 is declined, 1 is approved
-- 2 is not provisioned yet, 3 is self-cancelled.
-- =============================================
CREATE PROCEDURE [WFMP].[Roster_loadLeaves]
	-- Add the parameters for the stored procedure here
	@RepMgrCode int, 
	@WeekId int
	
AS
BEGIN
	SET NOCOUNT ON;
		SELECT 
			A.ECN
			,D.WEEKID
			,E.LeaveDate
			,D.RWEEK as WeekNum
			,A.id as LeaveBatchID
			,B.REPMGRCODE
			,F.ShiftCode as LeaveShiftCode
			,F.LeaveText as LeaveType
			FROM [CWFM_UMANG].[WFMP].[TBL_LEAVE_REQUEST] A
			INNER JOIN [WFMP].[TBLMASTER] B ON B.EMPLOYEE_ID = A.ECN
			INNER JOIN [WFMP].[TBL_DATEWISE_LEAVE] C  ON A.ID = C.LEAVE_BATCH_ID
			INNER JOIN [CWFM_UMANG].[WFMP].[TBLRSTWEEKS] D
			ON A.FROM_DATE BETWEEN D.FRDATE AND D.TODATE OR A.TO_DATE BETWEEN D.FRDATE AND D.TODATE
			INNER JOIN [CWFM_UMANG].[WFMP].[TBL_DATEWISE_LEAVE] E ON E.LEAVE_BATCH_ID = A.ID
			Inner Join [CWFM_Umang].[WFMP].[tblLeaveType] F on F.LeaveID = E.leave_type 
			where  
				1=1 			
				AND A.LEVEL2_ACTION = 1
				AND A.CancelDate is null 
				AND B.REPMGRCODE = @RepMgrCode 
				AND D.WEEKID = @WeekId
				And E.LeaveDate between D.FrDate and D.ToDate 
			group by 
				A.ECN
				,D.WEEKID
				,E.LeaveDate
				,D.RWEEK 
				,A.id 
				,B.REPMGRCODE
				,F.ShiftCode
				,F.LeaveText
			order by 
				A.ecn, E.LeaveDate
END

GO
/****** Object:  StoredProcedure [WFMP].[TeamList]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [WFMP].[TeamList]  
(
	@RepMgrCode as int
)
  ---[WFMP].[TeamList] 923563
as  
  
Begin  
	select Distinct
	A.Employee_ID,
	dbo.ToPropercase([First_Name])+' '+
	dbo.ToPropercase([Middle_Name]) +' '+ 
	dbo.ToPropercase([Last_Name]) AS [Name], D.Contact_Number, 
	Lower([Email_Office]) AS EMAIL_ID,
	C.Type as MovementType,
	B.State as MovementState
	from [WFMP].[tblMaster] A
	left join [CWFM_Umang].[WFMP].[tbltrans_Movement] B on B.EmpId = A.Employee_ID
	left join [CWFM_Umang].[WFMP].tblMovementTypes C on C.Id = B.Type
	left join [WFMP].[tblProfile] D on A.Employee_ID = D.Employee_ID
	
	where A.[RepMgrCode] = @RepMgrCode and [EmpStatus] = 1
	order by dbo.ToPropercase([First_Name])+' '+
	dbo.ToPropercase([Middle_Name]) +' '+ 
	dbo.ToPropercase([Last_Name]) ASC
End 
  
  
  
  
  
  
  
GO
/****** Object:  StoredProcedure [WFMP].[Transfer_ActionsList]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 15-Nov-2017 2.52 AM
-- Description:	This stored procedure is used by the Transfers Action Page of Project Team Anatomy.
-- 
-- The table cwfm_umang..WFM_Employee_List was broken up into several tables at Gurdeeps request. 2
-- such are WFMP.tblMaster & WFMP.tblProfile which form the basis for this procedure.
-- =============================================
CREATE PROCEDURE [WFMP].[Transfer_ActionsList] 
	@RepMgrCode as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT A.[Id]
      ,A.[FromDptLinkMstId]
      ,A.[ToDptLinkMstId]
      ,A.[FromMgr], B.[First_Name]+' '+B.[Middle_Name]+' '+B.[Last_Name] As FromMgrName	  
      ,A.[ToMgr], C.[First_Name]+' '+C.[Middle_Name]+' '+C.[Last_Name] As ToMgrName	 
      ,A.[EmpId], D.[First_Name]+' '+D.[Middle_Name]+' '+D.[Last_Name] As EmpName
      ,A.[Type], E.[Type] as MovementType
      ,A.[State], F.State as MovementProgress
      ,A.[InitBy], G.[First_Name]+' '+G.[Middle_Name]+' '+G.[Last_Name] As InitiatedBy
	  ,A.[InitOn]
      ,A.[EffectiveDate]
      ,A.[UpdaterID], H.[First_Name]+' '+H.[Middle_Name]+' '+H.[Last_Name] As UpdatedBy
      ,A.[UpdatedOn]
	  ,Case When A.State=0 and A.Type=2 then A.FromMgr 
	  When A.State = 0 and A.Type = 1 then A.ToMgr
	  end as PendingAt
	  ,I.[First_Name]+' '+I.[Middle_Name]+' '+I.[Last_Name] as PendingBy
  FROM [WFMP].[tbltrans_Movement] A
  left join [WFMP].[tblMaster] B on B.Employee_ID = A.FromMgr
  left join [WFMP].[tblMaster] C on C.Employee_ID = A.ToMgr
  left join [WFMP].[tblMaster] D on D.Employee_ID = A.EmpId
  left join [WFMP].[tblMovementTypes] E on E.Id = A.Type
  left join [WFMP].[tblMovementState] F on F.Id = A.State
  left join [WFMP].[tblMaster] G on G.Employee_ID = A.InitBy
  left join [WFMP].[tblMaster] H on H.Employee_ID = A.UpdaterID
  -- Pending At Field- Get the Pending Manager ID and the Name below
  left join [WFMP].[tblMaster] I on I.Employee_ID = Case When A.State=0 and A.Type=2 then A.FromMgr 
	  When A.State = 0 and A.Type = 1 then A.ToMgr end
  where A.[FromMgr] = @RepMgrCode or A.ToMgr = @RepMgrCode
  order by A.Id desc
END

GO
/****** Object:  StoredProcedure [WFMP].[Transfer_ApproveAndCommitToMaster]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 18-Nov-2017 12.57 AM
-- Description:	This stored procedure is used by the Transfers Action Page of Project Team Anatomy.
-- 1. Upon receiving the required parameters, it approves/declines the transfer of an employee in the [WFMP].[tbltrans_Movement]
--	  table.
-- 2. It checks if the effective date of the transfer is less than or equal to today 23:59:59:99 and changes the [WFMP].[tblMaster].
-- 3. Before it changes [WFMP].[tblMaster], it copies the old record into [WFMP].[tblMaster_Log] 
--    adding the date and time it was actioned along with the MovementID that links it back with the [WFMP].[tbltrans_Movement].
-- =============================================
CREATE PROCEDURE [WFMP].[Transfer_ApproveAndCommitToMaster] 
	@MovementId as int,
	@State INT,
	@UpdaterID INT,
	@EffectiveDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		BEGIN TRANSACTION;

			UPDATE [CWFM_Umang].[WFMP].[tbltrans_Movement] 
			SET [State] = @State, [UpdaterID] = @UpdaterID, [UpdatedOn] = GETDATE(), [EffectiveDate] = @EffectiveDate
			WHERE [Id]=@MovementId
 
		 --- Step 1: Push the current movement related data from [CWFM_Umang].wfmp.tblMaster into it's log table.
			IF @State = 2
			BEGIN
				Declare @Direction int
				DECLARE @NewRepMgr INT
				DECLARE @EmpCode INT

				Select @Direction = [Type],@EmpCode = [EmpId],
				@NewRepMgr  = case when [Type] = 1 then A.FromMgr 
				when [Type] = 2 then A.ToMgr
				END
				from [CWFM_Umang].[WFMP].[tbltrans_Movement] A where [Id] = @MovementId;
	
				If @Direction in (1,2)
				BEGIN
					--select * from [WFMP].tblMaster where Employee_Id = @EmpCode;
					
					IF CONVERT(DATETIME,CONVERT(VARCHAR,@EffectiveDate,112)) <= CONVERT(DATETIME,CONVERT(VARCHAR,GETDATE(),112)) 
					BEGIN
						Insert into [WFMP].[tblMaster_Log]
						Select A.*, getdate(), @MovementId from [CWFM_Umang].wfmp.tblMaster A
						inner join [CWFM_Umang].[WFMP].[tbltrans_Movement] B on B.EmpId = A.Employee_ID
						and B.Id = @MovementId

						Update WFMP.tblMaster
						set RepMgrCode = @NewRepMgr 
						where Employee_Id = @EmpCode;
					END

					Update [CWFM_Umang].[WFMP].[tbltrans_Movement] set [State] = 3
					WHERE [Id] = @MovementId;

					--select * from [WFMP].tblMaster where Employee_Id = @EmpCode;
					--select * from [WFMP].[tblMaster_Log] where Employee_Id = @EmpCode;
				END
			END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION;
		END
	END CATCH
END

GO
/****** Object:  StoredProcedure [WFMP].[Transfer_getTransfereeUsingMovementID]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		paras.parmar@sitel.com
-- Create date: 15-Nov-2017 2.52 AM
-- Description:	This stored procedure is used by the Transfers Action Page of Project Team Anatomy.
-- 
-- The table cwfm_umang..WFM_Employee_List was broken up into several tables at Gurdeeps request. 2
-- such are WFMP.tblMaster & WFMP.tblProfile which form the basis for this procedure.
-- =============================================
Create PROCEDURE [WFMP].[Transfer_getTransfereeUsingMovementID] 
	@ID as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT A.[Id]
      ,A.[FromDptLinkMstId]
      ,A.[ToDptLinkMstId]
      ,A.[FromMgr], B.[First_Name]+' '+B.[Middle_Name]+' '+B.[Last_Name] As FromMgrName	  
      ,A.[ToMgr], C.[First_Name]+' '+C.[Middle_Name]+' '+C.[Last_Name] As ToMgrName	 
      ,A.[EmpId], D.[First_Name]+' '+D.[Middle_Name]+' '+D.[Last_Name] As EmpName
      ,A.[Type], E.[Type] as MovementType
      ,A.[State], F.State as MovementProgress
      ,A.[InitBy], G.[First_Name]+' '+G.[Middle_Name]+' '+G.[Last_Name] As InitiatedBy
	  ,A.[InitOn]
      ,A.[EffectiveDate]
      ,A.[UpdaterID], H.[First_Name]+' '+H.[Middle_Name]+' '+H.[Last_Name] As UpdatedBy
      ,A.[UpdatedOn]
	  ,Case When A.State=0 and A.Type=2 then A.FromMgr 
	  When A.State = 0 and A.Type = 1 then A.ToMgr
	  end as PendingAt
  FROM [WFMP].[tbltrans_Movement] A
  left join [WFMP].[tblMaster] B on B.Employee_ID = A.FromMgr
  left join [WFMP].[tblMaster] C on C.Employee_ID = A.ToMgr
  left join [WFMP].[tblMaster] D on D.Employee_ID = A.EmpId
  left join [WFMP].[tblMovementTypes] E on E.Id = A.Type
  left join [WFMP].[tblMovementState] F on F.Id = A.State
  left join [WFMP].[tblMaster] G on G.Employee_ID = A.InitBy
  left join [WFMP].[tblMaster] H on H.Employee_ID = A.UpdaterID
  where A.[Id] = @ID
  order by A.Id desc
END

GO
/****** Object:  StoredProcedure [WFMP].[Transfer_TeamList]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [WFMP].[Transfer_TeamList]  
(
	@RepMgrCode as int
)
  
as  
  
Begin  
	if @RepMgrCode = 0
	Begin
		Select
		A.Employee_ID,
		dbo.ToPropercase(A.[First_Name])+' '+
		dbo.ToPropercase(A.[Middle_Name]) +' '+ 
		dbo.ToPropercase(A.[Last_Name]) AS [Name], 
		Lower(A.[Email_Office]) AS EMAIL_ID,
		case when b.State=0 THEN 'Pending with '+ dbo.ToPropercase(C.[First_Name])+' '+	dbo.ToPropercase(C.[Middle_Name]) +' '+ dbo.ToPropercase(C.[Last_Name]) else '' END as State
		from [WFMP].[tblMaster] A
		left join [CWFM_Umang].[WFMP].[tbltrans_Movement] B on B.EmpId = A.Employee_ID
		left join [WFMP].[tblMaster] C on C.Employee_ID = Case When B.Type = 1 Then B.ToMgr Else B.FromMgr End
		where (A.[RepMgrCode] is null or A.[RepMgrCode] = 0) and A.[EmpStatus] = 1;
	End
	else
	Begin
		Select
		A.Employee_ID,
		dbo.ToPropercase(A.[First_Name])+' '+
		dbo.ToPropercase(A.[Middle_Name]) +' '+ 
		dbo.ToPropercase(A.[Last_Name]) AS [Name], 
		Lower(A.[Email_Office]) AS EMAIL_ID,
		case when b.State=0 THEN 'Pending with '+ dbo.ToPropercase(C.[First_Name])+' '+	dbo.ToPropercase(C.[Middle_Name]) +' '+ dbo.ToPropercase(C.[Last_Name]) else '' END as State
		from [WFMP].[tblMaster] A
		left join [CWFM_Umang].[WFMP].[tbltrans_Movement] B on B.EmpId = A.Employee_ID
		left join [WFMP].[tblMaster] C on C.Employee_ID = Case When B.Type = 1 Then B.ToMgr Else B.FromMgr End
		where A.[RepMgrCode] = @RepMgrCode and A.[EmpStatus] = 1;
	End
End 
GO
/****** Object:  StoredProcedure [WFMP].[UpdateApproval]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [WFMP].[UpdateApproval] 
(
	-- Add the parameters for the stored procedure here
	@ApproverID int,
	@EmpID int,
	@id int,
	@comments varchar(max)	
)
AS
BEGIN
--[WFMP].[UpdateApproval] 918031, 934763, 
Declare @RepID int,@RevID int, @LevelId int, @MasterApprover int
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @RepID= (select [RepMgrCode] from [WFMP].[tblMaster] where [Employee_ID]=@EmpID)

	set @RevID = ( select [RepMgrCode] from [WFMP].[tblMaster] where [Employee_ID]=@RepID)

	set @LevelId=(select [LevelID] from WFMP.tblMaster where [Employee_ID]=@EmpID)

	--set @MasterApprover = (select EmployeeID from WFMP.tblMasterApprover where Active=1)

		--if (@LevelId>80)
		--begin
	if (@ApproverID = @RepID)
	BEGIN
	UPDATE [WFMP].[tbl_leave_request]
    SET [Level1_comments]=@comments, [Level1_Action]='1',[Level1_actioned_by]=@ApproverID, [Level1_actioned_on]=GETDATE()
    WHERE [id] = @id
	END

	else if (@ApproverID = @RevID)
	BEGIN	
	UPDATE [WFMP].[tbl_leave_request]
    SET [Level2_comments]=@comments, [Level2_Action]='1',[Level2_actioned_by]=@ApproverID, [Level2_actioned_on]=GETDATE()
    WHERE [id] = @id
	END
	--end

	--else if (@LevelId between 66 and 80)
	--begin

	--if (@ApproverID = @RepID)
	--BEGIN
	--UPDATE [WFMP].[tbl_leave_request]
 --   SET [Level1_comments]=@comments, [Level1_Action]='1',[Level1_actioned_by]=@ApproverID, [Level1_actioned_on]=GETDATE()
 --   WHERE [id] = @id
	--END

	
	--else
	--begin
	--UPDATE [WFMP].[tbl_leave_request]
 --   SET [Level2_comments]=@comments, [Level2_Action]='1',[Level2_actioned_by]=@ApproverID, [Level2_actioned_on]=GETDATE()
 --   WHERE [id] = @id and @ApproverID in (select EmployeeID from WFMP.tblMasterApprover where Active=1) 
	--end
	--end

END

GO
/****** Object:  StoredProcedure [WFMP].[UpdateDecline]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [WFMP].[UpdateDecline] 
(
	-- Add the parameters for the stored procedure here
	@ApproverID int,
	@EmpID int,
	@id int,
	@comments varchar(max),
	@bit varchar(10)	output
)
AS
BEGIN
--[WFMP].[UpdateApproval] 918031, 934763, 
	Declare @RepID int,@RevID int, @LevelId int, @MasterApprover int
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	set @RepID= (select [RepMgrCode] from [WFMP].[tblMaster] where [Employee_ID]=@EmpID)
	set @RevID = ( select [RepMgrCode] from [WFMP].[tblMaster] where [Employee_ID]=@RepID)
	set @LevelId=(select [LevelID] from WFMP.tblMaster where [Employee_ID]=@EmpID)
	--set @MasterApprover = (select EmployeeID from WFMP.tblMasterApprover where Active=1)
		------ As discudded with Chetan on 9/11/2017 removing feature(AM and above level approval should go to chetan)by commenting out the lines
	--if (@LevelId>80)
		--begin
		if (@ApproverID = @RepID)
		BEGIN
			UPDATE [WFMP].[tbl_leave_request]
			SET [Level1_comments]=@comments, [Level1_Action]='0',[Level1_actioned_by]=@ApproverID, [Level1_actioned_on]=GETDATE()
			WHERE [id] = @id

			
		END

		else if (@ApproverID = @RevID)
		BEGIN
			set @bit= 'disable';

			UPDATE [WFMP].[tbl_leave_request]
			SET [Level2_comments]=@comments, [Level2_Action]='0',[Level2_actioned_by]=@ApproverID, [Level2_actioned_on]=GETDATE()
			WHERE [id] = @id	

			
		END
	--end	
	--else if (@LevelId between 66 and 80)
	--begin

	--	if (@ApproverID = @RepID)
	--	BEGIN
	--		UPDATE [WFMP].[tbl_leave_request]
	--		SET [Level1_comments]=@comments, [Level1_Action]='0',[Level1_actioned_by]=@ApproverID, [Level1_actioned_on]=GETDATE()
	--		WHERE [id] = @id

			
	--	END

	--	--else if (@ApproverID = @RevID)
	--	--BEGIN
	--	--	UPDATE [WFMP].[tbl_leave_request]	
	--	--	SET[Level2_Action] = 0
	--	--	WHERE [id] = @id

	--	--	SELECt 4
	--	--END

	--	else 
	--	begin
	--		UPDATE [WFMP].[tbl_leave_request]
	--		SET [Level2_comments]=@comments, [Level2_Action]='0',[Level2_actioned_by]=@ApproverID, [Level2_actioned_on]=GETDATE()
	--		WHERE [id] = @id and @ApproverID in (select EmployeeID from WFMP.tblMasterApprover where Active=1 and EmployeeID = @ApproverID) 

	--		set @bit= 'disable';

			
	--	end
	--end
END

GO
/****** Object:  StoredProcedure [WFMP].[updateEmployeeProfileData]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Paras Parmar
-- Create date: 05-August-2017 12.35 AM
-- Description:	Updates the entries for an employee in the Team Anatomy Profile page
-- =============================================
CREATE PROCEDURE [WFMP].[updateEmployeeProfileData] 
		@Employee_ID int,
		@Date_of_Birth datetime= null,
		@Gender varchar(10),		
		@Email_Personal varchar(255),
		@Contact_Number bigint= null,
		@MaritalStatus varchar(50),
		@AnniversaryDate datetime = null,
		@HighestQualification varchar(255),
		@Transport bit,
		@Address1 varchar(255),
		@Address2 varchar(255),
		@Landmark varchar(255),
		@City varchar(255),
		@Total_Work_Experience int= null,
		@Skill1 varchar(255),
		@Skill2 varchar(255),
		@Skill3 varchar(255),
		@Alternate_Contact bigint= null,
		@EmergencyContactName varchar(255),
		@EmergencyContactPerson bigint=null,		
		@Updated_by nvarchar(50),
		@Update_Date datetime

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		
	IF EXISTS (Select * from [CWFM_Umang].[WFMP].[tblProfile] where Employee_ID = @Employee_ID)
	Begin
	print 'update query'
		 Update [CWFM_Umang].[WFMP].[tblProfile]
		 Set	Date_of_Birth = @Date_of_Birth, 
				Gender = @Gender, 		 
				Email_Personal = @Email_Personal, 
				Contact_Number = @Contact_Number, 
				MaritalStatus=@MaritalStatus,
				AnniversaryDate = @AnniversaryDate, 
				HighestQualification = @HighestQualification, 
				Transport = @Transport, 
				Address1 = @Address1, 
				Address2 = @Address2, 
				Landmark = @Landmark, 
				City = @City, 
				Total_Work_Experience = @Total_Work_Experience, 
				Skill1 = @Skill1, 
				Skill2 = @Skill2, 
				Skill3 = @Skill3, 
				Alternate_Contact = @Alternate_Contact, 
				EmergencyContactName = @EmergencyContactName, 	
				EmergencyContactPerson = @EmergencyContactPerson, 		
				Updated_by = @Updated_by, 
				Update_Date = @Update_Date
		where Employee_ID = @Employee_ID;
	End
	Else
	Begin
	print 'insert query';
	INSERT INTO [CWFM_Umang].[WFMP].[tblProfile] 
		(	Employee_ID,Date_of_Birth,Gender,Email_Personal,Contact_Number
			,MaritalStatus,AnniversaryDate,HighestQualification,Transport,Address1,Address2,Landmark 
			,City,Total_Work_Experience,Skill1,Skill2,Skill3,Alternate_Contact 
			,EmergencyContactName,EmergencyContactPerson,Updated_by,Update_Date
		)
	VALUES
		(	@Employee_ID,@Date_of_Birth, @Gender, @Email_Personal, @Contact_Number, 
			@MaritalStatus,@AnniversaryDate, @HighestQualification, @Transport, @Address1, 
			@Address2, @Landmark, @City, @Total_Work_Experience, @Skill1, 
			@Skill2, @Skill3, @Alternate_Contact, @EmergencyContactName, @EmergencyContactPerson, 		
			@Updated_by, @Update_Date
		);
	END
END

GO
/****** Object:  UserDefinedFunction [dbo].[DeleteME]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[DeleteME]
(
	@ValFrom int,
	@ValTo int
)
RETURNS int
AS
BEGIN
	
	if  @ValFrom > @ValTo
	Begin
		Set @ValFrom = @ValFrom - 1
	End
	Else
	Begin
		Set @ValFrom = 0
	End
	return @ValFrom
END



GO
/****** Object:  UserDefinedFunction [dbo].[FlattenedJSON]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FlattenedJSON] (@XMLResult XML)
RETURNS nvarchar(max)
WITH EXECUTE AS CALLER
AS
Begin
Declare  @JSONVersion NVarchar(max), @Rowcount int
Select @JSONVersion = '', @rowcount=count(*) from @XMLResult.nodes('/root/*') x(a)
Select @JSONVersion=@JSONVersion+
Stuff(
  (Select TheLine from 
    (Select ',
    {'+
      Stuff((Select ',"'+coalesce(b.c.value('local-name(.)', 'NVARCHAR(255)'),'')+'":"'+
       Replace( --escape tab properly within a value
         Replace( --escape return properly
           Replace( --linefeed must be escaped
             Replace( --backslash too
               Replace(coalesce(b.c.value('text()[1]','NVARCHAR(MAX)'),''),--forwardslash
               '\', '\\'),   
              '/', '\/'),   
          CHAR(10),'\n'),   
         CHAR(13),'\r'),   
       CHAR(09),'\t')   
     +'"'   
     from x.a.nodes('*') b(c) 
     for xml path(''),TYPE).value('(./text())[1]','NVARCHAR(MAX)'),1,1,'')+'}'
   from @XMLResult.nodes('/root/*') x(a)
   ) JSON(theLine)
  for xml path(''),TYPE).value('.','NVARCHAR(MAX)' )
,1,1,'')
if @Rowcount>1 Return '['+@JSONVersion+'
]'
return @JSONVersion
end
GO
/****** Object:  UserDefinedFunction [dbo].[fn_delimitedtotable]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_delimitedtotable](@DelimitedString varchar(max))  
returns @Values TABLE  
(  
 id int not null identity primary key clustered,   
 v VARCHAR(max)  
)  
as  
begin  
 declare @e int, @i int  
 set @i = 1  
 set @e = 1  
  
 set @DelimitedString = @DelimitedString + ','  
   
 while @e <> 0 and @i < 1000
 begin  
   set @e = charindex(',', @DelimitedString)  
   if @e <> 0  
   begin  
     insert into @Values (v)  
     select substring(@DelimitedString, 1, @e - 1)  
     set @DelimitedString = right(@DelimitedString, len(@DelimitedString) - @e)  
   end  
  set @i = @i + 1  
 end  
 return  
end  

GO
/****** Object:  UserDefinedFunction [dbo].[fnIntegerToWords]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIntegerToWords](@Number as BIGINT) 
    RETURNS VARCHAR(1024)
AS

BEGIN
      DECLARE @Below20 TABLE (ID int identity(0,1), Word varchar(32))
      DECLARE @Below100 TABLE (ID int identity(2,1), Word varchar(32))
      INSERT @Below20 (Word) VALUES 
                        ( 'Zero'), ('One'),( 'Two' ), ( 'Three'),
                        ( 'Four' ), ( 'Five' ), ( 'Six' ), ( 'Seven' ),
                        ( 'Eight'), ( 'Nine'), ( 'Ten'), ( 'Eleven' ),
                        ( 'Twelve' ), ( 'Thirteen' ), ( 'Fourteen'),
                        ( 'Fifteen' ), ('Sixteen' ), ( 'Seventeen'),
                        ('Eighteen' ), ( 'Nineteen' ) 

       INSERT @Below100 VALUES ('Twenty'), ('Thirty'),('Forty'), ('Fifty'),
                               ('Sixty'), ('Seventy'), ('Eighty'), ('Ninety')

    declare @belowHundred as varchar(126) 

    if @Number > 99 begin
        select @belowHundred = dbo.fnIntegerToWords( @Number % 100)
    end

    DECLARE @English varchar(1024) = 

    (

      SELECT Case 
        WHEN @Number = 0 THEN  ''

        WHEN @Number BETWEEN 1 AND 19 
          THEN (SELECT Word FROM @Below20 WHERE ID=@Number)

       WHEN @Number BETWEEN 20 AND 99   
         THEN  (SELECT Word FROM @Below100 WHERE ID=@Number/10)+ '-' +
               dbo.fnIntegerToWords( @Number % 10) 

       WHEN @Number BETWEEN 100 AND 999   
         THEN  (dbo.fnIntegerToWords( @Number / 100)) +' Hundred '+
             Case WHEN @belowHundred <> '' THEN 'and ' + @belowHundred else @belowHundred end 

       WHEN @Number BETWEEN 1000 AND 999999   
         THEN  (dbo.fnIntegerToWords( @Number / 1000))+' Thousand '+
             dbo.fnIntegerToWords( @Number % 1000)  

       WHEN @Number BETWEEN 1000000 AND 999999999   
         THEN  (dbo.fnIntegerToWords( @Number / 1000000))+' Million '+
             dbo.fnIntegerToWords( @Number % 1000000) 

       WHEN @Number BETWEEN 1000000000 AND 999999999999   
         THEN  (dbo.fnIntegerToWords( @Number / 1000000000))+' Billion '+
             dbo.fnIntegerToWords( @Number % 1000000000) 

            ELSE ' INVALID INPUT' END
    )

    SELECT @English = RTRIM(@English)

    SELECT @English = RTRIM(LEFT(@English,len(@English)-1))
        WHERE RIGHT(@English,1)='-'

    RETURN (@English)

END 

GO
/****** Object:  UserDefinedFunction [dbo].[GetWeekStartEndFromDate]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[GetWeekStartEndFromDate]
(
	@xDate smalldatetime,
	@xType varchar(1),
	@xDay int
)
RETURNS DATE
AS
BEGIN
	DECLARE @xSQL AS VARCHAR(MAX);
	DECLARE @xDateWhich AS VARCHAR(MAX);

	if (@xDay <> 1)
	BEGIN
		Set @xDay = 2
	END

	Set @xDateWhich = 0;
	IF (@xType = 'E')
	BEGIN
		Set @xDateWhich = 7

		Set @xDay =  @xDay - 1
	END

	SELECT @xDate = Dateadd(d,(@xDateWhich -DATEPart(DW,@xDate) + @xDay) ,@xDate)
	
	return @xDate
End

GO
/****** Object:  UserDefinedFunction [dbo].[ProperCase]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ProperCase]
(
	@Text varchar(8000)
)
RETURNS varchar(8000)

AS
BEGIN
	
	-- Select [dbo].[ProperCase] ('AHT')


	 declare @Reset bit;
   declare @Ret varchar(8000);
   declare @i int;
   declare @c char(1);

   select @Reset = 1, @i=1, @Ret = '';

   while (@i <= len(@Text))
    select @c= substring(@Text,@i,1),
               @Ret = @Ret + case when @Reset=1 then UPPER(@c) else LOWER(@c) end,
               @Reset = case when @c like '[a-zA-Z]' then 0 else 1 end,
               @i = @i +1
   return @Ret


END

GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]

(     

      @Input NVARCHAR(MAX),

      @Character CHAR(1)

)

RETURNS @Output TABLE (

      Item NVARCHAR(1000)

)

AS

BEGIN

      DECLARE @StartIndex INT, @EndIndex INT

 

      SET @StartIndex = 1

      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character

      BEGIN

            SET @Input = @Input + @Character

      END

 

      WHILE CHARINDEX(@Character, @Input) > 0

      BEGIN

            SET @EndIndex = CHARINDEX(@Character, @Input)

            

            INSERT INTO @Output(Item)

            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)

            

            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))

      END

 

      RETURN

END


GO
/****** Object:  UserDefinedFunction [dbo].[ToProperCase]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ToProperCase](@string VARCHAR(255)) RETURNS VARCHAR(255)
AS
BEGIN
  DECLARE @i INT           -- index
  DECLARE @l INT           -- input length
  DECLARE @c NCHAR(1)      -- current char
  DECLARE @f INT           -- first letter flag (1/0)
  DECLARE @o VARCHAR(255)  -- output string
  DECLARE @w VARCHAR(10)   -- characters considered as white space

  SET @w = '[' + CHAR(13) + CHAR(10) + CHAR(9) + CHAR(160) + ' ' + ']'
  SET @i = 1
  SET @l = LEN(@string)
  SET @f = 1
  SET @o = ''

  WHILE @i <= @l
  BEGIN
    SET @c = SUBSTRING(@string, @i, 1)
    IF @f = 1 
    BEGIN
     SET @o = @o + @c
     SET @f = 0
    END
    ELSE
    BEGIN
     SET @o = @o + LOWER(@c)
    END

    IF @c LIKE @w SET @f = 1

    SET @i = @i + 1
  END

  RETURN @o
END
GO
/****** Object:  UserDefinedFunction [dbo].[xGetdateBetween]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[xGetdateBetween]
(     
      @Increment              CHAR(1),
      @StartDate              smalldatetime,
      @EndDate                smalldatetime
)
RETURNS  
@SelectedRange    TABLE 
(xDate smalldatetime)
AS 
BEGIN
      ;WITH cteRange (DateRange) AS (
            SELECT @StartDate
            UNION ALL
            SELECT 
                  CASE
                        WHEN @Increment = 'd' THEN DATEADD(dd, 1, DateRange)
                        WHEN @Increment = 'w' THEN DATEADD(ww, 1, DateRange)
                        WHEN @Increment = 'm' THEN DATEADD(mm, 1, DateRange)
                  END
            FROM cteRange
            WHERE DateRange <= 
                  CASE
                        WHEN @Increment = 'd' THEN DATEADD(dd, -1, @EndDate)
                        WHEN @Increment = 'w' THEN DATEADD(ww, -1, @EndDate)
                        WHEN @Increment = 'm' THEN DATEADD(mm, -1, @EndDate)
                  END)
          
      INSERT INTO @SelectedRange (xDate)
      SELECT DateRange
      FROM cteRange
      OPTION (MAXRECURSION 3660);
      RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[xGetDayDate]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[xGetDayDate]
(
	@endDate datetime,
	@dayname varchar(20),
	@dayPara varchar(20)
)
RETURNS date
AS
BEGIN
	
	DECLARE @date date
	
	;WITH DATERANGE AS
	 (
		SELECT DT = DATEADD(DD, 1, DATEADD(YEAR,-1,@ENDDATE))
		WHERE DATEADD(DD, 1, DATEADD(YEAR,-1,@ENDDATE)) <= @ENDDATE
		UNION ALL
		SELECT DATEADD(DD, 1, DT)
		FROM DATERANGE
		WHERE DATEADD(DD, 1, DT) < @ENDDATE
	 )

	SELECT @DATE=DT FROM (
	SELECT DT,DATENAME(DW,DT) + CONVERT(VARCHAR,ROW_NUMBER() OVER (ORDER BY DT ASC)) AS NAME FROM(
	SELECT TOP(13) *
	FROM DATERANGE
	WHERE DATENAME(DW,DT) = @dayname
	ORDER BY DT DESC) AS ST) AS FT
	WHERE NAME=@dayPara

	OPTION (MAXRECURSION 0);


	RETURN @DATE

END

GO
/****** Object:  UserDefinedFunction [dbo].[xGetWeekDates]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[xGetWeekDates]
(     
	@xDate smalldatetime,
	@xSD as bit = null,
	@Increment CHAR(1)
)
RETURNS  
@SelectedRange    TABLE 
(xDate smalldatetime)
AS 
BEGIN
	DECLARE @StartDate SMALLDATETIME
	DECLARE @EndDate SMALLDATETIME
	
	IF isnull(@xSD,0) = 0
	BEGIN
		SET @xSD = 0
	END
	ELSE
	BEGIN
		SET @xSD = 1
	END
	
	SET @StartDate = CONVERT(varchar, DATEADD(DAY, (2-@xSD) - DATEPART(WEEKDAY, @xDate), @xDate),112) 
	SET @EndDate = CONVERT(varchar,DATEADD(DAY, (8-@xSD) - DATEPART(WEEKDAY, @xDate), @xDate) ,112)
	
	;WITH cteRange (DateRange) AS (
		SELECT @StartDate
		UNION ALL
		SELECT 
			  CASE
					WHEN @Increment = 'd' THEN DATEADD(dd, 1, DateRange)
					WHEN @Increment = 'w' THEN DATEADD(ww, 1, DateRange)
					WHEN @Increment = 'm' THEN DATEADD(mm, 1, DateRange)
			  END
		FROM cteRange
		WHERE DateRange <= 
			  CASE
					WHEN @Increment = 'd' THEN DATEADD(dd, -1, @EndDate)
					WHEN @Increment = 'w' THEN DATEADD(ww, -1, @EndDate)
					WHEN @Increment = 'm' THEN DATEADD(mm, -1, @EndDate)
			  END)
	  
	INSERT INTO @SelectedRange (xDate)
	SELECT DateRange
	FROM cteRange
	OPTION (MAXRECURSION 3660);
	RETURN
END
GO
/****** Object:  UserDefinedFunction [PM].[GetWorkday]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Name : GetWorkday
Parameters : 
			1. From Date - The date from which you'd like to count the number of non-weekend days 
			forward or backward.
			2. DaysToAdd - The integer representing the count of business days to 
			be added / subtracted from the above.
Output: A date that is 'n' Work Days after or before the From date.
Author / Support: paras.parmar@sitel.com; parasparmar@gmail.com; paras@parasparmar.com


*/
CREATE FUNCTION [PM].[GetWorkday]
(
    @FromDate DATE
    ,@DaysToAdd INT
)
RETURNS DATE 
AS 
BEGIN

    --If there are no days to add or subtract, return the day that was passed in
    IF @DaysToAdd = 0 RETURN @FromDate

    DECLARE @Weeks INT
    DECLARE @DMod INT
    DECLARE @FromDateIndex INT

    --number of weeks
    SET @Weeks = @DaysToAdd/5

    --remainder of days
    SET @dmod = @DaysToAdd%5

    --Get the FromDate day of the week, this logic standardizes the @@DateFirst to Sunday = 1
    SET @FromDateIndex = (DATEPART(weekday, @FromDate) + @@DATEFIRST - 1) % 7 + 1

    /*Splitting the addition vs subtraction logic for readability*/

    --Adding business days
    IF @DaysToAdd > 0 
        BEGIN 

            --If the FromDate is on a weekend, move it to the previous Friday
            IF @FromDateIndex IN(1,7) 
                BEGIN
                    SET @FromDate = DATEADD(dd,CASE @FromDateIndex WHEN 1 THEN -2 WHEN 7 THEN -1 END,@FromDate)
                    SET @FromDateIndex = 6
                END

            SET @FromDate = DATEADD(dd, 
                CASE 
                    --If the mod goes through the weekend, add 2 days to account for it
                    WHEN 
                        ((@FromDateIndex = 3 --Tuesday
                        AND @dmod > 3) --Days until Friday
                        OR
                        (@FromDateIndex = 4  --Wednesday
                        AND @dmod > 2)--Days until Friday
                        OR 
                        (@FromDateIndex = 5 --Thursday
                        AND @dmod > 1)--Days until Friday
                        OR 
                        (@FromDateIndex = 6 --Friday
                        AND @dmod > 0))--Days until Friday
                        THEN 
                            @DMod+2 
                    --Otherwise just add the mod
                    ELSE 
                        @DMod 
                END, @FromDate)

        END

    --Subtracting business days
    IF @DaysToAdd < 0 
        BEGIN 

            --If the FromDate is on a weekend, move it to the next Monday
            IF @FromDateIndex IN(1,7) 
                BEGIN
                    SET @FromDate = DATEADD(dd,CASE @FromDateIndex WHEN 1 THEN 1 WHEN 7 THEN 2 END,@FromDate)
                    SET @FromDateIndex = 2
                END

            SET @FromDate = DATEADD(dd, 
                CASE 
                    --If the mod goes through the weekend, subtract 2 days to account for it
                    WHEN 
                        ((@FromDateIndex = 5 --Thursday
                        AND @dmod < -3) --Days until Monday
                        OR
                        (@FromDateIndex = 4  --Wednesday
                        AND @dmod < -2)--Days until Monday
                        OR 
                        (@FromDateIndex = 3 --Tuesday
                        AND @dmod < -1)--Days until Monday
                        OR 
                        (@FromDateIndex = 2 --Monday
                        AND @dmod < 0))--Days until Monday
                        THEN 
                            @DMod-2 
                    --Otherwise just subtract the mod
                    ELSE 
                        @DMod 
                END, @FromDate)

        END

    --Shift the date by the number of weeks
    SET @FromDate = DATEADD(ww,@Weeks,@FromDate)

    RETURN @FromDate

END
GO
/****** Object:  Table [WFMP].[RosterMst]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[RosterMst](
	[RosterID] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [int] NOT NULL,
	[WeekID] [int] NOT NULL,
	[rDate] [smalldatetime] NOT NULL,
	[ShiftID] [int] NULL,
	[RepMgrCode] [int] NOT NULL,
	[UpdatedBy] [int] NOT NULL,
	[updatedOn] [datetime] NOT NULL,
	[WOCount] [int] NULL,
 CONSTRAINT [PK_RosterMst] PRIMARY KEY CLUSTERED 
(
	[RosterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tbl_datewise_leave]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tbl_datewise_leave](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LeaveDate] [date] NOT NULL,
	[leave_type] [int] NOT NULL,
	[roster] [int] NOT NULL,
	[leave_batch_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tbl_leave_request]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tbl_leave_request](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ecn] [int] NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
	[leave_reason] [nvarchar](max) NOT NULL,
	[applied_on] [datetime] NOT NULL,
	[Level1_Action] [tinyint] NULL,
	[Level1_actioned_by] [int] NULL,
	[Level1_comments] [nvarchar](max) NULL,
	[Level1_actioned_on] [datetime] NULL,
	[Level2_Action] [tinyint] NULL,
	[Level2_actioned_by] [int] NULL,
	[Level2_comments] [nvarchar](max) NULL,
	[Level2_actioned_on] [datetime] NULL,
	[CancelDate] [datetime] NULL,
	[cancel_reason] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tbl_leave_request_BU]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tbl_leave_request_BU](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ecn] [int] NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
	[leave_reason] [nvarchar](max) NOT NULL,
	[applied_on] [datetime] NOT NULL,
	[status] [int] NULL,
	[actioned_by] [int] NULL,
	[comments] [nvarchar](max) NULL,
	[actioned_on] [date] NULL,
	[CancelDate] [datetime] NULL,
	[cancel_reason] [nvarchar](max) NULL,
	[leave_batch_id] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tbl_leave_request_Log]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tbl_leave_request_Log](
	[Transid] [int] IDENTITY(1,1) NOT NULL,
	[id] [int] NOT NULL,
	[Level1_Action] [tinyint] NULL,
	[Level1_actioned_by] [int] NULL,
	[Level1_comments] [nvarchar](max) NULL,
	[Level1_actioned_on] [datetime] NULL,
	[Level2_Action] [tinyint] NULL,
	[Level2_actioned_by] [int] NULL,
	[Level2_comments] [nvarchar](max) NULL,
	[Level2_actioned_on] [datetime] NULL,
	[CancelDate] [datetime] NULL,
	[cancel_reason] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tbl_Master_Approver]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tbl_Master_Approver](
	[id] [int] NOT NULL,
	[EmployeeID] [int] NULL,
	[LevelID] [int] NULL,
	[Active] [tinyint] NULL,
 CONSTRAINT [PK_tbl_Master_Approver] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblCountry]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblCountry](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[Capital] [varchar](50) NOT NULL,
	[Currency] [varchar](50) NOT NULL,
	[Primary_Language] [varchar](50) NOT NULL,
	[Market] [varchar](50) NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblDepartment]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblDepartment](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblDepartmentLinkMst]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblDepartmentLinkMst](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[FunctionID] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[LOBID] [int] NOT NULL,
	[SkillSetID] [int] NOT NULL,
	[SubSkillSetID] [int] NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblDesignation]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblDesignation](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[Designation] [varchar](50) NOT NULL,
	[LevelID] [int] NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblEmpStatus]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblEmpStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmpStatus] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblEnableDisable]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblEnableDisable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MinLevel] [int] NULL,
	[MaxLevel] [int] NULL,
	[RepMgrAction] [int] NULL,
	[RevMgrAction] [int] NULL,
	[Result] [int] NULL,
	[RepMgrCan] [int] NULL,
	[RevMgrCan] [int] NULL,
 CONSTRAINT [PK_tblEnableDisable] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblFunction]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblFunction](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[Function] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblJob_Type]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblJob_Type](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblLeaveType]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblLeaveType](
	[LeaveID] [int] IDENTITY(1,1) NOT NULL,
	[LeaveText] [varchar](10) NOT NULL,
	[ShiftCode] [int] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_tblLeaveType] PRIMARY KEY CLUSTERED 
(
	[LeaveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblLevel]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblLevel](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[LevelID] [int] NULL,
	[Level] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblLOB]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblLOB](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[LOB] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblMappingMst]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblMappingMst](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NOT NULL,
	[MarketID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblMaster]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblMaster](
	[Employee_ID] [int] NOT NULL,
	[First_Name] [varchar](255) NULL,
	[Middle_Name] [varchar](255) NULL,
	[Last_Name] [varchar](255) NULL,
	[DesignationID] [int] NULL,
	[LevelID] [int] NULL,
	[DOJ] [datetime] NULL,
	[DOP] [datetime] NULL,
	[DOR] [datetime] NULL,
	[DPT] [varchar](10) NULL,
	[DOPS] [smalldatetime] NULL,
	[EmpStatus] [tinyint] NOT NULL,
	[TrngStatus] [tinyint] NOT NULL,
	[Job_Type] [tinyint] NULL,
	[CountryID] [int] NULL,
	[SiteID] [int] NULL,
	[DeptLinkId] [int] NULL,
	[RepMgrCode] [int] NULL,
	[TeamID] [varchar](25) NULL,
	[ntName] [varchar](50) NULL,
	[ResType] [tinyint] NULL,
	[BusinessID] [int] NULL,
	[Email_Office] [varchar](255) NULL,
	[IsReportingManager] [bit] NULL,
 CONSTRAINT [PK_tblMaster] PRIMARY KEY CLUSTERED 
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblMaster_Log]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblMaster_Log](
	[Employee_ID] [int] NOT NULL,
	[First_Name] [varchar](255) NULL,
	[Middle_Name] [varchar](255) NULL,
	[Last_Name] [varchar](255) NULL,
	[DesignationID] [int] NULL,
	[LevelID] [int] NULL,
	[DOJ] [datetime] NULL,
	[DOP] [datetime] NULL,
	[DOR] [datetime] NULL,
	[DPT] [varchar](10) NULL,
	[DOPS] [smalldatetime] NULL,
	[EmpStatus] [tinyint] NOT NULL,
	[TrngStatus] [tinyint] NOT NULL,
	[Job_Type] [tinyint] NULL,
	[CountryID] [int] NULL,
	[SiteID] [int] NULL,
	[DeptLinkId] [int] NULL,
	[RepMgrCode] [int] NULL,
	[TeamID] [varchar](25) NULL,
	[ntName] [varchar](50) NULL,
	[ResType] [tinyint] NULL,
	[BusinessID] [int] NULL,
	[Email_Office] [varchar](255) NULL,
	[IsReportingManager] [bit] NULL,
	[WhenUpdated] [datetime] NOT NULL,
	[MovementID] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblMasterApprover]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblMasterApprover](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[LevelID] [int] NULL,
	[Active] [tinyint] NULL,
 CONSTRAINT [PK_tblMasterApprover] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblMinDateForLeaveApproval]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblMinDateForLeaveApproval](
	[minDate] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblMovementState]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblMovementState](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[State] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblMovementTypes]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblMovementTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblProfile]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblProfile](
	[Employee_ID] [int] NOT NULL,
	[Date_of_Birth] [datetime] NULL,
	[Gender] [varchar](10) NULL,
	[Email_Personal] [varchar](255) NULL,
	[Contact_Number] [bigint] NULL,
	[MaritalStatus] [varchar](50) NULL,
	[AnniversaryDate] [datetime] NULL,
	[HighestQualification] [varchar](255) NULL,
	[Transport] [bit] NULL,
	[Address1] [varchar](255) NULL,
	[Address2] [varchar](255) NULL,
	[Landmark] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[Total_Work_Experience] [int] NULL,
	[Skill1] [varchar](255) NULL,
	[Skill2] [varchar](255) NULL,
	[Skill3] [varchar](255) NULL,
	[Alternate_Contact] [bigint] NULL,
	[EmergencyContactName] [varchar](255) NULL,
	[EmergencyContactPerson] [bigint] NULL,
	[UserImage] [nvarchar](255) NULL,
	[Updated_by] [nvarchar](50) NULL,
	[Update_Date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblQry]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblQry](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[Qry] [varchar](2000) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblQualification]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblQualification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Qualification] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblRstWeeks]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblRstWeeks](
	[WeekId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[rYear] [int] NOT NULL,
	[rWeek] [int] NOT NULL,
	[FrDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblRstWeeks] PRIMARY KEY CLUSTERED 
(
	[WeekId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblShiftCode]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblShiftCode](
	[ShiftID] [int] IDENTITY(1,1) NOT NULL,
	[ShiftCode] [varchar](12) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[ShiftType] [tinyint] NOT NULL,
	[Exception] [bit] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_tblShiftCode] PRIMARY KEY CLUSTERED 
(
	[ShiftCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblSite]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblSite](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](50) NULL,
	[Site] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblSkills]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tblSkills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Skill] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [WFMP].[tblSkillSet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblSkillSet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransID] [int] NOT NULL,
	[SkillSet] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_tblSkillSet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblSubSkillSet]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblSubSkillSet](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[SubSkillSet] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tblTrainingStatus]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [WFMP].[tblTrainingStatus](
	[TransID] [int] IDENTITY(1,1) NOT NULL,
	[TrngStatus] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [WFMP].[tbltrans_Movement]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WFMP].[tbltrans_Movement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromDptLinkMstId] [int] NULL,
	[ToDptLinkMstId] [int] NULL,
	[FromMgr] [int] NULL,
	[ToMgr] [int] NULL,
	[EmpId] [int] NULL,
	[Type] [int] NULL,
	[State] [tinyint] NOT NULL,
	[InitBy] [int] NULL,
	[InitOn] [datetime] NOT NULL,
	[EffectiveDate] [datetime] NULL,
	[UpdaterID] [int] NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[xGetMonthsGlidePath]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[xGetMonthsGlidePath]  
(	
	@startDate smalldatetime
)
RETURNS TABLE 
AS
RETURN 
(
	Select Left(CONVERT(varchar,Dateadd(m,-2,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,-1,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,0,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,1,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,2,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,3,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,4,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,5,@startDate),112),6) + '01' xMonths 
	Union
	Select Left(CONVERT(varchar,Dateadd(m,6,@startDate),112),6) + '01' xMonths 

)



GO
/****** Object:  UserDefinedFunction [dbo].[xWeekStart]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[xWeekStart] 
(	
	-- Add the parameters for the function here
	@startDate smalldatetime, 
	@endDate smalldatetime
)
RETURNS TABLE 
AS
RETURN 
(
	WITH t1(N) AS (SELECT N FROM (VALUES(1),(1))a(N)), -- 2 Rows
t2(N) AS (SELECT 1 FROM t1 x, t1 y), -- 4 Rows (2*2)
t3(N) AS (SELECT 1 FROM t2 x, t2 y), -- 16 Rows (4*4)
t4(N) AS (SELECT 1 FROM t3 x, t3 y), -- 256 Rows (16*16)
t5(N) AS (SELECT 1 FROM t4 x, t4 y), -- 65,536 Rows (256*256)
tally(N) AS (SELECT 0 UNION ALL
             SELECT TOP (DATEDIFF(WEEK, @startDate, @endDate)) -- Limit the result-set straight up front
             ROW_NUMBER() OVER(ORDER BY (SELECT NULL))
             FROM t5 x, t5 y) -- 4,294,967,296 Rows (65,536*65,536)
SELECT N AS WeekNo,
CASE WHEN DATEADD(WEEK, DATEDIFF(WEEK, '2012-01-02', DATEADD(WEEK,N-1,@startDate)), '2012-01-02') < @startDate 
     THEN @startDate
     ELSE DATEADD(WEEK, DATEDIFF(WEEK, '2012-01-02', DATEADD(WEEK,N-1,@startDate)), '2012-01-02') END AS weekStart,
CASE WHEN DATEADD(WEEK, DATEDIFF(WEEK, '2012-01-08', DATEADD(WEEK,N,@startDate)), '2012-01-08') > @endDate 
     THEN @endDate
     ELSE DATEADD(WEEK, DATEDIFF(WEEK, '2012-01-08', DATEADD(WEEK,N,@startDate)), '2012-01-08') END AS weekEnd
FROM tally
)


GO
/****** Object:  View [xSPT].[Sample forecasting]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*select count(ProjectName) from [xSPT].Sample where ProjectCode='4000-IN5F-1000-5520001' And [Job Classification Job Level]='Agent'
group by ProjectCode,[Job Classification Job Level]
select  ProjectCode,ProjectName,[Job Classification Job Code],[Job Classification Job Level],count([Job Classification Job Level])as CurrentCount,null  as Forecast,[Country],[COSVSSGA] from [xSPT].Sample 
--where ProjectCode='4200-XX41-4690-0000000' 
group by ProjectCode,ProjectName,[Job Classification Job Code],[Job Classification Job Level],[Country],[COSVSSGA]
order by ProjectCode
union all
select 'Z-SUM' ProjectCode,' ' [Job Classification Job Code],' ' [Job Classification Job Level], (count([Job Classification Job Level]))from [xSPT].Sample 
order by ProjectCode asc*/
CREATE VIEW [xSPT].[Sample forecasting]
AS
SELECT     TOP (100) PERCENT 'Sep' AS Month, [xSPT].Sample.Country, [xSPT].Sample.[Job Classification Job Level], SUBSTRING([xSPT].Sample.[Job Classification Job Code], 1, 6) 
                      AS JobCode, [xSPT].Sample.CATEGORY, [xSPT].Sample.ProjectCode, COUNT([xSPT].Sample.[Job Classification Job Level]) AS CurrentCount,
                          (SELECT     COUNT(CATEGORY) AS Expr1
                            FROM          [xSPT].Sample AS a
                            WHERE      (ProjectCode = [xSPT].Sample.ProjectCode) AND (CATEGORY = 'Agent')) AS ProjectAgentsCount, [xSPT].OpportunityPositions.GOSRatio, 
                      [xSPT].ForeCasting.AgentCount - [xSPT].ForeCasting.AgentCount * 40 / 100 AS ForecastAgentCount, ([xSPT].ForeCasting.AgentCount - [xSPT].ForeCasting.AgentCount * 40 / 100) 
                      / [xSPT].OpportunityPositions.GOSRatio AS ForecastPositionCount, COUNT([xSPT].Sample.[Job Classification Job Level]) 
                      - ([xSPT].ForeCasting.AgentCount - [xSPT].ForeCasting.AgentCount * 40 / 100) / [xSPT].OpportunityPositions.GOSRatio AS Opportunities, [xSPT].Sample.DivisionName, 
                      [xSPT].Sample.WorkLocationName, [xSPT].Sample.ProjectName
FROM         [xSPT].Sample INNER JOIN
                      [xSPT].OpportunityPositions ON SUBSTRING([xSPT].Sample.[Job Classification Job Code], 1, 6) = SUBSTRING([xSPT].OpportunityPositions.[Job Classification Job Code], 1, 6) 
                      INNER JOIN
                      [xSPT].ForeCasting ON [xSPT].Sample.ProjectCode = [xSPT].ForeCasting.ProjectCode
GROUP BY [xSPT].Sample.Country, [xSPT].Sample.ProjectCode, [xSPT].Sample.[Job Classification Job Code], [xSPT].Sample.[Job Classification Job Level], [xSPT].Sample.CATEGORY, 
                      [xSPT].OpportunityPositions.GOSRatio, [xSPT].ForeCasting.AgentCount, [xSPT].Sample.DivisionName, [xSPT].Sample.WorkLocationName, [xSPT].Sample.ProjectName
ORDER BY [xSPT].Sample.ProjectCode


GO
/****** Object:  View [xSPT].[View_3]    Script Date: 11/18/2017 3:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [xSPT].[View_3]
AS
SELECT     xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, SUM(xSPT.CaptureMonthlyOpportunities.Opportunities) 
                      AS Opportunities, xSPT.CaptureMonthlyOpportunities.WorkLocationName AS WorkLocation, xSPT.BusinessHeads.EmployeeId AS Expr1, xSPT.Employee.FirstName, 
                      xSPT.Employee.MiddleName
FROM         xSPT.Employee RIGHT OUTER JOIN
                      xSPT.BusinessHeads ON xSPT.Employee.EmployeeID = xSPT.BusinessHeads.EmployeeId RIGHT OUTER JOIN
                      xSPT.CaptureMonthlyOpportunities ON xSPT.BusinessHeads.WorkLocationCode = xSPT.CaptureMonthlyOpportunities.WorkLocationCode
WHERE     (xSPT.CaptureMonthlyOpportunities.Country = 'India')
GROUP BY xSPT.CaptureMonthlyOpportunities.Country, xSPT.CaptureMonthlyOpportunities.WorkLocationCode, xSPT.CaptureMonthlyOpportunities.WorkLocationName, 
                      xSPT.BusinessHeads.EmployeeId, xSPT.Employee.FirstName, xSPT.Employee.MiddleName

GO
ALTER TABLE [WFMP].[tblLeaveType] ADD  CONSTRAINT [DF__tblLeaveT__Activ__082E6AE0]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [WFMP].[tblMaster] ADD  CONSTRAINT [DF_tblMaster_IsReportingManager]  DEFAULT ((0)) FOR [IsReportingManager]
GO
EXEC sys.sp_addextendedproperty @name=N'Author', @value=N'Paras Parmar' , @level0type=N'SCHEMA',@level0name=N'FDT'
GO
EXEC sys.sp_addextendedproperty @name=N'Objective', @value=N'Contains stored procedures that provides a de-duplicator to data being uploaded to table dbo.FinanceRaw2016' , @level0type=N'SCHEMA',@level0name=N'FDT'
GO
EXEC sys.sp_addextendedproperty @name=N'Project', @value=N'Finance Data Uploader' , @level0type=N'SCHEMA',@level0name=N'FDT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Sample"
            Begin Extent = 
               Top = 12
               Left = 462
               Bottom = 205
               Right = 751
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "OpportunityPositions"
            Begin Extent = 
               Top = 8
               Left = 107
               Bottom = 191
               Right = 415
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ForeCasting"
            Begin Extent = 
               Top = 55
               Left = 841
               Bottom = 174
               Right = 1017
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 2640
         Width = 2805
         Width = 2505
         Width = 1500
         Width = 1500
         Width = 2745
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'xSPT', @level1type=N'VIEW',@level1name=N'Sample forecasting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'xSPT', @level1type=N'VIEW',@level1name=N'Sample forecasting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[2] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CaptureMonthlyOpportunities"
            Begin Extent = 
               Top = 35
               Left = 0
               Bottom = 241
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "BusinessHeads"
            Begin Extent = 
               Top = 0
               Left = 515
               Bottom = 214
               Right = 744
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Employee"
            Begin Extent = 
               Top = 30
               Left = 244
               Bottom = 224
               Right = 493
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 2325
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1800
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'xSPT', @level1type=N'VIEW',@level1name=N'View_3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'xSPT', @level1type=N'VIEW',@level1name=N'View_3'
GO
