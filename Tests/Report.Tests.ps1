using namespace System.Diagnostics.CodeAnalysis
using module ../Lcov.psd1

<#
.SYNOPSIS
	Tests the features of the `ConvertFrom-Info` cmdlet.
#>
Describe "ConvertFrom-Info" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "report")]
		$report = ConvertFrom-LcovInfo "$PSScriptRoot/../Resources" -Filter "*.info"
	}

	It "should have a test name" {
		$report.TestName | Should-BeString "Example" -CaseSensitive
	}

	It "should contain three source files" {
		$report.SourceFiles | Should-BeCollection -Count 3
		$report.SourceFiles[0].Path | Should-BeString "/home/CedX/Lcov.ps1/Fixture.psm1" -CaseSensitive
		$report.SourceFiles[1].Path | Should-BeString "/home/CedX/Lcov.ps1/Func1.psm1" -CaseSensitive
		$report.SourceFiles[2].Path | Should-BeString "/home/CedX/Lcov.ps1/Func2.psm1" -CaseSensitive
	}

	It "should have detailed branch coverage" {
		$branches = $report.SourceFiles[1].Branches
		$branches.Found | Should-Be 4
		$branches.Hit | Should-Be 4
		$branches.Data | Should-BeCollection -Count 4
		$branches.Data[0].LineNumber | Should-Be 8
	}

	It "should have detailed function coverage" {
		$functions = $report.SourceFiles[1].Functions
		$functions.Found | Should-Be 1
		$functions.Hit | Should-Be 1
		$functions.Data | Should-BeCollection -Count 1
		$functions.Data[0].FunctionName | Should-BeString "func1" -CaseSensitive
	}

	It "should have detailed line coverage" {
		$lines = $report.SourceFiles[1].Lines
		$lines.Found | Should-Be 9
		$lines.Hit | Should-Be 9
		$lines.Data | Should-BeCollection -Count 9
		$lines.Data[0].Checksum | Should-BeString "5kX7OTfHFcjnS98fjeVqNA" -CaseSensitive
	}

	It "should throw if the report has an invalid format" {
		{ ConvertFrom-LcovInfo $PSCommandPath -ErrorAction Stop } | Should-Throw
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-Report` cmdlet.
#>
Describe "New-Report" {
	It "should return a format like 'TN:[TestName]'" {
		(New-LcovReport "FooBar").ToString() | Should-BeString "TN:FooBar" -CaseSensitive

		$sourceFile = New-LcovSourceFile "/home/CedX/Lcov.ps1/Program.psm1"
		$report = New-LcovReport "LcovTest" $sourceFile
		$report.ToString() | Should-BeString "TN:LcovTest`n$sourceFile" -CaseSensitive
	}
}
