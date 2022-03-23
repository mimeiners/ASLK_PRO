clc

// Load SOCKET Toolbox
// exec(SCI+'contribsocket_toolbox_2.0.1loader.sce');
SOCKET_init();


// Define Red Pitaya as TCP/IP object

IP= '192.168.111.182';            // Input IP of your Red Pitaya...
port = 5000;                     // If you are using WiFi then IP is:
tcpipObj='RedPitaya';            // 192.168.128.1

// Open connection with your Red Pitaya

SOCKET_open(tcpipObj,IP,port);

// Red value on analog input 3

volts=strtod(SOCKET_query(tcpipObj,'ANALOG:PIN? AIN3'));
disp(volts)

// Define value p from 0 - 100 //

        p = volts *(100/3.3) ;   // Set value of p in respect to readed voltage

        if p >=(100/7)
        SOCKET_write(tcpipObj,'DIG:PIN LED1,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED1,0')
        end

        if p >=(100/7)*2
        SOCKET_write(tcpipObj,'DIG:PIN LED2,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED2,0')
        end

        if p >=(100/7)*3
        SOCKET_write(tcpipObj,'DIG:PIN LED3,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED3,0')
        end

        if p >=(100/7)*4
        SOCKET_write(tcpipObj,'DIG:PIN LED4,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED4,0')
        end

        if p >=(100/7)*5
        SOCKET_write(tcpipObj,'DIG:PIN LED5,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED5,0')
        end

        if p >=(100/7)*6
        SOCKET_write(tcpipObj,'DIG:PIN LED6,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED6,0')
        end

        if p >=(100/7)*7
        SOCKET_write(tcpipObj,'DIG:PIN LED7,1')
        else
        SOCKET_write(tcpipObj,'DIG:PIN LED7,0')
        end

// Close connection with Red Pitaya

SOCKET_close(tcpipObj);
