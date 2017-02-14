module Types exposing (..)


type Msg
    = Receive String
    | KeepAlive
    | Left  -- 37
    | Up  -- 38
    | Down  -- 40
    | Right  -- 39
    | KeyCode Int


type alias Model =
    { lastMessage : Maybe String
    , lastMove: String
    , keyCode: Int
    }
