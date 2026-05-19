using module ../Report.psm1
using module ../SourceFile.psm1

<#
.SYNOPSIS
	Creates a new report.
.OUTPUTS
	The newly created report.
#>
function New-LcovReport {
	[CmdletBinding()]
	[OutputType([Report])]
	param (
		# The test name.
		[Parameter(Mandatory, Position = 0)]
		[string] $TestName,

		# The source file list.
		[Parameter(Position = 1)]
		[ValidateNotNull()]
		[SourceFile[]] $SourceFiles = @()
	)

	[Report]::new($TestName, $SourceFiles)
}
