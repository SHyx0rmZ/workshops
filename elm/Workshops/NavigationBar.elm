module Workshops.NavigationBar exposing (..)

import Html
import Html.Attributes
import Html.Events
import Workshops.Workshop exposing (Workshop)

type CurrentPage
    = ListPage
    | PersonPage
    | WorkshopPage Workshop CurrentPage

viewTopLink : CurrentPage -> Html.Html msg
viewTopLink currentPage =
    case currentPage of
        ListPage ->
            Html.a [ Html.Attributes.href "#" ] [ Html.text "Your dashboard" ]

        PersonPage ->
            Html.a [ Html.Attributes.href "#" ] [ Html.text "Workshop list" ]

        WorkshopPage workshop previousPage ->
            viewTopLink previousPage

viewNavigationBar : CurrentPage -> Html.Html msg
viewNavigationBar currentPage =
    Html.nav [ Html.Attributes.style [ ("display", "flex"), ("flex-direction", "row"), ("justify-content", "space-between"), ("align-items", "flex-start") ] ]
        [ viewTopLink currentPage
        , Html.div [ Html.Attributes.style [ ("align-self", "flex-end") ] ]
            [ Html.input [ Html.Attributes.placeholder "Keywords" ] []
            , Html.button [] [ Html.text "Search" ]
            ]
        ]
