import Control.Monad
import Options.Applicative
import Data.Semigroup ((<>))

import Text.Regex

data Sample = Sample
  { hello  :: String
  , quiet  :: Bool
  , repeat :: Int }

sample :: Parser Sample
sample = Sample
      <$> strOption
          ( long "hello"
         <> metavar "TARGET"
         <> help "Target for the greeting" )
      <*> switch
          ( long "quiet"
         <> short 'q'
         <> help "Whether to be quiet" )
      <*> option auto
          ( long "repeat"
         <> help "Repeats for greeting"
         <> showDefault
         <> value 1
         <> metavar "INT" )

main :: IO ()
main = greet =<< execParser opts
  where
    opts = info (sample <**> helper)
      ( fullDesc
     <> progDesc "Print a greeting for TARGET"
     <> header "hello - a test for optparse-applicative" )

greet :: Sample -> IO ()
greet (Sample h False n) = Control.Monad.replicateM_ n . putStrLn $ (Text.Regex.subRegex (mkRegex "ello") ("Hello, " ++ h) "foo" :: String)
greet _ = return ()
