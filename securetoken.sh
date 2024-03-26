#!/bin/bash

# Function to hash a string using SHA256
sha256_hash() {
    local input="$1"
    echo -n "$input" | openssl dgst -sha256 -binary | base64
}

# Function to sanitize base64 output
sanitize_base64() {
    local input="$1"
    local sanitized="${input//\//_}"  # replace / with _
    sanitized="${sanitized//+/=}"       # replace + with =
    sanitized="${sanitized//-/}"        # remove -
    echo "$sanitized"
}

# Main function
main() {
    customSHAHash="$1"  # Assuming you pass the string to hash as a command line argument
    preHashName="$customSHAHash"

    # Hash the string using SHA256
    hash="$(sha256_hash "$preHashName")"

    # Sanitize and encode the hash
    sanitized_hash="$(sanitize_base64 "$hash")"
    echo "$sanitized_hash"
}

# Run the main function
main "$@"

