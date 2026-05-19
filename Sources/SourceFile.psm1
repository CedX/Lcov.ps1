using namespace System.Collections.Generic
using module ./BranchCoverage.psm1
using module ./FunctionCoverage.psm1
using module ./LineCoverage.psm1
using module ./Tokens.psm1

<#
.SYNOPSIS
	Provides the coverage data of a source file.
#>
[NoRunspaceAffinity()]
class SourceFile {

	<#
	.SYNOPSIS
		The branch coverage.
	#>
	[BranchCoverage] $Branches

	<#
	.SYNOPSIS
		The function coverage.
	#>
	[FunctionCoverage] $Functions

	<#
	.SYNOPSIS
		The line coverage.
	#>
	[LineCoverage] $Lines

	<#
	.SYNOPSIS
		The path to the source file.
	#>
	[ValidateNotNull()]
	[string] $Path

	<#
	.SYNOPSIS
		Creates a new source file.
	.PARAMETER Path
		The path to the source file.
	#>
	SourceFile([string] $Path) {
		$this.Path = $Path
	}

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		[List[string]] $output = , "$([Tokens]::SourceFile):$($this.Path)"
		if ($this.Functions) { $output.Add($this.Functions) }
		if ($this.Branches) { $output.Add($this.Branches) }
		if ($this.Lines) { $output.Add($this.Lines) }
		$output.Add([Tokens]::EndOfRecord)
		return $output -join "`n"
	}
}
