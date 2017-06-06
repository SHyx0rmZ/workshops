module Workshops.Types.Session exposing (Session)

import Date

type alias Session =
    { date : Date.Date
    , attendees : List Int
    }