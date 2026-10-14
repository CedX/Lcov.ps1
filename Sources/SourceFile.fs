namespace Belin.Lcov

open System.Management.Automation

/// Creates a new source file.
[<Cmdlet(VerbsCommon.New, "SourceFile", DefaultParameterSetName = "Default"); OutputType(typeof<SourceFile>)>]
type NewSourceFile() =
  inherit PSCmdlet()

  /// The path to the source file.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Path = "" with get, set

  /// The branch coverage.
  [<Parameter(ParameterSetName = "Default")>]
  member val Branches: BranchCoverage | null = null with get, set

  /// The function coverage.
  [<Parameter(ParameterSetName = "Default")>]
  member val Functions: FunctionCoverage | null = null with get, set

  /// The line coverage.
  [<Parameter(ParameterSetName = "Default")>]
  member val Lines: LineCoverage | null = null with get, set

  /// Value indicating whether to populate the instance with default coverage values.
  [<Parameter(ParameterSetName = "WithCoverage")>]
  member val WithCoverage = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    match this.ParameterSetName with
    | "WithCoverage" -> this.WriteObject (SourceFile.WithCoverage this.Path)
    | _ -> this.WriteObject (SourceFile(this.Path, Branches = this.Branches, Functions = this.Functions, Lines = this.Lines))
