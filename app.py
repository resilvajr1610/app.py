from flask import Flask, request, jsonify
from flask_cors import CORS
from deepface import DeepFace
import cv2
import numpy as np

app = Flask(__name__)
CORS(app)

@app.route('/verificar', methods=['POST'])
def verificar():
    img1 = request.files['imagem1'].read()
    img2 = request.files['imagem2'].read()

    nparr1 = np.frombuffer(img1, np.uint8)
    nparr2 = np.frombuffer(img2, np.uint8)

    img1_cv = cv2.imdecode(nparr1, cv2.IMREAD_COLOR)
    img2_cv = cv2.imdecode(nparr2, cv2.IMREAD_COLOR)

    try:
        result = DeepFace.verify(img1_cv, img2_cv)
        return jsonify(result)
    except Exception as e:
        return jsonify({'erro': str(e)}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)