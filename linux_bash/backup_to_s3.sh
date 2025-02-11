#!/bin/bash
set -e

s3_bucket=bucket_name

target_folder=folder_name

# Get the current date in the format YYYY-MM-DD
current_date=prefix-$(date +'%Y-%m-%d')

# change to temp directory
cd ..

# Zip the folder
# optionally use 'zip -r -e' to encrypt the zip file
zip -r "$current_date.zip" "$target_folder"

# copy to s3
aws s3 cp "$current_date.zip" "s3://$s3_bucket"

# Remove the unzipped folder
rm -rf "$current_date.zip"

s3_url=$(aws s3 presign "s3://$s3_bucket/$current_date.zip")

# Print a message indicating the process is complete
echo "Backup Complete"
echo "S3 Download URL : $s3_url"