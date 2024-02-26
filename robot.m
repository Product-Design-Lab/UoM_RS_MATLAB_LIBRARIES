classdef robot < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        control_mode
        q_ref
        q_dot_ref
        q_FB
        ID
        max_id
        connected_ID
        num_ID
        serial_obj
        serial_port
        serial_baudrate
        
    end

    methods
        function obj = robot(port,MAX_ID,BAUDRATE)
            %Robot Construct an instance of this class
            %   Detailed explanation goes here
            obj.max_id = MAX_ID;
            obj.control_mode = zeros(1,obj.max_id, 'logical');
            obj.q_ref = zeros(1,obj.max_id, 'double');
            obj.q_dot_ref = zeros(1,obj.max_id, 'double');
            obj.q_FB = zeros(1,obj.max_id, 'double');
            obj.serial_port = port;
            obj.serial_baudrate = BAUDRATE;
%             obj.serial_obj = establishSerial(port,BAUDRATE);

            for i=1:obj.max_id
                obj.ID(i) = i;
%                 obj.connected_ID(i) = 255;
            end


        end

%         function obj = setSerialParams(obj, port, baudrate)
%             obj.serial_port = port;
%             obj.serial_baudrate = baudrate;
%         end

        function obj = ConnectToArduino(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.serial_obj = establishSerial(obj.serial_port, obj.serial_baudrate);

        end
        
        function obj = getID(obj)
            [obj.num_ID, obj.connected_ID] = getMotorIDs(obj.serial_obj);

        end
        
        function obj = getFB(obj)
            obj.q_FB = readFB(obj.serial_obj, obj.max_id);

        end
        
        function obj = driveMotors(obj)

            value = zeros(1,obj.max_id, 'double');
            for i=1:length(obj.control_mode)
                if obj.control_mode(i) == 0
                    value(i) = obj.q_ref(i);
                else
                    value(i) = obj.q_dot_ref(i);
                end

            end
            sendMotorCommand(obj.serial_obj, value, obj.max_id)

        end

        function obj = setQ(obj, q)
            for i = 1:length(q)
                obj.q_ref(i) = q(i);
            end
        end

        function obj = setQDot(obj, q_dot)
            for i = 1:length(q_dot)
                obj.q_dot_ref(i) = q_dot(i);
            end
        end

        function obj = setDriveControlMode(obj, new_drive_control_mode)
            for i = 1:length(new_drive_control_mode)
                obj.control_mode(i) = new_drive_control_mode(i);
            end
            updateDriveMode(obj.serial_obj, obj.control_mode, obj.max_id);
        end
        
        


    end
end