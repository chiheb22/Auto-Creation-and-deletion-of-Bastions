resource "azurerm_function_app_function" "bastion-snooze-delete" {
  name            = "Delete-Azure-Bastion"
  function_app_id = azurerm_windows_function_app.bastion-snooze.id
  language        = "PowerShell"

  file {
    name          = "run.ps1"
    content       = <<EOT
param($Timer)
$subscriptionName = '${data.azurerm_subscription.current.display_name}'
Set-AzContext -Subscription $subscriptionName
if (-not $env:BASTION_RG) {
    Write-Error "Please ensure the BASTION_RG environment variable is set."
    exit
}
$bastions = Get-AzBastion -ResourceGroupName $env:BASTION_RG
if ($bastions -and $bastions.Count -gt 0) {
    foreach ($bastion in $bastions) {
        Write-Output "Removing Bastion Host: $($bastion.Name) from Resource Group: $env:BASTION_RG"
        Remove-AzBastion -Name $bastion.Name -ResourceGroupName $env:BASTION_RG -Force
    }
    Write-Output "All Bastion hosts in the resource group have been removed."
} else {
    Write-Output "No Bastion hosts found in the resource group $env:BASTION_RG."
}
EOT
  }

  config_json = jsonencode({
    "bindings" = [
      {
        "direction" = "in"
        "name" = "Timer"
        "type" = "timerTrigger"
        "schedule" : "${var.DeleteSchedule}"
      }
    ]
  })
}