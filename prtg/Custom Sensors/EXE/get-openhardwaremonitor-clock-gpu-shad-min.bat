@ECHO OFF
SET LOGFILE=C:\ISO\OpenHardwareMonitor\OHW-Current-Clock-GPU-Shad-Min.txt
TYPE %LOGFILE%
FOR /F "tokens=* delims=: USEBACKQ" %%a IN ( `TYPE %LOGFILE% ^| FINDSTR "DOWN"` ) DO ( EXIT 1 )
EXIT 0