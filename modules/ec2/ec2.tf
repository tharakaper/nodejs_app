resource "aws_instance" "ec2" {
  count = var.instance_count
  ami = var.ami_id

  associate_public_ip_address = var.associate_public_ip_address
  subnet_id = element(tolist(var.subnet_id),count.index)
  iam_instance_profile = var.iam_instance_profile
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = var.security_groups

    tags = merge(
          var.tags,
          {
            Name = "${var.application_name}${var.environment}-${count.index}"
          },
  )

}