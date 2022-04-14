package com.mode.ryankennedy.graalvm;

import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Engine;
import org.graalvm.polyglot.Source;
import org.graalvm.polyglot.Value;

import java.io.IOException;

public class TireKick {
    public static void main(String[] args) throws IOException {
        try (Engine engine = Engine.create();
             Context context = Context.newBuilder("js")
                     .allowAllAccess(true)
                     .engine(engine)
                     .build()) {

            String source = "function greeting() { return 'Hello, World!'; } greeting();";

            Value message = context.eval(Source.newBuilder("js", source, "source.js").build());
            System.out.println(message.asString());
        }
    }
}
