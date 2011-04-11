function Panel_com(command, argument)


%   Sends commands out to the panels
%  ARGUMENTS MUST BE ROW VECTORS
% Acceptable panel commands are:

switch lower(command)
    
    % one byte commands:
    case 'start'
        %	Start display: panel_addr, 0x20	-panel address not used
        send_serial( char([1 32]));
    case 'stop'
        %	Stop display: panel_addr, 0x30
        send_serial( char([1 48]));
        
    case 'start_w_trig'
        %	Start display w trigger: 0x25
        send_serial( char([1 37]));
        
    case 'stop_w_trig'
        %	Stop display w trigger: 0x35
        send_serial( char([1 53]));
        
    case 'clear'      % clear the flash
        send_serial( char([1 hex2dec('F0')]));
        
    case 'all_off'      % set all panels to 0;
        send_serial( char([1 hex2dec('00')]));
        
    case 'all_on'      % set all panels to 0;
        send_serial( char([1 hex2dec('FF')]));
        
    case  'g_level_0' % set all panels to grey level 0;
        send_serial( char([1 hex2dec('90')]));
        
    case  'g_level_1' % set all panels to grey level 1;
        send_serial( char([1 hex2dec('91')]));
        
    case  'g_level_2' % set all panels to grey level 2;
        send_serial( char([1 hex2dec('92')]));
        
    case  'g_level_3' % set all panels to grey level 3;
        send_serial( char([1 hex2dec('93')]));
        
    case  'g_level_4' % set all panels to grey level 4;
        send_serial( char([1 hex2dec('94')]));
        
    case  'g_level_5' % set all panels to grey level 5;
        send_serial( char([1 hex2dec('95')]));
        
    case  'g_level_6' % set all panels to grey level 6;
        send_serial( char([1 hex2dec('96')]));
        
    case  'g_level_7' % set all panels to grey level 7;
        send_serial( char([1 hex2dec('97')]));
        
    case  'g_level_8' % set all panels to grey level 8;
        send_serial( char([1 hex2dec('98')]));
        
    case  'g_level_9' % set all panels to grey level 9;
        send_serial( char([1 hex2dec('99')]));
        
    case  'g_level_10' % set all panels to grey level 10;
        send_serial( char([1 hex2dec('9A')]));
        
    case  'g_level_11' % set all panels to grey level 11;
        send_serial( char([1 hex2dec('9B')]));
        
    case  'g_level_12' % set all panels to grey level 12;
        send_serial( char([1 hex2dec('9C')]));
        
    case  'g_level_13' % set all panels to grey level 13;
        send_serial( char([1 hex2dec('9D')]));
        
    case  'g_level_14' % set all panels to grey level 14;
        send_serial( char([1 hex2dec('9E')]));
        
    case  'g_level_15' % set all panels to grey level 15;
        send_serial( char([1 hex2dec('9F')]));
        
    case  'led_tog' % toggles controller LED
        send_serial( char([1 hex2dec('50')]));
        
    case  'ctr_reset' % resets the controller
        send_serial( char([1 hex2dec('60')]));
        
    case  'bench_pattern' % run a benchmark on current pattern
        send_serial( char([1 hex2dec('70')]));
        
    case  'laser_on' % enable laser trigger
        send_serial( char([1 hex2dec('10')]));
        
    case  'laser_off' % enable laser trigger
        send_serial( char([1 hex2dec('11')]));
        
    case  'ident_compress_on' % enable compression for identical panel patches
        send_serial( char([1 hex2dec('12')]));
        
    case  'ident_compress_off' % disable compression for identical panel patches
        send_serial( char([1 hex2dec('13')]));
        
    case 'sync_sd_info'
        send_serial(char([1 hex2dec('14')]));
        
    case 'get_version'
        send_serial(char([1 hex2dec('15')]));
        
    case 'show_bus_number'
        send_serial(char([1 hex2dec('16')]));
        
    case 'quiet_mode_on' %In this mode, there is no feedback information sent from controller
        send_serial(char([1 hex2dec('17')]));
        
    case 'quiet_mode_off' %In this mode, feedback information from controller will be shown on the GUI
        send_serial(char([1, hex2dec('18')]));
        
    case 'controller_mode'
        send_serial(char([1 hex2dec('21')]));
        
    case 'pc_dumping_mode'
        send_serial(char([1 hex2dec('22')]));
        
        % two byte commands:
    case 'reset'
        if (~isequal(length(argument),1)||(~isnumeric(argument)))
            error('reset command requires 1 argument that is a number');
        end
        %	Board reset : 0x01, panel_addr
        send_serial( char([2 1 argument(1)]));
        
    case 'display'
        if (~isequal(length(argument),1)||(~isnumeric(argument)))
            error('display command requires 1 argument that is a number');
        end
        %	Display id:    0x02, panel_addr
        send_serial( char([2 2 argument(1)]));
        
    case 'set_pattern_id'
        if ((~isequal(length(argument),1))||(~isnumeric(argument))||(argument(1) >99)||(argument(1) <= 0))
            error('Pattern ID command requires 1 numerical argument that is between 1 and 99');
        end
        % panel ID:  0x03, Panel_ID
        send_serial( char([2 3 argument(1)]));
        
    case 'adc_test'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) >7)||(argument(1) < 0))
            error('ADC_test requires 1 argument that is a number between 0 and 7');
        end
        %	test ADC on controller board for certain chanel. send 0x04, channel addr (0 - 7)
        send_serial( char([2 4 argument(1)]));
        
    case 'dio_test'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) >7)||(argument(1) < 0))
            error('DIO_test requires 1 argument that is a number between 0 and 7');
        end
        %	test DIO on controller board for certain chanel. send 0x05, channel addr (0 - 7)
        send_serial( char([2 5 argument(1)]));
        
    case 'set_trigger_rate'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) > 255)||(argument(1) < 0))
            error('trigger setting requires 1 argument that is a number between 0 and 255');
        end
        %	set the trigger rate on the controller; send 0x06 and value
        %	0-255 (multiplied by 2 on the controller).
        send_serial( char([2 6 argument(1)]));
        
    case 'flash_panel'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) > 255)||(argument(1) < 0))
            error('trigger setting requires 1 argument that is a number between 0 and 255');
        end
        %	set the trigger rate on the controller; send 0x06 and value
        %	0-255 (multiplied by 2 on the controller).
        send_serial( char([2 7 argument(1)]));
        
    case 'eeprom_panel'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) > 255)||(argument(1) < 0))
            error('trigger setting requires 1 argument that is a number between 0 and 255');
        end
        %	set the trigger rate on the controller; send 0x06 and value
        %	0-255 (multiplied by 2 on the controller).
        send_serial( char([2 8 argument(1)]));
        
    case 'set_config_id'
        if ((~isequal(length(argument),1))||(~isnumeric(argument))||(argument(1) >99)||(argument(1) <= 0))
            error('arena configuration ID command requires 1 numerical argument that is between 1 and 99');
        end

        send_serial( char([2 9 argument(1)]));
        
    case 'get_adc_value'
        
        if ((~isequal(length(argument),1))||(~isnumeric(argument))||(argument(1) >4)||(argument(1) <= 0))
            error('get_adc_value requires 1 numerical argument, channel number, that is between 1 and 4');
        end
        
        send_serial( char([2 hex2dec('10') argument(1)]));
        
        % three byte commands:
        
    case 'set_mode'
        if ((~isequal(length(argument),2))||(~isnumeric(argument))||any(argument > 5)||any(argument(1) < 0))
            error('Loop mode command requires 2 numerical argument, 0,1,2,3, or 4 for both X, and Y');
        end
        send_serial( char([3  hex2dec('10') argument(1) argument(2)]));
        
    case 'address'
        if (~isequal(length(argument),2)||(~isnumeric(argument)))
            error('update address command requires 2 numerical arguments');
        end
        % update address: 0xFF; current address, new address
        send_serial( char([3 255 argument(1) argument(2)]));
        
    case 'set_posfunc_id'
        if (~isequal(length(argument),2)||(~isnumeric(argument)))
            error('set position function command requires 2 numerical arguments');
        end
        
        send_serial( char([3 hex2dec('15') argument(1) argument(2)]));
        
    case 'set_velfunc_id'
        if (~isequal(length(argument),2)||(~isnumeric(argument)))
            error('set velocity function command requires 2 numerical arguments');
        end
        
        send_serial( char([3 hex2dec('20') argument(1) argument(2)]));
        
    case 'set_funcx_freq'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) > 500)||(argument(1) < 0))
            error('function X update rate requires 1 argument that is a number between 0 and 500');
        end
        
        send_serial( char([3 hex2dec('25') dec2char(argument(1),2)]));
        
    case 'set_funcy_freq'
        if (~isequal(length(argument),1)||(~isnumeric(argument))||(argument(1) > 500)||(argument(1) < 0))
            error('function Y update rate requires 1 argument that is a number between 0 and 500');
        end
        
        send_serial( char([3 hex2dec('30') dec2char(argument(1),2)]));
  
