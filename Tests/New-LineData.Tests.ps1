using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-LineData` cmdlet.
#>
Describe "New-LineData" {
	It "should return a format like 'DA:[LineNumber],[ExecutionCount],[Checksum]'" {
		Should-BeString "DA:0,0" (New-LcovLineData).ToString() -CaseSensitive
		Should-BeString "DA:127,3,ed076287532e86365e841e92bfc50d8c" (New-LcovLineData -Checksum "ed076287532e86365e841e92bfc50d8c" -ExecutionCount 3 -LineNumber 127).ToString() -CaseSensitive
	}
}
