@{
	ModuleVersion = "1.1.0"
	PowerShellVersion = "7.6"
	RootModule = "Sources/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "Parse and format to LCOV your code coverage reports."
	GUID = "158416ed-ea32-4bcf-ac5d-8c555ad917e5"

	AliasesToExport = @()
	CmdletsToExport = @()
	VariablesToExport = @()

	FunctionsToExport = @(
		"ConvertFrom-LcovInfo"
		"New-LcovBranchCoverage"
		"New-LcovBranchData"
		"New-LcovFunctionCoverage"
		"New-LcovFunctionData"
		"New-LcovLineCoverage"
		"New-LcovLineData"
		"New-LcovReport"
		"New-LcovSourceFile"
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
