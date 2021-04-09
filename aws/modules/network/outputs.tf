output "vpc" {
  value = aws_vpc.bluecloud_vpc.id
}
output "sn_windows" {
  value = aws_subnet.user-subnet.id
}
output "sn_velocihelk" {
  value = aws_subnet.server-subnet.id
}
output "sg_velocihelk" {
  value = aws_security_group.bluecloud_velocihelk.id
}
output "sg_windows" {
  value = aws_security_group.bluecloud_windows.id
}
