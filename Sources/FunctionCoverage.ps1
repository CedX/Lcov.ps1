using namespace Belin.Lcov

<#
.SYNOPSIS
	Creates a new function coverage.
.OUTPUTS
	The newly created function coverage.
#>
function New-FunctionCoverage {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.FunctionCoverage])]
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

	return [FunctionCoverage]@{
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
function New-FunctionData {
	[CmdletBinding()]
	[OutputType([Belin.Lcov.FunctionData])]
	param (
		# The function name.
		[Parameter(Mandatory, Position = 1)]
		[string] $FunctionName,

		# The execution count.
		[ValidateRange("NonNegative")]
		[int] $ExecutionCount,

		# The line number of the function start.
		[ValidateRange("NonNegative")]
		[int] $LineNumber
	)

	return [FunctionData]@{
		ExecutionCount = $ExecutionCount
		FunctionName = $FunctionName
		LineNumber = $LineNumber
	}
}
