
module ReverseString

open System



let reverse (input: string): string = 
    input
    |> seq
    |> Seq.rev
    |>  String.Concat    