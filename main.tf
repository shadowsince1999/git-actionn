provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "wordpress" {
  ami           = "ami-04a81a99f5ec58529"  
  instance_type = "t2.micro"
  key_name       = "my-keypair"         

  tags = {
    Name = "WordPressInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              yum install -y php php-mysqlnd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from WordPress</h1>" > /var/www/html/index.html
              EOF
}

output "instance_ip" {
  value = aws_instance.wordpress.public_ip
}
