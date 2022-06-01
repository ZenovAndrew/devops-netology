# Домашнее задание к занятию "09.04 Teamcity"

## Подготовка к выполнению

1. Поднимите инфраструктуру [teamcity](./teamcity/docker-compose.yml)
```
vagrant@test1:~$ sudo chown -R 1000:1000 ~/teamcity
vagrant@test1:~$ cd 9.4
vagrant@test1:~/9.4$ docker-compose up

vagrant@test1:~/9.4$ docker-compose  up
Recreating 94_teamcity_1 ... done
Recreating 94_teamcity-agent_1 ... done
Attaching to 94_teamcity_1, 94_teamcity-agent_1
teamcity-agent_1  | /run-services.sh
teamcity-agent_1  | /services/run-docker.sh
teamcity_1        | /run-services.sh
teamcity_1        | /services/check-server-volumes.sh
teamcity_1        |
teamcity_1        | /run-server.sh
teamcity_1        | TeamCity server.xml parameter: -config conf/server.xml
teamcity-agent_1  | /run-agent.sh
teamcity-agent_1  | File buildAgent.properties was found in /data/teamcity_agent/conf. Will start the agent using it.
teamcity-agent_1  | Starting TeamCity build agent...
teamcity_1        | Java executable is found: '/opt/java/openjdk/bin/java'
teamcity_1        | Existing lock file found, would be removed
teamcity_1        | 2022-05-31 17:34:40 UTC: Starting TeamCity server
teamcity_1        | 2022-05-31 17:34:40 UTC: TeamCity process PID is 135
teamcity_1        | NOTE: Picked up JDK_JAVA_OPTIONS:  --add-opens jdk.management/com.sun.management.internal=ALL-UNNAMED -XX:+IgnoreUnrecognizedVMOptions --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
teamcity-agent_1  | Java executable is found: '/opt/java/openjdk/bin/java'
teamcity_1        | 31-May-2022 17:34:42.689 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/8.5.78
teamcity_1        | 31-May-2022 17:34:42.696 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Mar 31 2022 16:05:28 UTC
teamcity_1        | 31-May-2022 17:34:42.698 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 8.5.78.0
teamcity_1        | 31-May-2022 17:34:42.699 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Linux
teamcity_1        | 31-May-2022 17:34:42.701 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            5.4.0-80-generic
teamcity_1        | 31-May-2022 17:34:42.702 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
teamcity_1        | 31-May-2022 17:34:42.702 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             /opt/java/openjdk
teamcity_1        | 31-May-2022 17:34:42.717 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           11.0.15+9-LTS
teamcity_1        | 31-May-2022 17:34:42.718 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Amazon.com Inc.
teamcity_1        | 31-May-2022 17:34:42.719 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         /opt/teamcity
teamcity_1        | 31-May-2022 17:34:42.719 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         /opt/teamcity
teamcity_1        | 31-May-2022 17:34:42.721 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=jdk.management/com.sun.management.internal=ALL-UNNAMED
teamcity_1        | 31-May-2022 17:34:42.723 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -XX:+IgnoreUnrecognizedVMOptions
teamcity_1        | 31-May-2022 17:34:42.723 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.lang=ALL-UNNAMED
teamcity_1        | 31-May-2022 17:34:42.724 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.io=ALL-UNNAMED
teamcity_1        | 31-May-2022 17:34:42.725 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util=ALL-UNNAMED
teamcity_1        | 31-May-2022 17:34:42.725 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util.concurrent=ALL-UNNAMED
teamcity_1        | 31-May-2022 17:34:42.726 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
teamcity_1        | 31-May-2022 17:34:42.727 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=/opt/teamcity/conf/logging.properties
teamcity_1        | 31-May-2022 17:34:42.728 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
teamcity_1        | 31-May-2022 17:34:42.732 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
teamcity_1        | 31-May-2022 17:34:42.733 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
teamcity_1        | 31-May-2022 17:34:42.736 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dorg.apache.catalina.security.SecurityListener.UMASK=0027
teamcity_1        | 31-May-2022 17:34:42.739 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx2g
teamcity_1        | 31-May-2022 17:34:42.740 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -XX:ReservedCodeCacheSize=350m
teamcity_1        | 31-May-2022 17:34:42.741 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dteamcity.configuration.path=../conf/teamcity-startup.properties
teamcity_1        | 31-May-2022 17:34:42.744 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dlog4j2.configurationFile=file:/opt/teamcity/bin/../conf/teamcity-server-log4j.xml
teamcity_1        | 31-May-2022 17:34:42.745 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dteamcity_logs=/opt/teamcity/bin/../logs
teamcity_1        | 31-May-2022 17:34:42.747 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.awt.headless=true
teamcity_1        | 31-May-2022 17:34:42.749 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dignore.endorsed.dirs=
teamcity_1        | 31-May-2022 17:34:42.751 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=/opt/teamcity
teamcity_1        | 31-May-2022 17:34:42.753 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=/opt/teamcity
teamcity_1        | 31-May-2022 17:34:42.757 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=/opt/teamcity/temp
teamcity_1        | 31-May-2022 17:34:42.757 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent The Apache Tomcat Native library which allows using OpenSSL was not found on the java.library.path: [/usr/java/packages/lib:/usr/lib64:/lib64:/lib:/usr/lib]
teamcity_1        | 31-May-2022 17:34:42.896 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8111"]
teamcity_1        | 31-May-2022 17:34:42.999 INFO [main] org.apache.catalina.startup.Catalina.load Initialization processed in 1868 ms
teamcity_1        | 31-May-2022 17:34:43.188 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service [Catalina]
teamcity_1        | 31-May-2022 17:34:43.189 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet engine: [Apache Tomcat/8.5.78]
teamcity_1        | 31-May-2022 17:34:43.219 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/opt/teamcity/webapps/ROOT]
teamcity-agent_1  | Starting TeamCity Build Agent Launcher...
teamcity-agent_1  | Agent home directory is /opt/buildagent
teamcity-agent_1  | Done [353], see log at /opt/buildagent/logs/teamcity-agent.log
teamcity-agent_1  | [2022-05-31 18:27:21,274]   INFO - buildServer.AGENT.registration - Registering on server via URL "http://teamcity:8111": AgentDetails{Name='', AgentId=null, BuildId=null, AgentOwnAddress='null', AlternativeAddresses=[], Port=9090, Version='108502', PluginsVersion='108502-md5-896857e809298fc4681bcfedc4bb8309', AvailableRunners=[Ant, cargo-deploy-runner, csharpScript, DockerCommand, dotnet, dotnet-tools-dupfinder, dotnet-tools-inspectcode, Duplicator, ftp-deploy-runner, gradle-runner, Inspection, jetbrains_powershell, JPS, kotlinScript, Maven2, nodejs-runner, python-runner, Qodana, rake-runner, SBT, simpleRunner, smb-deploy-runner, ssh-deploy-runner, ssh-exec-runner], AvailableVcs=[tfs, jetbrains.git, mercurial, svn, perforce], AuthorizationToken='', PingCode='usMnnhndbBz8BkcgHd7psEPEFGmsvwhR'}
teamcity-agent_1  | [2022-05-31 18:27:21,350]   INFO -    jetbrains.buildServer.AGENT - Build agent started
teamcity-agent_1  | [2022-05-31 18:27:21,658]   INFO - r.artifacts.impl.HttpDiskCache - Cleaning up items with life time in cache greater than 172800 seconds
teamcity-agent_1  | [2022-05-31 18:27:21,659]   INFO - r.artifacts.impl.HttpDiskCache - Finished cleaning up expired items, 0 items removed
teamcity-agent_1  | [2022-05-31 18:27:22,148]   WARN - buildServer.AGENT.registration - Failed to obtain server supported protocols via URL http://teamcity:8111/app/agents/protocols: TeamCity Server is starting. Will try later.
teamcity-agent_1  | [2022-05-31 18:27:22,157]   WARN - buildServer.AGENT.registration - Error registering on the server via URL http://teamcity:8111. Will continue repeating connection attempts.
teamcity-agent_1  | [2022-05-31 18:27:22,165]   INFO - dDirectoryBasedCleanupRegistry - Removing files from /opt/buildagent/temp/.old
teamcity-agent_1  | [2022-05-31 18:27:22,166]   INFO - dDirectoryBasedCleanupRegistry - Removing files from /opt/buildagent/work/.old
teamcity-agent_1  | [2022-05-31 18:27:22,249]   INFO - l.directories.DirectoryMapImpl - Cleaning up old checkout directories. Default lifetime = 192 hour(s)
teamcity-agent_1  | [2022-05-31 18:27:23,197]   INFO -    jetbrains.buildServer.AGENT - CPU benchmark index is set to 390
teamcity-agent_1  | [2022-05-31 18:34:53,180]   INFO -   jetbrains.buildServer.SERVER - Starting TeamCity agent
teamcity-agent_1  | [2022-05-31 18:34:53,191]   INFO - s.buildServer.agent.AgentMain2 -
teamcity-agent_1  |
teamcity-agent_1  |
teamcity-agent_1  |
teamcity-agent_1  |
teamcity-agent_1  |
teamcity-agent_1  |
teamcity-agent_1  | [2022-05-31 18:34:53,194]   INFO - s.buildServer.agent.AgentMain2 - ===========================================================
teamcity-agent_1  | [2022-05-31 18:34:53,236]   INFO - s.buildServer.agent.AgentMain2 - TeamCity Build Agent 2022.04 (build 108502)
teamcity-agent_1  | [2022-05-31 18:34:53,292]   INFO - s.buildServer.agent.AgentMain2 - OS: Linux, version 5.4.0-80-generic, amd64, Current user: buildagent, Time zone: BST (UTC+01:00)
teamcity-agent_1  | [2022-05-31 18:34:53,304]   INFO - s.buildServer.agent.AgentMain2 - Java: 11.0.15, OpenJDK 64-Bit Server VM (11.0.15+9-LTS, mixed mode), OpenJDK Runtime Environment (11.0.15+9-LTS), Amazon.com Inc.; JVM parameters: -ea -Xmx384m -Dteamcity_logs=../logs/ -Dlog4j2.configurationFile=file:../conf/teamcity-agent-log4j2.xml
teamcity-agent_1  | [2022-05-31 18:34:53,314]   INFO - s.buildServer.agent.AgentMain2 - Agent home is "/opt/buildagent"
teamcity-agent_1  | [2022-05-31 18:34:53,314]   INFO - s.buildServer.agent.AgentMain2 - Starting...
teamcity_1        | Using logs directory "/opt/teamcity/logs"
teamcity_1        | Log4J configuration file /opt/teamcity/bin/../conf/teamcity-server-log4j.xml will be monitored with interval 10 seconds.
teamcity_1        | 31-May-2022 17:34:55.800 INFO [localhost-startStop-1] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/opt/teamcity/webapps/ROOT] has finished in [12,581] ms
teamcity_1        | 31-May-2022 17:34:55.829 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8111"]
teamcity_1        | 31-May-2022 17:34:55.908 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in 12909 ms
teamcity_1        | TeamCity version: 2022.04 (build 108502), data format version 980
teamcity_1        | OS: Linux, version 5.4.0-80-generic, amd64, Current user: tcuser, Time zone: GMT (UTC)
teamcity_1        | Java: 11.0.15, OpenJDK 64-Bit Server VM (11.0.15+9-LTS, mixed mode), OpenJDK Runtime Environment (11.0.15+9-LTS), Amazon.com Inc.; JVM parameters: --add-opens=jdk.management/com.sun.management.internal=ALL-UNNAMED -XX:+IgnoreUnrecognizedVMOptions --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Djava.util.logging.config.file=/opt/teamcity/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Xmx2g -XX:ReservedCodeCacheSize=350m -Dteamcity.configuration.path=../conf/teamcity-startup.properties -Dlog4j2.configurationFile=file:/opt/teamcity/bin/../conf/teamcity-server-log4j.xml -Dteamcity_logs=/opt/teamcity/bin/../logs -Djava.awt.headless=true -Dignore.endorsed.dirs= -Dcatalina.base=/opt/teamcity -Dcatalina.home=/opt/teamcity -Djava.io.tmpdir=/opt/teamcity/temp
teamcity_1        | Startup confirmation is required. Open TeamCity web page in the browser. Server is running at http://localhost:8111
teamcity-agent_1  | [2022-05-31 18:34:57,690]   INFO -    jetbrains.buildServer.AGENT - Calculating CPU benchmark index...
teamcity-agent_1  | [2022-05-31 18:34:57,828]   INFO -    jetbrains.buildServer.AGENT - Agent tools download temp directory created on path /opt/buildagent/temp/tools
teamcity-agent_1  | [2022-05-31 18:34:58,604]   INFO - dAgentConfigurationInitializer - Loading build agent configuration from /data/teamcity_agent/conf/buildAgent.properties
teamcity-agent_1  | [2022-05-31 18:34:58,747]   INFO - s.buildServer.agent.AgentMain2 - Working dir: /opt/buildagent/work
teamcity-agent_1  | [2022-05-31 18:34:58,747]   INFO - s.buildServer.agent.AgentMain2 - Temp dir: /opt/buildagent/temp
teamcity-agent_1  | [2022-05-31 18:34:58,765]   INFO - rver.plugins.PluginManagerImpl - ===========================================================
teamcity-agent_1  | [2022-05-31 18:34:58,773]   INFO - rver.plugins.PluginManagerImpl - Plugins initialization started...
teamcity-agent_1  | [2022-05-31 18:34:58,773]   INFO - rver.plugins.PluginManagerImpl - Scanning plugins folders
teamcity-agent_1  | [2022-05-31 18:34:58,776]   INFO - .plugins.files.JarSearcherBase - Scanning plugin folder: /opt/buildagent/plugins
teamcity-agent_1  | [2022-05-31 18:34:59,140]   INFO - .plugins.files.JarSearcherBase - Scanning plugin folder: /opt/buildagent/tools
teamcity-agent_1  | [2022-05-31 18:34:59,202]   INFO - rver.plugins.PluginManagerImpl - Found 55 non bundled plugins: [agentSystemInfo, amazonEC2, ant, ant-net-tasks, antPlugin, cloud-vmware-agent, commandLineRunner, coveragePlugin, crashDetector, deploy-runner-agent, docker-support, dotnet, dotnetPlugin, dotNetRunners, duplicatePlugin, environment-fetcher-agent, file-content-replacer, fxcop, gant, gantPlugin, golang-agent, gradle-runner, idea-runner, inspectionPlugin, java-dowser, jetbrains.git, jps, junitPlugin, jvm-update, kotlin-script-runner-agent-108502, mavenPlugin, mercurial, meta-runner, nodejs-agent-108502, nuget-agent, perfmon-agent, perforce-agent, powershell-agent, python-agent-108502, qodana, rake-runner, remoteAccess, s3-artifact-storage-agent, sbt-runner-agent, ssh-manager, stacktracesPlugin, svnAgent, swabra, teamcity-kubernetes-plugin-agent, teamcity-parallel-tests-agent, testNGPlugin, tfs-agent, visualstudiotest-agent, xcode-runner, xml-report-plugin]
teamcity-agent_1  | [2022-05-31 18:34:59,203]   INFO - rver.plugins.PluginManagerImpl - Found 0 bundled plugins: []
teamcity-agent_1  | [2022-05-31 18:34:59,217]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/ant
teamcity-agent_1  | [2022-05-31 18:34:59,218]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/antRun
teamcity-agent_1  | [2022-05-31 18:34:59,219]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/ant.bat
teamcity-agent_1  | [2022-05-31 18:34:59,219]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/ant.cmd
teamcity-agent_1  | [2022-05-31 18:34:59,219]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/antenv.cmd
teamcity-agent_1  | [2022-05-31 18:34:59,221]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/envset.cmd
teamcity-agent_1  | [2022-05-31 18:34:59,222]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/lcp.bat
teamcity-agent_1  | [2022-05-31 18:34:59,222]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/runrc.cmd
teamcity-agent_1  | [2022-05-31 18:34:59,223]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/antRun.pl
teamcity-agent_1  | [2022-05-31 18:34:59,223]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/complete-ant-cmd.pl
teamcity-agent_1  | [2022-05-31 18:34:59,223]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/runant.pl
teamcity-agent_1  | [2022-05-31 18:34:59,224]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/plugins/ant/bin/runant.py
teamcity-agent_1  | [2022-05-31 18:34:59,227]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/tools/gant/bin/gant
teamcity-agent_1  | [2022-05-31 18:34:59,228]   INFO - les.ExecutableAttributesSetter - Setting executable bit for: /opt/buildagent/tools/gant/bin/startGroovy
teamcity-agent_1  | [2022-05-31 18:34:59,229]   INFO - rver.plugins.PluginsCollection - Load shared classloader for 20 plugins [agentSystemInfo, amazonEC2, ant, commandLineRunner, crashDetector, dotnetPlugin, dotNetRunners, environment-fetcher-agent, file-content-replacer, fxcop, gradle-runner, java-dowser, jetbrains.git, mercurial, remoteAccess, ssh-manager, stacktracesPlugin, swabra, visualstudiotest-agent, xml-report-plugin]
teamcity-agent_1  | [2022-05-31 18:34:59,295]   INFO - rver.plugins.PluginsCollection - Load standalone classloaders for 32 plugins [antPlugin, cloud-vmware-agent, coveragePlugin, deploy-runner-agent, docker-support, dotnet, duplicatePlugin, gantPlugin, golang-agent, idea-runner, inspectionPlugin, junitPlugin, jvm-update, kotlin-script-runner-agent-108502, mavenPlugin, meta-runner, nodejs-agent-108502, nuget-agent, perfmon-agent, perforce-agent, powershell-agent, python-agent-108502, qodana, rake-runner, s3-artifact-storage-agent, sbt-runner-agent, svnAgent, teamcity-kubernetes-plugin-agent, teamcity-parallel-tests-agent, testNGPlugin, tfs-agent, xcode-runner]
teamcity-agent_1  | [2022-05-31 18:35:00,586]   INFO - KubeAgentConfigurationProvider - Initializing Kube Provider...
teamcity-agent_1  | [2022-05-31 18:35:01,082]   INFO - .vmware.VMWarePropertiesReader - VSphere plugin initializing...
teamcity-agent_1  | [2022-05-31 18:35:01,100]   INFO - .vmware.VMWarePropertiesReader - Unable to locate vmware-rpctool. Looks like not a VMWare VM or VWWare tools are not installed
teamcity-agent_1  | [2022-05-31 18:35:02,840]   INFO - t.golang.BuildMessagesListener - Init the Golang plugin
teamcity_1        | WARNING: An illegal reflective access operation has occurred
teamcity_1        | WARNING: Illegal reflective access by com.thoughtworks.xstream.core.util.Fields (file:/opt/teamcity/webapps/ROOT/WEB-INF/lib/xstream-1.4.11.1-custom.jar) to field java.lang.reflect.Proxy.h
teamcity_1        | WARNING: Please consider reporting this to the maintainers of com.thoughtworks.xstream.core.util.Fields
teamcity_1        | WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
teamcity_1        | WARNING: All illegal access operations will be denied in a future release
teamcity-agent_1  | [2022-05-31 18:35:05,545]   INFO - rver.plugins.PluginManagerImpl - Plugins initialization completed (55 plugins loaded): [agentSystemInfo, amazonEC2, ant, ant-net-tasks, antPlugin, cloud-vmware-agent, commandLineRunner, coveragePlugin, crashDetector, deploy-runner-agent, docker-support, dotnet, dotnetPlugin, dotNetRunners, duplicatePlugin, environment-fetcher-agent, file-content-replacer, fxcop, gant, gantPlugin, golang-agent, gradle-runner, idea-runner, inspectionPlugin, java-dowser, jetbrains.git, jps, junitPlugin, jvm-update, kotlin-script-runner-agent-108502, mavenPlugin, mercurial, meta-runner, nodejs-agent-108502, nuget-agent, perfmon-agent, perforce-agent, powershell-agent, python-agent-108502, qodana, rake-runner, remoteAccess, s3-artifact-storage-agent, sbt-runner-agent, ssh-manager, stacktracesPlugin, svnAgent, swabra, teamcity-kubernetes-plugin-agent, teamcity-parallel-tests-agent, testNGPlugin, tfs-agent, visualstudiotest-agent, xcode-runner, xml-report-plugin]
teamcity-agent_1  | [2022-05-31 18:35:05,557]   INFO - rver.plugins.PluginManagerImpl - ===========================================================
teamcity-agent_1  | [2022-05-31 18:35:05,739]   INFO -    jetbrains.buildServer.AGENT - Build Agent version: 108502, plugins signature: 108502-md5-896857e809298fc4681bcfedc4bb8309
teamcity-agent_1  | [2022-05-31 18:35:05,754]   INFO - rver.agent.PropertiesExtension - Start: Fetched agent properties
teamcity-agent_1  | [2022-05-31 18:35:06,175]   INFO - rver.agent.PropertiesExtension - DotNetCoreRuntime5.0_Path="/usr/share/dotnet/shared/Microsoft.NETCore.App/5.0.12".
teamcity-agent_1  | [2022-05-31 18:35:06,194]   INFO - rver.agent.PropertiesExtension - DotNetCoreRuntime5.0.12_Path="/usr/share/dotnet/shared/Microsoft.NETCore.App/5.0.12".
teamcity-agent_1  | [2022-05-31 18:35:06,201]   INFO - rver.agent.PropertiesExtension - DotNetCoreRuntime3.1_Path="/usr/share/dotnet/shared/Microsoft.NETCore.App/3.1.21".
teamcity-agent_1  | [2022-05-31 18:35:06,203]   INFO - rver.agent.PropertiesExtension - DotNetCLI_Path="/usr/share/dotnet/dotnet".
teamcity-agent_1  | [2022-05-31 18:35:06,214]   INFO - rver.agent.PropertiesExtension - DotNetCoreRuntime3.1.21_Path="/usr/share/dotnet/shared/Microsoft.NETCore.App/3.1.21".
teamcity-agent_1  | [2022-05-31 18:35:06,216]   INFO - rver.agent.PropertiesExtension - DotNetCoreRuntime6.0_Path="/usr/share/dotnet/shared/Microsoft.NETCore.App/6.0.0".
teamcity-agent_1  | [2022-05-31 18:35:06,218]   INFO - rver.agent.PropertiesExtension - DotNetCoreRuntime6.0.0_Path="/usr/share/dotnet/shared/Microsoft.NETCore.App/6.0.0".
teamcity-agent_1  | [2022-05-31 18:35:07,024]   INFO - .agent.CommandLineExecutorImpl - <--- "/usr/share/dotnet/dotnet --version" exits with code: 0
teamcity-agent_1  | [2022-05-31 18:35:07,029]   INFO - rver.agent.PropertiesExtension - DotNetCLI="6.0.100".
teamcity-agent_1  | [2022-05-31 18:35:07,032]   INFO - rver.agent.PropertiesExtension - DotNetCoreSDK6.0_Path="/usr/share/dotnet/sdk/6.0.100".
teamcity-agent_1  | [2022-05-31 18:35:07,037]   INFO - rver.agent.PropertiesExtension - DotNetCoreSDK6.0.100_Path="/usr/share/dotnet/sdk/6.0.100".
teamcity-agent_1  | [2022-05-31 18:35:07,048]   INFO - rver.agent.PropertiesExtension - Finish: Fetched agent properties (1293 ms)
teamcity-agent_1  | [2022-05-31 18:35:07,577]   INFO - ent.javaDowser.JavaDowserAgent - JavaDowser: Found 1 java installations:
teamcity-agent_1  |     11/64 (11.0.15) at /opt/java/openjdk (JDK) [200]
teamcity-agent_1  | [2022-05-31 18:35:07,583]   INFO - ialProviderPropertiesExtension - Found .NET credential provider DotNetCredentialProvider4.0.0_Path at /opt/buildagent/plugins/nuget-agent/bin/credential-plugin/net46/CredentialProvider.TeamCity.exe
teamcity-agent_1  | [2022-05-31 18:35:07,617]   INFO - ialProviderPropertiesExtension - Found .NET credential provider DotNetCredentialProvider1.0.0_Path at /opt/buildagent/plugins/nuget-agent/bin/credential-plugin/netcoreapp1.0/CredentialProvider.TeamCity.dll
teamcity-agent_1  | [2022-05-31 18:35:07,623]   INFO - ialProviderPropertiesExtension - Found .NET credential provider DotNetCredentialProvider2.0.0_Path at /opt/buildagent/plugins/nuget-agent/bin/credential-plugin/netcoreapp2.0/CredentialProvider.TeamCity.dll
teamcity-agent_1  | [2022-05-31 18:35:07,627]   INFO - ialProviderPropertiesExtension - Found .NET credential provider DotNetCredentialProvider3.0.0_Path at /opt/buildagent/plugins/nuget-agent/bin/credential-plugin/netcoreapp3.0/CredentialProvider.TeamCity.dll
teamcity-agent_1  | [2022-05-31 18:35:07,632]   INFO - ialProviderPropertiesExtension - Found .NET credential provider DotNetCredentialProvider5.0.0_Path at /opt/buildagent/plugins/nuget-agent/bin/credential-plugin/net5.0/CredentialProvider.TeamCity.dll
teamcity-agent_1  | [2022-05-31 18:35:07,635]   INFO - ialProviderPropertiesExtension - Found .NET credential provider DotNetCredentialProvider6.0.0_Path at /opt/buildagent/plugins/nuget-agent/bin/credential-plugin/net6.0/CredentialProvider.TeamCity.dll
teamcity-agent_1  | [2022-05-31 18:35:07,676]   INFO - r.mono.MonoPropertiesExtension - Mono not found
teamcity-agent_1  | [2022-05-31 18:35:08,225]   INFO - ggers.vcs.mercurial.HgDetector - Detect installed mercurial at path hg, provide it as a property teamcity.hg.agent.path
teamcity-agent_1  | [2022-05-31 18:35:08,228]   INFO - dAgentConfigurationInitializer - Loading build agent configuration from /data/teamcity_agent/conf/buildAgent.properties
teamcity-agent_1  | [2022-05-31 18:35:08,255]   INFO - Server.powershell.agent.DETECT - Detecting PowerShell using RegistryPowerShellDetector
teamcity-agent_1  | [2022-05-31 18:35:08,259]   INFO - Server.powershell.agent.DETECT - RegistryPowerShellDetector is only available on Windows
teamcity-agent_1  | [2022-05-31 18:35:08,263]   INFO - Server.powershell.agent.DETECT - Detecting PowerShell using CommandLinePowerShellDetector
teamcity-agent_1  | [2022-05-31 18:35:08,267]   INFO - Server.powershell.agent.DETECT - No PowerShell detected. If it is installed in non-standard location, please provide install locations in teamcity.powershell.detector.search.paths agent property (with ';' as a separator)
teamcity-agent_1  | [2022-05-31 18:35:08,286]   INFO - t.resolver.AgentPythonResolver - Python 2.x executable found at /usr/bin/python2
teamcity-agent_1  | [2022-05-31 18:35:08,296]   INFO - t.resolver.AgentPythonResolver - Python 3.x executable found at /usr/bin/python3
teamcity-agent_1  | [2022-05-31 18:35:08,301]   INFO - KubeAgentConfigurationProvider - TeamCity Server URL was not provided. The instance wasn't started using TeamCity Kube integration.
teamcity-agent_1  | [2022-05-31 18:35:08,427]   INFO - .agent.AgentStartupGitDetector - Detected git at /usr/bin/git
teamcity-agent_1  | [2022-05-31 18:35:08,676]   INFO - n.AmazonInstanceMetadataReader - Amazon is not available. Amazon EC2 integration is not active: Failed to connect to http://169.254.169.254/2016-04-19. Network is unreachable (connect failed)
teamcity-agent_1  | [2022-05-31 18:35:08,686]   WARN - r.mono.MonoPropertiesExtension - Failed to start pkg-config. Cannot run program "pkg-config": error=2, No such file or directory
teamcity-agent_1  | [2022-05-31 18:35:08,686]   INFO - r.mono.MonoPropertiesExtension - Can't get mono version through pkg-config. Try "pkg-config --modversion mono" from the console
teamcity-agent_1  | [2022-05-31 18:35:08,686]   INFO - r.mono.MonoPropertiesExtension - Check PKG_CONFIG_PATH if mono was installed to non-standard prefix (not /usr or /usr/local)
teamcity-agent_1  | [2022-05-31 18:35:09,185]   INFO - rains.buildServer.AGENT.DOCKER - Docker client is available: 20.10.12
teamcity-agent_1  | [2022-05-31 18:35:09,714]   INFO -    jetbrains.buildServer.AGENT - CPU benchmark index is set to 350
teamcity-agent_1  | [2022-05-31 18:35:09,934]   INFO - rains.buildServer.AGENT.DOCKER - Docker server is not available. Check whether docker daemon exists and it is up and running.
teamcity-agent_1  | [2022-05-31 18:35:09,934]   INFO - rains.buildServer.AGENT.DOCKER - Docker-compose is not available. Check whether it has been installed and PATH environment variable contains path to it.
teamcity-agent_1  | [2022-05-31 18:35:10,019]   INFO - .agent.impl.OsArchBitsDetector - Detecting via "getconf LONG_BIT", exit code: 0, output: 64
teamcity-agent_1  | [2022-05-31 18:35:10,020]   INFO - .agent.impl.OsArchBitsDetector - "teamcity.agent.os.arch.bits" detected as "64"
teamcity-agent_1  | [2022-05-31 18:35:10,031]   INFO -    jetbrains.buildServer.AGENT - Start build agent
teamcity-agent_1  | [2022-05-31 18:35:10,040]   INFO -    jetbrains.buildServer.AGENT - Agent Web server started on port 9090
teamcity-agent_1  | [2022-05-31 18:35:10,060]   INFO - agent.impl.AgentPortFileWriter - Writing agent runtime file to /opt/buildagent/logs/buildAgent.xmlRpcPort
teamcity-agent_1  | [2022-05-31 18:35:10,069]   INFO - agent.impl.AgentPortFileWriter - Launcher version is 108502
teamcity-agent_1  | [2022-05-31 18:35:10,073]   INFO - agent.impl.AgentPortFileWriter - Writing agent runtime file to /opt/buildagent/logs/buildAgent.xmlRpcPort :DONE!
teamcity-agent_1  | [2022-05-31 18:35:10,069]   INFO - nstall.PackagesInstallerRunner - NuGet requires .NET Framework (x86) 4.0 and higher or Mono 3.2 and higher to be installed.
teamcity-agent_1  | [2022-05-31 18:35:10,089]   INFO - t.agent.runner.pack.PackRunner - NuGet requires .NET Framework (x86) 4.0 and higher or Mono 3.2 and higher to be installed.
teamcity-agent_1  | [2022-05-31 18:35:10,090]   INFO - .publish.PackagesPublishRunner - NuGet requires .NET Framework (x86) 4.0 and higher or Mono 3.2 and higher to be installed.
teamcity-agent_1  | [2022-05-31 18:35:10,093]   INFO - ent.DotNetRunnersCompatibility - jetbrains.dotNetGenericRunner runner can work only under Windows or on any other OS with installed mono runtime
teamcity-agent_1  | [2022-05-31 18:35:10,095]   INFO - nner.agent.MSpecServiceFactory - MSpec runner is only available under windows
teamcity-agent_1  | [2022-05-31 18:35:10,149]   INFO - ent.DotNetRunnersCompatibility - MSBuild runner can work only under Windows or on any other OS with installed mono runtime
teamcity-agent_1  | [2022-05-31 18:35:10,150]   INFO - ent.DotNetRunnersCompatibility - NAnt runner can work only under Windows or on any other OS with installed mono runtime
teamcity-agent_1  | [2022-05-31 18:35:10,160]   INFO - ent.DotNetRunnersCompatibility - NUnit runner can work only under Windows or on any other OS with installed mono runtime
teamcity-agent_1  | [2022-05-31 18:35:10,160]   INFO - ent.DotNetRunnersCompatibility - sln2003 runner can work only under Windows or on any other OS with installed mono runtime
teamcity-agent_1  | [2022-05-31 18:35:10,162]   INFO - ent.DotNetRunnersCompatibility - VS.Solution runner can work only under Windows or on any other OS with installed mono runtime
teamcity-agent_1  | [2022-05-31 18:35:10,188]   INFO - buildServer.AGENT.registration - Registering on server via URL "http://teamcity:8111": AgentDetails{Name='', AgentId=null, BuildId=null, AgentOwnAddress='null', AlternativeAddresses=[], Port=9090, Version='108502', PluginsVersion='108502-md5-896857e809298fc4681bcfedc4bb8309', AvailableRunners=[Ant, cargo-deploy-runner, csharpScript, DockerCommand, dotnet, dotnet-tools-dupfinder, dotnet-tools-inspectcode, Duplicator, ftp-deploy-runner, gradle-runner, Inspection, jetbrains_powershell, JPS, kotlinScript, Maven2, nodejs-runner, python-runner, Qodana, rake-runner, SBT, simpleRunner, smb-deploy-runner, ssh-deploy-runner, ssh-exec-runner], AvailableVcs=[tfs, jetbrains.git, mercurial, svn, perforce], AuthorizationToken='', PingCode='IoUR8U5aMegToq8Sm224C7vUlIH0rFNz'}
teamcity-agent_1  | [2022-05-31 18:35:10,229]   WARN - buildServer.AGENT.registration - Failed to obtain server supported protocols via URL http://teamcity:8111/app/agents/protocols: TeamCity Server is starting. Will try later.
teamcity-agent_1  | [2022-05-31 18:35:10,230]   WARN - buildServer.AGENT.registration - Error registering on the server via URL http://teamcity:8111. Will continue repeating connection attempts.
teamcity-agent_1  | [2022-05-31 18:35:10,231]   INFO -    jetbrains.buildServer.AGENT - Build agent started
teamcity-agent_1  | [2022-05-31 18:35:10,551]   INFO - r.artifacts.impl.HttpDiskCache - Cleaning up items with life time in cache greater than 172800 seconds
teamcity-agent_1  | [2022-05-31 18:35:10,554]   INFO - r.artifacts.impl.HttpDiskCache - Finished cleaning up expired items, 0 items removed
teamcity-agent_1  | [2022-05-31 18:35:10,752]   INFO - dDirectoryBasedCleanupRegistry - Removing files from /opt/buildagent/temp/.old
teamcity-agent_1  | [2022-05-31 18:35:10,752]   INFO - dDirectoryBasedCleanupRegistry - Removing files from /opt/buildagent/work/.old
teamcity-agent_1  | [2022-05-31 18:35:10,802]   INFO - l.directories.DirectoryMapImpl - Cleaning up old checkout directories. Default lifetime = 192 hour(s)
teamcity-agent_1  | [2022-05-31 18:36:10,507]   INFO - buildServer.AGENT.registration - Registering on server via URL "http://teamcity:8111": AgentDetails{Name='', AgentId=null, BuildId=null, AgentOwnAddress='null', AlternativeAddresses=[], Port=9090, Version='108502', PluginsVersion='108502-md5-896857e809298fc4681bcfedc4bb8309', AvailableRunners=[Ant, cargo-deploy-runner, csharpScript, DockerCommand, dotnet, dotnet-tools-dupfinder, dotnet-tools-inspectcode, Duplicator, ftp-deploy-runner, gradle-runner, Inspection, jetbrains_powershell, JPS, kotlinScript, Maven2, nodejs-runner, python-runner, Qodana, rake-runner, SBT, simpleRunner, smb-deploy-runner, ssh-deploy-runner, ssh-exec-runner], AvailableVcs=[tfs, jetbrains.git, mercurial, svn, perforce], AuthorizationToken='', PingCode='IoUR8U5aMegToq8Sm224C7vUlIH0rFNz'}
teamcity-agent_1  | [2022-05-31 18:36:10,514]   WARN - buildServer.AGENT.registration - Failed to obtain server supported protocols via URL http://teamcity:8111/app/agents/protocols: TeamCity Server is starting. Will try later.
teamcity-agent_1  | [2022-05-31 18:36:10,514]   WARN - buildServer.AGENT.registration - Error registering on the server via URL http://teamcity:8111. Will continue repeating connection attempts.
teamcity_1        | =======================================================================
teamcity_1        | TeamCity initialized, server UUID: 8add4b85-3403-4397-95fc-c0109adbb8fe, URL: http://localhost
teamcity_1        | TeamCity is running in professional mode
teamcity_1        | [TeamCity] Super user authentication token: 1604821284796170305 (use empty username with the token as the password to access the server)
teamcity-agent_1  | [2022-05-31 18:37:11,699]   INFO - buildServer.AGENT.registration - Registering on server via URL "http://teamcity:8111": AgentDetails{Name='', AgentId=null, BuildId=null, AgentOwnAddress='null', AlternativeAddresses=[], Port=9090, Version='108502', PluginsVersion='108502-md5-896857e809298fc4681bcfedc4bb8309', AvailableRunners=[Ant, cargo-deploy-runner, csharpScript, DockerCommand, dotnet, dotnet-tools-dupfinder, dotnet-tools-inspectcode, Duplicator, ftp-deploy-runner, gradle-runner, Inspection, jetbrains_powershell, JPS, kotlinScript, Maven2, nodejs-runner, python-runner, Qodana, rake-runner, SBT, simpleRunner, smb-deploy-runner, ssh-deploy-runner, ssh-exec-runner], AvailableVcs=[tfs, jetbrains.git, mercurial, svn, perforce], AuthorizationToken='', PingCode='IoUR8U5aMegToq8Sm224C7vUlIH0rFNz'}
teamcity-agent_1  | [2022-05-31 18:37:11,704]   INFO - buildServer.AGENT.registration - Server supports the following communication protocols: [polling]
teamcity-agent_1  | [2022-05-31 18:37:11,704]   INFO - buildServer.AGENT.registration - Trying to register on server using 'polling' protocol.
teamcity-agent_1  | [2022-05-31 18:37:11,744]   INFO - buildServer.AGENT.registration - Registration using 'polling' protocol failed: ServerStillInitializingException: Build agent cannot be registered because TeamCity server is still initializing. Try again later.
teamcity-agent_1  | [2022-05-31 18:37:11,744]   WARN - buildServer.AGENT.registration - Error registering on the server via URL http://teamcity:8111. Will continue repeating connection attempts.
teamcity-agent_1  | [2022-05-31 18:37:18,284]   INFO - buildServer.AGENT.registration - Connection to TeamCity Server has been restored using the 'polling' protocol
teamcity-agent_1  | [2022-05-31 18:37:18,284]   INFO - ldServer.AGENT.PollingProtocol - Start polling server for commands
teamcity-agent_1  | [2022-05-31 18:37:18,303]   INFO -    jetbrains.buildServer.AGENT - Agent name was '', but server returned new name '94_teamcity-agent_1'. Agent name will be updated.
teamcity-agent_1  | [2022-05-31 18:37:18,392]   INFO - ldServer.AGENT.PollingProtocol - New command is received from server "testLocal" {id = 1} (enable debug to see command body)
teamcity-agent_1  | [2022-05-31 18:37:20,307]   INFO -    jetbrains.buildServer.AGENT - Updating agent parameters on the server: AgentDetails{Name='94_teamcity-agent_1', AgentId=1, BuildId=null, AgentOwnAddress='null', AlternativeAddresses=[], Port=9090, Version='108502', PluginsVersion='108502-md5-896857e809298fc4681bcfedc4bb8309', AvailableRunners=[Ant, cargo-deploy-runner, csharpScript, DockerCommand, dotnet, dotnet-tools-dupfinder, dotnet-tools-inspectcode, Duplicator, ftp-deploy-runner, gradle-runner, Inspection, jetbrains_powershell, JPS, kotlinScript, Maven2, nodejs-runner, python-runner, Qodana, rake-runner, SBT, simpleRunner, smb-deploy-runner, ssh-deploy-runner, ssh-exec-runner], AvailableVcs=[tfs, jetbrains.git, mercurial, svn, perforce], AuthorizationToken='adec9d83dc1003f722e90ca870655226', PingCode='IoUR8U5aMegToq8Sm224C7vUlIH0rFNz'}

```

