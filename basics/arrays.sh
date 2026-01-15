#!/bin/bash
# arrays.sh
# Practice script demonstrating Bash array basics:
# indexing, expansion, length, looping, and modification

# Define a simple indexed array
my_array=( a b c )

# Print value at index 1
echo ${my_array[1]}

# Print all items in the array
# @ and * both expand to all elements (difference matters when quoted)
echo ${my_array[@]}
echo ${my_array[*]}

# Print all index positions (keys) of the array
echo ${!my_array[@]}

# Print the number of elements in the array
echo ${#my_array[@]}

# Loop over array indexes and print index + value
for i in "${!my_array[@]}"
do
        echo "$i" "${my_array[$i]}"
done

# Loop over array values only (no indexes)
for i in "${my_array[@]}"
do
        echo "$i"
done

# Add a value at a specific index
# Using index 9 to demonstrate sparse arrays
my_array[9]=d
echo ${my_array[@]}
echo ${my_array[9]}

# Append values to the array using the next available indexes
my_array+=( e f )

# Loop again to show updated indexes and values
for i in "${!my_array[@]}"
do
        echo "$i" "${my_array[$i]}"
done

