module Workshops.Workshop exposing (viewWorkshopDetails, viewWorkshopSummary, workshopFromId, workshopFromTitle)

import Date
import Html
import Html.Attributes
import Html.Events
import Workshops.HtmlEvents exposing (onClickPreventingDefault)
import Workshops.Model exposing (Model)
import Workshops.Msg exposing (Msg(..))
import Workshops.Pages exposing (PageType(..))
import Workshops.Session exposing (viewSession)
import Workshops.Types.Workshop exposing (Workshop)

viewWorkshopDetails : Model -> Workshop -> Html.Html Msg
viewWorkshopDetails model workshop =
    Html.div []
        [ Html.h3 [] [ Html.text workshop.title ]
        , Html.p [] [ Html.text workshop.description ]
        , Html.span []
            [ Html.ul [ Html.Attributes.class "keywords" ]
                <| List.map (\kw -> Html.li [] [ Html.text kw ]) workshop.keywords
            ]
        , Html.h4 [] [ Html.text "Materials" ]
        , Html.ul []
            <| List.map (\mt -> Html.li [] [ Html.text mt ]) workshop.materials
        , Html.h4 [] [ Html.text "Prospects" ]
        , Html.ul []
            <| List.map (\ps -> Html.li [] [ Html.text ps.name ])
            <| List.filter (\ps -> List.any (\kw -> List.member kw workshop.keywords) ps.keywords)
            <| List.concat
            <| List.map (\psi -> List.filter (\ps -> ps.id == psi) model.people) workshop.prospects
        , Html.h4 [] [ Html.text "Schedule" ]
        , Html.ul []
            <| List.map (\html -> Html.li [] [ html ])
            <| List.map (viewSession model) workshop.schedule
        , Html.h4 [] [ Html.text "History" ]
        , Html.ul []
            <| List.map (\html -> Html.li [] [ html ])
            <| List.map (viewSession model) workshop.history
        ]

viewWorkshopSummary : PageType -> Workshop -> Html.Html Msg
viewWorkshopSummary currentPage workshop =
    Html.a [ Html.Attributes.href <| "/workshops/" ++ toString workshop.id, onClickPreventingDefault <| SwitchPage <| WorkshopPage workshop currentPage ]
        [ Html.div []
            [ Html.h3 [] [ Html.text workshop.title ]
            , Html.p [] [ Html.text workshop.description ]
            , Html.span [ Html.Attributes.class "keywords" ]
                [ Html.ul []
                    <| List.map (\kw -> Html.li [ Html.Attributes.style [ ("display", "inline") ] ] [ Html.text kw ]) workshop.keywords
                ]
            ]
        ]

workshopFromId : Model -> Int -> Maybe Workshop
workshopFromId model id =
    model.workshops
        |> List.filter (.id >> (==) id)
        |> List.head

workshopFromTitle : Model -> String -> Maybe Workshop
workshopFromTitle model title =
    model.workshops
        |> List.filter (.title >> (==) title)
        |> List.head
