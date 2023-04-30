#!/bin/bash

mv ~/.config/nvim ~/.config/nvimbak/
mkdir ~/.config/nvim
cp -r ./init.lua ./lua/ ~/.config/nvim/
