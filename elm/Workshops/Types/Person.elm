module Workshops.Types.Person exposing (Person)

type alias Person =
    { name : String
    , keywords : List String
    , workshops : List String
    , id : Int
    , email : String
    }
