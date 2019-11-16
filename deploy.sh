docker build -t alexskiffin/multi-client:latest -t alexskiffin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexskiffin/multi-server:latest -t alexskiffin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexskiffin/multi-worker:latest -t alexskiffin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexskiffin/multi-client:latest
docker push alexskiffin/multi-server:latest
docker push alexskiffin/multi-worker:latest

docker push alexskiffin/multi-client:$SHA
docker push alexskiffin/multi-server:$SHA
docker push alexskiffin/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alexskiffin/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexskiffin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexskiffin/multi-worker:$SHA