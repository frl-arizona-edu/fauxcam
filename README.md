fauxcam
=======

Simple on-disk imagery streaming service using MsgPack and ZMQ

### Building
    $ cabal sandbox init
    $ cabal install --only-dependencies
    $ cabal build

 ... and then run the server wth some images

     $ dist/build/fauxcam/fauxcam A.jpg B.jpg C.jpg D.jpg


The services will now be listening on port ```5555``` by default. The EKG services is on port ```8000```
