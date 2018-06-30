#!/bin/bash

conky -c cpu &
conky -c mem &
sleep 5 #time for the main conky to start; needed so that the smaller ones draw above not below (probably can be lower, but we still have to wait 5s for the rings to avoid segfaults)
conky -c rings & # the main conky with rings
