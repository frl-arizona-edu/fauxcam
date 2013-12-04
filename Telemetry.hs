{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE TemplateHaskell #-}

module Telemetry where

import Data.ByteString
import Data.MessagePack

data Telemetry = Telemetry
  { width  :: !Int
  , height :: !Int
  , image  :: !ByteString
  } deriving Show

$(deriveObject False ''Telemetry)
