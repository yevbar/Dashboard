{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Routes where

import GHC.Generics
import Data.Aeson (FromJSON, ToJSON)
import Data.Monoid ((<>))

import Web.Scotty

import Models

routes :: ScottyM ()
routes = do
  get "/" index
  get "/Index.js" indexJs
  get "/styles.css" cssStyles
  get "/hello/:name" helloName
  get "/bob" getBob
  get "/users" getUsers
  get "/users/:id" getUser

index :: ActionM ()
index = do
  file (formatStaticFilePath "index.html")

indexJs :: ActionM ()
indexJs = do
  file (formatStaticFilePath "Index.js")

cssStyles :: ActionM ()
cssStyles = do
  file (formatStaticFilePath "styles.css")

hello :: ActionM ()
hello = do
  text "Hello World!"

helloName :: ActionM ()
helloName = do
  name <- param "name"
  if name == "" then text ("hey bro!")
  else text ("hello " <> name <> "!")

getBob :: ActionM ()
getBob = do
  json bob

getUser :: ActionM ()
getUser = do
  id <- param "id"
  json (filter (matchesId id) allUsers)

getUsers :: ActionM ()
getUsers = do
  json allUsers

formatStaticFilePath :: String -> String
formatStaticFilePath fileName = ("src/site/build/" <> fileName)