using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides details for line coverage.
#>
[NoRunspaceAffinity()]
class LineData {

	<#
	.SYNOPSIS
		The data checksum.
	#>
	[ValidateNotNull()]
	[string] $Checksum = ""

	<#
	.SYNOPSIS
		The execution count.
	#>
	[ValidateRange("NonNegative")]
	[int] $ExecutionCount

	<#
	.SYNOPSIS
		The line number.
	#>
	[ValidateRange("NonNegative")]
	[int] $LineNumber

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		$value = "$([Tokens]::LineData):$($this.LineNumber),$($this.ExecutionCount)"
		return $this.Checksum ? "$value,$($this.Checksum)" : $value
	}
}
