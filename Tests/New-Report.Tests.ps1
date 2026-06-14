using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-Report` cmdlet.
#>
Describe "New-Report" {
	It "should return a format like 'TN:[TestName]'" {
		New-LcovReport "FooBar" | Should -BeExactly "TN:FooBar"

		$sourceFile = New-LcovSourceFile "/home/CedX/Lcov.ps1/Program.psm1"
		$report = New-LcovReport "LcovTest" $sourceFile
		$report | Should -BeExactly "TN:LcovTest`n$sourceFile"
	}
}
