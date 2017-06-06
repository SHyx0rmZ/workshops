module Workshops.NavigationBar exposing (viewNavigationBar)

import Html
import Html.Attributes
import Html.Events
import Workshops.Msg exposing (Msg(..))
import Workshops.Pages exposing (PageType(..))
import Workshops.Workshop exposing (Workshop)

viewNavigationBar : PageType -> Html.Html Msg
viewNavigationBar currentPage =
    Html.nav [ Html.Attributes.style [ ("background", "red"), ("display", "flex"), ("flex-direction", "row"), ("justify-content", "space-between"), ("align-items", "flex-start") ] ]
        [ viewMainLink currentPage
        , Html.div [ Html.Attributes.style [ ("align-self", "flex-end") ] ]
            [ Html.input [ Html.Attributes.placeholder "Keywords" ] []
            , Html.button [] [ Html.text "Search" ]
            ]
        ]

viewMainLink : PageType -> Html.Html Msg
viewMainLink currentPage =
    case currentPage of
        ListPage ->
            Html.a [ Html.Attributes.href "#", Html.Events.onClick <| SwitchPage PersonPage ] [ Html.text "Your dashboard" ]

        PersonPage ->
            Html.a [ Html.Attributes.href "#", Html.Events.onClick <| SwitchPage ListPage ] [ Html.text "Workshop list" ]

        WorkshopPage workshop previousPage ->
            viewMainLink previousPage