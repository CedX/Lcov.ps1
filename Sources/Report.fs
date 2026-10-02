namespace Belin.Lcov

open System
open System.IO
open System.Management.Automation
open System.Text

/// Converts the contents of a LCOV info file into a `Report` object.
[<Cmdlet(VerbsData.ConvertFrom, "Info", DefaultParameterSetName = "Path")>]
[<OutputType(typeof<Report>)>]
type ConvertFromInfoCommand() =
  inherit PSCmdlet()

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
    let script =
      StringBuilder("Get-ChildItem -File")
        .Append(if this.ParameterSetName = "Path" then " -Path $args[0]" else " -LiteralPath $args[0]")
        .Append(if this.Filter.Length > 0 then " -Filter $args[1]" else "")
        .Append(if this.Recurse.IsPresent then " -Recurse" else "")

    let parameters = ResizeArray<obj>()
    parameters.Add(if this.ParameterSetName = "Path" then this.Path else this.LiteralPath)
    if this.Filter.Length > 0 then parameters.Add this.Filter

    for psObject in this.InvokeCommand.InvokeScript(string script, parameters.ToArray()) do
      let file = psObject.BaseObject :?> FileInfo
      try this.WriteObject (Report.Parse (File.ReadAllText file.FullName))
      with :? FormatException as ex -> this.WriteError (ErrorRecord(ex, "Report.Parse", ErrorCategory.SyntaxError, file))

/// Creates a new report.
[<Cmdlet(VerbsCommon.New, "Report")>]
[<OutputType(typeof<Report>)>]
type NewReportCommand() =
  inherit Cmdlet()

  /// The test name.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val TestName = "" with get, set

  /// The source file list.
  [<Parameter(Position = 2); ValidateNotNull>]
  member val SourceFiles: SourceFile array = [||] with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Report (this.TestName, this.SourceFiles))
