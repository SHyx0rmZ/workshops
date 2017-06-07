module Workshops.Types.Workshop exposing (ApiWorkshop, Workshop, workshopFromApi)

import Date exposing (Date, fromString)
import Debug exposing (crash)
import Workshops.Types.Person exposing (Person)
import Workshops.Types.Session exposing (ApiSession, Session, sessionFromApi)

type alias ApiWorkshop =
    { keywords : List String
    , title : String
    , description : String
    , materials : List String
    , prospects : List Int
    , schedule : List ApiSession
    , history : List ApiSession
    , created : String
    , id : Int
    }

type alias Workshop =
    { keywords : List String
    , title : String
    , description : String
    , materials : List String
    , prospects : List Int
    , schedule : List Session
    , history : List Session
    , created : Date
    , id : Int
    }

workshopFromApi : ApiWorkshop -> Workshop
workshopFromApi apiWorkshop =
    case fromString apiWorkshop.created of
        Ok date ->
            Workshop
                apiWorkshop.keywords
                apiWorkshop.title
                apiWorkshop.description
                apiWorkshop.materials
                apiWorkshop.prospects
                (List.map sessionFromApi apiWorkshop.schedule)
                (List.map sessionFromApi apiWorkshop.history)
                date
                apiWorkshop.id

        Err error ->
            {- todo: do something sane instead -}
            crash error
