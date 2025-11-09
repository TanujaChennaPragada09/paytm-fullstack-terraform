from flask import Flask, request, jsonify
import pymysql
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# ---------- RDS MySQL Config ----------
db_config = {
    "host": "paytm-db.c2tmsk8a8e60.us-east-1.rds.amazonaws.com",
    "user": "admin",
    "password": "admin123",
    "database": "paytm"
}

def get_db_connection():
    return pymysql.connect(
        host=db_config["host"],
        user=db_config["user"],
        password=db_config["password"],
        database=db_config["database"]
    )

# ---------- Health Check ----------
@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "✅ Paytm Flask API is running successfully!"})

# ---------- SIGNUP ----------
@app.route("/api/save", methods=["POST"])
def save_user():
    try:
        data = request.get_json()
        email = data.get("email")
        password = data.get("password")

        if not email or not password:
            return jsonify({"error": "Email and password required"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()
        sql = "INSERT INTO users (email, password) VALUES (%s, %s)"
        cursor.execute(sql, (email, password))
        conn.commit()

        cursor.close()
        conn.close()
        return jsonify({"message": "User registered successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# ---------- LOGIN ----------
@app.route("/api/login", methods=["POST"])
def login_user():
    try:
        data = request.get_json()
        email = data.get("email")
        password = data.get("password")

        if not email or not password:
            return jsonify({"error": "Email and password required"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()
        sql = "SELECT * FROM users WHERE email = %s AND password = %s"
        cursor.execute(sql, (email, password))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if user:
            return jsonify({"message": "Login successful", "email": email}), 200
        else:
            return jsonify({"error": "Invalid email or password"}), 401
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
