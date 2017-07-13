myFunc s = unlines (map reverse (lines s))

main = interact myFunc
