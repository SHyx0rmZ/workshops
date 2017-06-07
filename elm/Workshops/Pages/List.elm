module Workshops.Pages.List exposing (viewListPage)

import Html
import Html.Attributes
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Types.Workshop exposing (Workshop)
import Workshops.Workshop exposing (viewWorkshopSummary)

viewListPage : Model -> Html.Html Msg
viewListPage model =
    Html.div [ Html.Attributes.style [ ("display", "grid"), ("grid-template-columns", "1fr 1fr") ] ]
        [ Html.div []
            [ Html.h2 [] [ Html.text "Workshops offered" ]
            , Html.ul []
                <| List.map (\ws -> Html.li [] [ viewWorkshopSummary model.currentPage ws ]) model.workshops
            ]
        , Html.div []
            [ Html.h2 [] [ Html.text "Topics wanted" ]
            , Html.ul [ Html.Attributes.class "keywords" ]
                <| List.map (\kw -> Html.li [] [ Html.text kw ])
                <| List.concat
                <| List.map .keywords model.people
            ]
        ]
