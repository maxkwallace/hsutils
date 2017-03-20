import System.Environment
import System.Directory
import Data.List

import Text.Regex
import Text.Regex.PCRE

main = do
  regex:filepaths <- getArgs

  putStrLn ("Regex: " ++ regex)
  putStrLn ("Files: " ++ (intercalate ", " filepaths))

  mapM_ (replaceFile regex) filepaths

replaceFile regex path = do
  content <- readFile path
  writeFile (path ++ ".bak") (applyRegex regex content)
  renameFile (path ++ ".bak") path

applyRegex regex content =
  subRegex (mkRegex regex) content ""
