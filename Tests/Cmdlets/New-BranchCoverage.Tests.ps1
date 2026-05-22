using module ../../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-BranchCoverage` cmdlet.
#>
Describe "New-BranchCoverage" {
	It "should return a format like 'BRF:[Found]\nBRH:[Hit]'" {
		$data = New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1
		New-LcovBranchCoverage | Should -BeExactly "BRF:0`nBRH:0"
		New-LcovBranchCoverage -Data $data -Found 23 -Hit 11 | Should -BeExactly "$data`nBRF:23`nBRH:11"
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-BranchData` cmdlet.
#>
Describe "New-BranchData" {
	It "should return a format like 'BRDA:[LineNumber],[BlockNumber],[BranchNumber],[Taken]'" {
		New-LcovBranchData | Should -BeExactly "BRDA:0,0,0,-"
		New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1 | Should -BeExactly "BRDA:127,3,2,1"
	}
}
