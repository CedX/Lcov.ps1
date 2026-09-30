namespace Belin.Lcov

open System.Management.Automation

/// Creates a new branch coverage.
[<Cmdlet(VerbsCommon.New, "BranchCoverage")>]
[<OutputType(typeof<BranchCoverage>)>]
type NewBranchCoverageCommand () =
  inherit Cmdlet ()

  /// The coverage data.
  [<Parameter; ValidateNotNull>]
  member val Data: BranchData array = [||] with get, set

  /// The number of branches found.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Found = 0 with get, set

  /// The number of branches hit.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Hit = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (BranchCoverage (
    Data = this.Data,
    Found = this.Found,
    Hit = this.Hit
  ))

/// Creates new branch data.
[<Cmdlet(VerbsCommon.New, "BranchData")>]
[<OutputType(typeof<BranchData>)>]
type NewBranchDataCommand () =
  inherit Cmdlet ()

  /// The block number.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val BlockNumber = 0 with get, set

  /// The branch number.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val BranchNumber = 0 with get, set

  /// The line number.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val LineNumber = 0 with get, set

  /// A number indicating how often this branch was taken.
  [<Parameter; ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Taken = 0 with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (BranchData (
    BlockNumber = this.BlockNumber,
    BranchNumber = this.BranchNumber,
    LineNumber = this.LineNumber,
    Taken = this.Taken
  ))
