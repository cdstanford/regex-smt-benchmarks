# Boolean Regular Expression SMT Benchmarks

This repository contains a collection of regular expression benchmarks for SMT string solvers.

The focus is on benchmarks which either *explicitly* or *implicitly* incorporate Boolean connectives on regular expressions:

- *Explicit* benchmarks use the syntax `re.comp`, `re.inter`, and `re.diff` to denote complement, intersection, and difference of regular languages.

- *Implicit* benchmarks use multiple constraints to encode a Boolean property: for instance checking if two regular expressions intersect, or if one is a subset of another.

## Sources

With the exception of the **state_space** benchmarks, all benchmarks in this repository were used for the evaluation of our PLDI'21 paper:

- *Symbolic Boolean Derivatives for Efficiently Solving Extended Regular Expression Constraints,* C. Stanford, M. Veanes, and N. Bjørner, PLDI 2021.

Of these, the RegExLib benchmarks were originally created for an SMT'12 paper (which in turn used regexes from [regexlib.com](https://regexlib.com/)), with only the syntax updated for this version:

- *An SMT-LIB Format for Sequences and Regular Expressions,* Nikolaj Bjørner, Vijay Ganesh, Raphael Michel, and Margus Veanes. SMT'12, 2012. [Original Source (dead link)](https://www.microsoft.com/enus/research/wp-content/uploads/2016/02/nbjornermicrosoft.automata.smtbenchmarks.zip).

All the rest are handwritten specific cases, designed to be challenging in various ways.

## Syntax

Benchmarks use the [SMTLib](http://smtlib.cs.uiowa.edu/language.shtml) v2 format. If you notice any out-of-date or wrong syntax, please file an issue or pull request!

## Directory Structure

- **RegExLib (regexlib_membership, regexlib_intersection, regexlib_subset):**
These ask for the answer to a membership, intersection, or containment problem between regular expressions taken from [regexlib.com](regexlib.com), an online library of regular expressions.
Of these, the membership benchmarks do not contain any (explicit or implicit) Boolean combinations.

- **date** contains problems involving constraints on a string to look like a date. For example: a string like `yyyy-mmm-dd`, where if the month is `feb`, then the day must not be `30` or `31`.

- **password** contains problems involving typical constraints on a password string. For example: a password must contain at least one number and letter, and between 8 and 20 characters.

- **boolean_loops** contains regexes where Boolean operations interact with concatenation and iteration, in particular to create nontrivial unsatisfiable regexes.

- **det_blowup** contains classical regex examples which have small nondeterministic state spaces but blowup when determinized, to test efficiency of derivatives in avoiding determinization. For example, these include variants of `(.*a.{k})&(.*b.{k})` where `k` is some positive integer constant.

- **state_space** contains regexes which have large state spaces (either when converted to automata or when explored incrementally using derivatives).
These benchmarks were added to this repository in January 2022.
Many can be immediately determined to be `sat` with direct nonemptiness heuristics, but are intended to push the limits of solvers which do not hardcode an initial nonemptiness check.

## External Links

- [SMTLib Benchmarks](https://clc-gitlab.cs.uiowa.edu:2443/SMT-LIB-benchmarks)

- [The Z3 Theorem Prover](https://github.com/Z3Prover/z3)

- [PLDI21 Paper Artifact](https://github.com/cdstanford/dz3-artifact)
