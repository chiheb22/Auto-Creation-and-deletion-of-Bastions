variable "ServiceName" {
  type     = string
  description = "The name of all resources referring to the service name."
  default = "bstsnooze"
}
variable "Location" {
  type    = string
  description = "Resource location"
  default = "westeurope"
}
variable "EnvironmentPrefix" {
  type     = string
  description = "The prefix of all resources referring to environment type. Choose p for production, t for testing and a for acceptance. Only 1 character."
  default = "t"
}
variable "Timezone" {
  type     = string
  description = "The timezone in which the Azure Function acts and uses for its time schedule."
  default = "Central European Standard Time"
}
variable "DeleteSchedule" {
  type     = string
  description = "Schedule for deleting the Bastion Host (NCRONTAB expression). {second} {minute} {hour} {day} {month} {day-of-week}"
  default = "0 0 18 * * 1-5"
}
variable "BastionResourceGroup" {
  type     = string
  description = "The name of the Bastion Host Resource Group."
  default = "app-rg"
}
variable "SubscriptionId" {
  type     = string
  description = "The subscription id of the Azure subscription."
  default = "5b07a1bf-3f42-47f7-8a53-85d5b7796157"
}
