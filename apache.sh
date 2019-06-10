#!/bin/bash
      yum install httpd -y
      service httpd restart
      echo "<h1> deployed by tera </h1>" > /var/www/html/index.html
