module Styles exposing (..)

import Color
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


-- STYLES


type Classes
    = None
    | CatchLine
    | Home
    | Main
    | NavBar
    | Post
    | Splash


stylesheet : StyleSheet Classes variation
stylesheet =
    Style.stylesheet
        [ style None []
        , style NavBar
            [ Color.background Color.lightGrey
            , Font.size 16
            ]
        , style Main
            [ Font.typeface [ "DejaVu", "Arial" ]
            ]
        , style Splash
            [ Color.background Color.lightPurple
            , Font.size 23
            ]
        , style Post
            [ Border.all 1
            , Color.border Color.lightGrey
            ]
        , style CatchLine
            [ Font.size 42
            ]
        ]
