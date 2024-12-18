
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "RDS Subnet Group"
  }
}
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.1.1" 

  identifier = "my-postgres-db"

  engine            = "postgres"
  engine_version    = "14.14"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "ipfs_db"
  username = "ipfs_user"
  password = "ipfs_pass"
  port     = "5432"

  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  # Replace subnet_ids with db_subnet_group_name
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  family     = "postgres14"
  major_engine_version = "14"

  deletion_protection = false
}
