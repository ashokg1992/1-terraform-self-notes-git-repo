module "vpc_modules" {
    source = "./modules/aws_vpc"
    vpc_cidr_block = ""
    tags = ""
    availability_zone =  " "
  
}
module "subnets" {
    source = "./modules/subnets"
    vpc_id = " "
    availability_zone = ""
    tags = " "
    subnet_cidr_block = " "



    
  
}