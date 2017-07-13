import System.Environment
import System.Directory
import Data.List
import Control.Monad

import Text.Regex
import Text.Regex.PCRE

main = do
  regex:filepaths <- getArgs

  putStrLn ("Regex: " ++ regex)
  putStrLn ((formatFilepaths filepaths) ++ "\n")

  putStrLn "Modified:"
  mapM_ (replaceFile regex) filepaths
  -- putStrLn "Modified " ++ (show (length modifiedFiles)) ++ " files:"
  -- putStrLn (intercalate "\n" modifiedFiles)

replaceFile regex path = do
  content <- readFile path
  let newContent = applyRegex regex content

  if content == newContent
  then return ()
  else modifyFile path newContent

applyRegex regex content =
  subRegex (mkRegex regex) content ""

formatFilepaths filepaths =
  "Files " ++
  "(" ++ (show (length filepaths)) ++ " total): " ++
  (if (length filepaths) > 3
    then (intercalate ", " (take 3 filepaths)) ++ " ..."
    else (intercalate ", " filepaths)
  )

modifyFile path newContent = do
  writeFile (path ++ ".bak") newContent
  renameFile (path ++ ".bak") path
  putStrLn path
