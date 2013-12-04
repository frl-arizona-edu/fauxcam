{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (forM_)
import qualified Data.ByteString as BS
import Data.MessagePack
import System.ZMQ3.Monadic
import Telemetry

main :: IO ()
main = runZMQ $ do
  liftIO $ putStrLn "Connecting to server.."

  reqSocket <- socket Req
  connect reqSocket "tcp://localhost:5555"

  forM_ [1..] $ \i -> do
    send reqSocket [] "snap"

    reply <- receive reqSocket
    let msg = unpack reply :: Telemetry
        len = BS.length $ image msg

    liftIO $ putStrLn $ unwords [show i, "received", show len, "bytes"]
