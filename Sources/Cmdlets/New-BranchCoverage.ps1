using module ../BranchCoverage.psm1
using module ../BranchData.psm1

<#
.SYNOPSIS
	Creates a new branch coverage.
.OUTPUTS
	The newly created branch coverage.
#>
function New-LcovBranchCoverage {
	[CmdletBinding()]
	[OutputType([BranchCoverage])]
	param (
		# The coverage data.
		[ValidateNotNull()]
		[BranchData[]] $Data = @(),

		# The number of branches found.
		[ValidateRange("NonNegative")]
		[int] $Found,

		# The number of branches hit.
		[ValidateRange("NonNegative")]
		[int] $Hit
	)

	[BranchCoverage]@{
		Data = $Data
		Found = $Found
		Hit = $Hit
	}
}
