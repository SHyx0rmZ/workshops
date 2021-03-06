module Workshops.Pages.Person exposing (viewPersonPage)

import Html
import Html.Attributes
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Types.Person exposing (Person)
import Workshops.Workshop exposing (viewWorkshopSummary, workshopFromTitle)

viewPersonPage : Person -> Model -> Html.Html Msg
viewPersonPage person model =
    Html.div [ Html.Attributes.style [ ("display", "grid"), ("grid-template-columns", "1fr 1fr") ] ]
        [ Html.div []
            [ Html.h2 [] [ Html.text "Workshops I offer" ]
            , Html.ul []
                <| List.map (\ws -> Html.li [] [ viewWorkshopSummary model.currentPage ws ])
                <| List.filterMap (workshopFromTitle model) person.workshops
            ]
        , Html.div []
            [ Html.h2 [] [ Html.text "Topics wanted" ]
            , Html.ul [ Html.Attributes.class "keywords" ]
                <| List.map (\kw -> Html.li [] [ Html.text kw ]) person.keywords
            ]
        ]
