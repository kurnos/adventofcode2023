let digits_in_line (line : string) =
  line |> String.to_seq |>
  Seq.filter_map (fun c ->
    match c with
    | '0'..'9' as d -> Some (Char.code d - Char.code '0')
    | _ -> None
  )

let digits_in_line2 (line: string) =
  line |> String.to_seq |>
  Seq.mapi (fun i c ->
    let remaining = String.sub line i (String.length line - i) in
    match c with
    | '0'..'9' as d -> Some (Char.code d - Char.code '0')
    | _ when (String.starts_with ~prefix:"one" remaining) -> Some 1
    | _ when (String.starts_with ~prefix:"two" remaining) -> Some 2
    | _ when (String.starts_with ~prefix:"three" remaining) -> Some 3
    | _ when (String.starts_with ~prefix:"four" remaining) -> Some 4
    | _ when (String.starts_with ~prefix:"five" remaining) -> Some 5
    | _ when (String.starts_with ~prefix:"six" remaining) -> Some 6
    | _ when (String.starts_with ~prefix:"seven" remaining) -> Some 7
    | _ when (String.starts_with ~prefix:"eight" remaining) -> Some 8
    | _ when (String.starts_with ~prefix:"nine" remaining) -> Some 9
    | _ -> None
  ) |> Seq.filter_map (fun x -> x)

let first_and_last =
  Seq.fold_left (fun acc n ->
    match acc with
    | None -> Some (n, n)
    | Some (first, _) -> Some (first, n)
  ) None

let solve digit_func =
  In_channel.with_open_text "../data/day01" In_channel.input_all
  |> String.split_on_char '\n'
  |> List.to_seq
  |> Seq.map digit_func
  |> Seq.filter_map first_and_last
  |> Seq.map (fun (first, last) -> first*10 + last)
  |> Seq.fold_left (fun acc n -> acc + n) 0

let () =
  solve digits_in_line |> Printf.printf "%d\n";
  solve digits_in_line2 |> Printf.printf "%d\n";

