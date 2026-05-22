using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of lines.
#>
class LineCoverage {

	<#
	.SYNOPSIS
		The coverage data.
	#>
	[ValidateNotNull()]
	[LineData[]] $Data = @()

	<#
	.SYNOPSIS
		The number of lines found.
	#>
	[ValidateRange("NonNegative")]
	[int] $Found

	<#
	.SYNOPSIS
		The number of lines hit.
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
			"$([Tokens]::LinesFound):$($this.Found)"
			"$([Tokens]::LinesHit):$($this.Hit)"
		) -join "`n"
	}
}

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
