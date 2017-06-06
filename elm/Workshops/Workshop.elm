module Workshops.Workshop exposing (viewWorkshopSummary)

import Date
import Html
import Html.Attributes
import Html.Events
import Workshops.Msg exposing (Msg(..))
import Workshops.Types.Workshop exposing (Workshop)

viewWorkshopSummary : Workshop -> Html.Html Msg
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
