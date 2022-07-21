region = {
  "dev" = "ap-south-1"
}
product = "MyStone"
environment = {
dev = {
    region = "ap-south-1"
    azs = [
        "ap-south-1a",
        "ap-south-1b",
        "ap-south-1c"
    ]

    vpc_conf = {
        vpc_cidr_block = "10.0.0.0/16"
        public_subnet_cidrs = ["10.0.0.0/24" , "10.0.4.0/24"]
        private_subnet_cidrs = ["10.0.1.0/24"]
        database_subnet_cidrs = ["10.0.2.0/24" , "10.0.3.0/24"]
    }
}

}
