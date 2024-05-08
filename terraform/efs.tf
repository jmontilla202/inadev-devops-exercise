resource "aws_efs_file_system" "efs" {
   creation_token = "efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = "EFS"
   }
 }


resource "aws_efs_mount_target" "efs-mt1" {
#    count = length(data.aws_availability_zones.available.names)
#    count = 2
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = module.vpc.private_subnets[0]
   security_groups = [aws_security_group.efs.id]
 }

resource "aws_efs_mount_target" "efs-mt2" {
#    count = length(data.aws_availability_zones.available.names)
#    count = 2
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = module.vpc.private_subnets[1]
   security_groups = [aws_security_group.efs.id]
 }

resource "aws_security_group" "efs" {
   name = "efs-sg"
   description= "Allos inbound efs traffic from ec2"
   vpc_id = module.vpc.vpc_id

   ingress {
    #  security_groups = [aws_security_group.ec2.id]
     cidr_blocks         = ["172.27.0.0/16"]
     from_port = 2049
     to_port = 2049 
     protocol = "tcp"
   }     
        
   egress {
    #  security_groups = [aws_security_group.ec2.id]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }
 }