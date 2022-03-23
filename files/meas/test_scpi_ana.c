/*
 * =====================================================================================
 *
 *       Filename:  test_scpi_ana.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  29.04.2020 17:08:05
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */

/* Read analog voltage on slow analog input */

#include <stdio.h>
#include <stdlib.h>

#include "redpitaya/rp.h"

int main (int argc, char **argv) {
    float value [4];

    // Initialization of API
    if (rp_Init() != RP_OK) {
        fprintf(stderr, "Red Pitaya API init failed!\n");
        return EXIT_FAILURE;
    }

    // Measure each XADC input voltage
    for (int i=0; i<4; i++) {
        rp_AIpinGetValue(i, &value[i]);
        printf("Measured voltage on AI[%i] = %1.2fV\n", i, value[i]);
    }

    // Releasing resources
    rp_Release();

    return EXIT_SUCCESS;
}

