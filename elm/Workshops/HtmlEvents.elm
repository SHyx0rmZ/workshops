module Workshops.HtmlEvents exposing (onClickPreventingDefault)

import Html exposing (Attribute)
import Html.Events exposing (onWithOptions)
import Json.Decode exposing (succeed)

onClickPreventingDefault : msg -> Attribute msg
onClickPreventingDefault msg =
    onWithOptions "click" ({ stopPropagation = False, preventDefault = True }) (succeed msg)
