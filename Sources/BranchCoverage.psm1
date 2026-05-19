using module ./BranchData.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of branches.
#>
class BranchCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[ValidateNotNull()]
	[BranchData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of branches found.
	#>
	[ValidateRange("NonNegative")]
	[int] $Found

	<#
	.SYNOPSIS
		The number of branches hit.
	#>
	[ValidateRange("NonNegative")]
	[int] $Hit

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		return @(
			$this.Data.ForEach{ [string] $_ }
			"$([Tokens]::BranchesFound):$($this.Found)"
			"$([Tokens]::BranchesHit):$($this.Hit)"
		) -join "`n"
	}
}
