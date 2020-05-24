docker build -t abilash16882/multi-client:latest -t abilash16882/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abilash16882/multi-server:latest -t abilash16882/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abilash16882/multi-worker:latest -t abilash16882/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abilash16882/multi-client:latest
docker push abilash16882/multi-server:latest
docker push abilash16882/multi-worker:latest

docker push abilash16882/multi-client:$SHA
docker push abilash16882/multi-server:$SHA
docker push abilash16882/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abilash16882/multi-server:$SHA
kubectl set image deployments/client-deployment client=abilash16882/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abilash16882/multi-worker:$SHA
