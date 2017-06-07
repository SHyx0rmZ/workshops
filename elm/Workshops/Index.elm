module Workshops.Index exposing (..)

import Date
import Debug
import Html
import Html.Attributes
import Html.Events
import Navigation exposing (Location)
import UrlParser exposing (parsePath)
import Workshops.Flags exposing (Flags)
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.NavigationBar exposing (routes, viewNavigationBar)
import Workshops.Pages exposing (PageType(..))
import Workshops.Pages.List exposing (viewListPage)
import Workshops.Pages.Person exposing (viewPersonPage)
import Workshops.Pages.Workshop exposing (viewWorkshopPage)
import Workshops.Person exposing (personFromId)
import Workshops.Types.Person exposing (Person)
import Workshops.Types.Session exposing (Session, SessionStatus(..))
import Workshops.Types.Workshop exposing (Workshop, workshopFromApi)

determinePage : Model -> Location -> PageType
determinePage model location =
    parsePath (routes model) location
        |> Maybe.withDefault ListPage

init : Flags -> Location -> (Model, Cmd Msg)
init flags location =
    let
        model =
            Model (List.map workshopFromApi flags.workshops) flags.people ListPage 0
    in
        { model | currentPage = determinePage model location } ! []

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
        , Html.node "style" [] [ Html.text ".keywords li + li:before { content: \", \"; } .keywords li { display: inline; } ul.keywords { list-style-type: none; }" ]
        ]

viewPage : Model -> PageType -> Html.Html Msg
viewPage model currentPage =
    case currentPage of
        ListPage ->
            viewListPage model

        PersonPage ->
            let
                person =
                    case personFromId model model.person of
                        Just person ->
                            person

                        Nothing ->
                            Debug.crash "invalid user"
            in
                viewPersonPage person model

        WorkshopPage workshop previousPage ->
            viewWorkshopPage workshop previousPage model
