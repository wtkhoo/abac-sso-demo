# EC2 for Research
resource "aws_instance" "alice" {
  ami                    = data.aws_ssm_parameter.aml_latest_ami.value
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id

  tags = {
    Name = "${var.name}-Alice",
    Department = "Research"
  }
}

# EC2 for Security
resource "aws_instance" "bob" {
  ami                    = data.aws_ssm_parameter.aml_latest_ami.value
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id

  tags = {
    Name = "${var.name}-Bob",
    Department = "Security"
  }
}