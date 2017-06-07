module Workshops.Index exposing (..)

import Date
import Debug
import Html
import Html.Attributes
import Html.Events
import Navigation exposing (Location)
import Workshops.Flags exposing (Flags)
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.NavigationBar exposing (viewNavigationBar)
import Workshops.Pages exposing (PageType(..))
import Workshops.Pages.List exposing (viewListPage)
import Workshops.Pages.Person exposing (viewPersonPage)
import Workshops.Pages.Workshop exposing (viewWorkshopPage)
import Workshops.Types.Person exposing (Person)
import Workshops.Types.Session exposing (Session, SessionStatus(..))
import Workshops.Types.Workshop exposing (Workshop)

init : Flags -> Location -> (Model, Cmd Msg)
init flags location =
    Model initWorkshops initPeople ListPage 0 ! []

initPeople : List Person
initPeople =
    let
        date =
            case Date.fromString "2017-06-06T00:00:00Z" of
                Ok date ->
                    date

                Err _ ->
                    Debug.crash "failed to initialize"
    in
        [ Person "Hans Wurst" [ "cat", "fish" ] [ "Foo" ] 0 "hans.wurst@example.com"
        , Person "Horst Semmel" [ "banana", "fruit" ] [] 1 "horst.semmel@example.com"
        ]

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
        [ Workshop [ "banana", "apple", "fruit" ] "Foo" "Lorem ipsum dolor sit amet." [] [] [] [ Session date [ 0, 1 ] SessionApproved  ] date 0
        , Workshop [ "dog", "cat", "animal" ] "Bar" "Lorem ipsum dolor sit amet." [ "http://example.com/Bar.pdf" ] [ 0 ] [ Session date [ 0 ] SessionRejected ] [] date 1
        ]

main : Program Flags Model Msg
main =
    Navigation.programWithFlags ChangeLocation
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
        ChangeLocation location ->
            model ! []

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
            let
                person =
                    case List.head <| List.filter (\ps -> ps.id == model.person) model.people of
                        Just person ->
                            person

                        Nothing ->
                            Debug.crash "invalid user"
            in
                viewPersonPage person model

        WorkshopPage workshop previousPage ->
            viewWorkshopPage workshop previousPage model
