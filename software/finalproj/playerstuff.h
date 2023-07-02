#ifndef PLAYERSTUFF_H_
#define PLAYERSTUFF_H_

#include <stdio.h>
#include "system.h"
#include "altera_avalon_spi.h"
#include "altera_avalon_spi_regs.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"

struct VGA_STRUCT {
	unsigned VRAM [512];
};

struct player {
	int xoff;
	int yoff;
	int angoff;
};

static volatile struct VGA_STRUCT* vga_ctrl = VGA_TEST_MODE_CONTROLLER_0_BASE;

void raycast(struct player);


#endif
