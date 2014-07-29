# coq-clarus-clojure-test

Tests for the branch *Clojure* of https://github.com/clarus/coq.

To run the tests, clone the branch *Clojure* of https://github.com/clarus/coq in `coq/`:

    git clone https://github.com/clarus/coq.git
    cd coq/
    git branch Clojure

Then run the `Dokerfile`:

    docker build --tag=coq-clojure .

It will install OCaml and Clojure in a container, compile Coq and run some tests. If you want to connect to the generated image:

    docker run -ti coq-clojure /bin/bash