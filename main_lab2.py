import psycopg2
import csv



db_name = "postgres"
db_host = "127.0.0.1"
db_port = "5432"
user_name = "postgres"
password_text = "12zx34"


def input_config():
    dbname = input("Input database name: ")
    dbhost = input("Input database host: ")
    dbport = input("Input database port: ")
    user = input("Input user name: ")
    pswd = input("Input password: ")
    return dbname, dbhost, dbport, user, pswd


def connect_db():
    conn = psycopg2.connect(database=db_name, user=user_name, password=password_text,
                            host=db_host, port=db_port)
    cur = conn.cursor()
    return conn, cur


def write_result(result_file, conn, cur):
    query = '''
    SELECT Address.Region, Exam.Test_year, min(Exam.Ball100) 
    FROM Exam JOIN Person ON (Exam.person_id = Person.person_id) 
	JOIN Person_Address On (Person_Address.person_id = Person.person_id)
	JOIN Address ON (Person_Address.address_id = Address.address_id)
    WHERE Exam.Object_name = 'Історія' AND
        Exam.Object_status = 'Зараховано'
    GROUP BY Address.Region, Exam.Test_year;'''
    cur.execute(query)
    with open(result_file, 'w', newline='', encoding="cp1251") as csv_file:
        csv_writer = csv.writer(csv_file)
        # Зберігаємо заголовки
        csv_writer.writerow(['Область', 'Рік', 'Найгірший бал з Історії України'])
        # Збергіаємо результати запиту
        for row in cur:
            csv_writer.writerow(row)
    return conn, cur



db_name, db_host, db_port, user_name, password_text = input_config()
connect, cursor = connect_db()

connect, cursor = write_result('result2.csv', connect, cursor)
cursor.close()
connect.close()

