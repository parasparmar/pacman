/****** Script for SelectTopNRows command from SSMS  ******/
SELECT N.AccountID,c.[LOB]
, D.SplitID
, D.Date, D.TimePeriod  
FROM [WFMP].[tblMaster] A
inner join [WFMPMS].[tblEmp2Account] B on A.Employee_ID = B.EmpCode
inner join [WFMPMS].[tblAccount] N on N.AccountID = B.PrimaryClientID
inner join [WFMPMS].[tblAcc2LOB] C on C.AccountID = B.PrimaryClientID
inner join [WFMPMS].[tblBO] D on N.AccountID = D.PrimaryClientID and C.SkillId = D.SplitID
inner join [WFMPMS].[tblCalculations] G on G.ClientID = B.PrimaryClientID and G.LOB = C.BusinessUnit
inner join [WFMPMS].[tblLOB2CT] I on I.AccountID = C.AccountID and I.LOB = C.LOB and I.SubLOB = C.SubLOB
left join [WFMPMS].[tblForecastCallsBO] J on J.QueueName = I.CT and D.Date = J.Date and D.TimePeriod = J.TimePeriod
------
inner join [CWFM_Umang].[WFMPMS].[tblIEX] L on L.CT like '%'+I.CT and D.Date = L.Date and D.TimePeriod = L.Time
inner join [WFMPMS].[tblHOOP] M on M.AccountID = N.AccountID and M.LOB = C.LOB and Datepart("WEEKDAY",D.Date) = M.WeekDay 
 and M.TimeZone = G.ReportingTimeZone and D.TimePeriod between M.QStart and M.QEnd

where 
	A.Employee_ID = 803471
	and D.Date ='20170820'
	and B.PrimaryClientID = '511TOT1'
order by 
D.SplitID, 
D.Date, D.TimePeriod