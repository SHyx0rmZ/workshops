module Workshops.NavigationBar exposing (viewNavigationBar)

import Html
import Html.Attributes
import Html.Events
import Workshops.HtmlEvents exposing (onClickPreventingDefault)
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Pages exposing (PageType(..))
import Workshops.Routes exposing (generateUrl)
import Workshops.Types.Workshop exposing (Workshop)
import Workshops.Workshop exposing (workshopFromId)

viewMainLink : PageType -> Html.Html Msg
viewMainLink currentPage =
    case currentPage of
        ListPage ->
            viewMainLinkPersonPage

        PersonPage ->
            viewMainLinkListPage

        WorkshopPage workshop previousPage ->
            case previousPage of
                ListPage ->
                    viewMainLinkListPage

                PersonPage ->
                    viewMainLinkPersonPage

                WorkshopPage _ _ ->
                    viewMainLink previousPage

viewMainLinkListPage : Html.Html Msg
viewMainLinkListPage =
    Html.a [ Html.Attributes.href <| generateUrl ListPage, onClickPreventingDefault <| SwitchPage ListPage ] [ Html.text "Workshop list" ]

viewMainLinkPersonPage : Html.Html Msg
viewMainLinkPersonPage =
    Html.a [ Html.Attributes.href <| generateUrl PersonPage, onClickPreventingDefault <| SwitchPage PersonPage ] [ Html.text "Your dashboard" ]

viewNavigationBar : PageType -> Html.Html Msg
viewNavigationBar currentPage =
    Html.nav [ Html.Attributes.style [ ("display", "flex"), ("flex-direction", "row"), ("justify-content", "space-between"), ("align-items", "flex-start") ] ]
        [ viewMainLink currentPage
        , Html.div [ Html.Attributes.style [ ("align-self", "flex-end") ] ]
            [ Html.input [ Html.Attributes.placeholder "Keywords" ] []
            , Html.button [] [ Html.text "Search" ]
            ]
        ]