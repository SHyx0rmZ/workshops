module Workshops.Msg exposing (Msg(..))

import Navigation exposing (Location)
import Workshops.Pages exposing (PageType)

type Msg
    = ChangeLocation Location
    | SwitchPage PageType
