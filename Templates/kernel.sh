#!/usr/bin/env bash
mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg
