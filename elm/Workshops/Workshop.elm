module Workshops.Workshop exposing (..)

import Date
import Html
import Html.Attributes
import Html.Events

type alias Person =
    { name : String
    }

type alias Session =
    { date : Date.Date
    , attendees : Person
    }

type alias Keywords = List String

type alias Workshop =
    { keywords : List String
    , title : String
    , description : String
    , materials : List String
    , prospects : List Person
    , calendar : List Session
    , history : List Session
    , created : Date.Date
    }

viewWorkshopSummary workshop =
    Html.div []
        [ Html.h3 [] [ Html.text workshop.title ]
        , Html.p [] [ Html.text workshop.description ]
        , Html.node "style" [] [ Html.text "li + li:before { content: \", \"; }" ]
        , Html.span []
            [ Html.ul [ Html.Attributes.style [ ("list-style-type", "content(', ')") ] ]
                <| List.map (\kw -> Html.li [ Html.Attributes.style [ ("display", "inline") ] ] [ Html.text kw ]) workshop.keywords
            ]
        ]
