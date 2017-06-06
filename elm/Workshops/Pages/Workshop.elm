module Workshops.Pages.Workshop exposing (viewWorkshopPage)

import Html
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Pages exposing (PageType)
import Workshops.Workshop exposing (Workshop)

viewWorkshopPage : Workshop -> PageType -> Model -> Html.Html Msg
viewWorkshopPage workshop previousPage model =
    Html.h1 [] [ Html.text <| "Workshop Page" ++ workshop.title ]
