Time=0;
fprintf(tcpipObj,':SING');

% Old 'Wait for data' loop tryout
% % % pause(0.001);
% % % while (strcmp(query(tcpipObj,':RSTATE?'),'SING') && Time<TriggerTimeOut)
% % %     pause(0.001);
% % %     Time=Time+0.001;
% % % end

if Time<TriggerTimeOut
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Specify data from Channel 1
    fprintf(tcpipObj,':WAVEFORM:SOURCE CHAN1');
    % Get the preamble block
    waveform1.Points=0;
    while (waveform1.Points~=2000 && Time<TriggerTimeOut) %!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        pause(0.001);
        Time=Time+0.01;
        
        preambleBlock = query(tcpipObj,':WAVEFORM:PREAMBLE?');
        % Maximum value storable in a INT8
        maxVal = 2^8;
        %  split the preambleBlock into individual pieces of info
        preambleBlock = regexp(preambleBlock,',','split');
        % store all this information into a waveform structure for later use
        waveform1.Format = str2double(preambleBlock{1});     % This should be 0, since we're specifying INT8 output
        waveform1.Type = str2double(preambleBlock{2});
        waveform1.Points = str2double(preambleBlock{3});
        waveform1.Count = str2double(preambleBlock{4});      % This is always 1
        waveform1.XIncrement = str2double(preambleBlock{5}); % in seconds
        waveform1.XOrigin = str2double(preambleBlock{6});    % in seconds
        waveform1.XReference = str2double(preambleBlock{7});
        waveform1.YIncrement = str2double(preambleBlock{8}); % V
        waveform1.YOrigin = str2double(preambleBlock{9});
        waveform1.YReference = str2double(preambleBlock{10   });
    end
    
    if Time>=TriggerTimeOut
        disp('WARNING :: Wainting for trigger timeout')
    end
    
    %% Instrument control and data retreival
    fwrite(tcpipObj,sprintf(':WAV:DATA?\n'));
    % Read back the BINBLOCK with the data in specified format and store it in the waveform structure
    waveform1.RawData = binblockread(tcpipObj,'int16');
    
    % Generate X & Y Data
    waveform1.XData = (waveform1.XIncrement.*(1:length(waveform1.RawData))) - waveform1.XIncrement;
    waveform1.YData = (waveform1.RawData - waveform1.YReference) .* waveform1.YIncrement + waveform1.YOrigin;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Specify data from Channel 2
    fprintf(tcpipObj,':WAVEFORM:SOURCE CHAN2');
    % Get the preamble block
    preambleBlock = query(tcpipObj,':WAVEFORM:PREAMBLE?');
    % Maximum value storable in a INT8
    maxVal = 2^8;
    %  split the preambleBlock into individual pieces of info
    preambleBlock = regexp(preambleBlock,',','split');
    % store all this information into a waveform structure for later use
    waveform2.Format = str2double(preambleBlock{1});     % This should be 0, since we're specifying INT8 output
    waveform2.Type = str2double(preambleBlock{2});
    waveform2.Points = str2double(preambleBlock{3});
    waveform2.Count = str2double(preambleBlock{4});      % This is always 1
    waveform2.XIncrement = str2double(preambleBlock{5}); % in seconds
    waveform2.XOrigin = str2double(preambleBlock{6});    % in seconds
    waveform2.XReference = str2double(preambleBlock{7});
    waveform2.YIncrement = str2double(preambleBlock{8}); % V
    waveform2.YOrigin = str2double(preambleBlock{9});
    waveform2.YReference = str2double(preambleBlock{10   });
    
    %% Instrument control and data retreival
    fwrite(tcpipObj,sprintf(':WAV:DATA?\n'));
    % Read back the BINBLOCK with the data in specified format and store it in the waveform structure
    waveform2.RawData = binblockread(tcpipObj,'int16');
    
    % Generate X & Y Data
    waveform2.XData = (waveform2.XIncrement.*(1:length(waveform2.RawData))) - waveform2.XIncrement;
    waveform2.YData = (waveform2.RawData - waveform2.YReference) .* waveform2.YIncrement + waveform2.YOrigin;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Specify data from Channel 3
    fprintf(tcpipObj,':WAVEFORM:SOURCE CHAN3');
    % Get the preamble block
    preambleBlock = query(tcpipObj,':WAVEFORM:PREAMBLE?');
    % Maximum value storable in a INT8
    maxVal = 2^8;
    %  split the preambleBlock into individual pieces of info
    preambleBlock = regexp(preambleBlock,',','split');
    % store all this information into a waveform structure for later use
    waveform3.Format = str2double(preambleBlock{1});     % This should be 0, since we're specifying INT8 output
    waveform3.Type = str2double(preambleBlock{2});
    waveform3.Points = str2double(preambleBlock{3});
    waveform3.Count = str2double(preambleBlock{4});      % This is always 1
    waveform3.XIncrement = str2double(preambleBlock{5}); % in seconds
    waveform3.XOrigin = str2double(preambleBlock{6});    % in seconds
    waveform3.XReference = str2double(preambleBlock{7});
    waveform3.YIncrement = str2double(preambleBlock{8}); % V
    waveform3.YOrigin = str2double(preambleBlock{9});
    waveform3.YReference = str2double(preambleBlock{10   });
    
    %% Instrument control and data retreival
    fwrite(tcpipObj,sprintf(':WAV:DATA?\n'));
    % Read back the BINBLOCK with the data in specified format and store it in the waveform structure
    waveform3.RawData = binblockread(tcpipObj,'int16');
    
    % Generate X & Y Data
    waveform3.XData = (waveform3.XIncrement.*(1:length(waveform3.RawData))) - waveform3.XIncrement;
    waveform3.YData = (waveform3.RawData - waveform3.YReference) .* waveform3.YIncrement + waveform3.YOrigin;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Specify data from Channel 4
    fprintf(tcpipObj,':WAVEFORM:SOURCE CHAN4');
    % Get the preamble block
    preambleBlock = query(tcpipObj,':WAVEFORM:PREAMBLE?');
    % Maximum value storable in a INT8
    maxVal = 2^8;
    %  split the preambleBlock into individual pieces of info
    preambleBlock = regexp(preambleBlock,',','split');
    % store all this information into a waveform structure for later use
    waveform4.Format = str2double(preambleBlock{1});     % This should be 0, since we're specifying INT8 output
    waveform4.Type = str2double(preambleBlock{2});
    waveform4.Points = str2double(preambleBlock{3});
    waveform4.Count = str2double(preambleBlock{4});      % This is always 1
    waveform4.XIncrement = str2double(preambleBlock{5}); % in seconds
    waveform4.XOrigin = str2double(preambleBlock{6});    % in seconds
    waveform4.XReference = str2double(preambleBlock{7});
    waveform4.YIncrement = str2double(preambleBlock{8}); % V
    waveform4.YOrigin = str2double(preambleBlock{9});
    waveform4.YReference = str2double(preambleBlock{10   });
    
    %% Instrument control and data retreival
    fwrite(tcpipObj,sprintf(':WAV:DATA?\n'));
    % Read back the BINBLOCK with the data in specified format and store it in the waveform structure
    waveform4.RawData = binblockread(tcpipObj,'int16');
    
    % Generate X & Y Data
    waveform4.XData = (waveform4.XIncrement.*(1:length(waveform4.RawData))) - waveform4.XIncrement;
    waveform4.YData = (waveform4.RawData - waveform4.YReference) .* waveform4.YIncrement + waveform4.YOrigin;
    
    %% Waves and save
    Waves=[waveform1.YData,waveform2.YData,waveform3.YData, waveform4.YData];
    
else
    disp('trigger time out occured')
end










