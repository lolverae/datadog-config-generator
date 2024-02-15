$AssetID = "123"
$ServerType = "WebServer"
$TeamName = "Team1"
$EnvType = "NonProd"
$EnvironmentName = "Env1"
$Region = "Region"
$Hostname = "Host"

$TargetConfig = (Join-Path $ENV:ProgramData 'Datadog/datadog.yaml')
$Services = [pscustomobject]@{
    'instances' = @(
        [ordered]@{
            'hostname' = $Hostname
            'hostname_fqdn' = $true
            'tags'                       = @(
                "Team:$TeamName"
                "Application_insight_id:$AssetID"
                "Type:$ServerType"
                "environment_type:$EnvType"
                "env:$EnvironmentName"
                "Region:$Region"
            )

            'cmd_port' = 5555
            'gui_port' = 5552
            
            'process_config' = 
              @{
              'process_collection' = @{
                'enabled' = $true
              }}
            
        }
    )
}

$Services | ConvertTo-Json -Depth 100 | &'C:\tools\yq.exe' eval - --prettyPrint | Out-File $TargetConfig -Encoding UTF8

