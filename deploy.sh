docker build -t nerddaddy/multi-client:latest -t nerddaddy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nerddaddy/multi-server:latest -t nerddaddy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nerddaddy/multi-worker:latest -t nerddaddy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nerddaddy/multi-client:latest
docker push nerddaddy/multi-server:latest
docker push nerddaddy/multi-worker:latest

docker push nerddaddy/multi-client:$SHA
docker push nerddaddy/multi-server:$SHA
docker push nerddaddy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nerddaddy/multi-server:$SHA
kubectl set image deployments/client-deployment client=nerddaddy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nerddaddy/multi-worker:$SHA