% four byte commands:     
    case 'set_ao'
         if ~isequal(length(argument),2)||(~isnumeric(argument))
             error('set_AO(chan, val) requires 2 argument');
         end
         
         if (argument(1) > 4)||(argument(1) < 1)
             error('set_AO(chan, val): channel number ranges from 1 to 4');
         end
         
         if (argument(2) > 2047)||(argument(2) < 0)
             error('set_AO(chan, val): val ranges from 0 to 2047 (0-5V)');
         end
         
         send_serial(char([4 hex2dec('10') argument(1) dec2char(argument(2),2)]));
             
% five byte commands:
    case 'set_position'
        % 5 bytes to set pattern position: 0x70, then 2 bytes for x index, y index
        if (~isequal(length(argument),2)||(~isnumeric(argument)))
            error('position setting command requires 2 numerical arguments');
        end
        %subtract -1 from each argument
        % beacause in matlab use 1 as start index, and controller uses 0
        send_serial([5 hex2dec('70') dec2char(argument(1)-1,2) dec2char(argument(2)-1,2)]);
        
    case 'send_gain_bias'
        % 5 bytes to set gain and bias values: 0x71, then 1 byte each for gain_x, bias_x, gain_y, bias_y
        if (~isequal(length(argument),4)||(~isnumeric(argument)))
            error('gain & bias setting command requires 4 numerical arguments');
        end
        %Note: these are all signed arguments, so we need to convert to 2's complement if necessary
        send_serial( [5 hex2dec('71') signed_byte_to_char(argument)]);
        
        % twelve byte command
        %compress the 96 0/1 laser pattern into a 12 bytes data
        %Panel_com('send_laser_pattern',pattern);
        %argument pattern is a numerical array with 96 elements whose value is either 0 or 1
        %for example
        %Panel_com('send_laser_pattern',[ones(1,24),zeros(1,24),ones(1,24),zeros(1,24)]);
    case 'send_laser_pattern'
        if (~isequal(length(argument),96)||(~isnumeric(argument)))
            error('send_laser_pattern command requires 96 numerical arguments (0 or 1)');
        end
        
        for i=1:12
            binString = ''; %set binString to empty string
            for j =1:8
                temp = argument((i-1)* 8+ j);
                if temp ~= 0
                    temp = 1; %arugments should 0 or 1, if not 0 , set it to 1
                end
                binString = [binString num2str(temp)];
            end
            arg12(i) = bin2dec(binString);
        end
        
        %Note: these are all signed arguments, so we need to convert to 2's complement if necessary
        send_serial([12 arg12]);
        
        % variable lenth of bytes
        %frame dump into the frame buffer over USB
    case 'dump_frame'
        % first argument is the 'dump_frame'
        % argument 2 is the length of the data
        % argument 3 is x_AO,  0 <= x_AO < 2048  
        % argument 4 is y_AO, 0 < y_AO < 2048
        % argument 5 is the number of the panels
        % argument 6 is the gray scale level
        % argument 7 is the flag for the row compression
        % argument 8 to the end is the frame data
        % for example:
        % Panel_com('dump_frame', [384, 1, 0, 48, 1, 0, round(rand(1,8*48)*255)]);
       if (argument(1)>1536)||(~isnumeric(argument))
            error('dumping frame requires numerical arguments, maximum data length is 1536 bytes');
       end
       
       if (argument(2)>2048) && (argument(2)<0)
           error('analog output value for x channel in the range of 0 - 2047');
       end

       if (argument(3)>2048) && (argument(3)<0)
           error('analog output value for y channel in the range of 0 - 2047');
       end
       
        %50 is hardcoded no matter what is the length of the the message
        send_serial(char([50, signed_16Bit_to_char(argument(1)), signed_16Bit_to_char(argument(2)),...
            signed_16Bit_to_char(argument(3)), argument(4), argument(5), argument(6), argument(7:end)]));

        % case 'dump_frame'
        % first argument is the 'dump_frame'
        % argument 2 is x_AO,  0 <= x_AO < 2048
        % argument 3 is y_AO, 0 < y_AO < 2048
        % argument 4 is the number of the panels
        % argument 5 is the gray scale level
        % argument 6 is the flag for the row compression
        % argument 7 to the end is the frame data
        % for example:
        % Panel_com('dump_frame', [1, 0, 48, 1, 0, round(rand(1,8*48)*255)]);
