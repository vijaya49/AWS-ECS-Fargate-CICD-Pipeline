# from flask import Flask, jsonify
# from datetime import datetime, timezone

# app = Flask(__name__)

# @app.route('/')
# def get_current_time():
#     utc_now = datetime.now(timezone.utc)
#     return jsonify({
#         "current_time": utc_now.isoformat()
#     })

# from flask import Flask, render_template
# from datetime import datetime, timezone

# app = Flask(__name__)

# @app.route('/')
# def get_current_time():
#     utc_now = datetime.now(timezone.utc)
#     return render_template('time.html', current_time=utc_now.isoformat())

# if __name__ == '__main__':
#     app.run(debug=True)

from flask import Flask, jsonify, request
from datetime import datetime, timezone

app = Flask(__name__)

@app.route('/')
def get_info():
    utc_now = datetime.now(timezone.utc)
    visitor_ip = request.headers.get('X-Forwarded-For', request.remote_addr)
    
    return jsonify({
        "timestamp": utc_now.isoformat(),
        "ip": visitor_ip
    })

if __name__ == '__main__':
    app.run(debug=True)
