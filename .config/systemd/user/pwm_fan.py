#! /usr/bin/python

import RPi.GPIO as GPIO
import time
import signal
import sys
import os

class my_pwm:

    # Configuration
    FAN_PIN   = 24           # BCM pin used to drive PWM fan
    WAIT_TIME = 2            # [s] Time to wait between each refresh
    PWM_FREQ  = 50           # [kHz] 50Hz for Noctua PWM control

    # Configurable temperature and fan speed
    MIN_TEMP = 53
    MAX_TEMP = 58
    FAN_OFF  = 0
    FAN_LOW  = 85
    FAN_MAX  = 100

    def __init__(self):
        try:
            # Setup GPIO pin
            GPIO.setmode(GPIO.BCM)
            GPIO.setup(self.FAN_PIN, GPIO.OUT, initial=GPIO.LOW)
            self.fan = GPIO.PWM(self.FAN_PIN,self.PWM_FREQ)
            self.fan.start(self.FAN_MAX)
            # Handle fan speed every WAIT_TIME sec
            while True:
                self.handleFanSpeed()
                time.sleep(self.WAIT_TIME)

        except KeyboardInterrupt: # trap a CTRL+C keyboard interrupt
            print( "Exit FAN PWM" )
            self.setFanSpeed(self.FAN_OFF)
            GPIO.cleanup() # resets all GPIO ports used by this function

    # Get CPU's temperature
    def getCpuTemperature(self):
        res = os.popen('vcgencmd measure_temp').readline()
        temp =(res.replace("temp=","").replace("'C\n",""))
        # print(f"temp is {temp}") # Uncomment for testing
        return temp

    # Set fan speed
    def setFanSpeed(self, speed):
        if speed != self.FAN_OFF:
            self.fan.ChangeDutyCycle(self.FAN_MAX)
            time.sleep(1)
        self.fan.ChangeDutyCycle(speed)
        return()

    # Handle fan speed
    def handleFanSpeed(self):
        temp = float(self.getCpuTemperature())
        # Turn off the fan if temperature is below MIN_TEMP
        if temp < self.MIN_TEMP:
            self.setFanSpeed(self.FAN_OFF)
        # Set fan speed to MAXIMUM if the temperature is above MAX_TEMP
        elif temp >= self.MAX_TEMP:
            self.setFanSpeed(self.FAN_MAX)
        # Caculate dynamic fan speed
        else:
            step = (self.FAN_MAX - self.FAN_LOW)/(self.MAX_TEMP - self.MIN_TEMP)   
            temp -= self.MIN_TEMP
            self.setFanSpeed(self.FAN_LOW + ( round(temp) * step ))
        return ()

fan = my_pwm()
