module Jampub exposing (main)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Task exposing (..)
import Window


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { device : Device
    }


init : ( Model, Cmd Msg )
init =
    ( { device = Element.classifyDevice (Window.Size 0 0) }
    , Task.perform Resize Window.size
    )



-- UPDATE


type Msg
    = Resize Window.Size


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resize newSize ->
            ( { model | device = Element.classifyDevice newSize }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes Resize



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


view : Model -> Html msg
view model =
    Element.layout stylesheet <|
        column Main
            []
            [ headerView model.device, homeView model.device.width ]


homeView : Int -> Element Styles variation msg
homeView viewportWidth =
    column Home
        [ spacing 40, paddingXY ((toFloat viewportWidth - 1024) / 2) 20 ]
        [ column Splash
            [ height (px 400), width (percent 100), center, verticalCenter ]
            [ el CatchLine [] (text "Lorem ipsum...")
            , el None [] (text "Dolor. Sit. Amet.")
            ]
        , article <| el Post [ width (percent 100) ] (text "First article")
        ]


headerView : Device -> Element Styles variation msg
headerView device =
    row NavBar
        (if device.phone || device.tablet then
            [ justify, paddingXY ((toFloat device.width - 1024) / 2) 20 ]
         else
            [ alignRight ]
        )
        [ text "Welcome"
        , row None
            [ spacing 20 ]
            [ el None [ alignBottom ] (link "http://codewithflair.org" <| text "Blog")
            , el None [ alignBottom ] (link "http://codewithflair.org" <| text "Blog")
            ]
        ]
