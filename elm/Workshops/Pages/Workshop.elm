module Workshops.Pages.Workshop exposing (viewWorkshopPage)

import Html
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Pages exposing (PageType)
import Workshops.Types.Workshop exposing (Workshop)
import Workshops.Workshop exposing (viewWorkshopDetails)

viewWorkshopPage : Workshop -> PageType -> Model -> Html.Html Msg
viewWorkshopPage workshop previousPage model =
    viewWorkshopDetails model workshop
