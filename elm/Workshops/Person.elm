module Workshops.Person exposing (personFromId)

import Workshops.Model exposing (Model)
import Workshops.Types.Person exposing (Person)

personFromId : Model -> Int -> Maybe Person
personFromId model id =
    model.people
        |> List.filter (.id >> (==) id)
        |> List.head
