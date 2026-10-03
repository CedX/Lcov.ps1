using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-SourceFile` cmdlet.
#>
Describe "New-SourceFile" {
	It "should return a format like 'SF:[Path]\nend_of_record'" {
		(New-LcovSourceFile "/FooBar.ps1").ToString() | Should-BeString "SF:/FooBar.ps1`nend_of_record" -CaseSensitive

		$sourceFile = New-LcovSourceFile "/home/CedX/Lcov.ps1/Program.psm1" -WithCoverage
		$sourceFile.ToString() | Should-BeString "SF:/home/CedX/Lcov.ps1/Program.psm1`n$($sourceFile.Functions)`n$($sourceFile.Branches)`n$($sourceFile.Lines)`nend_of_record" -CaseSensitive
	}
}
