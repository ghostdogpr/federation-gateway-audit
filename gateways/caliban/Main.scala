//> using scala 3.9.0
//> using dep com.github.ghostdogpr::caliban-gateway:3.2.0
//> using dep com.github.ghostdogpr::caliban-quick:3.2.0

import caliban.QuickAdapter
import caliban.gateway.{ Gateway, Supergraph }
import zio.*

import java.nio.file.Paths

object Main extends ZIOAppDefault {

  private val gateway = Gateway.fromSupergraph(Supergraph.file(Paths.get("supergraph.graphql")))

  override def run =
    for {
      interpreter <- gateway.interpreter
      server      <- QuickAdapter(interpreter).runServer(4000, "/graphql")
    } yield server
}
