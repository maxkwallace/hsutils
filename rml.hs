import System.Environment
import Text.Regex
import Text.Regex.Posix
import System.Directory
import Data.List

main = do
  regex:filepaths <- getArgs

  putStrLn ("Regex: " ++ regex)
  putStrLn ("Files: " ++ (intercalate ", " filepaths))

  mapM_ (replaceFile regex) filepaths

replaceFile regex path = do
  content <- readFile path
  writeFile (path ++ ".bak") (removeMatchingLines regex content)
  renameFile (path ++ ".bak") path

removeMatchingLines regex content =
  unlines (filter (doesNotMatch regex) (lines content))

doesNotMatch :: String -> String -> Bool
doesNotMatch regex string = not (regex =~ string)
