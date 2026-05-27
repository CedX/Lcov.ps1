using namespace System.Diagnostics.CodeAnalysis
using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `ConvertFrom-Info` cmdlet.
#>
Describe "ConvertFrom-Info" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "")]
		$report = ConvertFrom-LcovInfo "$PSScriptRoot/../Resources" -Filter "*.info"
	}

	It "should have a test name" {
		$report.TestName | Should -BeExactly "Example"
	}

	It "should contain three source files" {
		$report.SourceFiles | Should -HaveCount 3
		$report.SourceFiles[0].Path | Should -BeExactly "/home/CedX/Lcov.ps1/Fixture.psm1"
		$report.SourceFiles[1].Path | Should -BeExactly "/home/CedX/Lcov.ps1/Func1.psm1"
		$report.SourceFiles[2].Path | Should -BeExactly "/home/CedX/Lcov.ps1/Func2.psm1"
	}

	It "should have detailed branch coverage" {
		$branches = $report.SourceFiles[1].Branches
		$branches.Found | Should -Be 4
		$branches.Hit | Should -Be 4
		$branches.Data | Should -HaveCount 4
		$branches.Data[0].LineNumber | Should -Be 8
	}

	It "should have detailed function coverage" {
		$functions = $report.SourceFiles[1].Functions
		$functions.Found | Should -Be 1
		$functions.Hit | Should -Be 1
		$functions.Data | Should -HaveCount 1
		$functions.Data[0].FunctionName | Should -BeExactly "func1"
	}

	It "should have detailed line coverage" {
		$lines = $report.SourceFiles[1].Lines
		$lines.Found | Should -Be 9
		$lines.Hit | Should -Be 9
		$lines.Data | Should -HaveCount 9
		$lines.Data[0].Checksum | Should -BeExactly "5kX7OTfHFcjnS98fjeVqNA"
	}

	It "should throw if the report has an invalid format" {
		{ ConvertFrom-LcovInfo $PSCommandPath -ErrorAction Stop } | Should -Throw
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-BranchCoverage` cmdlet.
#>
Describe "New-BranchCoverage" {
	It "should return a format like 'BRF:[Found]\nBRH:[Hit]'" {
		$data = New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1
		New-LcovBranchCoverage | Should -BeExactly "BRF:0`nBRH:0"
		New-LcovBranchCoverage -Data $data -Found 23 -Hit 11 | Should -BeExactly "$data`nBRF:23`nBRH:11"
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-BranchData` cmdlet.
#>
Describe "New-BranchData" {
	It "should return a format like 'BRDA:[LineNumber],[BlockNumber],[BranchNumber],[Taken]'" {
		New-LcovBranchData | Should -BeExactly "BRDA:0,0,0,-"
		New-LcovBranchData -BlockNumber 3 -BranchNumber 2 -LineNumber 127 -Taken 1 | Should -BeExactly "BRDA:127,3,2,1"
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-FunctionCoverage` cmdlet.
#>
Describe "New-FunctionCoverage" {
	It "should return a format like 'FNF:[Found]\nFNH:[Hit]'" {
		$data = New-LcovFunctionData -ExecutionCount 3 -FunctionName "main" -LineNumber 127
		New-LcovFunctionCoverage | Should -BeExactly "FNF:0`nFNH:0"
		New-LcovFunctionCoverage -Data $data -Found 23 -Hit 11 | Should -BeExactly "FN:127,main`nFNDA:3,main`nFNF:23`nFNH:11"
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-FunctionData` cmdlet.
#>
Describe "New-FunctionData" {
	It "should return a format like 'FN:<LineNumber>,<FunctionName>\nFNDA:<ExecutionCount>,<FunctionName>'" {
		New-LcovFunctionData -ExecutionCount 3 -FunctionName "main" -LineNumber 127 | Should -BeExactly "FN:127,main`nFNDA:3,main"
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-LineCoverage` cmdlet.
#>
Describe "New-LineCoverage" {
	It "should return a format like 'LF:[Found]\nLH:[Hit]'" {
		$data = New-LcovLineData -ExecutionCount 3 -LineNumber 127
		New-LcovLineCoverage | Should -BeExactly "LF:0`nLH:0"
		New-LcovLineCoverage -Data $data -Found 23 -Hit 11 | Should -BeExactly "$data`nLF:23`nLH:11"
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-LineData` cmdlet.
#>
Describe "New-LineData" {
	It "should return a format like 'DA:[LineNumber],[ExecutionCount],[Checksum]'" {
		New-LcovLineData | Should -BeExactly "DA:0,0"
		New-LcovLineData -Checksum "ed076287532e86365e841e92bfc50d8c" -ExecutionCount 3 -LineNumber 127 | Should -BeExactly "DA:127,3,ed076287532e86365e841e92bfc50d8c"
	}
}
