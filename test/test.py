# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, Timer


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())
    
     # Generatore di oscillazione lenta: periodo 4000 ns (250 kHz)
    async def osc_gen():
        while True:
            dut.osc.value = 0
            await Timer(2000, units="ns")
            dut.osc.value = 1
            await Timer(2000, units="ns")

    cocotb.start_soon(osc_gen())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.osc.value = 0
    dut.uio_in.value = 0
    dut.uio_oe.value = 1
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Monitoraggio (simile a $monitor in Verilog)
    async def monitor():
    	while True:
        	await RisingEdge(dut.clk)
        	dut._log.info(
            		f"Time: {cocotb.utils.get_sim_time('ns')} ns | "
            		f"clk={int(dut.clk.value)} osc={int(dut.osc.value)} "
            		f"measure={dut.measure.value.binstr}"
        	)


    cocotb.start_soon(monitor())

    # Durata simulazione (ridotta a 1.2 ms per ridurre tempo di simulazione, ma i risultati si osservano dopo 1 s)
    sim_time = 1_200_000  # ns
    await Timer(sim_time, units="ns")

    dut._log.info("Simulation finished")

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
