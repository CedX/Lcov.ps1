using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-LineCoverage` cmdlet.
#>
Describe "New-LineCoverage" {
	It "should return a format like 'LF:[Found]\nLH:[Hit]'" {
		Should-BeString "LF:0`nLH:0" (New-LcovLineCoverage).ToString() -CaseSensitive

		$data = New-LcovLineData -ExecutionCount 3 -LineNumber 127
		Should-BeString "$data`nLF:23`nLH:11" (New-LcovLineCoverage -Data $data -Found 23 -Hit 11).ToString() -CaseSensitive
	}
}
