
% establishSerial.m
% --------------------------
% Licenting Information: You are free to use or extend this project
% for educational purposes provided that (1) you do not distribute or
% publish solutions, (2) you retain this notice, and (3) you provide 
% clear attribution to the University of Melbourne, Department of 
% Mechanical Engineering.
% 
% Attribution Information: The ChessBot project was developed at the
% University of Melbourne. The core project was primarily developed
% by Professor Denny Oetomo (doetomo@unimelb.edu.au). The ChessBot 
% Skeleton Code was developed by Nathan Batham 
% (nathan.batham@unimelb.edu.au)




function [s] = establishSerial(port, baudrate)

    % Create a serial object and handshake with Arduino
    
    % External Variables
    % @ port                - COM port address of the Arduino.
    % @ baudrate            - BaudRate used between MATLAB and Arduino.
    
    % Create serial object
%     s = serial(port,'BaudRate', baudrate); 
    s = serialport(port,baudrate); 
%     fopen(s);

    % Wait for arduino to send connection request
    while ( read(s, 1, 'char') ~= 'a' ) 
    end

    % Send back ack to arduino
    writeline(s,'a'); 

    % Wait for arduino ack
    while ( read(s, 1, 'char') ~= 'b' ) 
    end

    % Consume a NaN
    temp = readline(s);

end