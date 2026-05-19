using module ../BranchCoverage.psm1
using module ../FunctionCoverage.psm1
using module ../LineCoverage.psm1
using module ../SourceFile.psm1

<#
.SYNOPSIS
	Creates a new source file.
.OUTPUTS
	The newly created source file.
#>
function New-LcovSourceFile {
	[CmdletBinding()]
	[OutputType([SourceFile])]
	param (
		# The path to the source file.
		[Parameter(Mandatory, Position = 0)]
		[string] $Path,

		# The branch coverage.
		[BranchCoverage] $Branches,

		# The function coverage.
		[FunctionCoverage] $Functions,

		# The line coverage.
		[LineCoverage] $Lines
	)

	$sourceFile = [SourceFile] $Path
	$sourceFile.Branches = $Branches
	$sourceFile.Functions = $Functions
	$sourceFile.Lines = $Lines
	$sourceFile
}
