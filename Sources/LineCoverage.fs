namespace Belin.Lcov

open System.Management.Automation

/// Creates a new line coverage.
[<Cmdlet(VerbsCommon.New, "LineCoverage")>]
[<OutputType(typeof<LineCoverage>)>]
type NewLineCoverageCommand () =
  inherit Cmdlet ()

  /// The coverage data.
  [<Parameter; ValidateNotNull>]
  member val Data: LineData array = [||] with get, set

  /// The number of lines found.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Found = 0 with get, set

  /// The number of lines hit.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Hit = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (LineCoverage (
    Data = this.Data,
    Found = this.Found,
    Hit = this.Hit
  ))

/// Creates new line data.
[<Cmdlet(VerbsCommon.New, "LineData")>]
[<OutputType(typeof<LineData>)>]
type NewLineDataCommand () =
  inherit Cmdlet ()

  /// The data checksum.
  [<Parameter; ValidateNotNull>]
  member val Checksum = "" with get, set

  /// The execution count.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val ExecutionCount = 0 with get, set

  /// The line number.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val LineNumber = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (LineData (
    Checksum = this.Checksum,
    ExecutionCount = this.ExecutionCount,
    LineNumber = this.LineNumber
  ))
