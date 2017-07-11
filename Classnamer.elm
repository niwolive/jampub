module Classnamer exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (property)
import Json.Encode as Encode


className : String -> Attribute msg
className name =
    property "className" (Encode.string name)
