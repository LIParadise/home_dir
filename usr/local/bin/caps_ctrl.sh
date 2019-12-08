#!/usr/bin/env bash
(dumpkeys | head -1; echo "keycode 58 = Control") | loadkeys
