using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `New-SourceFile` cmdlet.
#>
Describe "New-SourceFile" {
	It "should return a format like 'SF:[Path]\nend_of_record'" {
		Should-BeString "SF:/FooBar.ps1`nend_of_record" (New-LcovSourceFile "/FooBar.ps1").ToString() -CaseSensitive

		$sourceFile = New-LcovSourceFile "/home/CedX/Lcov.ps1/Program.psm1" `
			-Branches (New-LcovBranchCoverage) `
			-Functions (New-LcovFunctionCoverage) `
			-Lines (New-LcovLineCoverage)

		Should-BeString "SF:/home/CedX/Lcov.ps1/Program.psm1`n$($sourceFile.Functions)`n$($sourceFile.Branches)`n$($sourceFile.Lines)`nend_of_record" $sourceFile.ToString() -CaseSensitive
	}
}
