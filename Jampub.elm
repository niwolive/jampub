module Jampub exposing (main)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


main : Program Never number (number -> number)
main =
    Html.beginnerProgram
        { model = 0
        , update = \x -> x
        , view = view
        }



-- VIEW


type Styles
    = None
    | CatchLine
    | Home
    | Main
    | NavBar
    | Post
    | Splash


stylesheet : StyleSheet Styles variation
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
            ]
        , style Post
            [ Border.all 1
            , Color.border Color.lightGrey
            ]
        , style CatchLine
            [ Font.size 42
            ]
        ]


view : a -> Html msg
view _ =
    Element.layout stylesheet <|
        column Main
            []
            [ headerView, homeView ]


homeView : Element Styles variation msg
homeView =
    column Home
        [ spacing 40 ]
        [ column Splash
            [ height (px 400), width (percent 100), center, verticalCenter ]
            [ el CatchLine [] (text "Lorem ipsum...")
            , el None [] (text "Dolor. Sit. Amet.")
            ]
        , article <| el Post [ width (percent 100) ] (text "First article")
        ]


headerView : Element Styles variation msg
headerView =
    row NavBar
        [ justify, paddingXY 20 20 ]
        [ text "Welcome"
        , row None
            [ spacing 20 ]
            [ el None [ alignBottom ] (link "http://codewithflair.org" <| text "Blog")
            , el None [ alignBottom ] (link "http://codewithflair.org" <| text "Blog")
            ]
        ]
