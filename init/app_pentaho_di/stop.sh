#!/bin/sh
kill $(ps aux|grep [r]un.sh|awk '{print $2}')

