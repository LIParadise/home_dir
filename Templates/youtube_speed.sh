#!/usr/bin/env bash
printf "%s" "document.getElementsByTagName(\"video\")[0].playbackRate =" | xclip -selection c
echo ""
echo "Usage:"
echo ""
echo "go to YouTube, choose a video U want to play faster than default 2-times"
echo "press \"ctrl\" + \"shift\" + \"j\""
echo "paste current buffer by pressing \"ctrl\" + \"v\""
echo "fill in the multiplier you want and then press \"Enter\"."
echo ""
