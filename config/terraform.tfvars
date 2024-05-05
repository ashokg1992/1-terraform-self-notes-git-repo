vpc_config = {
    vpc01 = {
        vpc_cidr_block = "192.168.0.0./16"
        tags = {
            "name" = "my_vpc"

        }
    }
}

subnet_config = {
    "public_us_east_1a" = {

    cir_block = "192.168.0.0./18"
    availability_zone = "us_east_1a"
    tags = {
        name = "public_us_east_1a "
    }
    }

    "public_us_east_1b" = {

    cir_block = "192.168.0.0./18"
    availability_zone = "us_east_1a"
    tags = {
        name = "public_us_east_1b "
    }
    }


    "public_us_east_1a" = {

    cir_block = "192.168.0.0./18"
    availability_zone = "us_east_1a"
    tags = {
        name = "public_us_east_1a "
    }
}
}