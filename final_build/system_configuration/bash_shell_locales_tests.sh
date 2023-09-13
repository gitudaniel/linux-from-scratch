#!/bin/bash

echo "Starting tests for locale settings"

# Tests for the en_US locale I've chosen to use
# It is important that the locale found is tested before it is added to the
# bash startup files.
# This is a separate file because of Murphy.
LC_ALL=en_US.iso88591 locale language
LC_ALL=en_US.iso88591 locale charmap
LC_ALL=en_US.iso88591 locale int_curr_symbol
LC_ALL=en_US.iso88591 locale int_prefix

echo "Finished tests for locale settings"
