#!/bin/bash

# -------------------------------------------------
# Simple Password Generator
# This script generates a cryptographically secure
# random password using OpenSSL.
# Author: Mohamed Hibbi
echo "Hello! This is a Simple Password Generator"
echo "-----------------------------------------"

# Prompt the user to enter desired password length
read -p "Please enter the length of the password: " PASS_LENGTH

# -------------------------------------------------
# Input validation
# -------------------------------------------------
if ! [[ "$PASS_LENGTH" =~ ^[0-9]+$ ]] || [ "$PASS_LENGTH" -le 0 ]; then
    echo "Error: Please enter a valid positive number."
    exit 1
fi
# Now we want to Check if input is a number using regex
# [[ "$PASS_LENGTH" =~ ^[0-9]+$ ]] checks:
#   ^      -> start of string
#   [0-9]+ -> one or more digits (0-9)
#   $      -> end of string
# ! negates the condition, so this is true if input is NOT a number
# [ "$PASS_LENGTH" -le 0 ] checks that the number is greater than 0

# -------------------------------------------------
# Generate the password
# -------------------------------------------------
openssl rand -base64 $((PASS_LENGTH * 3 / 4 + 1)) | cut -c1-$PASS_LENGTH
# openssl rand -base64 generates random bytes and encodes them in base64
# $((PASS_LENGTH * 3 / 4 + 1)) calculates the number of bytes needed
#   because Base64 expands bytes to characters (~4 chars per 3 bytes)
# cut -c1-$PASS_LENGTH trims the password to the exact requested length
# Thank you 


