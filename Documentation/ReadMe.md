# LCOV Reports for PowerShell
Parse and format [LCOV](https://github.com/linux-test-project/lcov) coverage reports,
in [PowerShell](https://learn.microsoft.com/en-us/powershell).
	
## Quick start
Install the latest version of **LCOV Reports for PowerShell**
with [PSResourceGet](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget) package manager:

```powershell
Install-PSResource Belin.Lcov
```

For detailed instructions, see the [installation guide](Installation.md).

## Usage
This library provides a set of types representing a [LCOV](https://github.com/linux-test-project/lcov) coverage report and its data.  

To manipulate these types, the module exposes a set of dedicated cmdlets.  
For more details, please refer to the following pages:

- [Parse coverage data from a LCOV file](LcovParsing.md)
- [Format coverage data to the LCOV format](LcovFormatting.md)
