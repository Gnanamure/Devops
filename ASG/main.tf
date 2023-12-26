provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}
 
resource "aws_launch_configuration" "example" {
  name = "example_config"
 
  image_id = "ami-079db87dc4c10ac91"  # Specify the AMI ID for your desired image
  instance_type = "t2.micro"          # Specify the instance type
 
  lifecycle {
    create_before_destroy = true
  }
}
 
resource "aws_autoscaling_group" "example" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
 
  launch_configuration = aws_launch_configuration.example.id
vpc_zone_identifier  = ["subnet-0f47866458c7df6b1", "subnet-0b5df3a1c70240222"]  # Specify your subnet IDs
 
  health_check_type    = "EC2"
  health_check_grace_period = 300
 
  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }
 
  lifecycle {
    create_before_destroy = true
  }
}
 