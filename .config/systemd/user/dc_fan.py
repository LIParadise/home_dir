#! /usr/bin/python

import RPi.GPIO as GPIO
import time
import signal
import sys
import os

class my_dc_fan:

    # Configuration
    FAN_PIN    = 24           # BCM pin used to drive PWM fan
    WAIT_TIME  = 2.4          # [s] Time to wait between each refresh
    TEMP_THRES = 52.3

    def __init__(self):
        try:
            # Setup GPIO pin
            GPIO.setmode(GPIO.BCM)
            GPIO.setup(self.FAN_PIN, GPIO.OUT, initial=GPIO.LOW)
            # Handle fan speed every WAIT_TIME sec
            while True:
                self.handleFanSpeed()
                time.sleep(self.WAIT_TIME)

        except KeyboardInterrupt: # trap a CTRL+C keyboard interrupt
            print( "Exit DC Fan" )
            self.setFanSpeed(False)
            GPIO.cleanup() # resets all GPIO ports used by this function

    # Get CPU's temperature
    def getCpuTemperature(self):
        res = os.popen('vcgencmd measure_temp').readline()
        temp =(res.replace("temp=","").replace("'C\n",""))
        # print(f"temp is {temp}") # Uncomment for testing
        return temp

    # Set fan speed
    def setFanSpeed(self, on_or_off):
        GPIO.output(self.FAN_PIN, on_or_off)
        return()

    # Handle fan speed
    def handleFanSpeed(self):
        temp = float(self.getCpuTemperature())
        # Turn off the fan if temperature is below MIN_TEMP
        self.setFanSpeed(temp >= self.TEMP_THRES)
        return ()

fan = my_dc_fan()
