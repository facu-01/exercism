module Anagram


let findAnagrams (sources: List<string>) (target: string) : List<string> =
    let sortTarget = target.ToLower() |> Seq.sort

    sources
    |> List.filter (fun w ->
        Seq.toList (Seq.sort (w.ToLower())) = Seq.toList sortTarget
        && w.ToLower() <> target.ToLower())
