#!/bin/bash
# This will be executed whenever WSL starts.

# Execute the task we created before.
/mnt/c/Windows/system32/schtasks.exe /run /tn "wsl_mount_p44pro"
# Since mounting will take some time, if you need to do something with the mounted drives later,
# you will need to write some logic to wait for it to be ready.
