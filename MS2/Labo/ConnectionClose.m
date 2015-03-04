% Close the TCPIP connection.
fclose(tcpipObj);
% Set the terminator back to LF
tcpipObj.Terminator = 'LF';
% Delete objects and clear them.
delete(tcpipObj); clear tcpipObj;