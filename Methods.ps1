#Created methods to pass multi pipeline parameters
#Methods, Function, Variables, Pipeline#
function Create-Configuration{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Verison="1.0.0",
        [Parameter(Mandatory)]
        [string]$Path,
        [parameter(ValueFromPipelineByPropertyName)]
        [Validateset('Linux','Windows')]
        [string]$OperatingSystem="Windows"

    )

    begin{
        Write-Verbose "Begin Block"
        $CounterPassed=0
        $CounterFailed=0

    }

    Process{
        try{
            Write-Verbose "Creating configuration for $Name with Version $Version"
            New-Item -Path $Path -Name "$($Name).cfg" -ItemType File -ErrorAction stop
            #New-Item -Path "C:\Scripts\Methods\Configs" -Name "$($Name).cfg" -ItemType File
            $Verison | Out-File -Filepath "$Path\$($Name).cfg" -Force
            $OperatingSystem | Out-File -Filepath "$Path\$($Name).cfg" -Append -Force
            $CounterPassed++
        }catch{
            Write-Output $_.Exception.Message
            Write-Verbose "Failed Creating Config for $Name"
            $CounterFailed++
        
        }
        Write-Debug "Configuration created : $CounterPassed"
        Write-Debug "Configuration created : $CounterFailed"
    }


    end{
        Write-Verbose "End Block"
        Write-Output "Configuration created: $CounterPassed , Configuration failed: $CounterFailed"
    }
}

$configPath="C:\Scripts\Methods\Configs"

#Create-Configuration -Name "TestConfig0" -Version"1.0.1" -OperatingSystem "Linux"  -Path $configPath

#configPath="C:\Scripts\Methods\Configs"
#$configPath="C:\Scripts\Methods\Configs"

#New-item -Path $configPath -Name "TestConfig1.cfg" -ItemType File
#New-item -Path $configPath -Name "TestConfig2.cfg" -ItemType File


#$Names=('TestConfig1','Testconfig2','Testconfig3','TestConfig4')
#$Names | Create-Configuration -Path $configPath -Verbose -Debug

$IISServer = New-Object -TypeName PSCustomObject
Add-Member -InputObject $IISServer -MemberType NoteProperty -Name "Name" -Value "IIServer2022"
Add-Member -InputObject $IISServer -MemberType NoteProperty -Name "Version" -Value "1.0.3"
Add-Member -InputObject $IISServer -MemberType NoteProperty -Name "OperatingSystem" -Value "Windows"

$IISServer | Create-Configuration -Path $configPath

$Servers=Import-Csv -Path "C:\Scripts\Methods\Configs\servers.csv" -Delimiter ','

$Servers | Create-Configuration -Path $configPath -Verbose