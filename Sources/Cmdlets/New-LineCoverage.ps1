using module ../LineCoverage.psm1

<#
.SYNOPSIS
	Creates a new line coverage.
.OUTPUTS
	The newly created line coverage.
#>
function New-LcovLineCoverage {
	[CmdletBinding()]
	[OutputType([LineCoverage])]
	param (
		# The coverage data.
		[ValidateNotNull()]
		[LineData[]] $Data = @(),

		# The number of lines found.
		[ValidateRange("NonNegative")]
		[int] $Found,

		# The number of lines hit.
		[ValidateRange("NonNegative")]
		[int] $Hit
	)

	[LineCoverage]@{
		Data = $Data
		Found = $Found
		Hit = $Hit
	}
}

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
