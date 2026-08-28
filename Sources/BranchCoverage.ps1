using namespace Belin.Lcov

<#
.SYNOPSIS
	Creates a new branch coverage.
.OUTPUTS
	The newly created branch coverage.
#>
function New-BranchCoverage {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.BranchCoverage])]
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

	return [BranchCoverage]@{
		Data = $Data
		Found = $Found
		Hit = $Hit
	}
}

<#
.SYNOPSIS
	Creates new branch data.
.OUTPUTS
	The newly created branch data.
#>
function New-BranchData {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.BranchData])]
	param (
		# The block number.
		[ValidateRange("NonNegative")]
		[int] $BlockNumber,

		# The branch number.
		[ValidateRange("NonNegative")]
		[int] $BranchNumber,

		# The line number.
		[ValidateRange("NonNegative")]
		[int] $LineNumber,

		# A number indicating how often this branch was taken.
		[ValidateRange("NonNegative")]
		[int] $Taken
	)

	return [BranchData]@{
		BlockNumber = $BlockNumber
		BranchNumber = $BranchNumber
		LineNumber = $LineNumber
		Taken = $Taken
	}
}
