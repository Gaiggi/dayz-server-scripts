#!/bin/bash

./DayZServer -config=serverDZ.cfg -port=2302 "-mod=1559212036;2545327648;1828439124;" -BEpath=battleye -profiles=profiles -dologs -adminlog -netlog -freezecheck -noCB -cpuCount=4 -limitFPS=100
