using module ./BranchCoverage.psm1
using module ./FunctionCoverage.psm1
using module ./LineCoverage.psm1
using module ./Report.psm1
using module ./SourceFile.psm1

<#
.SYNOPSIS
	Converts the contents of a LCOV info file into a `Report` object.
.INPUTS
	The path to the LCOV file to convert.
.OUTPUTS
	The report corresponding to the specified LCOV file.
#>
function ConvertFrom-LcovInfo {
	[CmdletBinding(DefaultParameterSetName = "Path")]
	[OutputType([Report])]
	param (
		# The path to the LCOV file to convert.
		[Parameter(Mandatory, ParameterSetName = "Path", Position = 0, ValueFromPipeline)]
		[SupportsWildcards()]
		[string[]] $Path,

		# The path to the LCOV file to convert.
		[Parameter(Mandatory, ParameterSetName = "LiteralPath")]
		[ValidateScript({ Test-Path $_ -IsValid }, ErrorMessage = "The specified literal path is invalid.")]
		[string[]] $LiteralPath,

		# A pattern used to filter the list of files to be processed.
		[string] $Filter = "",

		# Value indicating whether to process the input path recursively.
		[switch] $Recurse
	)

	process {
		$parameters = @{ File = $true; Recurse = $Recurse }
		if ($Filter) { $parameters.Filter = $Filter }

		$files = $PSCmdlet.ParameterSetName -eq "LiteralPath" ? (Get-ChildItem -LiteralPath $LiteralPath @parameters) : (Get-ChildItem $Path @parameters)
		foreach ($file in $files) {
			try { [Report]::Parse((Get-Content $file.FullName -Raw)) }
			catch [FormatException] { Write-Error $_.Exception }
		}
	}
}

<#
.SYNOPSIS
	Creates a new branch coverage.
.OUTPUTS
	The newly created branch coverage.
#>
function New-LcovBranchCoverage {
	[CmdletBinding()]
	[OutputType([BranchCoverage])]
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

	[BranchCoverage]@{
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
function New-LcovBranchData {
	[CmdletBinding()]
	[OutputType([BranchData])]
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

	[BranchData]@{
		BlockNumber = $BlockNumber
		BranchNumber = $BranchNumber
		LineNumber = $LineNumber
		Taken = $Taken
	}
}

<#
.SYNOPSIS
	Creates a new function coverage.
.OUTPUTS
	The newly created function coverage.
#>
function New-LcovFunctionCoverage {
	[CmdletBinding()]
	[OutputType([FunctionCoverage])]
	param (
		# The coverage data.
		[ValidateNotNull()]
		[FunctionData[]] $Data = @(),

		# The number of functions found.
		[ValidateRange("NonNegative")]
		[int] $Found,

		# The number of functions hit.
		[ValidateRange("NonNegative")]
		[int] $Hit
	)

	[FunctionCoverage]@{
		Data = $Data
		Found = $Found
		Hit = $Hit
	}
}

<#
.SYNOPSIS
	Creates new function data.
.OUTPUTS
	The newly created function data.
#>
function New-LcovFunctionData {
	[CmdletBinding()]
	[OutputType([FunctionData])]
	param (
		# The function name.
		[Parameter(Mandatory, Position = 0)]
		[string] $FunctionName,

		# The execution count.
		[ValidateRange("NonNegative")]
		[int] $ExecutionCount,

		# The line number of the function start.
		[ValidateRange("NonNegative")]
		[int] $LineNumber
	)

	[FunctionData]@{
		ExecutionCount = $ExecutionCount
		FunctionName = $FunctionName
		LineNumber = $LineNumber
	}
}

<#
.SYNOPSIS
	Creates a new line coverage.
.OUTPUTS
	The newly created line coverage.
#>
function New-LcovLineCoverage {
	[CmdletBinding()]
	[OutputType([LineCoverage])]
	param (
		# The coverage data.
		[ValidateNotNull()]
		[LineData[]] $Data = @(),

		# The number of lines found.
		[ValidateRange("NonNegative")]
		[int] $Found,

		# The number of lines hit.
		[ValidateRange("NonNegative")]
		[int] $Hit
	)

	[LineCoverage]@{
		Data = $Data
		Found = $Found
		Hit = $Hit
	}
}

<#
.SYNOPSIS
	Creates new line data.
.OUTPUTS
	The newly created line data.
#>
function New-LcovLineData {
	[CmdletBinding()]
	[OutputType([LineData])]
	param (
		# The data checksum.
		[ValidateNotNull()]
		[string] $Checksum = "",

		# The execution count.
		[ValidateRange("NonNegative")]
		[int] $ExecutionCount,

		# The line number.
		[ValidateRange("NonNegative")]
		[int] $LineNumber
	)

	[LineData]@{
		Checksum = $Checksum
		ExecutionCount = $ExecutionCount
		LineNumber = $LineNumber
	}
}

<#
.SYNOPSIS
	Creates a new report.
.OUTPUTS
	The newly created report.
#>
function New-LcovReport {
	[CmdletBinding()]
	[OutputType([Report])]
	param (
		# The test name.
		[Parameter(Mandatory, Position = 0)]
		[string] $TestName,

		# The source file list.
		[Parameter(Position = 1)]
		[ValidateNotNull()]
		[SourceFile[]] $SourceFiles = @()
	)

	[Report]::new($TestName, $SourceFiles)
}

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
