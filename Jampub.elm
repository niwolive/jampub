module Jampub exposing (main)

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
    div [ class "home" ]
        [ article [] [ text "First article" ]
        , article [] [ text "Second article" ]
        , article [] [ text "Third article" ]
        ]


headerView : Model -> Html Msg
headerView model =
    header [ class "header" ]
        [ text "Welcome"
        , nav []
            [ a [ href "http://codewithflair.org" ] [ text "Blog" ]
            , a [ href "http://codewithflair.org" ] [ text "Blog" ]
            ]
        ]
