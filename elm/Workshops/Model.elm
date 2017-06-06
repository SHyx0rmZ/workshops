module Workshops.Model exposing (Model)

import Workshops.Pages exposing (PageType)
import Workshops.Types.Person exposing (Person)
import Workshops.Types.Workshop exposing (Workshop)

type alias Model =
    { workshops : List Workshop
    , people : List Person
    , currentPage : PageType
    , person : Int
    }
