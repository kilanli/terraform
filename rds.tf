resource "aws_db_instance" "default" {
    allocated_storage = 10
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t3.micro"
    db_name = "mydb"
    username = "erdem"
    password = "kilanli"
    parameter_group_name = "default.mysql.5.7"
    skip_final_snapshot = true
    vpc_security_group_ids = ["${aws_security_group.tf-devops.id}"]
    db_subnet_group_name = aws_db_subnet_group.default.name
    publicly_accessible = true
}
resource "aws_db_subnet_group" "default" {
  name = "terra-db-subnet"
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]]
  tags = {
    name="my db subnet group"
  }
}
