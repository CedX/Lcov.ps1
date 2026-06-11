using module ../Sources/BranchCoverage.psm1
using module ../Sources/FunctionCoverage.psm1
using module ../Sources/LineCoverage.psm1
using module ../Sources/SourceFile.psm1

<#
.SYNOPSIS
	Tests the features of the `SourceFile` class.
#>
Describe "SourceFile" {
	Context "ToString" {
		It "should return a format like 'SF:<Path>\nend_of_record'" {
			[SourceFile]::new("").ToString() | Should -BeExactly "SF:`nend_of_record"

			$sourceFile = [SourceFile] "/home/CedX/Lcov.ps1/program.psm1"
			$sourceFile.Branches = [BranchCoverage]::new()
			$sourceFile.Functions = [FunctionCoverage]::new()
			$sourceFile.Lines = [LineCoverage]::new()
			$sourceFile.ToString() | Should -BeExactly "SF:/home/CedX/Lcov.ps1/program.psm1`n$($sourceFile.Functions)`n$($sourceFile.Branches)`n$($sourceFile.Lines)`nend_of_record"
		}
	}
}
