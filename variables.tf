# Connexion Proxmox

variable "proxmox_api_url" {
  description = "URL de l'API Proxmox (ex: https://192.168.1.50:8006/api2/json)"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "ID du token API Proxmox (ex: root@pam!terraform)"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "Secret du token API Proxmox"
  type        = string
  sensitive   = true
}

variable "tls_insecure" {
  description = "Désactiver la vérification TLS (true en lab, false en prod)"
  type        = bool
  default     = true
}

# Nœud cible

variable "target_node" {
  description = "Nom du nœud Proxmox cible"
  type        = string
  default     = "pve"
}

# Templates

variable "template_linux" {
  description = "Nom du template Debian 12"
  type        = string
  default     = "template-debian-12"
}

variable "template_windows_srv" {
  description = "Nom du template Windows Server 2022"
  type        = string
  default     = "template-ws-2022"
}

variable "template_windows_10" {
  description = "Nom du template Windows 10"
  type        = string
  default     = "template-w10"
}

variable "template_pfsense" {
  description = "Nom du template pfSense"
  type        = string
  default     = "template-pfsense"
}

# Réseau

variable "bridge_wan" {
  description = "Bridge Proxmox côté WAN"
  type        = string
  default     = "vmbr0"
}

variable "bridge_lan" {
  description = "Bridge Proxmox côté LAN"
  type        = string
  default     = "vmbr1"
}

# Ressources RAM

variable "ram_ad" {
  description = "RAM pour le serveur AD (en Mo)"
  type        = number
  default     = 16384 # 16 Go
}

variable "ram_client" {
  description = "RAM pour le client Windows 10 (en Mo)"
  type        = number
  default     = 8192 # 8 Go
}

variable "ram_zabbix" {
  description = "RAM pour le serveur Zabbix (en Mo)"
  type        = number
  default     = 8192 # 8 Go
}

variable "ram_pfsense" {
  description = "RAM pour pfSense (en Mo)"
  type        = number
  default     = 4096 # 4 Go
}

# Cloud-Init

variable "ssh_public_key_path" {
  description = "Chemin absolu vers la clé SSH publique pour Cloud-Init"
  type        = string
}

variable "ci_user" {
  description = "Nom de l'utilisateur Cloud-Init"
  type        = string
  default     = "adminuser"
}

# IPs statiques

variable "zabbix_ip" {
  description = "IP statique du serveur Zabbix (CIDR)"
  type        = string
  default     = "192.168.10.20/24"
}

variable "zabbix_gw" {
  description = "Passerelle par défaut du serveur Zabbix"
  type        = string
  default     = "192.168.10.1"
}
