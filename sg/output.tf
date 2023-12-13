output "security_groups" {
  value = aws_security_group.allow_access_to_instance.id
}