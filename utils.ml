  
open Printf

 
module IntSet = Set.Make( 
  struct
    let compare = Pervasives.compare
    type t = int
  end)

type intset = IntSet.t


(* Returns the last element *)
let rec last xs =
  match xs with 
    | [] -> raise (Invalid_argument "Utils.last")
    | [x] -> x
    | x::xs -> last xs

let findindex x l = 
  let rec findidx l c =
    match l with
      | [] -> raise Not_found
      | y::ys -> if x = y then c else findidx ys (c+1)
  in findidx l 0

let (|>) x f = f x 

let (<|) f x = f x 

let (>>) f g x = g(f x)

let map_option f op = 
  match op with
    | Some t -> Some (f t)
    | None -> None

let string_of_intlist il = 
  let s = String.create (List.length il) in
  il |> List.fold_left (fun i x -> (s.[i] <- char_of_int x); i+1) 0 |> ignore;
  s

let intlist_of_string s =
  let rec work n a = if n >= 0
    then work (n-1) ((int_of_char (s.[n]))::a) else a in
  work (String.length s) []

let write_binfile filename str =
  let f = open_out_bin filename in
  output_string f str;
  flush f;
  close_out f  

let read_binfile filename =
  let f = open_in_bin filename in
  let size = in_channel_length f in
  let s = String.create size in
  try 
    let rec readinput pos size =
      let read = input f s pos size in
      if read != 0 then readinput (pos+read) (size-read) else ()
    in
    readinput 0 size;
    close_in f; 
    s 
  with 
  | Invalid_argument _ -> raise (Sys_error "Cannot read file")

  
let rec fold_interval f a s e =
  if s = e then (f a s) else fold_interval f (f a s) (s+1) e  



