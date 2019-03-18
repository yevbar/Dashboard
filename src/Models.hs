{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Models where

import GHC.Generics
import Data.Aeson (FromJSON, ToJSON)

data User = User { userId :: Int, userName :: String } deriving (Show, Generic)

instance ToJSON User
instance FromJSON User

bob :: User
bob = User { userId = 1, userName = "bob" }

jenny :: User
jenny = User { userId = 2, userName = "jenny" }

allUsers :: [User]
allUsers = [bob, jenny]

matchesId :: Int -> User -> Bool
matchesId id user = userId user == id
