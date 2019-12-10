#!/bin/bash
yosys -p "synth_ice40 -top top -json demo.json" *.v
nextpnr-ice40 --up5k --package sg48 --json demo.json --pcf pins.pcf --asc output.asc
