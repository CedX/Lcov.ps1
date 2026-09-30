namespace Belin.Lcov

open System
open System.IO
open System.Management.Automation

/// Converts the contents of a LCOV info file into a `Report` object.
[<Cmdlet(VerbsData.ConvertFrom, "Info", DefaultParameterSetName = "Path")>]
[<OutputType(typeof<Report>)>]
type ConvertFromInfoCommand () =
  inherit PSCmdlet ()

  /// The path to the LCOV file to convert.
  [<Parameter(Mandatory = true, ParameterSetName = "Path", Position = 1, ValueFromPipeline = true)>]
  [<SupportsWildcards>]
  member val Path: string array = [||] with get, set

  /// The path to the LCOV file to convert.
  [<Parameter(Mandatory = true, ParameterSetName = "LiteralPath")>]
  member val LiteralPath: string array = [||] with get, set

  /// A pattern used to filter the list of files to be processed.
  [<Parameter>]
  member val Filter = "" with get, set

  /// Value indicating whether to process the input path recursively.
  [<Parameter>]
  member val Recurse = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    use getChildItem = PowerShell.Create(RunspaceMode.CurrentRunspace).AddCommand "Get-ChildItem"
    getChildItem.AddParameter("File").AddParameter "Recurse" |> ignore
    if this.Filter.Length > 0 then getChildItem.AddParameter("Filter", this.Filter) |> ignore

    if this.ParameterSetName = "LiteralPath" then getChildItem.AddParameter("LiteralPath", this.LiteralPath) |> ignore
    else getChildItem.AddParameter("Path", this.Path) |> ignore

    for file in getChildItem.Invoke<FileInfo>() do
      try this.WriteObject (Report.Parse (File.ReadAllText file.FullName))
      with :? FormatException as ex -> this.WriteError (ErrorRecord(ex, "Report.Parse", ErrorCategory.ParserError, file))

/// Creates a new report.
[<Cmdlet(VerbsCommon.New, "Report")>]
[<OutputType(typeof<Report>)>]
type NewReportCommand () =
  inherit Cmdlet ()

  /// The test name.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val TestName = "" with get, set

  /// The source file list.
  [<Parameter(Position = 2); ValidateNotNull>]
  member val SourceFiles: SourceFile array = [||] with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Report (this.TestName, this.SourceFiles))
