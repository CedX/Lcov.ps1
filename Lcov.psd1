@{
	DefaultCommandPrefix = "Lcov"
	ModuleVersion = "3.0.0"
	PowerShellVersion = "7.6"
	RootModule = "Binaries/Belin.Lcov.PowerShell.dll"
	NestedModules = , "Sources/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "Parse and format to LCOV your code coverage reports."
	GUID = "158416ed-ea32-4bcf-ac5d-8c555ad917e5"

	AliasesToExport = @()
	RequiredAssemblies = , "Binaries/Belin.Lcov.dll"
	VariablesToExport = @()

	CmdletsToExport = @(
		"New-BranchCoverage"
		"New-BranchData"
		"New-FunctionCoverage"
		"New-FunctionData"
		"New-LineCoverage"
		"New-LineData"
		"New-Report"
		"New-SourceFile"
	)

	FunctionsToExport = @(
		"ConvertFrom-Info"
	)

	RequiredModules = @(
		@{ ModuleName = "Belin.FSharp"; ModuleVersion = "10.1.401" }
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/CedX/Lcov.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/CedX/Lcov.ps1"
			ReleaseNotes = "https://github.com/CedX/Lcov.ps1/releases"
			Tags = "coverage", "formatter", "lcov", "parser", "test", "writer"
		}
	}
}
