variable "username" {
  default = "saikey"

}

variable "vmname" {
  default = "snipeitmechine"

}
variable "password" {
  type    = string
  default = "Sai123@"

}
variable "ssh_private_key" {
  description = "ssh private key content"
  type        = string
  default     = <<EOF
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----

EOF
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkPNYn0qnlZrTbe9aKiuOsUOj/wQOqj9lqyXMZn7siX6n+6fyBquzzOAEfbgP1mDi7Rtkf7yARFw4/I84M6tj6GrAALZTyo2QRZvoXgyHxkpAwwxscu0bW/IBpVU5DFkPC82sQ7BLghX0A3aqDf5Tosby7bSjlcuzKy3O76EJWp8X+7SuRYj83cGl2BNY2CijSMcQA6L+p5LLZALTxRq1SLAdrHgi5gXm9PfZQwLGarrRDrJx/shCcDrFEOpgOLYAJ767OXu0xmlE2ZJYArLx39SwyZWseNtmARUiiMkzR1Z4dHnUZ4cg50HvgJDEJyyO5LH3X8Sw/qsB7meXoACUqLIt3YB8ZMPPSS1bu8cV+1kxeV7wVOF03xs50A5MMTTlwmbuyqwpczPN9C/Wg0jsPmcF4MzDxsY1Mn6/PN/ErKPfxaQsccrAdJyfySxIrYzo5zBVuQDQ05tAlpJjT36qlrl3kqRkVOUEjIY+rAiidN9dwvYDSOknTmXX79bVwQLk= generated-by-azure"
}
