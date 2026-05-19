using module ../LineData.psm1

<#
.SYNOPSIS
	Creates new line data.
.OUTPUTS
	The newly created line data.
#>
function New-LcovLineData {
	[CmdletBinding()]
	[OutputType([LineData])]
	param (
		# The data checksum.
		[ValidateNotNull()]
		[string] $Checksum = "",

		# The execution count.
		[ValidateRange("NonNegative")]
		[int] $ExecutionCount,

		# The line number.
		[ValidateRange("NonNegative")]
		[int] $LineNumber
	)

	[LineData]@{
		Checksum = $Checksum
		ExecutionCount = $ExecutionCount
		LineNumber = $LineNumber
	}
}
