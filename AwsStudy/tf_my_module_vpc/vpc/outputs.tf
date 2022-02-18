output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_name" {
    value = aws_vpc.vpc.tags["Name"]
}