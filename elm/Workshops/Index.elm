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
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.NavigationBar exposing (viewNavigationBar)
import Workshops.Workshop exposing (Workshop)

init : (Model, Cmd Msg)
init =
        Model initWorkshops ListPage ! []

initWorkshops : List Workshop
initWorkshops =
    let
        date =
            case Date.fromString "2017-06-06T00:00:00Z" of
                Ok date ->
                    date

                Err _ ->
                    Debug.crash "failed to initialize"
    in
        [ Workshop [ "banana", "apple", "fruit" ] "Foo" "Lorem ipsum dolor sit amet." [] [] [] [] date
        , Workshop [ "dog", "cat", "animal" ] "Bar" "Lorem ipsum dolor sit amet." [] [] [] [] date
        ]

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SwitchPage newPage ->
            { model | currentPage = newPage } ! []

view : Model -> Html.Html Msg
view model =
    Html.div []
        [ viewNavigationBar model.currentPage
        , viewPage model model.currentPage
        ]

viewPage : Model -> PageType -> Html.Html Msg
viewPage model currentPage =
    case currentPage of
        ListPage ->
            viewListPage model

        PersonPage ->
            viewPersonPage model

        WorkshopPage workshop previousPage ->
            viewWorkshopPage workshop previousPage model
