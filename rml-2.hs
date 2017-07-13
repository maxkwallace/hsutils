import System.Environment
import Text.Regex

main = do
  [regexp]:files <- getArgs
  fileContents   <- mapM readFile f
  writeFile g s
