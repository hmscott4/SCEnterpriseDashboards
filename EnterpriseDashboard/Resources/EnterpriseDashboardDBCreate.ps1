# Copyright (c) 2017 Microsoft Corporation. All rights reserved.
#
# THIS CODE IS MADE AVAILABLE AS IS, WITHOUT WARRANTY OF ANY KIND. THE ENTIRE RISK
# OF THE USE OR THE RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.

#Import SQL Server Module called SQLPS
Import-Module SQLPS -DisableNameChecking
 
#Your SQL Server Instance Name. If default leave it blank

#enumerate sql instances
$instances=(Get-WmiObject -ComputerName "datazen" win32_service | where {$_.name -like "MSSQL*"}).name
Write-host "The instances you have on the server are ="
$instances
$Inst = read-host 'Please enter the instance name, for default instance just enter to continiue' 



try{
$Srvr = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $Inst
$dbs=$srvr.databases.name
$DBName = "EnterpriseDashboards"

if($dbs -eq $DBName ) {  write-host "The database $DBName already exists!!!" -foregroundcolor "red" ;exit }
Else {$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database($Srvr, $DBName);
      $db.Create();
      $db.RecoveryModel = [Microsoft.SqlServer.Management.Smo.RecoveryModel]::Simple;
       $db.Alter();
      write-host "The $DBName database is succesfully created!!!" -foregroundcolor "magenta"
      $dbname.size}
		
#Confirm, list databases in your current instance
$Srvr.Databases |Select Name, recoverymodel,owner, CreateDate,size|ft -auto

}

catch {write-host "This Instance doesn't exists!!!" -foregroundcolor "cyan"}


       