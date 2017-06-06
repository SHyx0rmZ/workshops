module Workshops.Pages exposing (PageType(..))

import Workshops.Types.Workshop exposing (Workshop)

type PageType
    = ListPage
    | PersonPage
    | WorkshopPage Workshop PageType
