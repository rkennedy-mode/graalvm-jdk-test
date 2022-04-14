# GraalVM JavaScript Testing With Various JVMs

This repository demonstrates testing GraalVM JavaScript execution using the
following configurations:

* GraalVM 1.0.0RC6
* GraalVM 22.0.0.2
* OpenJDK 8 with GraalVM 1.0.0RC6 Polyglot
* OpenJDK 8 with GraalVM 22.0.0.2 Polyglot

The included [Dockerfile](Dockerfile) will build a container with all of the necessary
dependencies to test the above configurations. The [run.sh](run.sh) script can then
be run from within the container to see the results of executing the simple
[TireKick](src/main/java/com/mode/ryankennedy/graalvm/TireKick.java) class, which
evaluates and executes a small JavaScript program.

More details regarding running GraalVM JavaScript on non-GraalVM JVMs is available
in the [Oracle documentation](https://docs.oracle.com/en/graalvm/enterprise/22/docs/reference-manual/js/RunOnJDK/).

## Results

The [results](results.txt) show that execution works in all four configurations.
However, the final configuration (OpenJDK 8 with GraalVM 22.0.0.2 Polyglot) generates
several warnings regarding performance related to being unable to support runtime
compilation.

> [engine] WARNING: The polyglot context is using an implementation that does not support runtime compilation.
> The guest application code will therefore be executed in interpreted mode only.
> Execution only in interpreted mode will strongly impact the guest application performance.
> For more information on using GraalVM see https://www.graalvm.org/java/quickstart/.
> To disable this warning the '--engine.WarnInterpreterOnly=false' option or use the '
> -Dpolyglot.engine.WarnInterpreterOnly=false' system property.
