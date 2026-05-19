using module ../Sources/LineCoverage.psm1
using module ../Sources/LineData.psm1

<#
.SYNOPSIS
	Tests the features of the `LineCoverage` class.
#>
Describe "LineCoverage" {
	Context "ToString" {
		It "should return a format like 'LF:<Found>\nLH:<Hit>'" {
			[LineCoverage]::new().ToString() | Should -BeExactly "LF:0`nLH:0"

			$data = [LineData]@{ ExecutionCount = 3; LineNumber = 127 }
			([LineCoverage]@{ Data = @($data); Found = 23; Hit = 11 }).ToString() | Should -BeExactly "$data`nLF:23`nLH:11"
		}
	}
}
