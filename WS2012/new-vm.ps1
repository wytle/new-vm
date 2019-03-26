$vms = import-csv -path "D:\axiu\Desktop\2019\VM POWERCLI\new-vm\WS2012\windows2012.csv"
foreach ($vm in $vms){
      $VMName = $vm.name
      $VMHost = $vm.host
      $Datastore = $vm.datastore
      $Template = $vm.template
      $Customization = $vm.customization
      $IPAddress = $vm.ipaddress
      $Subnetmask = $vm.subnetmask
      $DefaultGW = $vm.defaultgw
      $DNS1 = $vm.dns1
      $DNS2 = $vm.dns2
      $VLAN = $vm.vlan
      $Memory = $vm.mem
      $CPU = $vm.cpu
      $ResourcePool = $vm.resourcepool
      $osname = $vm.name
      $disktype = $vm.disktype
      $domain = $vm.domain
    Get-OSCustomizationNicMapping -Spec $Customization | Set-OSCustomizationNicMapping -IpMode UseStaticIP -IpAddress $IPAddress -SubnetMask $Subnetmask -DefaultGateway $DefaultGW -Dns $DNS1
    New-VM -Name $VMName -OSCustomizationSpec $Customization -Template $Template -VMHost $VMHost -DiskStorageFormat $disktype -Datastore $Datastore -ResourcePool $ResourcePool | Set-VM -NumCpu $CPU -MemoryMB $Memory -Confirm:$false -RunAsync 
    Get-VM -Name $VMName | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $VLAN -Confirm:$false
    Start-VM -VM $VMName -RunAsync
    }