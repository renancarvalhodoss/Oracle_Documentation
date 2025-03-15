#!/bin/bash
echo "SPACE IN DISk"

df -h| awk '{print $5 " " $6}'   | sed '1d' | sort -nr
