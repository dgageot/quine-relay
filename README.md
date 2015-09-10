# What's that?

[Quine relay](https://github.com/mame/quine-relay) implemented with a network ring of Docker containers.

Aka, "The most expensive `echo QR.rb` script ever".

# Create the cluster

```bash
./cluster.sh
```

This will build a Docker image with every 100 languages installed in it.
That's a large image we are talking about. Maybe too big for the default
virtualbox based boot2docker. [I warned you](https://www.youtube.com/watch?v=7Q8hAb230OE).

In an ideal world it would build 100 different images with
only what's needed to compile and run a single language.
I'm open to pull requests.

Then it will start 100 linked containers to create an oriented
ring.

Eventually it'll print merged logs for all 100 containers.

You should seen empty logs. Don't panic! Our next action is to awake the monster.

# Post the QR.rb ruby source code

From a different terminal:

```bash
./client.sh
```

It'll post the `QR.rb` file to the first node of the ring (not a movie).
On each node, the source code will be compiled, then executed.
It'll produce a source code recognizable by the next node of the ring.
So on and so on.
Nodes communicate through http posts.
Once all 100 nodes are visited, the client will get as an answer the exact
same ruby code it sent in the first place.

How cool is that?

# Was it worth it?

Of course it was!
