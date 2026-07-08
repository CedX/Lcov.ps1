using module ../Lcov.psd1

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
