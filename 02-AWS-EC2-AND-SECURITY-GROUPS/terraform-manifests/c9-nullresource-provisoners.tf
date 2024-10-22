# Create a Null Resource and Provisioners


resource "null_resource" "name" {
  depends_on = [module.public_bastion_server]

  connection {
    host        = aws_eip.bastion_eip.public_ip
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/terraform-key.pem")
  }

  ## File Provisioner

  # Copies the myapp.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  ## Remote Exec Provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }

  ##Local Exec Provisioner

  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> vpc-creation-time.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }






}