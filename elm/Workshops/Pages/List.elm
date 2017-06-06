module Workshops.Pages.List exposing (viewListPage)

import Html
import Html.Attributes
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Workshop exposing (Workshop, viewWorkshopSummary)

viewListPage : Model -> Html.Html Msg
viewListPage model =
    Html.div [ Html.Attributes.style [ ("display", "grid"), ("grid-template-columns", "1fr 1fr") ] ]
        [ Html.div [ Html.Attributes.style [ ("background", "green") ] ]
            [ Html.h2 [] [ Html.text "Workshops offered" ]
            , Html.ul []
                <| List.map (\ws -> Html.li [] [ viewWorkshopSummary ws ]) model.workshops
            ]
        , Html.div [ Html.Attributes.style [ ("background", "blue") ] ]
            [ Html.h2 [] [ Html.text "Topics wanted" ]
            , Html.ul []
                [
                ]
            ]
        ]
