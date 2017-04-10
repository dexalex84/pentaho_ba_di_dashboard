docker ps -l -q --filter STATUS=exited | xargs docker rm
docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi -f
docker images | grep 'app_pentaho_ba' | awk '{print $3}' | xargs docker rmi -f 
docker images --filter "dangling=true" -q --no-trunc | xargs docker rmi -f 
