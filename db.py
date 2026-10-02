import os
import time
import psycopg2
from psycopg2 import OperationalError


def conectar(tentativas=10, espera=2):
    """Conecta ao PostgreSQL e tolera alguns segundos de inicialização do Docker."""
    ultimo_erro = None

    for tentativa in range(1, tentativas + 1):
        try:
            conexao = psycopg2.connect(
                host=os.environ.get("DB_HOST", "db"),
                port=os.environ.get("DB_PORT", "5432"),
                database=os.environ.get("DB_NAME", "ceit_db"),
                user=os.environ.get("DB_USER", "ceit_user"),
                password=os.environ.get("DB_PASSWORD", "123456"),
                connect_timeout=5,
            )
            conexao.set_client_encoding("UTF8")
            return conexao
        except OperationalError as erro:
            ultimo_erro = erro
            if tentativa < tentativas:
                time.sleep(espera)

    raise ultimo_erro
