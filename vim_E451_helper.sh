#!/bin/sh
rm ~/.zcompdump
rm ~/.zcompdump*
rm $ZPULG_HOME/zcompdump*
#exec zsh
exec $SHELL -l
