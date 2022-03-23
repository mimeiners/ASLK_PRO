#!/usr/bin/env python3

import sys
from redpitaya import redpitaya_scpi as scpi


IP = "192.168.111.182"
# rp_s = scpi.scpi(sys.argv[0])
rp_s = scpi.scpi(IP)


for i in range(4):
    rp_s.tx_txt('ANALOG:PIN? AIN' + str(i))
    value = float(rp_s.rx_txt())
    print("Measured voltage on AI[" + str(i) + "] = " + str(value) + "V")
