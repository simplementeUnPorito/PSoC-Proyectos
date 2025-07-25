@ECHO OFF

REM %~dp0 expands %0 but only gives you the drive letter and path without quotes.
"%~dp0\..\bin\cyoptimizesetup.exe" %~1
EXIT /B %errorLevel%