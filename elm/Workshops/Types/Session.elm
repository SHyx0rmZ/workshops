module Workshops.Types.Session exposing (Session)

import Date
import Workshops.Types.Person exposing (Person)

type alias Session =
    { date : Date.Date
    , attendees : Person
    }