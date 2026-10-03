using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-LineCoverage` cmdlet.
#>
Describe "New-LineCoverage" {
	It "should return a format like 'LF:[Found]\nLH:[Hit]'" {
		(New-LcovLineCoverage).ToString() | Should-BeString "LF:0`nLH:0" -CaseSensitive

		$data = New-LcovLineData -ExecutionCount 3 -LineNumber 127
		(New-LcovLineCoverage -Data $data -Found 23 -Hit 11).ToString() | Should-BeString "$data`nLF:23`nLH:11" -CaseSensitive
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-LineData` cmdlet.
#>
Describe "New-LineData" {
	It "should return a format like 'DA:[LineNumber],[ExecutionCount],[Checksum]'" {
		(New-LcovLineData).ToString() | Should-BeString "DA:0,0" -CaseSensitive
		(New-LcovLineData -Checksum "ed076287532e86365e841e92bfc50d8c" -ExecutionCount 3 -LineNumber 127).ToString() | Should-BeString "DA:127,3,ed076287532e86365e841e92bfc50d8c" -CaseSensitive
	}
}
