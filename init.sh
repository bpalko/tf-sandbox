#!/bin/bash

# export AWS_ACCESS_KEY_ID=""
# export AWS_SECRET_ACCESS_KEY=""
# export AWS_REGION=""

# Define the path to your .tfvars file
TFVARS_FILE="./init.tfvars"

# Check if the .tfvars file exists, create it if not
if [ ! -e "$TFVARS_FILE" ]; then
    touch "$TFVARS_FILE"
fi

# Function to write or update a variable in the .tfvars file
write_tfvar() {
    variable_name=$1
    value=$2

    # Check if the variable exists in the .tfvars file
    if grep -q "^$variable_name" "$TFVARS_FILE"; then
        # If the variable exists, update its value
        sed -i "s|^$variable_name.*|$variable_name = \"$(printf "%s" "$value" | sed 's/[&/\]/\\&/g')\"|" "$TFVARS_FILE"
    else
        # If the variable doesn't exist, append it to the file
        echo "$variable_name = \"$value\"" >> "$TFVARS_FILE"
    fi
}

# Check if AWS environment variables are set
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ -z "$AWS_REGION" ]; then
    echo "Error: AWS environment variables are not set."
    echo "Please set AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_REGION."
    exit 1
fi

# Populate variables from environment variables
write_tfvar "aws_access_key" "$AWS_ACCESS_KEY_ID"
write_tfvar "aws_secret_key" "$AWS_SECRET_ACCESS_KEY"
write_tfvar "region" "$AWS_REGION"
# Add more variables as needed

echo "Terraform .tfvars file updated successfully."
