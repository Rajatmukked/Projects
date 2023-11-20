#Select the base image
FROM fedora:39

#install required softwares
RUN dnf update -y
RUN dnf install wget -y
RUN dnf install unzip -y
RUN dnf install httpd -y 

#set wokrdir means cd into that dir and whenerver you get into the container
# your shell will start from this dir
WORKDIR /var/www/html

#download the data
RUN wget https://github.com/Rajatmukked/Website/archive/refs/heads/main.zip
RUN unzip main.zip
RUN cp -r Website-main/* /var/www/html/
RUN rm -rf Website-main main.zip 

# Expose port 80 for accessing the web server
EXPOSE 80

# Start Apache service when the container starts
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
