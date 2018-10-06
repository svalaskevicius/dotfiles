#!/usr/bin/env bash

RESTORE_LIGHT=$(light)

light -S 10

trap "exit 0" TERM INT
trap "light -S '$RESTORE_LIGHT'" EXIT

sleep 2147483647 &
wait


