# LCOV Parsing
The `ConvertFrom-LcovInfo` cmdlet parses a [LCOV](https://github.com/linux-test-project/lcov) info file,
and creates a `Report` instance giving detailed information about this coverage report:

```pwsh
using module Belin.Lcov

$report = ConvertFrom-LcovInfo "/path/to/lcov.info"
Write-Output "The coverage report contains $($report.SourceFiles.Count) source files:"
Write-Output (ConvertTo-Json $report -Depth 5)
```

> [!NOTE]
> A non-terminating error is triggered if any error occurred while parsing the coverage report.  
> The cmdlet supports the [-ErrorAction](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters#-erroraction) common parameter.

Converting the `Report` instance to [JSON](https://www.json.org) format will return a structure like this:

```json
{
  "TestName": "Example",
  "SourceFiles": [
    {
      "Path": "/home/CedX/Lcov.ps1/Fixture.psm1",
      "Branches": {
        "Found": 0,
        "Hit": 0,
        "Data": []
      },
      "Functions": {
        "Found": 1,
        "Hit": 1,
        "Data": [
          {"FunctionName": "main", "LineNumber": 4, "ExecutionCount": 2}
        ]
      },
      "Lines": {
        "Found": 2,
        "Hit": 2,
        "Data": [
          {"LineNumber": 6, "ExecutionCount": 2, "Checksum": "PF4Rz2r7RTliO9u6bZ7h6g"},
          {"LineNumber": 9, "ExecutionCount": 2, "Checksum": "y7GE3Y4FyXCeXcrtqgSVzw"}
        ]
      }
    }
  ]
}
```
