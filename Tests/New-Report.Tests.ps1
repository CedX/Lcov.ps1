using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-Report` cmdlet.
#>
Describe "New-Report" {
	It "should return a format like 'TN:[TestName]'" {
		Should-BeString "TN:FooBar" (New-LcovReport "FooBar").ToString() -CaseSensitive

		$sourceFile = New-LcovSourceFile "/home/CedX/Lcov.ps1/Program.psm1"
		$report = New-LcovReport "LcovTest" $sourceFile
		Should-BeString "TN:LcovTest`n$sourceFile" $report.ToString() -CaseSensitive
	}
}
