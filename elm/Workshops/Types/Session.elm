module Workshops.Types.Session exposing (ApiSession, Session, SessionStatus(..), sessionFromApi)

import Date exposing (Date, fromString)
import Debug exposing (crash)

type alias ApiSession =
    { date : String
    , attendees : List Int
    , status : String
    }

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

sessionFromApi : ApiSession -> Session
sessionFromApi apiSession =
    case fromString apiSession.date of
        Ok date ->
            Session
                date
                apiSession.attendees
                (sessionStatusFromApi apiSession.status)

        Err error ->
            {- todo: do something sane instead -}
            crash error

sessionStatusFromApi : String -> SessionStatus
sessionStatusFromApi status =
    case status of
        "approved" ->
            SessionApproved

        "held" ->
            SessionHeld

        "pending" ->
            SessionPending

        "rejected" ->
            SessionRejected

        _ ->
            crash <| "invalid session status from API: " ++ status