2. Если хочется, можете создать свою собственную инфраструктуру на основе той технологии, которая нравится. Инструкция по установке из [документации](https://www.jetbrains.com/help/teamcity/installing-and-configuring-the-teamcity-server.html)
3. Дождитесь запуска teamcity, выполните первоначальную настройку
4. Авторизуйте агент
```
Залогиниваемся, в списке агентов, авторизируем нашего агента
```

5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity)
```
https://github.com/ZenovAndrew/example-teamcity
```

## Основная часть

1. Создайте новый проект в teamcity на основе fork
```
создаем новый проект на основе гит репозитория.
```
2. Сделайте autodetect конфигурации
```
Переходим в билд, делаем автодетект конфигурации
```
3. Сохраните необходимые шаги, запустите первую сборку master'a
```
Запускаем сборку. Сборка успешна
```
4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean package`, иначе `mvn clean test`
```
Меняем условия сборки

1.first step
Maven
Path to POM: pom.xml
Goals: clean package
Execute: If all previous steps finished successfully
Parameter-based execution conditions:
teamcity.build.branch equals master

 
2. second step
Maven
Path to POM: pom.xml
Goals: clean test
Execute: If all previous steps finished successfully
Parameter-based execution conditions:
teamcity.build.branch does not equal master


```
5. Мигрируйте `build configuration` в репозиторий
```
Переходим в настройки проекта "Versioned Settings" > Выбираем "Synchronization enabled" > Выбираем  "VCS Root https://github.com/ZenovAndrew/example-teamcity.git#refs/heads/master" > Apply. 
Далее нажимаем "Commit current project settings..."
```
6. Создайте отдельную ветку `feature/add_reply` в репозитории
```
сделали https://github.com/ZenovAndrew/example-teamcity/tree/feature/add_reply
```
7. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`
```
example-teamcity/src/main/java/plaindoll/Welcomer.java
```java
package plaindoll;

