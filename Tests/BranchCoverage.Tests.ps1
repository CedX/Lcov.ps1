using module ../Sources/BranchCoverage.psm1
using module ../Sources/BranchData.psm1

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
