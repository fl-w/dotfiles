#!/bin/bash

sudo systemctl restart bluetooth
sudo modprobe -r r8169
sudo modprobe r8169
