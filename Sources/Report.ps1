using namespace Belin.Lcov

<#
.SYNOPSIS
	Converts the contents of a LCOV info file into a `Report` object.
.INPUTS
	The path to the LCOV file to convert.
.OUTPUTS
	The report corresponding to the specified LCOV file.
#>
function ConvertFrom-Info {
	[CmdletBinding(DefaultParameterSetName = "Path")]
	[OutputType([Belin.Lcov.Report])]
	param (
		# The path to the LCOV file to convert.
		[Parameter(Mandatory, ParameterSetName = "Path", Position = 1, ValueFromPipeline)]
		[SupportsWildcards()]
		[string[]] $Path,

		# The path to the LCOV file to convert.
		[Parameter(Mandatory, ParameterSetName = "LiteralPath")]
		[ValidateScript({ Test-Path $_ -IsValid }, ErrorMessage = "The specified literal path is invalid.")]
		[string[]] $LiteralPath,

		# A pattern used to filter the list of files to be processed.
		[string] $Filter,

		# Value indicating whether to process the input path recursively.
		[switch] $Recurse
	)

	process {
		$parameters = @{ File = $true; Recurse = $Recurse }
		if ($Filter) { $parameters.Filter = $Filter }

		$files = $LiteralPath ? (Get-ChildItem -LiteralPath $LiteralPath @parameters) : (Get-ChildItem $Path @parameters)
		foreach ($file in $files) {
			try { [Report]::Parse((Get-Content $file.FullName -Raw)) }
			catch [FormatException] { Write-Error $_ }
		}
	}
}

<#
.SYNOPSIS
	Creates a new report.
.OUTPUTS
	The newly created report.
#>
function New-Report {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.Report])]
	param (
		# The test name.
		[Parameter(Mandatory, Position = 1)]
		[string] $TestName,

		# The source file list.
		[Parameter(Position = 2)]
		[ValidateNotNull()]
		[SourceFile[]] $SourceFiles = @()
	)

	[Report]::new($TestName, $SourceFiles)
}
