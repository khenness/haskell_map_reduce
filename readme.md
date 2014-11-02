Assignment brief:

MapReduce is normally described as a parallel algorithm, and it's easy to see how we would add 'par' and 'seq' annotations to the basic implementation we studied in lecture set 5 to introduce some parallelism (at least in principle; as we have also seen getting the granularity right might take some thinking).
On slide 138, after seeing a simple "executable specification" of MapReduce I suggested that it would be interesting to extend our implementation so that it was capable of exploiting some real parallelism. You will explore building such an implementation in this project.
Your goal in this project is to design and implement a MapReduce framework that can be used to solve a simple task. Your framework should also come with an example program that can calculate a word count table for a text file. The output of the program should be an alphabetical listing of each distinct word in the file, along with a number showing how frequently the word occurred. Ideally the program can be configured to use a variable number of mappers (so that we can tune the amount of parallelism to match what's available on a given platform).
What to submit
All your Haskell source files, sensibly named (for example: part01.hs, part02.hs, and so on). Each source file should contain a comment with the ghc command line needed to compile it and any other information I might need like RTS arguments you think running it will require). I plan to test with a recent Haskell Platform release (so you can expect ghc 7.6.3 or ghc 7.8.3)

Part 1.
Start simple: take the MapReduce framework from the lectures and use it to provide an implementation of the word counting program. Don't worry about generating any real parallelism.
Part 2.
Using Control.Parallel (and related modules if you like), add some real Parallel processing. There are several obvious places to include parallelism, but you should at least make sure your system does parallel mapping. Better if it tries to exploit some parallelism in the reduction phase as well (but it's more important to have parallel mapping).
Part 3
Benchmark your program (don't just time it, profile it: use ThreadScope to get some real figures for how much work is being done in parallel). You will probably find you need to tune the placement of par and seq annotations in your program to get good performance, so there will be a new version of the MapReduce framework from this part (and maybe a newly tweaked word count program too). To justify the changes you have made include documentation of the before and after profiles to show what has changed, and explain why you needed to make the changes you did!
Part 4
Julian Porter has described a rather nice way of representing MapReduce as a monad. His paper even includes the same example program we were using (what a coincidence!).
Following his design, or some other way (if you prefer), design a MapReduce monad which uses concurrency rather than parallelism. That is, use forkIO to generate new execution threads for the mappers (and perhaps the reducers), and split the access to the data sets so that the individual threads are scheduled reasonably fairly.
