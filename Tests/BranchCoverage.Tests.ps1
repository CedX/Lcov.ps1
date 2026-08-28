using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-BranchCoverage` cmdlet.
#>
Describe "New-BranchCoverage" {
	It "should return a format like 'BRF:[Found]\nBRH:[Hit]'" {
		Should-BeString "BRF:0`nBRH:0" (New-LcovBranchCoverage).ToString() -CaseSensitive

		$data = New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1
		Should-BeString "$data`nBRF:23`nBRH:11" (New-LcovBranchCoverage -Data $data -Found 23 -Hit 11).ToString() -CaseSensitive
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-BranchData` cmdlet.
#>
Describe "New-BranchData" {
	It "should return a format like 'BRDA:[LineNumber],[BlockNumber],[BranchNumber],[Taken]'" {
		Should-BeString "BRDA:0,0,0,-" (New-LcovBranchData).ToString() -CaseSensitive
		Should-BeString "BRDA:127,3,2,1" (New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1).ToString() -CaseSensitive
	}
}
