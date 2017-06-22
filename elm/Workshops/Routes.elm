module Workshops.Routes exposing (generateUrl, routes)

import UrlParser exposing ((</>), Parser, int, map, oneOf, s)
import Workshops.Model exposing (Model)
import Workshops.Pages exposing (PageType(..))
import Workshops.Workshop exposing (workshopFromId)

generateUrl : PageType -> String
generateUrl page =
    case page of
        ListPage ->
            "/workshops"

        PersonPage ->
            "/dashboard"

        WorkshopPage workshop _ ->
            "/workshops/" ++ toString workshop.id

routes : Model -> Parser (PageType -> a) a
routes model =
    oneOf
        [ map ListPage (s "workshops")
        , map PersonPage (s "dashboard")
        , map (routesHelperWorkshop model) (s "workshops" </> int)
        ]

routesHelperWorkshop : Model -> Int -> PageType
routesHelperWorkshop model id =
    case workshopFromId model id of
        Just workshop ->
            WorkshopPage workshop model.currentPage

        Nothing ->
            ListPage
