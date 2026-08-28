using namespace Belin.Lcov

<#
.SYNOPSIS
	Creates a new line coverage.
.OUTPUTS
	The newly created line coverage.
#>
function New-LineCoverage {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.LineCoverage])]
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

	return [LineCoverage]@{
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
function New-LineData {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.LineData])]
	param (
		# The data checksum.
		[ValidateNotNull()]
		[string] $Checksum,

		# The execution count.
		[ValidateRange("NonNegative")]
		[int] $ExecutionCount,

		# The line number.
		[ValidateRange("NonNegative")]
		[int] $LineNumber
	)

	return [LineData]@{
		Checksum = $Checksum
		ExecutionCount = $ExecutionCount
		LineNumber = $LineNumber
	}
}
