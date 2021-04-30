Param(
  $groupname
)

Get-LocalGroupMember -Group $groupname | ConvertTo-Json
