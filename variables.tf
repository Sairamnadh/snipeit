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
  default     = data.github_repository_file.ssh_private.content
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkPNYn0qnlZrTbe9aKiuOsUOj/wQOqj9lqyXMZn7siX6n+6fyBquzzOAEfbgP1mDi7Rtkf7yARFw4/I84M6tj6GrAALZTyo2QRZvoXgyHxkpAwwxscu0bW/IBpVU5DFkPC82sQ7BLghX0A3aqDf5Tosby7bSjlcuzKy3O76EJWp8X+7SuRYj83cGl2BNY2CijSMcQA6L+p5LLZALTxRq1SLAdrHgi5gXm9PfZQwLGarrRDrJx/shCcDrFEOpgOLYAJ767OXu0xmlE2ZJYArLx39SwyZWseNtmARUiiMkzR1Z4dHnUZ4cg50HvgJDEJyyO5LH3X8Sw/qsB7meXoACUqLIt3YB8ZMPPSS1bu8cV+1kxeV7wVOF03xs50A5MMTTlwmbuyqwpczPN9C/Wg0jsPmcF4MzDxsY1Mn6/PN/ErKPfxaQsccrAdJyfySxIrYzo5zBVuQDQ05tAlpJjT36qlrl3kqRkVOUEjIY+rAiidN9dwvYDSOknTmXX79bVwQLk= generated-by-azure"
}
