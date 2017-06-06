module Workshops.Pages.Workshop exposing (viewWorkshopPage)

import Html
import Workshops.Workshop exposing (Workshop)
import Workshops.Pages exposing (CurrentPage)

viewWorkshopPage : Workshop -> CurrentPage -> Html.Html msg
viewWorkshopPage workshop previousPage =
    Html.h1 [] [ Html.text <| "Workshop Page" ++ workshop.title ]
