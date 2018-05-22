﻿Function Write-SqlObjListToLocalPath{
<#
    .DESCRIPTION
        Takes a well-formatted array of objects from Format-SqlObjectList
        Retrieves & appends the object_id & calls Write-SqlObjectToLocalPath for each
#>
    [cmdletbinding()]Param(
         [parameter(Mandatory=$true)]$objList
    )

    $objList | ForEach-Object {
        $objId  = (Get-SqlObjectID @PSItem -env).ID 
        $object = Get-SqlObject @PSItem -objectId $objId
        
        $isOnDisk = (Write-SqlObjectToLocalPath @object -objectId $objId).IsOnDisk

        Add-Member -MemberType Property -Name ObjectID -Value $objId
        Add-Member -MemberType Property -Name Object   -Value $obj
        Add-Member -MemberType Property -Name IsOnDisk -Value $isOnDisk
    }

}