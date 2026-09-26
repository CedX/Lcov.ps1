using namespace Belin.Lcov

<#
.SYNOPSIS
	Creates a new source file.
.OUTPUTS
	The newly created source file.
#>
function New-SourceFile {
	[CmdletBinding(DefaultParameterSetName = "TODO")]
	[OutputType([Belin.Lcov.SourceFile])]
	param (
		# The path to the source file.
		[Parameter(Mandatory, Position = 1)]
		[string] $Path,

		# The branch coverage.
		[Parameter(ParameterSetName = "TODO")]
		[BranchCoverage] $Branches,

		# The function coverage.
		[Parameter(ParameterSetName = "TODO")]
		[FunctionCoverage] $Functions,

		# The line coverage.
		[Parameter(ParameterSetName = "TODO")]
		[LineCoverage] $Lines,

		# Value indicating whether to populate the instance with default coverage values.
		[Parameter(ParameterSetName = "WithCoverage")]
		[switch] $WithCoverage
	)

	$sourceFile = [SourceFile]::new($Path)
	$sourceFile.Branches = $WithCoverage ? (New-BranchCoverage) : $Branches
	$sourceFile.Functions = $WithCoverage ? (New-FunctionCoverage) : $Functions
	$sourceFile.Lines = $WithCoverage ? (New-LineCoverage) : $Lines
	$sourceFile
}
