using module ../Sources/BranchData.psm1

<#
.SYNOPSIS
	Tests the features of the `BranchData` class.
#>
Describe "BranchData" {
	Context "ToString" {
		It "should return a format like 'BRDA:<LineNumber>,<BlockNumber>,<BranchNumber>,<Taken>'" {
			[BranchData]::new().ToString() | Should -BeExactly "BRDA:0,0,0,-"
			([BranchData]@{ BlockNumber = 3; BranchNumber = 2; LineNumber = 127; Taken = 1 }).ToString() | Should -BeExactly "BRDA:127,3,2,1"
		}
	}
}
