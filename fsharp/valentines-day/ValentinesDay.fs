module ValentinesDay

type Approval =
    | Yes
    | No
    | Maybe


type Cuisine = 
    | Korean
    | Turkish


type Genre =
    | Crime
    | Horror
    | Romance
    | Thriller


type Activity =
    | BoardGame
    | Chill
    | Movie of Genre
    | Restaurant of Cuisine
    | Walk of int


let rateActivity (activity: Activity): Approval = 
    match activity with
    | BoardGame -> No
    | Chill -> No
    | Movie gen -> match gen with
                            | Romance -> Yes
                            | _ -> No
    | Restaurant cuis -> match cuis with
                                    | Korean -> Yes
                                    | Turkish -> Maybe
    | Walk dis -> match dis with
                        | var when var < 3 -> Yes
                        | var when var < 5 -> Maybe
                        | _ -> No
