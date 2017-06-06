module Workshops.Session exposing (viewSession)

import Date
import Html
import Html.Attributes
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg)
import Workshops.Person exposing (personFromId)
import Workshops.Types.Session exposing (Session)

viewSession : Model -> Session -> Html.Html Msg
viewSession model session =
    Html.table []
        [ Html.tr []
            [ Html.th [] [ Html.text "Date" ]
            , Html.th [] [ Html.text "Attendees" ]
            , Html.th [] [ Html.text "Status" ]
            ]
        , Html.tr []
            [ Html.td [] [ Html.text <| toString session.date ]
            , Html.td []
                [ Html.ul []
                    <| List.map (\ps -> Html.li [] [ Html.text ps.name ])
                    <| List.filterMap (personFromId model) session.attendees
                ]
            , Html.td [] [ Html.text <| toString session.status ]
            ]
        ]