public class Welcomer{
	public String sayWelcome() {
		return "Welcome home, good hunter. What is it your desire?";
	}
	public String sayFarewell() {
		return "Farewell, good hunter. May you find your worth in waking world.";
	}
	public String sayHunter() {
		return "Hunter is the best hunter!";
	}
}

8. Дополните тест для нового метода на поиск слова `hunter` в новой реплике
```
добавляем новый тест для нового метода
example-teamcity/src/test/java/plaindoll/WelcomerTest.java

```
```java
	@Test
	public void welcomerSayHunter() {

		assertThat(welcomer.sayHunter(), containsString("hunter"));
	}
```

9. Сделайте push всех изменений в новую ветку в репозиторий
```
делаем push
```

10. Убедитесь что сборка самостоятельно запустилась, тесты прошли успешно
```
сборка автоматически запускается в teamcity. Тесты успешно пройдены
```
11. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`
```
мержим...запустилась сборка, сборка успешна
```
12. Убедитесь, что нет собранного артефакта в сборке по ветке `master`
```
артефактов нет, только внутренние
[09:09:32]Publishing internal artifacts
[09:09:32][Publishing internal artifacts] Publishing 1 file using [WebPublisher]
[09:09:32][Publishing internal artifacts] Publishing 1 file using [ArtifactsCachePublisherImpl]
[09:09:32]Build finished

```
13. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки
```
Заходмм в Build > в General Settings
Добавляем 
Publish artifacts - Only if build status is successful 
Artifact paths - +:target/*.jar
```
14. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны
```
Сборка успешна, появились артефакты
[09:18:44]Publishing internal artifacts
[09:18:44][Publishing internal artifacts] Publishing 1 file using [WebPublisher]
[09:18:44][Publishing internal artifacts] Publishing 1 file using [ArtifactsCachePublisherImpl]
[09:18:44]Publishing artifacts
[09:18:44][Publishing artifacts] Collecting files to publish: [+:target/*.jar]
[09:18:44][Publishing artifacts] Publishing 2 files using [WebPublisher]: target/*.jar
[09:18:44][Publishing artifacts] Publishing 2 files using [ArtifactsCachePublisherImpl]: target/*.jar
[09:18:44]Build finished
```
15. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity
```
Проверено, в векции Build появились дополнительные настройки
<settings>
    <options>
      <option name="artifactRules" value="+:target/*.jar" />
      <option name="publishArtifactCondition" value="SUCCESSFUL" />
    </options>
```
16. В ответ предоставьте ссылку на репозиторий
https://github.com/ZenovAndrew/example-teamcity

