module Workshops.Pages exposing (PageType(..))

import Workshops.Workshop exposing (Workshop)

type PageType
    = ListPage
    | PersonPage
    | WorkshopPage Workshop PageType
