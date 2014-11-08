import Control.Parallel

sfib n | n < 2 = 1
sfib n = sfib (n-1) + sfib (n-2)

fib :: Integer -> Integer -> Integer
fib 0 n = sfib n
fib _ n | n < 2 = 1
fib d n = nf1 `par` (nf2 `pseq` nf2 + nf1 + 1)
           where nf1 = fib (d-1) (n-1)
                 nf2 = fib (d-1) (n-2)

main = print $ fib 4 4

