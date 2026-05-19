using module ../Sources/FunctionData.psm1

<#
.SYNOPSIS
	Tests the features of the `FunctionData` class.
#>
Describe "FunctionData" {
	Context "ToString" {
		It "should return a format like 'FN:<LineNumber>,<FunctionName>\nFNDA:<ExecutionCount>,<FunctionName>'" {
			[FunctionData]::new().ToString() | Should -BeExactly "FN:0,`nFNDA:0,"
			([FunctionData]@{ ExecutionCount = 3; FunctionName = "main"; LineNumber = 127 }).ToString() | Should -BeExactly "FN:127,main`nFNDA:3,main"
		}
	}
}
