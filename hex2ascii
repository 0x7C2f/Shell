#!/bin/bash/
# Method One
echo '<hex encoded string>' | xxd -r -p
# Method Two
echo 'hello world' | xxd -p
# Method Three
echo 'hello world' | od -t c -t x1
# Method Four
python -c "print bytearray.fromhex('<hex encoded string>')"
