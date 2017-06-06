module Workshops.Types.Workshop exposing (Workshop)

import Date
import Workshops.Types.Person exposing (Person)
import Workshops.Types.Session exposing (Session)

type alias Workshop =
    { keywords : List String
    , title : String
    , description : String
    , materials : List String
    , prospects : List Person
    , calendar : List Session
    , history : List Session
    , created : Date.Date
    }