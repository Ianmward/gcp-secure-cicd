export REL=dodgy-$1
docker build -t australia-southeast1-docker.pkg.dev/$PROJECT_ID/pop-stats/pop-stats:${REL} -f app/Dockerfile app
docker image inspect australia-southeast1-docker.pkg.dev/$PROJECT_ID/pop-stats/pop-stats:${REL} --format '{{index .RepoDigests 0}}' > image-digest.txt 
docker push australia-southeast1-docker.pkg.dev/$PROJECT_ID/pop-stats/pop-stats:${REL}
gcloud deploy releases create rel-${REL} --delivery-pipeline=security-demo-pipelne       --region=australia-southeast1       --annotations=commitId=dodgy --images=pop-stats=$(/bin/cat image-digest.txt)


