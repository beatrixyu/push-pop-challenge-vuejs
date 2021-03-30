# DO NOT MODIFY
target: run_api run_frontend

run_api:
	cd api \
	&& pip3 install -r requirements.txt \
	&& python3 -m api

run_frontend:
	cd frontend \
	&& npm install \
	&& npm run dev
