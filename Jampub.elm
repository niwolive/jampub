module Jampub exposing (main)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Styles exposing (..)
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


view : Model -> Html msg
view model =
    Element.layout stylesheet <|
        column Main
            [ width (percent 100) ]
            [ headerView model.device, homeView model.device ]


headerView : Device -> Element Classes variation msg
headerView device =
    row NavBar
        (if device.phone || device.tablet then
            [ alignLeft, padding 20 ]
         else
            [ justify
            , dynamicPaddingX device.width 20
            ]
        )
        [ text "Welcome"
        , row None
            [ spacing 20 ]
            [ el None [ alignBottom ] (link "http://codewithflair.org" <| text "Blog")
            , el None [ alignBottom ] (link "http://codewithflair.org" <| text "Blog")
            ]
        ]


homeView : Device -> Element Classes variation msg
homeView device =
    column Home
        [ spacingXY 0 40 -- TODO report issue here, we should be able to use spacing 40 without having the horizontal scroll
        , dynamicPaddingX device.width 0
        ]
        [ empty -- This is a hack until issue #47 of the style-elements library gets solved
        , full None
            []
            (column Splash
                [ height (px 400), width (fill 1), center, verticalCenter ]
                [ el CatchLine [] (text "Lorem ipsum...")
                , el None [] (text "Dolor. Sit. Amet.")
                ]
            )
        , article <|
            el Post
                [ width (fill 1), height (px 200), padding 10 ]
                (text "First article")
        , article <|
            el Post
                [ width (fill 1), height (px 200), padding 10 ]
                (text "Second article")
        ]



-- HELPERS


dynamicPaddingX : Int -> Int -> Attribute variation msg
dynamicPaddingX width paddingY =
    paddingXY
        -- TODO instead of hard-wiring 1024 here, see if it's possible to get a value from the Device module
        (if width > 1024 then
            (toFloat width - 1024) / 2
         else
            0
        )
        (toFloat paddingY)
