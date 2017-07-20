module Jampub exposing (main)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Style exposing (..)
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
    | NavBar
    | Home


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None []
        , style NavBar
            [ Color.background Color.lightGrey
            , Font.typeface [ "DejaVu", "Arial" ]
            , Font.size 16
            ]
        , style Home []
        ]


view : a -> Html msg
view _ =
    Element.layout stylesheet <|
        column None
            []
            [ headerView, homeView ]


homeView : Element Styles variation msg
homeView =
    column Home
        []
        [ article <| el None [] (text "First article")
        , el None [] (text "Second article")
        , el None [] (text "Third article")
        , el None [] (text "Fourth article")
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
