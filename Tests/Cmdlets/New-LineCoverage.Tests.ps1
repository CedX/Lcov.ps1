using module ../../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-LineCoverage` cmdlet.
#>
Describe "New-LineCoverage" {
	It "should return a format like 'LF:[Found]\nLH:[Hit]'" {
		$data = New-LcovLineData -ExecutionCount 3 -LineNumber 127
		New-LcovLineCoverage | Should -BeExactly "LF:0`nLH:0"
		New-LcovLineCoverage -Data $data -Found 23 -Hit 11 | Should -BeExactly "$data`nLF:23`nLH:11"
	}
}
