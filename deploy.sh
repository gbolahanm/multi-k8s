docker build -t gbdotcom/multi-client:latest -t gbdotcom/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t gbdotcom/multi-server:latest -t gbdotcom/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gbdotcom/multi-worker:latest -t gbdotcom/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gbdotcom/multi-client:latest
docker push gbdotcom/multi-client:$SHA
docker push gbdotcom/multi-server:latest
docker push gbdotcom/multi-server:$SHA
docker push gbdotcom/multi-worker:latest
docker push gbdotcom/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gbdotcom/multi-server:$SHA
kubectl set image deployments/client-deployment client=gbdotcom/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gbdotcom/multi-worker:$SHA