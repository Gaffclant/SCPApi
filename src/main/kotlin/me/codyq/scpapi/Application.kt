package me.codyq.scpapi

import io.ktor.application.*
import io.ktor.features.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.serialization.*
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import me.codyq.scpapi.models.SCP
import org.koin.dsl.module
import org.koin.ktor.ext.Koin
import org.koin.ktor.ext.inject
import org.koin.logger.slf4jLogger
import java.io.File

fun main(args: Array<String>): Unit = io.ktor.server.netty.EngineMain.main(args)

@OptIn(ExperimentalSerializationApi::class)
fun Application.main(){
    install(DefaultHeaders)
    install(CallLogging)
    install(ContentNegotiation) {
        json()
    }
    install(Koin) {
        slf4jLogger()
        modules(scpAppModule)
    }

    val scp: ScpService by inject()
    val database: DbService by inject()

    val connection = database.getConnection()

    routing {
        get("/scp/{id}"){
            val id = call.parameters["id"]!!.toString()

            val scpObj: SCP
            val scpDbCheck = connection.sync().get(id)
            if (scpDbCheck.isNullOrBlank()) {
                scpObj = scp.sayScp(id)
                connection.sync().set(id, Json.encodeToString(scpObj))
                connection.sync().expire(id, 21_600)
            } else {
                scpObj = Json.decodeFromString(scpDbCheck)
            }

            val scpJsonStr = Json.encodeToString(scpObj)
            call.respond(scpJsonStr)
        }


        get("/"){
            call.respond(
                """<!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <title>SCPapi</title>
                    </head>
                    <body>
                      <h1>Welcome to the SCPapi</h1>
                      <h2>Created by <a href=https://www.github.com/gaffclant>Gaffclant</a> and <a href=https://www.github.com/catdevz>CatDevz</a></h2>
                      <p>Please refer to the <a href=docs>docs</a> for more info</p>
                      <p>An example: <a href=scp/049>SCP-049</a></p>
                    </body>
                    </html>"""
            )
        }
        get("/docs" ){
            call.respond(
                """
                <!DOCTYPE html>
                <html lang="en">
                <head>
                  <meta charset="UTF-8">
                  <title>Swagger UI</title>
                  <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700|Source+Code+Pro:300,600|Titillium+Web:400,600,700" rel="stylesheet">
                  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/3.24.2/swagger-ui.css" >
                  <style>
                    html
                    {
                      box-sizing: border-box;
                      overflow: -moz-scrollbars-vertical;
                      overflow-y: scroll;
                    }
                    *,
                    *:before,
                    *:after
                    {
                      box-sizing: inherit;
                    }
                    body {
                      margin:0;
                      background: #fafafa;
                    }
                  </style>
                </head>
                <body>
                <div id="swagger-ui"></div>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/3.24.2/swagger-ui-bundle.js"> </script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/3.24.2/swagger-ui-standalone-preset.js"> </script>
                <script>
                window.onload = function() {
                  var spec = {"openapi": "3.0.1", "info": {"title": "SCPapi", "description": "This api is made to return data on SCP's in the SCP foundation.", "contact": {"email": "gaffclant@gmail.com"}, "version": "1.0.0"}, "servers": [{"url": "https://scpapi.com/"}, {"url": "http://scpapi.com/"}], "tags": [{"name": "scp", "description": "Get info on any SCP on the wiki"}], "paths": {"/scp/{scpNum}": {"get": {"tags": ["scp"], "summary": "Find SCP-SCPNUM", "description": "Returns information on an SCP", "operationId": "getScp", "parameters": [{"name": "scpNum", "in": "path", "description": "Number of the SCP you want to return", "required": true, "schema": {"type": "string"}}], "responses": {"200": {"description": "successful operation", "content": {"application/json": {"schema": {"\${"$"}ref": "#/components/schemas/SCP"}}}}, "400": {"description": "Invalid ID supplied", "content": {}}, "404": {"description": "SCP not found", "content": {}}}}}}, "components": {"schemas": {"SCP": {"type": "object", "properties": {"scpRating": {"type": "integer", "format": "int64"}, "scpId": {"type": "string"}, "scpClass": {"type": "string"}, "scpContainmentProcedures": {"type": "string"}, "scpDescription": {"type": "string"}, "scpBody": {"type": "string"}, "scpLogs": {"type": "array", "items": {"type": "string"}}, "scpImages": {"type": "array", "items": {"type": "object", "properties": {"url": {"type": "string"}, "caption": {"type": "string"}}}}}}}}};
                  // Build a system
                  const ui = SwaggerUIBundle({
                    spec: spec,
                    dom_id: '#swagger-ui',
                    deepLinking: true,
                    presets: [
                      SwaggerUIBundle.presets.apis,
                      SwaggerUIStandalonePreset
                    ],
                    plugins: [
                      SwaggerUIBundle.plugins.DownloadUrl
                    ],
                    layout: "StandaloneLayout"
                  })
                  window.ui = ui
                }
                </script>
                </body>
                </html>
                """

            )
        }
    }


}

val scpAppModule = module {
    single<ScpService> { ScpServiceImpl(get()) }
    single { ScpRepository() }
    single<DbService> { DbServiceImpl("redis://127.0.0.1:6379") }
}