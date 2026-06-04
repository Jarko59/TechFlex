# 1. FIREWALL & VPN (pfSense)
resource "proxmox_vm_qemu" "pfsense" {
  name        = "TF-FW-PFSENSE"
  target_node = var.target_node
  clone       = var.template_pfsense

  cores  = 1
  memory = var.ram_pfsense
  agent  = 0

  # WAN
  network {
    model  = "virtio"
    bridge = var.bridge_wan
    tag    = -1
  }

  # LAN
  network {
    model  = "virtio"
    bridge = var.bridge_lan
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "10G"
    discard = "on"
  }
}

# 2. WINDOWS SERVER
resource "proxmox_vm_qemu" "srv_ad" {
  name        = "TF-SRV-AD"
  target_node = var.target_node
  clone       = var.template_windows_srv

  cores   = 2
  sockets = 1
  memory  = var.ram_ad
  balloon = 2048
  agent   = 1

  network {
    model  = "virtio"
    bridge = var.bridge_lan
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "40G"
    discard = "on"
  }
}

# 3. MONITORING
resource "proxmox_vm_qemu" "srv_zabbix" {
  name        = "TF-SRV-ZABBIX"
  target_node = var.target_node
  clone       = var.template_linux

  cores  = 2
  memory = var.ram_zabbix
  agent  = 1

  network {
    model  = "virtio"
    bridge = var.bridge_lan
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "20G"
    discard = "on"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=${var.zabbix_ip},gw=${var.zabbix_gw}"

  sshkeys = file(var.ssh_public_key_path)
  ciuser  = var.ci_user
}

# 4. CLIENT TÉLÉTRAVAIL
resource "proxmox_vm_qemu" "cli_win10" {
  name        = "TF-CLI-WIN10"
  target_node = var.target_node
  clone       = var.template_windows_10

  cores   = 2
  memory  = var.ram_client
  balloon = 1024
  agent   = 1

  network {
    model  = "virtio"
    bridge = var.bridge_lan
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "50G"
    discard = "on"
  }
}
