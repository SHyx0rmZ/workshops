module Workshops.Pages.Person exposing (viewPersonPage)

import Html
import Html.Attributes
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Types.Person exposing (Person)
import Workshops.Workshop exposing (viewWorkshopSummary)

viewPersonPage : Person -> Model -> Html.Html Msg
viewPersonPage person model =
    Html.div [ Html.Attributes.style [ ("display", "grid"), ("grid-template-columns", "1fr 1fr") ] ]
        [ Html.div [ Html.Attributes.style [ ("background", "green") ] ]
            [ Html.h2 [] [ Html.text "Workshops I offer" ]
            , Html.ul []
                <| List.map (\ws -> Html.li [] [ viewWorkshopSummary ws ])
                <| List.concat
                <| List.map (\wsn -> List.filter (\ws -> ws.title == wsn) model.workshops) person.workshops
            ]
        , Html.div [ Html.Attributes.style [ ("background", "blue") ] ]
            [ Html.h2 [] [ Html.text "Topics wanted" ]
            , Html.ul []
                <| List.map (\kw -> Html.li [] [ Html.text kw ]) person.keywords
            ]
        ]
