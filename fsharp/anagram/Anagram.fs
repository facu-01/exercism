module Anagram

open System

let findAnagrams (sources: List<string>) (target: string) : List<string> =
    let normalize string =
        string |> Seq.map Char.ToLower |> Seq.sort |> Seq.toList

    sources
    |> List.filter (fun w -> w.ToLower() <> target.ToLower())
    |> List.filter (fun w -> normalize w = normalize target)
