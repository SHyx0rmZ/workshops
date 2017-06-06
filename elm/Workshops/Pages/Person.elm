module Workshops.Pages.Person exposing (viewPersonPage)

import Html
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))

viewPersonPage : Model -> Html.Html Msg
viewPersonPage model =
    Html.h1 [] [ Html.text "Person Page" ]
