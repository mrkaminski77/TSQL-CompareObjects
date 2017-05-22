:setvar server1 "SCSBENSQLDEV01"
:setvar server2 "BENSQL08"
:setvar db1 "ATOReporting_UAT"
:setvar db2 "ATOReporting_PROD"
:setvar schema "results"
:setvar name "QueueNameBusinessRules"

:Connect $(server1)
USE $(db1);
GO

:out "C:\temp\"$(db1)".sql"
DECLARE @ObjectName NVARCHAR(MAX);
DECLARE @oType CHAR(1);
SET @ObjectName = N'[$(schema)].[$(name)]';
SELECT @oType = [Type] FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(@ObjectName);
IF @oType IN ('P','T', 'V') PRINT CAST(OBJECT_DEFINITION(OBJECT_ID(@ObjectName)) AS NTEXT);
IF @oType IN ('U') EXEC sp_help @ObjectName;
GO

:out stdout
:Connect $(server2)
USE $(db2);
GO


:out "C:\temp\"$(db2)".sql"
DECLARE @ObjectName NVARCHAR(MAX);
DECLARE @oType CHAR(1);
SET @ObjectName = N'[$(schema)].[$(name)]';
SET @ObjectName = N'[$(schema)].[$(name)]';
SELECT @oType = [Type] FROM [sys].[objects] WHERE [object_id] = OBJECT_ID(@ObjectName);
IF @oType IN ('P','T', 'V') PRINT CAST(OBJECT_DEFINITION(OBJECT_ID(@ObjectName)) AS NTEXT);
IF @oType IN ('U') EXEC sp_help @ObjectName;


GO

:out stdout
!!start winmergeu.exe "C:\temp\$(db1).sql" "c:\temp\$(db2).sql" 
