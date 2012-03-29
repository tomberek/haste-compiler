{-# LANGUAGE ForeignFunctionInterface, EmptyDataDecls #-}
module Haste (alert, prompt, eval, round_, fromInt,
              module Haste.Readable, module Haste.Showable,
              module Haste.Callback, module Haste.Random) where
import Haste.Prim
import Haste.Readable
import Haste.Showable
import Haste.Callback
import Haste.Random

foreign import ccall jsAlert  :: JSString -> IO ()
foreign import ccall jsPrompt :: JSString -> IO JSString
foreign import ccall jsEval   :: JSString -> IO JSString

-- | Javascript alert() function.
alert :: String -> IO ()
alert = jsAlert . toJSStr

-- | Javascript prompt() function.
prompt :: String -> IO String
prompt q = do
  a <- jsPrompt (toJSStr q)
  return (fromJSStr a)

-- | Javascript eval() function.
eval :: String -> IO String
eval js = jsEval (toJSStr js) >>= return . fromJSStr