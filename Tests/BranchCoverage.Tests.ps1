using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-BranchCoverage` cmdlet.
#>
Describe "New-BranchCoverage" {
	It "should return a format like 'BRF:[Found]\nBRH:[Hit]'" {
		(New-LcovBranchCoverage).ToString() | Should-BeString "BRF:0`nBRH:0" -CaseSensitive

		$data = New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1
		(New-LcovBranchCoverage -Data $data -Found 23 -Hit 11).ToString() | Should-BeString "$data`nBRF:23`nBRH:11" -CaseSensitive
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-BranchData` cmdlet.
#>
Describe "New-BranchData" {
	It "should return a format like 'BRDA:[LineNumber],[BlockNumber],[BranchNumber],[Taken]'" {
		(New-LcovBranchData).ToString() | Should-BeString "BRDA:0,0,0,-" -CaseSensitive
		(New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1).ToString() | Should-BeString "BRDA:127,3,2,1" -CaseSensitive
	}
}
