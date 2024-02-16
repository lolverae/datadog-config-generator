$AssetID = "123"
$TeamName = "Team1"
$EnvironmentName = "Env1"
$Hostname = "Host"
$ServerTypes = @("WebServer1", "WebServer2", "WebServer3")
$EnvTypes = @("NonProd", "Prod", "Test")
$Regions = @("Region1", "Region2", "Region3")

function Create-DataDogConfig {
    param(
        [string]$Hostname,
        [string]$TeamName,
        [string]$AssetID,
        [string[]]$ServerTypes,
        [string[]]$EnvTypes,
        [string[]]$Regions,
        [string]$EnvironmentName
    )

    $TargetConfig = Join-Path $env:ProgramData 'Datadog/datadog.yaml'
    
    $Services = [pscustomobject]@{
        'instances' = @(
            [ordered]@{
                'hostname' = $Hostname
                'hostname_fqdn' = $true
                'tags' = @(
                    "Team:$TeamName",
                    "Application_insight_id:$AssetID",
                    "Type:$ServerType",
                    "environment_type:$EnvType",
                    "env:$EnvironmentName",
                    "Region:$Region"
                )
                'cmd_port' = 5555
                'gui_port' = 5552
                'process_config' = @{
                    'process_collection' = @{
                        'enabled' = $true
                    }
                }
            }
        )
    }

    $Services | ConvertTo-Json -Depth 100 | & 'C:\tools\yq.exe' eval - --prettyPrint | Out-File $TargetConfig -Encoding UTF8
}

Update-DataDogConfig -Hostname "example-host" -TeamName "example-team" -AssetID "example-id" -ServerType "WebServer" -EnvType "NonProd" -EnvironmentName "ExampleEnv" -Region "ExampleRegion"

