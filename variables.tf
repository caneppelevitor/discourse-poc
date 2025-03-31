
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "availability_domain" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "instance_shape" {
  default = "VM.Standard.A1.Flex"
}
variable "image_ocid" {
  description = "Ubuntu 22.04 image OCID for your region"
}

