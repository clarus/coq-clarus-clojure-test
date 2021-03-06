FROM ubuntu
MAINTAINER Guillaume Claret

RUN apt-get update && apt-get upgrade -y

# OCaml
RUN apt-get install -y ocaml camlp4-extra

# Clojure with Leiningen
RUN apt-get install -y wget default-jre-headless
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/bin/lein
RUN chmod +x /usr/bin/lein
RUN lein
ENV LEIN_ROOT true

# Compile Coq
RUN apt-get install -y make
ADD coq /root/coq
WORKDIR /root/coq
RUN yes "" |./configure -no-native-compiler
RUN make -j8
RUN make install

# Run the tests.
RUN apt-get install -y ruby
ADD sample-app /root/sample-app
ADD tests /root/tests
WORKDIR /root/tests
RUN ruby run.rb