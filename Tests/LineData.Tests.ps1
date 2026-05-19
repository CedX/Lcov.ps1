using module ../Sources/LineData.psm1

<#
.SYNOPSIS
	Tests the features of the `LineData` class.
#>
Describe "LineData" {
	Context "ToString" {
		It "should return a format like 'DA:<LineNumber>,<ExecutionCount>[,<Checksum>]'" {
			[LineData]::new().ToString() | Should -BeExactly "DA:0,0"
			([LineData]@{ Checksum = "ed076287532e86365e841e92bfc50d8c"; ExecutionCount = 3; LineNumber = 127 }).ToString() | Should -BeExactly "DA:127,3,ed076287532e86365e841e92bfc50d8c"
		}
	}
}
