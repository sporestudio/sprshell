#!/bin/bash

#!/bin/bash

# Define colors for output
yellowColour='\033[1;33m'
greenColour='\033[0;32m'
redColour='\033[0;31m'
endColour='\033[0m'

# Function to check if gcc is installed
function check_dependencies() {
	echo -e "${yellowColour}[*]${endColour}${yellowColour} Checking if gcc is installed...${endColour}"
	if command -v gcc >/dev/null 2>&1; then
		echo -e "${greenColour}[+]${endColour}${yellowColour} gcc is installed.${endColour}"
	else
		echo -e "${redColour}[!]${endColour}${yellowColour} gcc is not installed. Installing gcc...${endColour}"
		# Check if the package manager is available and install gcc
		if command -v pacman >/dev/null 2>&1; then
			sudo pacman -S --noconfirm gcc
		elif command -v apt >/dev/null 2>&1; then
			sudo apt update && sudo apt install -y gcc
		elif command -v dnf >/dev/null 2>&1; then
			sudo dnf install -y gcc
		elif command -v yum >/dev/null 2>&1; then
			sudo yum install -y gcc
		elif command -v zypper >/dev/null 2>&1; then
			sudo zypper install -y gcc
		elif command -v pacman >/dev/null 2>&1; then
			sudo pacman -S --noconfirm gcc
		else
			echo -e "${redColour}[!]${endColour}${yellowColour} No known package manager found. Please install gcc manually.${endColour}"
			exit 1
		fi
	fi
}

# Function to compile the C program
function compile_program() {
	echo -e "${yellowColour}[*]${endColour}${yellowColour} Compiling the C program...${endColour}"
	gcc -o sprshell src/main.c
	if [ $? -eq 0 ]; then
		echo -e "${greenColour}[+]${endColour}${yellowColour} Compilation successful.${endColour}"
	else
		echo -e "${redColour}[!]${endColour}${yellowColour} Compilation failed.${endColour}"
		exit 1
	fi
}

# Function to execute the compiled program
function execute_program() {
	echo -e "${yellowColour}[*]${endColour}${yellowColour} Executing the program...${endColour}"
	./sprshell
}

# Main function
function main() {
	# Check if running as root
	if [ "$(id -u)" -ne "0" ]; then
		echo -e "${redColour}[!]${endColour}${yellowColour} You need to run this script as root.${endColour}"
		exit 1
	fi

	# Call the functions
	check_dependencies
	compile_program
	execute_program
}

# Execute the main function
main
