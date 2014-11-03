#!/bin/bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
   ./project2.sh

elif [[ "$OSTYPE" == "darwin"* ]]; then
   ./project1.sh

fi