module Workshops.Index exposing (..)

import Date
import Debug
import Html
import Html.Attributes
import Html.Events
import Workshops.Pages exposing (PageType(..))
import Workshops.Pages.List exposing (viewListPage)
import Workshops.Pages.Person exposing (viewPersonPage)
import Workshops.Pages.Workshop exposing (viewWorkshopPage)
import Workshops.Workshop exposing (Workshop)
import Workshops.NavigationBar exposing (viewNavigationBar)

main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

init =
    let
        date =
            case Date.fromString "2017-06-06T00:00:00Z" of
                Ok date ->
                    date

                Err _ ->
                    Debug.crash "failed to initialize"
    in
        { workshops =
            [ Workshop [ "banana", "apple", "fruit" ] "Foo" "Lorem ipsum dolor sit amet." [] [] [] [] date
            , Workshop [ "dog", "cat", "animal" ] "Bar" "Lorem ipsum dolor sit amet." [] [] [] [] date
            ] } ! []

update _ model =
    model ! []

view { workshops } =
    Html.div [ Html.Attributes.style [ ("background", "red") ] ]
        [ viewNavigationBar ListPage
        , viewPage workshops ListPage
        ]

viewPage : List Workshop -> PageType -> Html.Html msg
viewPage workshops currentPage =
    case currentPage of
        ListPage ->
            viewListPage workshops

        PersonPage ->
            viewPersonPage

        WorkshopPage workshop previousPage ->
            viewWorkshopPage workshop previousPage

subscriptions _ =
    Sub.none
