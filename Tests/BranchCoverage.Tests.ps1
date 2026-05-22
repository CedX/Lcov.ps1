using module ../Sources/BranchCoverage.psm1

<#
.SYNOPSIS
	Tests the features of the `BranchCoverage` class.
#>
Describe "BranchCoverage" {
	Context "ToString" {
		It "should return a format like 'BRF:<Found>\nBRH:<Hit>'" {
			[BranchCoverage]::new().ToString() | Should -BeExactly "BRF:0`nBRH:0"

			$data = [BranchData]@{ BlockNumber = 3; BranchNumber = 2; LineNumber = 127; Taken = 1 }
			([BranchCoverage]@{ Data = @($data); Found = 23; Hit = 11 }).ToString() | Should -BeExactly "$data`nBRF:23`nBRH:11"
		}
	}
}

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
