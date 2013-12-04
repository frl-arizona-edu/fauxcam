{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.MessagePack
import System.Environment (getArgs)
import System.Remote.Monitoring
import System.ZMQ3.Monadic
import Telemetry

main :: IO ()
main = runZMQ $ do
  _ <- liftIO $ forkServer "localhost" 8000

  liftIO $ putStrLn "Reading in telemetry.."

  telemetries <- liftIO $ do
    filepaths <- getArgs
    forM filepaths $ \fp -> do
      contents <- BS.readFile fp
      return $ pack Telemetry{width = 3264, height = 2448, image = contents}

  repSocket <- socket Rep
  bind repSocket "tcp://*:5555"

  liftIO $ putStrLn "Waiting for clients.."

  forM_ (cycle telemetries) $ \t -> do
    _ <- receive repSocket
    send repSocket [] (BS.concat $ BL.toChunks t)
