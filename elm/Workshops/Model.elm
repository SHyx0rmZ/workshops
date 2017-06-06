module Workshops.Model exposing (Model)

import Workshops.Pages exposing (PageType)
import Workshops.Workshop exposing (Workshop)

type alias Model =
    { workshops : List Workshop
    , currentPage : PageType
    }
