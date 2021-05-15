docker build -t djone/multi-client:latest -t djone/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t djone/multi-server:latest -t djone/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t djone/multi-worker:latest -t djone/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push djone/multi-client:latest
docker push djone/multi-server:latest
docker push djone/multi-worker:latest

docker push djone/multi-client:$SHA
docker push djone/multi-server:$SHA
docker push djone/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=djone/multi-client:$SHA
kubectl set image deployments/server-deployment server=djone/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=djone/multi-worker:$SHA