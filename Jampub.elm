module Jampub exposing (main)

import Classnamer exposing (className)
import Html exposing (..)
import Html.Attributes exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { greetings : String }


model : Model
model =
    { greetings = "Well, that's a start." }



-- UPDATE


type alias Msg =
    String


update : Msg -> Model -> Model
update msg model =
    { model | greetings = msg }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ headerView model, homeView model ]


homeView : Model -> Html Msg
homeView model =
    div [ className "home" ]
        [ article [] [ text "First article" ]
        , article [] [ text "Second article" ]
        ]


headerView : Model -> Html Msg
headerView model =
    header [ className "header" ]
        [ text "Welcome"
        , nav []
            [ a [ href "http://codewithflair.org" ] [ text "Blog" ]
            , a [ href "http://codewithflair.org" ] [ text "Blog" ]
            ]
        ]
