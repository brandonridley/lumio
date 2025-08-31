.PHONY: dev prod logs

dev:
	docker compose up --build

prod:
	docker compose -f docker-compose.prod.yml up -d --build

logs:
	docker compose logs -f
