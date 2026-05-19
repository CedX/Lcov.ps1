<#
.SYNOPSIS
	Parses a LCOV report to coverage data.
#>
using module Belin.Lcov

$report = ConvertFrom-LcovInfo "/path/to/lcov.info"
Write-Output "The coverage report contains $($report.SourceFiles.Count) source files:"
Write-Output (ConvertTo-Json $report -Depth 5)
