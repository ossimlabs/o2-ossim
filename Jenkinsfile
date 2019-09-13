properties([
    parameters ([
        string(name: 'BUILD_NODE', defaultValue: 'omar-build', description: 'The build node to run on'),
          string(name: 'ARTIFACT_TYPE', defaultValue: 'centos-7', description: 'type of artifact to pull from the sandbox'),
       booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Clean the workspace at the end of the run')
    ]),
    pipelineTriggers([
            [$class: "GitHubPushTrigger"]
    ]),
    [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ossimlabs/omar-ossim-base'],
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '3', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds()
])

node("${BUILD_NODE}"){
    try {
        stage("Checkout branch $BRANCH_NAME")
        {
            checkout(scm)
        }

        stage("Pull Artifacts")
        {
            // String repoName
            // if ("${BRANCH_NAME}" == "master") {
            //     repoName = "ossim.repo_master"
            // } else {
            //     repoName = "ossim.repo_dev"
            // }

            withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
                step ([$class: "CopyArtifact",
                    projectName: o2ArtifactProject,
                    filter: "common-variables.groovy",
                    flatten: true])

                // step ([$class: "CopyArtifact",
                //     projectName: o2ArtifactProject,
                //     filter: "${repoName}"])
                step ([$class: "CopyArtifact",
                    projectName: "ossim-sandbox-ossimbuild-multibranch/${BRANCH_NAME}",
                    filter: "ossim-sandbox-${ARTIFACT_TYPE}-runtime.tgz",
                    flatten: true])
                 }

            load "common-variables.groovy"

            // sh "mv ${repoName} ossim.repo"
        }

        stage ("Publish Docker App")
        {
            withCredentials([[$class: 'UsernamePasswordMultiBinding',
                            credentialsId: 'dockerCredentials',
                            usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                            passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])
            {
                // Run all tasks on the app. This includes pushing to OpenShift and S3.
                sh """
                gradle pushDockerImage \
                    -PossimMavenProxy=${OSSIM_MAVEN_PROXY}
                """
            }
        }
        
        stage ("Publish Latest Tagged Docker App")
        {
            withCredentials([[$class: 'UsernamePasswordMultiBinding',
                            credentialsId: 'dockerCredentials',
                            usernameVariable: 'DOCKER_REGISTRY_USERNAME',
                            passwordVariable: 'DOCKER_REGISTRY_PASSWORD']])
            {
                // Tag to latest/release and push that too, to ensure the new changes get used by dependant apps
                if ("$BRANCH_NAME" == "dev") {
                    sh """
                        gradle tagDockerImage pushDockerImage \
                         -PdockerImageTag=latest \
                         -PossimMavenProxy=${OSSIM_MAVEN_PROXY}
                    """
                } else if ("$BRANCH_NAME" == "master") {
                    sh """
                        gradle tagDockerImage pushDockerImage \
                         -PdockerImageTag=release \
                         -PossimMavenProxy=${OSSIM_MAVEN_PROXY}
                    """
                }
            }
        }

    } finally {
        stage("Clean Workspace")
        {
            if ("${CLEAN_WORKSPACE}" == "true")
                step([$class: 'WsCleanup'])
        }
    }
}
