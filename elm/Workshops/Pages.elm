module Workshops.Pages exposing (CurrentPage(..))

import Workshops.Workshop exposing (Workshop)

type CurrentPage
    = ListPage
    | PersonPage
    | WorkshopPage Workshop CurrentPage
