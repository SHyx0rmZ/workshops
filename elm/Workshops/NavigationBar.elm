module Workshops.NavigationBar exposing (routes, viewNavigationBar)

import Html
import Html.Attributes
import Html.Events
import UrlParser exposing ((</>), Parser, int, map, oneOf, s)
import Workshops.HtmlEvents exposing (onClickPreventingDefault)
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Pages exposing (PageType(..))
import Workshops.Types.Workshop exposing (Workshop)
import Workshops.Workshop exposing (workshopFromId)

routes : Model -> Parser (PageType -> a) a
routes model =
    oneOf
        [ map ListPage (s "workshops")
        , map PersonPage (s "dashboard")
        , map (routesHelperWorkshop model) (s "workshops" </> int)
        ]

routesHelperWorkshop : Model -> Int -> PageType
routesHelperWorkshop model id =
    case workshopFromId model id of
        Just workshop ->
            WorkshopPage workshop ListPage

        Nothing ->
            ListPage

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
    Html.a [ Html.Attributes.href "/workshops", onClickPreventingDefault <| SwitchPage ListPage ] [ Html.text "Workshop list" ]

viewMainLinkPersonPage : Html.Html Msg
viewMainLinkPersonPage =
    Html.a [ Html.Attributes.href "/dashboard", onClickPreventingDefault <| SwitchPage PersonPage ] [ Html.text "Your dashboard" ]

viewNavigationBar : PageType -> Html.Html Msg
viewNavigationBar currentPage =
    Html.nav [ Html.Attributes.style [ ("display", "flex"), ("flex-direction", "row"), ("justify-content", "space-between"), ("align-items", "flex-start") ] ]
        [ viewMainLink currentPage
        , Html.div [ Html.Attributes.style [ ("align-self", "flex-end") ] ]
            [ Html.input [ Html.Attributes.placeholder "Keywords" ] []
            , Html.button [] [ Html.text "Search" ]
            ]
        ]