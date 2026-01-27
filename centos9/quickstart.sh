#!/bin/bash
echo "1. Update installed packages..."
dnf update

echo "2. Let's check SSH default port (it must differs from 22)"
telnet_output="$({ sleep 1; echo $'\e'; } | telnet localhost 22 2>&1)"
if [[ "$telnet_output" == *"Connection refused"* ]];
	then echo "Success: 22 port connection refused"
else
	echo "Result: fail. Connection success. Change default SSH port"
	exit 1
fi