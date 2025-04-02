variable "tenancy_ocid" {
  type        = string
  description = "The OCID of your tenancy"
}

variable "user_ocid" {
  type        = string
  description = "The OCID of the user calling the API"
}

variable "fingerprint" {
  type        = string
  description = "The fingerprint for the user public key in OCI"
}

variable "private_key_path" {
  type        = string
  description = "Path to your private key for OCI API signing"
}

variable "region" {
  type        = string
  description = "OCI region to use (e.g., 'us-ashburn-1')"
}

variable "compartment_ocid" {
  type        = string
  description = "OCID of the compartment in which to create resources"
}

variable "availability_domain" {
  type        = string
  description = "The availability domain where the instance will launch"
}

variable "subnet_ocid" {
  type        = string
  description = "The OCID of the subnet where the instance's VNIC will reside"
}

variable "instance_shape" {
  type        = string
  description = "Shape of the instance (e.g., VM.Standard.E3.Flex)"
}

variable "image_ocid" {
  type        = string
  description = "OCID of the image to use for the instance"
}

variable "instance_display_name" {
  type        = string
  description = "A friendly name for the instance"
  default     = "example-terraform-instance"
}

variable "hostname_label" {
  type        = string
  description = "Hostname for the instance"
  default     = "example-host"
}

variable "ssh_public_key" {
  type        = string
  description = "Path to your SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}
