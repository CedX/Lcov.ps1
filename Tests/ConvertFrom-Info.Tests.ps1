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
		Should-BeString "Example" $report.TestName -CaseSensitive
	}

	It "should contain three source files" {
		Should-Be 3 $report.SourceFiles.Count
		Should-BeString "/home/CedX/Lcov.ps1/Fixture.psm1" $report.SourceFiles[0].Path -CaseSensitive
		Should-BeString "/home/CedX/Lcov.ps1/Func1.psm1" $report.SourceFiles[1].Path -CaseSensitive
		Should-BeString "/home/CedX/Lcov.ps1/Func2.psm1" $report.SourceFiles[2].Path -CaseSensitive
	}

	It "should have detailed branch coverage" {
		$branches = $report.SourceFiles[1].Branches
		Should-Be 4 $branches.Found
		Should-Be 4 $branches.Hit
		Should-Be 4 $branches.Data.Count
		Should-Be 8 $branches.Data[0].LineNumber
	}

	It "should have detailed function coverage" {
		$functions = $report.SourceFiles[1].Functions
		Should-Be 1 $functions.Found
		Should-Be 1 $functions.Hit
		Should-Be 1 $functions.Data.Count
		Should-BeString "func1" $functions.Data[0].FunctionName -CaseSensitive
	}

	It "should have detailed line coverage" {
		$lines = $report.SourceFiles[1].Lines
		Should-Be 9 $lines.Found
		Should-Be 9 $lines.Hit
		Should-Be 9 $lines.Data.Count
		Should-BeString "5kX7OTfHFcjnS98fjeVqNA" $lines.Data[0].Checksum -CaseSensitive
	}

	It "should throw if the report has an invalid format" {
		Should-Throw -ScriptBlock { ConvertFrom-LcovInfo $PSCommandPath -ErrorAction Stop }
	}
}
