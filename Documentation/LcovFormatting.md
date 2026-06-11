# LCOV Formatting
Each `New-Lcov...` cmdlet provided by this module returns an object having a dedicated `ToString()` method returning
the corresponding data formatted as [LCOV](https://github.com/linux-test-project/lcov) string.
All you have to do is to create the adequate structure using these different cmdlets, and to export the final result:

```pwsh
using module Belin.Lcov

$functionCoverage = New-LcovFunctionCoverage -Found 1 -Hit 1
$lineCoverage = New-LcovLineCoverage -Found 2 -Hit 1 -Data @(
  New-LcovLineData -LineNumber 6 -ExecutionCount 2 -Checksum "PF4Rz2r7RTliO9u6bZ7h6g"
  New-LcovLineData -LineNumber 7 -ExecutionCount 2 -Checksum "yGMB6FhEEAd8OyASe3Ni1w"
)

$sourceFile = New-LcovSourceFile "/home/CedX/Lcov.ps1/Fixture.psm1" -Functions $functionCoverage -Lines $lineCoverage
$report = New-LcovReport -TestName "Example" -SourceFiles $sourceFile
Write-Output $report.ToString()
```

The `Report.ToString()` method will return a [LCOV](https://github.com/linux-test-project/lcov) report formatted like this:

```lcov
TN:Example
SF:/home/CedX/Lcov.ps1/Fixture.psm1
FNF:1
FNH:1
DA:6,2,PF4Rz2r7RTliO9u6bZ7h6g
DA:7,2,yGMB6FhEEAd8OyASe3Ni1w
LF:2
LH:2
end_of_record
```

> [!TIP]
> See the [source code](https://github.com/CedX/Lcov.ps1/tree/main/Sources) of this module
> for detailed information on the available cmdlets.
