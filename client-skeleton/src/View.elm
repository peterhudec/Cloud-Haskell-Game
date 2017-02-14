module View exposing (root)

import CDN exposing (bootstrap)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div
        [ style
            [ ( "padding", "15px" )
            , ( "display", "flex" )
            , ( "flex-direction", "column" )
            ]
        ]
        [ bootstrap.css
        , button [ onClick Left ] [ text "left" ]
        , button [ onClick Right ] [ text "right" ]
        , button [ onClick Up ] [ text "up" ]
        , button [ onClick Down ] [ text "down" ]
        , div [] [ code [] [ text <| model.lastMove ] ]
        , div [] [ code [] [ text <| toString model.keyCode ] ]
        , div [] [ code [] [ text <| toString model ] ]
        ]
