module Workshops.Flags exposing (Flags)

import Workshops.Types.Person exposing (Person)
import Workshops.Types.Workshop exposing (ApiWorkshop)

type alias Flags =
    { people : List Person
    , workshops : List ApiWorkshop
    }
