data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.1.1"

    name = "${var.vpc_name}"
    cidr = "${var.vpc_cidr}"

    azs = "${data.aws_availability_zones.available.names}"
    private_subnets = "${var.vpc_private_subnets}"
    public_subnets = "${var.vpc_public_subnets}"

    enable_dns_hostnames = true
    enable_dns_support = true

    map_public_ip_on_launch = true
    enable_nat_gateway = true
    single_nat_gateway = true
    one_nat_gateway_per_az = false

    public_subnet_tags = {
        "kubernetes.io/role/elb" = 1
        "kubernetes.io/cluster/demo" = "owned"
    }

}