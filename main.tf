module "vpc" {
    source = "./modules/vpc"
    appln_server_1_id = module.application.appln_server_1_id
    appln_server_2_id = module.application.appln_server_2_id
}

module "application" {
    source = "./modules/application"
    pub_subnet_1_id = module.vpc.pub_subnet_1_id
    pub_subnet_2_id = module.vpc.pub_subnet_2_id
    vpc_id = module.vpc.vpc_id
}

module "database" {
    source = "./modules/database"
    vpc_id = module.vpc.vpc_id
    pvt_subnet_1_id = module.vpc.pvt_subnet_1_id
    pvt_subnet_2_id = module.vpc.pvt_subnet_2_id
    user = var.db_user
    password = var.db_passsword
}

