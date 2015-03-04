% 'Fs' and 'Ns' must be set before calling this script

%% Interface configuration and instrument connection

% Change the IP address to match your instrument's IP address
% Use 'localhost' if running from MATLAB installed directly on scope
% IPAddress = 'localhost';
IPAddress = '130.104.207.81';
scopePort = 5025;
TriggerTimeOut = 1; %TimeOut in second (approximation)      

% Create a TCPIP object. Agilent instruments use port 5025 to send SCPI commands and receive data so use that information.
tcpipObj = instrfind('Type', 'tcpip', 'RemoteHost', IPAddress, 'RemotePort', scopePort, 'Tag', '');

% Create the TCPIP object if it does not exist
% otherwise use the object that was found.
if isempty(tcpipObj)
    tcpipObj = tcpip(IPAddress, scopePort);
else
    fclose(tcpipObj);
    tcpipObj = tcpipObj(1);
end

% Set the buffer size. Change this buffer size to slightly over the number
% of bytes you get back in each read
tcpipObj.InputBufferSize = 350000;
% Set the timeout value
tcpipObj.Timeout = 1;
% Set the Byte order
tcpipObj.ByteOrder = 'littleEndian';
% Open the connection
fopen(tcpipObj)
disp ('Waiting for Tcpipobject Opening');
pause(20), 

%% Instrument Setup
% Now setup the instrument using SCPI commands. refer to the instrument
% programming manual for your instrument for the correct SCPI commands for
% your instrument.

% Set acquisition mode to Real Time Normal
fprintf(tcpipObj, ':ACQUIRE:MODE RTIM');

% Set total number of points per segment
fprintf(tcpipObj, [':ACQUIRE:POINTS ' num2str(Ns,'%1.0f')]);
Ns=str2double(query(tcpipObj,':ACQUIRE:POINTS?'));

% Set sample rate
fprintf(tcpipObj, [':ACQUIRE:SRATE ' num2str(Fs,'%1.0f')]);
Fs=str2double(query(tcpipObj,':ACQUIRE:SRATE?'));

% Force to display
fprintf(tcpipObj, ':CHAN1:DISP ON');
fprintf(tcpipObj, ':CHAN2:DISP ON');
fprintf(tcpipObj, ':CHAN3:DISP ON');
fprintf(tcpipObj, ':CHAN4:DISP ON');

% Turn interpolation off for faster averaging
fprintf(tcpipObj, ':ACQUIRE:INTERPOLATE OFF');

% Set the byte order on the instrument as well
fprintf(tcpipObj,':WAVEFORM:BYTEORDER LSBFirst');

% Get the data back as a BYTE (i.e., INT8)
fprintf(tcpipObj,':WAVEFORM:FORMAT WORD');






