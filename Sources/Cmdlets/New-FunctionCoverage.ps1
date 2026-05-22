using module ../FunctionCoverage.psm1

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
