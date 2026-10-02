namespace Belin.Lcov

open System.Management.Automation

/// Creates a new function coverage.
[<Cmdlet(VerbsCommon.New, "FunctionCoverage"); OutputType(typeof<FunctionCoverage>)>]
type NewFunctionCoverageCommand() =
  inherit Cmdlet()

  /// The coverage data.
  [<Parameter; ValidateNotNull>]
  member val Data: FunctionData array = [||] with get, set

  /// The number of functions found.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Found = 0 with get, set

  /// The number of functions hit.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Hit = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (FunctionCoverage (
    Data = this.Data,
    Found = this.Found,
    Hit = this.Hit
  ))

/// Creates new function data.
[<Cmdlet(VerbsCommon.New, "FunctionData"); OutputType(typeof<FunctionData>)>]
type NewFunctionDataCommand() =
  inherit Cmdlet()

  /// The function name.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val FunctionName = "" with get, set

  /// The execution count.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val ExecutionCount = 0 with get, set

  /// The line number of the function start.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val LineNumber = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (FunctionData (
    FunctionName = this.FunctionName,
    ExecutionCount = this.ExecutionCount,
    LineNumber = this.LineNumber
  ))
