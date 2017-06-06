module Workshops.Types.Session exposing (Session, SessionStatus(..))

import Date

type alias Session =
    { date : Date.Date
    , attendees : List Int
    , status : SessionStatus
    }

type SessionStatus
    = SessionApproved
    | SessionHeld
    | SessionPending
    | SessionRejected
