
% readFB.m
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


function [fb, e] = readFB(s, numMotors)

    % Read motor position by sending a position read command to the
    % Arduino and then calling the readSerial() function to receive
    % the data.
    
    % External Variables
    % @ s                   - Serial object.
    % @ numMotors           - Number of motors expected to read from.
    
    % Internal Functions
    % @ readSerial()        - Read data sent by Arduino over serial.
    
    % Send position read command to Arduino
    writeline(s,'FBK');
    writeline(s,'FBK');
    
    % Convert encoder counts into radians
    SMS_2_RAD = (2*pi)/4096;
    
    % Read motor feedback in SCS format
    [fb, e] = readSerial(s, numMotors);
    
    % Convert from SCS to rad
    for i = 1:numMotors

        fb(i) = fb(i)*SMS_2_RAD;

    end

end