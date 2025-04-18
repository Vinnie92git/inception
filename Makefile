COMPOSEPATH 		= ./srcs/compose.yaml
MYSQL_NAME 		= mysql
WEBSERVER_NAME 		= webserver
SRCS_PREFIX		= srcs_
MYSQL_VOLUME		= ${addprefix ${SRCS_PREFIX}, ${MYSQL_NAME}}
WEBSERVER_VOLUME	= ${addprefix ${SRCS_PREFIX}, ${WEBSERVER_NAME}}
DATA_PATH		= /home/${USER}
DATA_DIR		= ${DATA_PATH}/data/
MYSQL_DIR		= ${addprefix ${DATA_DIR}, ${MYSQL_NAME}}
WEBSERVER_DIR		= ${addprefix ${DATA_DIR}, ${WEBSERVER_NAME}}


all:	${DATA_DIR} ${MYSQL_DIR} ${WEBSERVER_DIR}
	docker compose -f  ${COMPOSEPATH} up -d

${MYSQL_DIR}: ${DATA_DIR}
	mkdir -p ${MYSQL_DIR}

${WEBSERVER_DIR}: ${DATA_DIR}
	mkdir -p ${WEBSERVER_DIR}

${DATA_DIR}:
	mkdir -p ${DATA_DIR}

down:
	docker compose -f  ${COMPOSEPATH} down

fclean: down clean
	docker volume rm ${MYSQL_VOLUME}
	docker volume rm ${WEBSERVER_VOLUME}

clean:
	docker image prune -a -f

rmdata:
	rm -rf ${MYSQL_DIR}
	rm -rf ${WEBSERVER_DIR}

ps:
	docker compose -f ${COMPOSEPATH} ps

logs:
	docker compose -f ${COMPOSEPATH} logs -f

re: down clean all

.PHONY: all clean fclean re
