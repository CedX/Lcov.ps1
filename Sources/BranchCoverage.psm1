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

<#
.SYNOPSIS
	Provides details for branch coverage.
#>
[NoRunspaceAffinity()]
class BranchData {

	<#
	.SYNOPSIS
		The block number.
	#>
	[ValidateRange("NonNegative")]
	[int] $BlockNumber

	<#
	.SYNOPSIS
		The branch number.
	#>
	[ValidateRange("NonNegative")]
	[int] $BranchNumber

	<#
	.SYNOPSIS
		The line number.
	#>
	[ValidateRange("NonNegative")]
	[int] $LineNumber

	<#
	.SYNOPSIS
		A number indicating how often this branch was taken.
	#>
	[ValidateRange("NonNegative")]
	[int] $Taken

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$value = "$([Tokens]::BranchData):$($this.LineNumber),$($this.BlockNumber),$($this.BranchNumber)"
		return $this.Taken ? "$value,$($this.Taken)" : "$value,-"
	}
}
