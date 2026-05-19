<#
.SYNOPSIS
	Provides the list of tokens supported by the parser.
#>
[NoRunspaceAffinity()]
class Tokens {

	<#
	.SYNOPSIS
		The coverage data of a branch.
	#>
	static [string] $BranchData = "BRDA"

	<#
	.SYNOPSIS
		The number of branches found.
	#>
	static [string] $BranchesFound = "BRF"

	<#
	.SYNOPSIS
		The number of branches hit.
	#>
	static [string] $BranchesHit = "BRH"

	<#
	.SYNOPSIS
		The end of a section.
	#>
	static [string] $EndOfRecord = "end_of_record"

	<#
	.SYNOPSIS
		The coverage data of a function.
	#>
	static [string] $FunctionData = "FNDA"

	<#
	.SYNOPSIS
		A function name.
	#>
	static [string] $FunctionName = "FN"

	<#
	.SYNOPSIS
		The number of functions found.
	#>
	static [string] $FunctionsFound = "FNF"

	<#
	.SYNOPSIS
		The number of functions hit.
	#>
	static [string] $FunctionsHit = "FNH"

	<#
	.SYNOPSIS
		The coverage data of a line.
	#>
	static [string] $LineData = "DA"

	<#
	.SYNOPSIS
		The number of lines found.
	#>
	static [string] $LinesFound = "LF"

	<#
	.SYNOPSIS
		The number of lines hit.
	#>
	static [string] $LinesHit = "LH"

	<#
	.SYNOPSIS
		The path to a source file.
	#>
	static [string] $SourceFile = "SF"

	<#
	.SYNOPSIS
		A test name.
	#>
	static [string] $TestName = "TN"
}
