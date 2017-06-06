module Workshops.Index exposing (..)

import Date
import Debug
import Html
import Html.Attributes
import Html.Events
import Workshops.Workshop exposing (Workshop, viewSummary)
import Workshops.NavigationBar exposing (CurrentPage(..), viewNavigationBar)

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
        , Html.div [ Html.Attributes.style [ ("display", "grid"), ("grid-template-columns", "1fr 1fr") ] ]
            [ Html.div [ Html.Attributes.style [ ("background", "green") ] ]
                [ Html.h2 [] [ Html.text "Workshops offered" ]
                , Html.ul []
                    <| List.map (\ws -> Html.li [] [ viewSummary ws ]) workshops
                ]
            , Html.div [ Html.Attributes.style [ ("background", "blue") ] ]
                [ Html.h2 [] [ Html.text "Topics wanted" ]
                , Html.ul []
                    [
                    ]
                ]
            ]
        ]

subscriptions _ =
    Sub.none
