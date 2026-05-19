using module ./FunctionData.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of functions.
#>
class FunctionCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[ValidateNotNull()]
	[FunctionData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of functions found.
	#>
	[ValidateRange("NonNegative")]
	[int] $Found

	<#
	.SYNOPSIS
		The number of functions hit.
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
			"$([Tokens]::FunctionsFound):$($this.Found)"
			"$([Tokens]::FunctionsHit):$($this.Hit)"
		) -join "`n"
	}
}
