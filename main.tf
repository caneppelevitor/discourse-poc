resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "poc-vcn"
}

resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "poc-igw"
  is_enabled     = true
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "poc-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

resource "oci_core_subnet" "subnet" {
  cidr_block        = "10.0.0.0/24"
  display_name      = "poc-subnet"
  vcn_id            = oci_core_virtual_network.vcn.id
  compartment_id    = var.compartment_ocid
  route_table_id    = oci_core_route_table.rt.id
  dns_label         = "pocsubnet"
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "poc-security-list"

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}

resource "oci_core_instance" "discourse_vm" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "discourse-poc"
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.subnet.id

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
  }
}

