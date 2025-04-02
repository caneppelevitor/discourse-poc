output "instance_ocid" {
  description = "The OCID of the created instance"
  value       = oci_core_instance.example.id
}

output "public_ip" {
  description = "The public IP of the instance"
  value = oci_core_instance.example.public_ip
}