%         if (length(argument)>1550)||(~isnumeric(argument))
%             error('dumping frame requires numerical arguments, maximum data length is 1536 bytes');
%         end
%         
%         if (argument(1)>2048) && (argument(1)<0)
%             error('analog output value for x channel in the range of 0 - 2047');
%         else
%             argument = [signed_16Bit_to_char(argument(1)), argument(2:end)];
%         end
%         
%         if (argument(2)>2048) && (argument(2)<0)
%             error('analog output value for y channel in the range of 0 - 2047');
%         else
%             argument = [argument(1:2),  signed_16Bit_to_char(argument(3)), argument(4:end)];
%         end
% 
%         totalIteration = ceil(length(argument)/50);
%         remained = mod((length(argument)), 50);
%         data = zeros(1, 50);
%        
%         %tranfer 50 data each time
%         for counter = 1:totalIteration - 1
%             for i = 1: 50
%                 data(i) = argument((counter-1)* 50 + i);
%             end
%             send_serial(char([52,counter, totalIteration, data]));
%         end
%         
%         %tranfer the remained data
%         data= zeros(1, 50);
%         for i = 1: remained
%             data(i) = argument((totalIteration - 1)*50 + i);
%         end
%         send_serial(char([52,totalIteration, totalIteration, data]));
%         if (length(argument)>1550)||(~isnumeric(argument))
%             error('dumping frame requires numerical arguments, maximum data length is 1536 bytes');
%         end
%         
%         if (argument(1)>2048) && (argument(1)<0)
%             error('analog output value for x channel in the range of 0 - 2047');
%         else
%             argument = [signed_16Bit_to_char(argument(1)), argument(2:end)];
%         end
%         
%         if (argument(2)>2048) && (argument(2)<0)
%             error('analog output value for y channel in the range of 0 - 2047');
%         else
%             argument = [argument(1:2),  signed_16Bit_to_char(argument(3)), argument(4:end)];
%         end
% 
%         totalIteration = ceil(length(argument)/400);
%         remained = mod((length(argument)), 400);
%         data = zeros(1, 400);
%        
%         %tranfer 400 data each time
%         for counter = 1:totalIteration - 1
%             for i = 1: 400
%                 data(i) = argument((counter-1)* 400 + i);
%             end
%             send_serial(char([50,counter, totalIteration, data]));
%         end
%         
%         %tranfer the remained data
%         data= zeros(1, 400);
%         for i = 1: remained
%             data(i) = argument((totalIteration - 1)*400 + i);
%         end
%         send_serial(char([50,totalIteration, totalIteration, data]));
        
    otherwise
        error('invalid command name, please check help')
end
