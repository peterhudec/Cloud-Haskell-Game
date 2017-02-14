module State exposing (init, update, subscriptions)

import Response exposing (..)
import Types exposing (..)
import WebSocket
import Keyboard


websocketEndpoint : String
websocketEndpoint =
    "ws://game.clearercode.com:8000"


init : Response Model Msg
init =
    ( { lastMessage = Nothing
      , lastMove = ""
      , keyCode = 0
      }
    , Cmd.none
    )

update : Msg -> Model -> Response Model Msg
update msg model =
    case msg of
        KeyCode keyCode ->
            ( { model | keyCode = keyCode }
            , WebSocket.send websocketEndpoint "{\"tag\": \"SetColor\", \"contents\": \"lime\"}" )
        Left ->
            ( { model | lastMove = "left" }
            , WebSocket.send websocketEndpoint "{\"tag\": \"Move\", \"contents\": {\"x\": -1, \"y\": 0}}" )
        Right ->
            ( { model | lastMove = "right" }
            , WebSocket.send websocketEndpoint "{\"tag\": \"Move\", \"contents\": {\"x\": 1, \"y\": 0}}" )
        Up ->
            ( { model | lastMove = "top" }
            , WebSocket.send websocketEndpoint "{\"tag\": \"Move\", \"contents\": {\"x\": 0, \"y\": -1}}" )
        Down ->
            ( { model | lastMove = "bottom" }
            , WebSocket.send websocketEndpoint "{\"tag\": \"Move\", \"contents\": {\"x\": 0, \"y\": 1}}" )
        KeepAlive ->
            ( model, Cmd.none )
        Receive response ->
            ( { model | lastMessage = Just response }
            , Cmd.none
            )

keyCodeToMessage keyCode =
  case keyCode of
    37 ->
      Left
    38 ->
      Up
    40 ->
      Down
    39 ->
      Right
    _ ->
      KeyCode keyCode


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ WebSocket.listen websocketEndpoint Receive
        , WebSocket.keepAlive websocketEndpoint
            |> Sub.map (always KeepAlive)
        -- , Keyboard.ups (\keyCode -> KeyCode keyCode)
        , Keyboard.ups keyCodeToMessage
        ]
