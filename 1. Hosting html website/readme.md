# Web Server Setup Script

This repository contains a simple Bash script to set up a web server using Apache (httpd) on a Fedora-based system. The script updates the system, installs Apache, downloads a web application from a specified GitHub repository, and starts the Apache service.

## Prerequisites

Before running the script, please make sure you have the following prerequisites in place:

- A Fedora-based system
- Superuser (root) privileges

## Usage


The script will perform the following actions:

Update the system using DNF (dnf update -y).
Install Apache (httpd.x86_64) using DNF (dnf install httpd.x86_64 -y).
Download the web application from the specified GitHub repository.(Your repository)
Extract the downloaded files to the web server's document root (/var/www/html).
Remove the temporary files (main.zip and Website-main).
Start the Apache service using systemctl start httpd.
Enable Apache to start on boot using systemctl enable httpd.
Please note that you should replace the GitHub repository URL in the script with the URL of your web application's repository.

