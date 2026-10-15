import os, random
from flask import Flask, render_template, request, redirect, url_for, flash, session, url_for, make_response
from werkzeug.utils import secure_filename
import mysql.connector
from flask_mail import Mail, Message
from flask import jsonify, request
import time  # Import time to simulate the waiting period
import threading  # Import threading to run the status update in the background
from flask import jsonify
import time
import logging
import threading
from werkzeug.security import generate_password_hash




app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Replace with your actual secret key
# Set the upload folder path for general images
app.config['UPLOAD_FOLDER'] = os.path.join('static', 'upload_images')

app.config['UPLOAD_FOLDERS'] = os.path.join('static', 'refund_request')

# Set the upload folder path specifically for registration uploads
REGISTRATION_UPLOAD_FOLDER = r"F:\E-COMMERCE KAILAN MO KO UUPDATE\static\registration_uploads"
app.config['REGISTRATION_UPLOAD_FOLDER'] = REGISTRATION_UPLOAD_FOLDER

UPLOAD_FOLDER = 'static/profile_picture_uploads'

# Configure Flask-Mail
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'glamourgaze33@gmail.com'  # Your Gmail address
app.config['MAIL_PASSWORD'] = 'dzjd ciep jexs tilj'  # The app password you generated
mail = Mail(app)

# Allowed file extensions
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Database connection function
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",               # Replace with your DB user
        password="",               # Replace with your DB password
        database="ecomm"           # Replace with your database name
    )

# Route for Home (root) - redirects to login
@app.route('/')
def home():
    return redirect(url_for('login'))  # Redirect to login page

from werkzeug.security import check_password_hash



@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        
        # Check if user exists in the database
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT ID, Username, Password, Roles, Status FROM user_info WHERE Email = %s", (email,))
        user = cursor.fetchone()
        conn.close()

        if user:
            user_id, username, stored_password, role, status = user

            # Check if the status is pending
            if status.lower() == 'pending':  
                flash("Your application is still under review. Please wait for approval.", "warning")
                return render_template('login.html')

            password_valid = False  # Default to invalid

            # **Check if the stored password is already hashed**
            if stored_password.startswith('pbkdf2:sha256'):
                # If hashed, verify using check_password_hash
                password_valid = check_password_hash(stored_password, password)
            else:
                # If plain text, compare directly (temporary check)
                if stored_password == password:
                    password_valid = True

                    # **Upgrade old passwords to hashed versions**
                    new_hashed_password = generate_password_hash(password, method='pbkdf2:sha256')
                    conn = get_db_connection()
                    cursor = conn.cursor()
                    cursor.execute("UPDATE user_info SET Password = %s WHERE ID = %s", (new_hashed_password, user_id))
                    conn.commit()
                    conn.close()

            if password_valid:
                session['user'] = username  # Store the username in the session
                session['role'] = role  # User role
                session['seller_id'] = user_id  # Seller ID
                session['user_id'] = user_id  # Store user ID
                session['username'] = username  # Store username

                # Redirect based on user role
                if role.lower() == 'admin':
                    return redirect(url_for('admin', user_type='buyers'))  
                elif role.lower() == 'seller':
                    return redirect(url_for('seller_homepage'))  
                elif role.lower() == 'courier':
                    return redirect(url_for('courierrrr'))  
                else:
                    return redirect(url_for('buyer_homepage'))  

            else:
                flash("Invalid email or password", "danger")
        else:
            flash("Invalid email or password", "danger")
    
    return render_template('login.html')

@app.route('/courierrrr')
def courierrrr():
    return render_template('courierrrr.html')




@app.route('/logout')
def logout():
    session.clear()  # Clear the session
    flash("You have been logged out.")
    return redirect(url_for('login'))

@app.route('/buyer_register', methods=['GET', 'POST'])
def buyer_register():
    if request.method == 'POST':
        # Capture form fields
        username = request.form['username']
        first_name = request.form['first_name']
        middle_name = request.form.get('middle_name', '')  # Optional field
        last_name = request.form['last_name']
        email = request.form['email']
        password = request.form['password']
        municipality = request.form['municipality']
        province = request.form['province']
        barangay = request.form['barangay']
        phone_number = request.form['phone']
        role = 'buyer'
        profile_picture = 'default.png'
        status = 'pending'  # Sellers have a 'pending' status by default

        # Hash the password
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')

        # Check if email already exists
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM user_info WHERE Email = %s", (email,))
        existing_user = cursor.fetchone()

        if existing_user:
            flash("Email already registered")
            conn.close()
            return redirect(url_for('buyer_register'))

        try:
            # Generate OTP for verification
            otp = random.randint(100000, 999999)

            # Handle file upload for upload_id
            upload_id = request.files.get('upload_id')
            upload_id_path = None

            if upload_id:
                user_dir = os.path.join(app.config['REGISTRATION_UPLOAD_FOLDER'], email)
                os.makedirs(user_dir, exist_ok=True)

                upload_id_filename = 'upload_id' + os.path.splitext(upload_id.filename)[1]
                upload_id_path = os.path.join(user_dir, upload_id_filename)
                upload_id.save(upload_id_path)
                upload_id_path = f'registration_uploads/{email}/{upload_id_filename}'

            # Store user details and OTP in the session temporarily
            session['registration_data'] = {
                'username': username,
                'first_name': first_name,
                'middle_name': middle_name,
                'last_name': last_name,
                'email': email,
                'password': hashed_password,
                'municipality': municipality,
                'province': province,
                'barangay': barangay,
                'phone_number': phone_number,
                'role': role,
                'profile_picture': profile_picture,
                'upload_id': upload_id_path,
                'status': status  # Set status to 'Pending'
            }
            session['otp'] = otp

            # Send OTP email
            send_otp_email(email, otp)
            flash(f"An OTP has been sent to {email} for verification.")

        except Exception as e:
            flash(f"An error occurred: {str(e)}")
        finally:
            conn.close()

        return redirect(url_for('verify_otp'))  # Redirect to OTP verification page

    return render_template('buyer_register.html')





def send_buyer_approval_email(buyer_email):
    subject = "Welcome to Glamour Gaze!"
    recipient = buyer_email

    message = f"""Hello,

Congratulations! Your buyer account has been successfully registered and approved. You can now explore our platform and start shopping.

Thank you for joining Glamour Gaze!

Best regards,
Glamour Gaze Team
"""

    msg = Message(subject, sender="joracion42@gmail.com", recipients=[recipient])
    msg.body = message

    try:
        print("Preparing to send buyer approval email...")
        mail.send(msg)
        print("Buyer approval email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")
        flash("There was an error sending the approval email.")


from werkzeug.security import generate_password_hash

@app.route('/seller_register', methods=['GET', 'POST'])
def seller_register():
    if request.method == 'POST':
        username = request.form['username']
        first_name = request.form['first_name']
        middle_name = request.form.get('middle_name', '')  # Optional field
        last_name = request.form['last_name']
        email = request.form['email']
        password = request.form['password']
        business_name = request.form.get('business_name')
        phone_number = request.form.get('phone')
        province = request.form['province']
        municipality = request.form['municipality']
        barangay = request.form['barangay']
        role = 'seller'
        status = 'pending'  # Sellers have a 'pending' status by default

        # Check if the password meets length requirements
        if len(password) < 8:
            flash("Password must be at least 8 characters long.", 'danger')
            return redirect(url_for('seller_register'))

        # Hash the password before storing
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')

        # Check if the email already exists
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM user_info WHERE Email = %s", (email,))
        existing_user = cursor.fetchone()

        if existing_user:
            flash("Email already registered", 'danger')
            conn.close()
            return redirect(url_for('seller_register'))

        try:
            otp = random.randint(100000, 999999)

            # Store user data in session
            session['registration_data'] = {
                'username': username,
                'first_name': first_name,
                'middle_name': middle_name,
                'last_name': last_name,
                'email': email,
                'password': hashed_password,  # Store hashed password
                'business_name': business_name,
                'phone_number': phone_number,
                'province': province,
                'municipality': municipality,
                'barangay': barangay,
                'role': role,
                'status': status
            }
            session['otp'] = otp

            # Handle file uploads
            business_permit = request.files.get('business_permit')
            upload_id = request.files.get('upload_id')
            user_dir = os.path.join(app.config['REGISTRATION_UPLOAD_FOLDER'], email)
            os.makedirs(user_dir, exist_ok=True)

            # Save business_permit
            if business_permit:
                business_permit_filename = 'business_permit' + os.path.splitext(business_permit.filename)[1]
                business_permit_path = os.path.join(user_dir, business_permit_filename)
                business_permit.save(business_permit_path)
                session['registration_data']['business_permit'] = business_permit_path

            # Save upload_id
            if upload_id:
                upload_id_filename = 'upload_id' + os.path.splitext(upload_id.filename)[1]
                upload_id_path = os.path.join(user_dir, upload_id_filename)
                upload_id.save(upload_id_path)
                session['registration_data']['upload_id'] = upload_id_path

            # Send OTP email
            send_otp_email(email, otp)
            flash(f"An OTP has been sent to {email} for verification.", 'success')

        except Exception as e:
            flash(f"An error occurred: {str(e)}", 'danger')
        finally:
            conn.close()

        return redirect(url_for('verify_otp'))

    return render_template('seller_register.html')

@app.route('/courier_register', methods=['GET', 'POST'])
def courier_register():
    if request.method == 'POST':
        # Capture form fields
        username = request.form['username']
        first_name = request.form['first_name']
        middle_name = request.form.get('middle_name', '')  # Optional field
        last_name = request.form['last_name']
        email = request.form['email']
        password = request.form['password']
        municipality = request.form['municipality']
        province = request.form['province']
        barangay = request.form['barangay']
        phone_number = request.form['phone']
        vehicle_type = request.form['vehicle_type']  # Vehicle type
        plate_number = request.form['plate_number']  # Added plate number
        role = 'courier'
        profile_picture = 'default.png'  # Default profile picture
        status = 'pending'  # Status is 'pending' by default

        # Hash the password
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')

        # Check if email already exists
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM user_info WHERE Email = %s", (email,))
        existing_user = cursor.fetchone()

        if existing_user:
            flash("Email already registered")
            conn.close()
            return redirect(url_for('courier_register'))

        try:
            # Generate OTP for verification
            otp = random.randint(100000, 999999)

            # Handle file upload for upload_id
            upload_id = request.files.get('upload_id')
            upload_id_path = None

            if upload_id:
                user_dir = os.path.join(app.config['REGISTRATION_UPLOAD_FOLDER'], email)
                os.makedirs(user_dir, exist_ok=True)

                upload_id_filename = 'upload_id' + os.path.splitext(upload_id.filename)[1]
                upload_id_path = os.path.join(user_dir, upload_id_filename)
                upload_id.save(upload_id_path)
                upload_id_path = f'registration_uploads/{email}/{upload_id_filename}'

            # Store user details and OTP in the session temporarily
            session['registration_data'] = {
                'username': username,
                'first_name': first_name,
                'middle_name': middle_name,
                'last_name': last_name,
                'email': email,
                'password': hashed_password,  # Store hashed password
                'municipality': municipality,
                'province': province,
                'barangay': barangay,
                'phone_number': phone_number,
                'vehicle_type': vehicle_type,  # Store vehicle type
                'plate_number': plate_number,  # Store plate number
                'role': role,
                'profile_picture': profile_picture,
                'upload_id': upload_id_path,
                'status': status  # Set status to 'Pending'
            }
            session['otp'] = otp

            # Send OTP email
            send_otp_email(email, otp)
            flash(f"An OTP has been sent to {email} for verification.")

        except Exception as e:
            flash(f"An error occurred: {str(e)}")
        finally:
            conn.close()

        return redirect(url_for('verify_otp'))  # Redirect to OTP verification page

    return render_template('courier_register.html')







# Route to Accept Seller Application
@app.route('/admin/approve/<email>', methods=['POST'])
def approve_application(email):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Update seller's status to approved
    cursor.execute("UPDATE user_info SET Status = 'approved' WHERE Email = %s", (email,))
    conn.commit()
    conn.close()

    # Send approval email to the seller
    send_approval_email(email)

    flash(f"Application for {email} has been accepted.")
    return redirect(url_for('admin'))  # Redirect to admin dashboard or suitable page

def send_approval_email(seller_email):
    subject = "Your Seller Account Status"
    recipient = seller_email

    message = f"""Hello,

Your seller account has been successfully approved by the admin. You can now start selling your products.

Thank you for being a part of our platform!

Best regards,
Glamour Gaze Team
"""

    msg = Message(subject, sender="glamourgaze33@gmail.com", recipients=[recipient])
    msg.body = message

    try:
        print("Preparing to send approval email...")
        mail.send(msg)
        print("Approval email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")  # Log error
        flash(f"There was an error sending the email: {e}")

# Route to Reject Seller Application
@app.route('/admin/reject/<email>', methods=['POST'])
def reject_application(email):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Delete the seller from the user_info table
    cursor.execute("DELETE FROM user_info WHERE Email = %s", (email,))
    conn.commit()
    conn.close()

    # Send rejection email to the seller
    send_rejection_email(email)

    flash(f"Application for {email} has been rejected and the seller is removed.")
    return redirect(url_for('admin'))  # Redirect to admin dashboard or suitable page

def send_rejection_email(seller_email):
    subject = "Your Seller Account Status"
    recipient = seller_email

    message = f"""Hello,

We regret to inform you that your seller account has been rejected.

Thank you for your understanding.

Best regards,
Glamour Gaze Team
"""

    msg = Message(subject, sender="glamourgaze33@gmail.com", recipients=[recipient])
    msg.body = message

    try:
        print("Preparing to send rejection email...")
        mail.send(msg)
        print("Rejection email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")  # Log error
        flash(f"There was an error sending the email: {e}")

# Route for Password Recovery
@app.route('/password_recovery', methods=['GET', 'POST'])
def password_recovery():
    if 'step' not in session:
        session['step'] = 'request'  # Default to the first step

    step = session['step']  # Get the current step from the session

    if request.method == 'POST':
        if step == 'request':
            email = request.form['email']
            
            # Check if email exists in the database
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("SELECT Username FROM user_info WHERE Email = %s", (email,))
            user = cursor.fetchone()
            conn.close()

            if user:
                # Generate OTP
                otp = random.randint(100000, 999999)

                # Save OTP in session
                session['otp'] = otp
                session['email'] = email  # Store email in session
                session['step'] = 'verify'  # Move to OTP verification step
                
                # Send OTP via email
                send_otp_email(email, otp)

                flash(f"An OTP has been sent to {email}.")
                return redirect(url_for('password_recovery'))

            flash("Email not found.")
        
        elif step == 'verify':
            otp = request.form['otp']
            if str(session.get('otp')) == str(otp):  # Compare as strings
                session['step'] = 'change'  # Move to change password step
                flash("OTP verified. Please enter your new password.")
                return redirect(url_for('password_recovery'))  # Redirect to the same page to show change password form
            flash("Invalid OTP")
        
        elif step == 'change':
            new_password = request.form['new_password']

            # Check if the new password is at least 8 characters long
            if len(new_password) < 8:
                flash("Password must be at least 8 characters long.")
                return redirect(url_for('password_recovery'))

            # Hash the new password before saving it
            hashed_password = generate_password_hash(new_password)

            # Update password in the database
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("UPDATE user_info SET Password = %s WHERE Email = %s", (hashed_password, session['email']))
            conn.commit()
            conn.close()

            flash("Password has been changed successfully!")
            session.pop('step', None)  # Clear the step from the session
            session.pop('otp', None)  # Clear the OTP from the session
            session.pop('email', None)  # Remove email from session

            return redirect(url_for('login'))

    return render_template('password_recovery.html', step=step)

@app.route('/courier_homepage')
def courier_homepage():
    return render_template('courier_homepage.html')


# Route for Admin Dashboard
@app.route('/admin', methods=['GET'])
def admin():
    username = session.get('username', None)  # Get username from session
    user_is_logged_in = username is not None  # Check if user is logged in

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Fetch banned users
    cursor.execute("SELECT * FROM user_info_banned")
    banned_users = cursor.fetchall()

   # Fetch buyers
    cursor.execute("""
        SELECT first_name, last_name, Email, Roles, Status, created_at
        FROM user_info WHERE Roles = 'buyer'
    """)
    buyer_users = cursor.fetchall()

    # Fetch sellers
    cursor.execute("""
        SELECT first_name, last_name, Email, Roles, Status, Business_name, Phone_number, created_at
        FROM user_info WHERE Roles = 'seller'
    """)
    seller_users = cursor.fetchall()

      # Fetch couriers
    cursor.execute("""
    SELECT first_name, last_name, Email, Roles, Status, Phone_number, vehicle_type, plate_number, created_at
    FROM user_info WHERE Roles = 'courier'
    """)

    courier_users = cursor.fetchall()


    for user in buyer_users:
        # Construct the buyer's folder path using their email
        user_folder = os.path.join(app.config['REGISTRATION_UPLOAD_FOLDER'], user['Email'])
        
        # Resolve path for upload_id
        id_path = os.path.join(user_folder, 'upload_id.jpg')

        # Debugging: print the path being checked for the upload_id file
        print(f"Checking for buyer {user['Email']}'s upload_id at {id_path}")

        if os.path.exists(id_path):
            user['upload_id'] = f'registration_uploads/{user["Email"]}/upload_id.jpg'
            print(f"Found upload_id for buyer {user['Email']}")
        else:
            user['upload_id'] = None
            print(f"upload_id not found for buyer {user['Email']}")

    # Close the connection after fetching the buyers
    conn.close()

  
    for user in seller_users:
        # Construct the seller's folder path using their email
        user_folder = os.path.join(app.config['REGISTRATION_UPLOAD_FOLDER'], user['Email'])
        
        # Resolve paths for business_permit and upload_id
        permit_path = os.path.join(user_folder, 'business_permit.jpg')
        id_path = os.path.join(user_folder, 'upload_id.jpg')

        # Check if the files exist and set paths relative to the static folder
        if os.path.exists(permit_path):
            user['business_permit'] = f'registration_uploads/{user["Email"]}/business_permit.jpg'
        else:
            user['business_permit'] = None

        if os.path.exists(id_path):
            user['upload_id'] = f'registration_uploads/{user["Email"]}/upload_id.jpg'
        else:
            user['upload_id'] = None

    conn.close()

    # Process Uploads for Couriers
    for user in courier_users:
        # Construct the courier's folder path using their email
        user_folder = os.path.join(app.config['REGISTRATION_UPLOAD_FOLDER'], user['Email'])

        # Resolve paths for license and upload_id
        license_path = os.path.join(user_folder, 'license.jpg')  # Assuming couriers upload a license
        id_path = os.path.join(user_folder, 'upload_id.jpg')

        # Check if the files exist and set paths relative to the static folder
        user['license'] = f'registration_uploads/{user["Email"]}/license.jpg' if os.path.exists(license_path) else None
        user['upload_id'] = f'registration_uploads/{user["Email"]}/upload_id.jpg' if os.path.exists(id_path) else None

    conn.close()

    return render_template(
        'admin.html',
        buyer_users=buyer_users,
        seller_users=seller_users,
        courier_users=courier_users,  # Pass couriers to template
        banned_users=banned_users,
        user_is_logged_in=user_is_logged_in,
        username=username
    )


@app.route('/toggle_ban/<email>', methods=['POST'])
def toggle_ban(email):
    conn = get_db_connection()  # Create a new database connection
    cursor = conn.cursor(dictionary=True)

    # Fetch user information
    cursor.execute("SELECT * FROM user_info WHERE Email = %s", (email,))
    user = cursor.fetchone()

    if user:
        try:
            cursor.execute(""" 
                INSERT INTO user_info_banned (
                    ID, 
                    Username, 
                    Email, 
                    Password, 
                    Roles, 
                    Status, 
                    created_at, 
                    Business_name, 
                    Phone_number, 
                    Business_permit, 
                    Upload_id,
                    gender,
                    date_of_birth,
                    profile_picture,
                    municipality,
                    province,
                    barangay
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                user['ID'],
                user['Username'], 
                user['Email'], 
                user['Password'],  # Ideally, this should be hashed
                user['Roles'], 
                user['Status'],
                user['created_at'], 
                user['Business_name'], 
                user['Phone_number'],
                user['Business_permit'], 
                user['Upload_id'],
                user['gender'],  
                user['date_of_birth'],  
                user['profile_picture'],  
                user['municipality'],
                user['province'],
                user['barangay']
            ))

            # Delete user from user_info
            cursor.execute("DELETE FROM user_info WHERE Email = %s", (email,))
            conn.commit()  # Commit the changes

            flash('User banned successfully.', 'success')
        except Exception as e:
            conn.rollback()  # Rollback in case of error
            flash(f'Error banning user: {str(e)}', 'danger')
    else:
        flash('User not found.', 'danger')

    cursor.close()  # Close the cursor
    conn.close()    # Close the connection

    return redirect(url_for('admin'))


@app.route('/unban/<email>', methods=['POST'])
def unban(email):
    conn = get_db_connection()  # Create a new database connection
    cursor = conn.cursor(dictionary=True)

    # Fetch user information from user_info_banned
    cursor.execute("SELECT * FROM user_info_banned WHERE Email = %s", (email,))
    user = cursor.fetchone()

    if user:
        try:
            # Check if the user already exists in user_info
            cursor.execute("SELECT * FROM user_info WHERE Email = %s", (email,))
            existing_user = cursor.fetchone()

            if existing_user:
                flash('User already exists in the active users list.', 'danger')
            else:
                # Insert user data back into user_info
                cursor.execute(""" 
                    INSERT INTO user_info (
                        ID, 
                        Username, 
                        first_name, 
                        last_name, 
                        middle_name, 
                        Email, 
                        Password, 
                        Roles, 
                        Status, 
                        created_at, 
                        Business_name, 
                        Phone_number, 
                        Business_permit, 
                        Upload_id,
                        gender,
                        date_of_birth,
                        profile_picture,
                        municipality,
                        province,
                        barangay
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (
                    user['ID'], 
                    user['Username'], 
                    user['first_name'], 
                    user['last_name'], 
                    user['middle_name'], 
                    user['Email'], 
                    user['Password'],  # Ideally, this should be hashed
                    user['Roles'], 
                    user['Status'],  # Status remains unchanged
                    user['created_at'], 
                    user['Business_name'], 
                    user['Phone_number'], 
                    user['Business_permit'], 
                    user['Upload_id'],
                    user['gender'],  
                    user['date_of_birth'],  
                    user['profile_picture'],  
                    user['municipality'],
                    user['province'],
                    user['barangay']
                ))

                # Delete the user from user_info_banned
                cursor.execute("DELETE FROM user_info_banned WHERE Email = %s", (email,))

                conn.commit()  # Commit changes to the database
                flash('User unbanned successfully.', 'success')

                # Send email notification
                send_unban_email(user['Email'])  # Send the unban email to the user

        except Exception as e:
            conn.rollback()  # Rollback in case of error
            flash(f'Error unbanning user: {str(e)}', 'danger')
    else:
        flash('User not found in banned list.', 'danger')

    cursor.close()  # Close the cursor
    conn.close()    # Close the connection

    return redirect(url_for('admin'))  # Redirect back to admin dashboard




@app.route('/admin_dashboard_data')
def admin_dashboard_data():
    if 'user_id' not in session:
        return jsonify({'error': 'User not logged in'}), 401

    # Get the search query and date range if available
    search_query = request.args.get('search', '').lower()
    start_date = request.args.get('start_date', '')
    end_date = request.args.get('end_date', '')

    # Connect to the database
    connection = get_db_connection()
    cursor = connection.cursor()


    # Fetch count of approved users
    cursor.execute(
        "SELECT COUNT(*) FROM user_info WHERE status = 'approved'"
    )
    approved_users_count = cursor.fetchone()[0]

    # Fetch count of products listed by sellers
    cursor.execute(
        "SELECT COUNT(*) FROM seller_add_product"
    )
    products_listed_count = cursor.fetchone()[0]

    # Fetch count of completed transactions (orders with status 'Completed')
    cursor.execute(
        "SELECT COUNT(*) FROM orders WHERE status = 'Completed'"
    )
    transactions_made_count = cursor.fetchone()[0]

    # Fetch count of pending approval users
    cursor.execute(
        "SELECT COUNT(*) FROM user_info WHERE status = 'pending'"
    )
    pending_approval_count = cursor.fetchone()[0]

    # Build the dynamic WHERE clause based on the search query
    search_clause = f"WHERE status = 'Completed' AND (" \
                    f"LOWER(username) LIKE '%{search_query}%' OR " \
                    f"LOWER(phoneNumber) LIKE '%{search_query}%' OR " \
                    f"LOWER(productName) LIKE '%{search_query}%' OR " \
                    f"LOWER(business_name) LIKE '%{search_query}%' OR " \
                    f"LOWER(total) LIKE '%{search_query}%' OR " \
                    f"LOWER(payment_method) LIKE '%{search_query}%' OR " \
                    f"LOWER(created_at) LIKE '%{search_query}%' " \
                    f")"

    # Add date range filter if both start and end dates are provided
    if start_date and end_date:
        search_clause += f" AND created_at BETWEEN '{start_date}' AND '{end_date}'"
    elif start_date:
        search_clause += f" AND created_at >= '{start_date}'"
    elif end_date:
        search_clause += f" AND created_at <= '{end_date}'"

    # Fetch completed orders with specified fields and the search filter applied
    cursor.execute(f"""
        SELECT 
            username,
            phoneNumber,
            productName,
            quantity,
            business_name,
            total,
            payment_method,
            created_at,
            total_gross,  -- Add total_gross
            total_net     -- Add total_net
        FROM orders
        {search_clause}
    """)

    completed_orders = cursor.fetchall()

    # Process completed orders into a list of dictionaries with formatted dates
    completed_orders_list = []
    for order in completed_orders:
        completed_orders_list.append({
            'username': order[0],
            'phoneNumber': order[1],
            'productName': order[2],
            'quantity': order[3],
            'business_name': order[4],
            'total': order[5],
            'payment_method': order[6],
            'created_at': order[7].strftime('%Y-%m-%d %H:%M:%S'),  # Format date to YYYY-MM-DD HH:MM:SS
            'total_gross': order[8],  # Add total_gross
            'total_net': order[9]     # Add total_net
        })

    # Close the cursor and connection
    cursor.close()
    connection.close()

    # Return all data as a JSON response
    return jsonify({
        'approved_users_count': approved_users_count,
        'products_listed_count': products_listed_count,
        'transactions_made_count': transactions_made_count,
        'pending_approval_count': pending_approval_count,
        'completed_orders': completed_orders_list
    })





@app.route('/admin/ban/<email>', methods=['POST'])
def ban_user(email):
    conn = get_db_connection()  # Create a new database connection
    cursor = conn.cursor(dictionary=True)

    # Retrieve the ban reason from the form
    reason = request.form.get('reason')

    # Fetch user information from the database
    cursor.execute("SELECT * FROM user_info WHERE Email = %s", (email,))
    user = cursor.fetchone()

    if user:
        try:
            # Insert the user into the banned users table without changing the status
            cursor.execute(""" 
                INSERT INTO user_info_banned (
                    ID, 
                    Username, 
                    first_name, 
                    last_name, 
                    middle_name, 
                    Email, 
                    Password, 
                    Roles, 
                    Status, 
                    created_at, 
                    Business_name, 
                    Phone_number, 
                    Business_permit, 
                    Upload_id,
                    gender,
                    date_of_birth,
                    profile_picture,
                    Address,
                    ban_reason  -- Optional: Store the reason for the ban
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                user['ID'],
                user['Username'], 
                user['first_name'], 
                user['last_name'], 
                user['middle_name'], 
                user['Email'], 
                user['Password'],  # Ideally, this should be hashed
                user['Roles'], 
                user['Status'],  # Do not change the status here
                user['created_at'], 
                user['Business_name'], 
                user['Phone_number'],
                user['Business_permit'], 
                user['Upload_id'],
                user['gender'],  
                user['date_of_birth'],  
                user['profile_picture'],  
                user['Address'],
                reason  # Store the reason for the ban
            ))

            # Delete the user from the user_info table after banning
            cursor.execute("DELETE FROM user_info WHERE Email = %s", (email,))

            # Commit the changes
            conn.commit()

            # Send a ban email with the reason
            send_ban_email(email, reason)

            flash(f"User {email} has been banned. A notification email has been sent.", 'success')
        except Exception as e:
            conn.rollback()  # Rollback in case of error
            flash(f'Error banning user: {str(e)}', 'danger')
    else:
        flash('User not found.', 'danger')

    cursor.close()  # Close the cursor
    conn.close()    # Close the connection

    return redirect(url_for('admin'))  # Redirect to the admin page


def send_ban_email(seller_email, reason):
    subject = "Your Account Has Been Banned"
    recipient = seller_email

    message = f"""Hello,

We regret to inform you that your account has been banned for the following reason:

{reason}

If you believe this was a mistake, please contact support.

Best regards,
Glamour Gaze Team
"""

    msg = Message(subject, sender="glamourgaze33@gmail.com", recipients=[recipient])
    msg.body = message

    try:
        mail.send(msg)
        print("Ban email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")
        flash(f"There was an error sending the ban email: {e}")

def send_unban_email(seller_email):
    subject = "Your Account Has Been Unbanned"
    recipient = seller_email

    message = f"""Hello,

We are happy to inform you that your account has been unbanned and restored to active status.

If you have any questions or concerns, please contact support.

Best regards,
Glamour Gaze Team
"""

    msg = Message(subject, sender="glamourgaze33@gmail.com", recipients=[recipient])
    msg.body = message

    try:
        mail.send(msg)
        print("Unban email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")
        flash(f"There was an error sending the unban email: {e}")



@app.route('/buyer_homepage')
def buyer_homepage():
    # Check if user is logged in
    username = session.get('username', None)  # Get username from session
    user_is_logged_in = username is not None  # Check if user is logged in

    
    # Fetch 16 random products from the entire seller_add_product table
    conn = get_db_connection()  # Establish DB connection
    cursor = conn.cursor()

    # Query to get 16 random products from all columns in the table
    query = "SELECT * FROM seller_add_product ORDER BY RAND() LIMIT 16"
    cursor.execute(query)
    products = cursor.fetchall()  # Fetch 16 random products with all columns

    # Debugging: Print the raw products data
    print("Raw Products Data:", products)

    # Close connection
    cursor.close()
    conn.close()

    # Render the template and pass the products data along with user info
    return render_template('buyer_homepage.html', user_is_logged_in=user_is_logged_in, username=username, products=products)

@app.route('/search_products', methods=['GET'])
def search_products():
    query = request.args.get('query', '').strip()
    products = search_products_in_database(query)  # Custom function to search in seller_add_product
    
    user_is_logged_in = 'user_id' in session
    username = session.get('username', None)

    return render_template(
        'search_products.html',  # Ensure this matches your actual template filename
        products=products,
        user_is_logged_in=user_is_logged_in,
        username=username
    )



def search_products_in_database(query):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        sql = """
            SELECT * FROM seller_add_product 
            WHERE LOWER(product_name) LIKE LOWER(%s)
        """
        search_term = f"%{query}%"
        cursor.execute(sql, (search_term,))
        products = cursor.fetchall()
        return products
    except mysql.connector.Error as err:
        print(f"Error fetching products: {err}")
        return []
    finally:
        cursor.close()
        conn.close()


@app.route('/seller_homepage')
def seller_homepage():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    seller_id = session.get('seller_id') or session.get('user_id')
    listed_products = []
    unlisted_products = []
    search_query = ''
    selected_category = 'all'

    if seller_id:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM seller_add_product WHERE seller_id = %s AND product_status = 'listed'", (seller_id,))
        listed_products = cursor.fetchall()
        cursor.execute("SELECT * FROM seller_unlisted_products WHERE seller_id = %s", (seller_id,))
        unlisted_products = cursor.fetchall()
        cursor.close()
        conn.close()

    return render_template(
        'seller_homepage.html',
        listed_products=listed_products,
        unlisted_products=unlisted_products,
        search_query=search_query,
        selected_category=selected_category,
        active_tab='dashboard'
    )

@app.route('/seller_dashboard_data')
def seller_dashboard_data():
    if 'user_id' not in session:
        return jsonify({'error': 'User not logged in'}), 401

    seller_id = session['user_id']
    search_query = request.args.get('search', '').lower()
    start_date = request.args.get('start_date', '')
    end_date = request.args.get('end_date', '')

    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetch cart count
    cursor.execute(
        "SELECT COUNT(*) FROM carts WHERE seller_id = %s",
        (seller_id,)
    )
    cart_count = cursor.fetchone()[0]

    # Fetch low stock count
    cursor.execute(
        "SELECT COUNT(*) FROM seller_add_product WHERE seller_id = %s AND stock_quantity < 15",
        (seller_id,)
    )
    low_stock_count = cursor.fetchone()[0]

    # Fetch pending shipment count (status 'To Pay')
    cursor.execute(
        """
        SELECT COUNT(*) FROM orders
        WHERE seller_id = %s AND status = 'To Pay'
        """,
        (seller_id,)
    )
    pending_shipment_count = cursor.fetchone()[0]

    # Fetch total orders count (status 'Completed')
    cursor.execute(
        """
        SELECT COUNT(*) FROM orders
        WHERE seller_id = %s AND status = 'Completed'
        """,
        (seller_id,)
    )
    total_orders_count = cursor.fetchone()[0]

    # Finance: Build dynamic WHERE clause based on the search query and date range
    search_clause = f"WHERE seller_id = {seller_id} AND status = 'Completed' AND (" \
                    f"LOWER(username) LIKE '%{search_query}%' OR " \
                    f"LOWER(phoneNumber) LIKE '%{search_query}%' OR " \
                    f"LOWER(productName) LIKE '%{search_query}%' OR " \
                    f"LOWER(business_name) LIKE '%{search_query}%' OR " \
                    f"LOWER(total) LIKE '%{search_query}%' OR " \
                    f"LOWER(payment_method) LIKE '%{search_query}%' OR " \
                    f"LOWER(created_at) LIKE '%{search_query}%' " \
                    f")"

    # Add date range filter if both start and end dates are provided
    if start_date and end_date:
        search_clause += f" AND created_at BETWEEN '{start_date}' AND '{end_date}'"
    elif start_date:
        search_clause += f" AND created_at >= '{start_date}'"
    elif end_date:
        search_clause += f" AND created_at <= '{end_date}'"

    # Fetch completed orders with specified fields and the search filter applied
    cursor.execute(f"""
        SELECT 
            username,
            phoneNumber,
            productName,
            quantity,
            business_name,
            total,
            payment_method,
            created_at,
            total_gross,  -- Add total_gross
            total_net     -- Add total_net
        FROM orders
        {search_clause}
    """)

    completed_orders = cursor.fetchall()

    # Process completed orders into a list of dictionaries with formatted dates
    completed_orders_list = []
    for order in completed_orders:
        completed_orders_list.append({
            'username': order[0],
            'phoneNumber': order[1],
            'productName': order[2],
            'quantity': order[3],
            'business_name': order[4],
            'total': order[5],
            'payment_method': order[6],
            'created_at': order[7].strftime('%Y-%m-%d %H:%M:%S'),
            'total_gross': order[8],  # Add total_gross
            'total_net': order[9]     # Add total_net
        })

    cursor.close()
    connection.close()

    return jsonify({
        'cart_count': cart_count,
        'low_stock_count': low_stock_count,
        'pending_shipment_count': pending_shipment_count,
        'total_orders_count': total_orders_count,
        'completed_orders': completed_orders_list
    })



@app.route('/seller_profile')
def seller_profile():
    user_is_logged_in = 'user_id' in session
    username = session.get('username', None)

    # Ensure the seller is authenticated before rendering the profile page
    if not user_is_logged_in:
        return redirect(url_for('login'))  # Redirect to login page if not authenticated

    user_id = session.get('user_id')
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch seller data based on session user_id
        cursor.execute(
            "SELECT Business_name, Email, Phone_number, gender, date_of_birth, profile_picture FROM user_info WHERE id = %s AND Roles = 'seller'",
            (user_id,)
        )
        seller_info = cursor.fetchone()

        if seller_info is None:
            flash('Seller not found or you do not have the correct permissions', 'danger')
            return redirect(url_for('login'))

    except Exception as e:
        flash(f"An error occurred: {e}", 'error')
        seller_info = None  # Ensure this is set to avoid undefined errors in the template

    finally:
        cursor.close()
        conn.close()

    # Render the template with seller data
    return render_template(
        'sellerProfile.html',
        seller=seller_info,
        user_is_logged_in=user_is_logged_in,
        username=username
    )

#Seller My Account
@app.route('/seller_my_account', methods=['GET', 'POST'])
def seller_my_account():
    user_id = session.get('user_id')
    if not user_id:
        flash("Please log in first", "warning")
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch seller data based on session user_id
        cursor.execute("SELECT Business_name, Email, Phone_number, gender, date_of_birth, profile_picture, Business_name FROM user_info WHERE id = %s AND Roles = 'seller'", (user_id,))
        seller_info = cursor.fetchone()  # Returns None if no data is found

        # If seller_info is None, display an error and redirect to login
        if seller_info is None:
            flash('Seller not found or you do not have the correct permissions', 'danger')
            return redirect(url_for('login'))

        # Process form data if the request method is POST
        if request.method == 'POST':
            business_name = request.form['business_name']
            email = request.form['email']
            phone_number = request.form['phone_number']
            gender = request.form['gender']
            dob = request.form['dob']

            # Handle profile picture upload
            profile_picture = request.files.get('profile_picture')
            profile_picture_filename = seller_info[5]  # Default to existing profile picture

            if profile_picture:
                # Save the new profile picture
                filename = secure_filename(profile_picture.filename)
                profile_picture_filename = filename
                upload_folder = os.path.join('static', 'profile_picture_uploads')
                profile_picture.save(os.path.join(upload_folder, filename))

            # Update seller profile in the database
            cursor.execute(
                "UPDATE user_info SET Business_name = %s, Email = %s, Phone_number = %s, gender = %s, date_of_birth = %s, profile_picture = %s WHERE id = %s",
                (business_name, email, phone_number, gender, dob, profile_picture_filename, user_id)
            )
            conn.commit()
            flash('Profile updated successfully!', 'success')
            return redirect(url_for('seller_my_account'))

    except Exception as e:
        flash(f"An error occurred: {e}", 'error')
    finally:
        cursor.close()
        conn.close()

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    # Pass the fetched seller_info as 'seller' to the template
    return render_template('sellerProfile.html', seller=seller_info, active_tab='seller-account', user_is_logged_in=user_is_logged_in, username=username)


@app.route('/buyer_profile')
def buyer_profile():
    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('buyerProfile.html', user_is_logged_in=user_is_logged_in, username=username)


@app.route('/verify_otp', methods=['GET', 'POST'])
def verify_otp():
    if request.method == 'POST':
        input_otp = request.form['otp']
        saved_otp = session.get('otp')
        registration_data = session.get('registration_data')

        if not registration_data:
            flash("No registration data found. Please register again.")
            return redirect(url_for('buyer_register'))

        if input_otp == str(saved_otp):
            conn = get_db_connection()
            cursor = conn.cursor()
            try:
                # Insert user data based on role
                if registration_data['role'] == 'buyer':
                    cursor.execute("""
                        INSERT INTO user_info 
                        (first_name, middle_name, last_name, Username, Email, Password, Roles, Status, 
                        Phone_number, created_at, profile_picture, municipality, province, barangay)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, 'pending', %s, NOW(), %s, %s, %s, %s)
                    """, (
                        registration_data['first_name'], registration_data['middle_name'], registration_data['last_name'],
                        registration_data['username'], registration_data['email'], registration_data['password'],
                        registration_data['role'], registration_data['phone_number'], 
                        registration_data['profile_picture'], registration_data['municipality'],
                        registration_data['province'], registration_data['barangay']
                    ))

                    flash("OTP verified successfully! Your account is now approved!")

                elif registration_data['role'] == 'seller':
                    cursor.execute("""
                        INSERT INTO user_info 
                        (first_name, middle_name, last_name, Username, Email, Password, Roles, Status, 
                        Business_name, Phone_number, created_at, Business_permit, Upload_id, municipality, province, barangay)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, 'pending', %s, %s, NOW(), %s, %s, %s, %s, %s)
                    """, (
                        registration_data['first_name'], registration_data['middle_name'], registration_data['last_name'],
                        registration_data['username'], registration_data['email'], registration_data['password'],
                        registration_data['role'], registration_data['business_name'], 
                        registration_data['phone_number'], registration_data.get('business_permit'),
                        registration_data.get('upload_id'), registration_data['municipality'],
                        registration_data['province'], registration_data['barangay']
                    ))

                    flash("OTP verified successfully! Your account is now pending admin approval.")

                elif registration_data['role'] == 'courier':
                    cursor.execute("""
                        INSERT INTO user_info 
                        (first_name, middle_name, last_name, Username, Email, Password, Roles, Status, 
                        Phone_number, created_at, profile_picture, municipality, province, barangay, vehicle_type, plate_number, Upload_id)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, 'pending', %s, NOW(), %s, %s, %s, %s, %s, %s, %s)
                    """, (
                        registration_data['first_name'], 
                        registration_data['middle_name'], 
                        registration_data['last_name'],
                        registration_data['username'], 
                        registration_data['email'], 
                        registration_data['password'],
                        registration_data['role'], 
                        registration_data['phone_number'], 
                        registration_data['profile_picture'], 
                        registration_data['municipality'],
                        registration_data['province'], 
                        registration_data['barangay'], 
                        registration_data['vehicle_type'], 
                        registration_data.get('plate_number', None),  # Ensure plate_number is passed as None if not present
                        registration_data.get('upload_id', None)  # Ensure upload_id is passed as None if not present
                    ))

                    flash("OTP verified successfully! Your courier account is now pending admin approval.")

                conn.commit()
            except Exception as e:
                conn.rollback()
                flash(f"An error occurred: {str(e)}")
            finally:
                conn.close()

            # Clear session data
            session.pop('otp', None)
            session.pop('registration_data', None)

            return redirect(url_for('login'))
        else:
            flash("Invalid OTP. Please try again.")

    return render_template('verify_otp.html')





# Route to send OTP for password change
@app.route('/send_change_password_otp', methods=['POST'])
def send_change_password_otp():
    data = request.get_json()
    user_email = data.get('email')
    if not user_email:
        print("No email provided.")
        return jsonify({"success": False, "message": "Email is required."}), 400

    otp = str(random.randint(100000, 999999))
    session['otp'] = otp  # Store OTP in session for verification
    print(f"Generated OTP: {otp} for email: {user_email}")

    # Attempt to send OTP email
    if send_password_otp_email(user_email, otp):
        return jsonify({"success": False, "message": "Failed to send OTP email."})
        
    else:
        return jsonify({"success": True, "message": "OTP sent to your email."}), 500

@app.route('/verify_change_password_otp', methods=['POST'])
def verify_change_password_otp():
    data = request.get_json()
    entered_otp = data.get('otp')
    session_otp = session.get('otp')

    if entered_otp == session_otp:
        session.pop('otp', None)  # Remove OTP after successful verification
        return jsonify({"success": True, "message": "OTP verified"})
    else:
        return jsonify({"success": False, "message": "Invalid OTP"})

@app.route('/change_password', methods=['GET', 'POST'])
def change_password():
    if request.method == 'POST':
        new_password = request.form['new_password'].strip()
        confirm_password = request.form['confirm_password'].strip()

        # Check if user is logged in
        username = session.get('username')  # Assuming username is stored in session
        
        if username:
            # Check if the new password meets the minimum length requirement
            if len(new_password) < 8:
                flash("Password must be at least 8 characters long.")
                return redirect(url_for('change_password'))

            # Check if the new password matches the confirmation
            if new_password == confirm_password:
                # Hash the new password
                hashed_password = generate_password_hash(new_password)

                # Update the password in the database
                conn = get_db_connection()
                cursor = conn.cursor()
                cursor.execute("UPDATE user_info SET Password = %s WHERE Username = %s", (hashed_password, username))
                conn.commit()
                conn.close()

                flash("Password has been changed successfully!")  # Set the flash message
                return redirect(url_for('change_password'))  # Redirect to reload the page
            else:
                flash("New passwords do not match.")
        else:
            flash("You need to be logged in to change your password.")

    return render_template('buyerProfile.html')  # Adjust to the appropriate template for changing password

# Function to send OTP email for password handling (change password and forgot password)
def send_password_otp_email(recipient, otp):
    msg = Message("Password Change Verification", sender="joracion42@gmail.com", recipients=[recipient])
    msg.body = f"""Hello {recipient},

You requested a password change or forgot password verification.

Your OTP code for verification is: {otp}
Please enter this code to complete your password change process.

Thank you for your attention!

Best regards,
Glamour Gaze Team
"""
    
    try:
        print("Preparing to send password verification email...")
        mail.send(msg)
        print("Password verification email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")
        flash("There was an error sending the email.")

# Function to send OTP email using Flask-Mail
def send_otp_email(recipient, otp):
    msg = Message("Welcome! Verify Your Email", sender="joracion42@gmail.com", recipients=[recipient])
    msg.body = f"""Hello {recipient},

Thank you for registering! 

Your OTP code for verification is: {otp}. 
Please enter this code to complete your registration process.

Thank you for joining us!

Best regards,
Glamour Gaze Team
"""
    
    try:
        print("Preparing to send email...")
        mail.send(msg)
        print("Email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {e}")
        flash("There was an error sending the email.")

@app.route('/add_product', methods=['GET'])
def add_product():
    # Fetch users from the database
    conn = get_db_connection()
    cursor = conn.cursor()

    # Only select the necessary fields
    cursor.execute("SELECT fullname, email, password, role FROM users")
    users = cursor.fetchall()

    print(users)  

    cursor.close()
    conn.close()

    return render_template('add_product.html', users=users) 

@app.route('/my-orders')
def my_orders():
    if 'seller_id' not in session:
        return "Seller not logged in", 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # Fetch ALL orders for this seller, "To Pay" first
    query = """
        SELECT id, username, product_image, productName, quantity, total, payment_method, status 
        FROM orders
        WHERE seller_id = %s
        ORDER BY 
            CASE 
                WHEN status = 'To Pay' THEN 0
                WHEN status = 'To Ship' THEN 1
                WHEN status = 'Waiting for Courier' THEN 2
                WHEN status = 'To Receive' THEN 3
                WHEN status = 'Completed' THEN 4
                WHEN status = 'Cancelled' THEN 5
                ELSE 6
            END,
            id DESC
    """
    cursor.execute(query, (seller_id,))
    orders = cursor.fetchall()
    cursor.close()
    conn.close()
    
    return render_template('seller_homepage.html', orders=orders, active_tab='my-orders')

@app.route('/request-cancel-order', methods=['POST'])
def request_cancel_order():
    data = request.get_json()
    order_id = data.get('order_id')
    cancel_reason = data.get('cancel_reason')

    if not order_id or not cancel_reason:
        return jsonify({"message": "Order ID and cancellation reason are required!"}), 400

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Update order status and store the cancellation reason
        update_query = """
            UPDATE orders 
            SET status = 'Cancelled', cancel_reason = %s 
            WHERE id = %s
        """
        cursor.execute(update_query, (cancel_reason, order_id))
        conn.commit()

        # Fetch order details for the notification
        order_details_query = """
            SELECT user_id, seller_id, productName, product_image 
            FROM orders 
            WHERE id = %s
        """
        cursor.execute(order_details_query, (order_id,))
        order_details = cursor.fetchone()

        if not order_details:
            return jsonify({"message": "Order not found."}), 404

        user_id, seller_id, product_name, product_image = order_details

        # Add a notification to the notifications table
        notification_query = """
            INSERT INTO notifications (user_id, seller_id, order_id, product_name, product_image, message, created_at) 
            VALUES (%s, %s, %s, %s, %s, %s, NOW())
        """
        message = f"Your order {order_id} has been cancelled. Reason: {cancel_reason}"
        cursor.execute(
            notification_query, 
            (user_id, seller_id, order_id, product_name, product_image, message)
        )
        conn.commit()

        return jsonify({"message": "Order successfully cancelled!"}), 200

    except Exception as e:
        conn.rollback()
        print(f"Error: {e}")  # Log the error for debugging
        return jsonify({"message": "Error cancelling the order. Please try again later."}), 500

    finally:
        cursor.close()
        conn.close()







# Set up logging
logging.basicConfig(level=logging.INFO)

# Function to update order statuses
def update_order_status():
    while True:
        try:
            # Wait for 1 minute before updating "To Ship" to "To Receive"
            time.sleep(120)  # 1 minute

            # Connect to the database
            conn = get_db_connection()
            cursor = conn.cursor()

            # Update orders from "To Ship" to "To Receive"
            update_to_receive_query = """
                UPDATE orders 
                SET status = 'To Receive', updated_at = NOW()
                WHERE status = 'To Ship';
            """
            cursor.execute(update_to_receive_query)

            # Get only recently updated orders
            select_updated_orders_query = """
                SELECT o.id, o.user_id, o.seller_id, o.productName, o.product_image 
                FROM orders o
                WHERE o.status = 'To Receive' AND o.updated_at >= NOW() - INTERVAL 1 MINUTE;
            """
            cursor.execute(select_updated_orders_query)
            updated_order_details = cursor.fetchall()

            if updated_order_details:
                # Insert notification for each updated order
                for order in updated_order_details:
                    order_id, user_id, seller_id, product_name, product_image = order

                    # Notification message
                    notification_message = f"Order #{order_id} for '{product_name}' has been successfully delivered! Please confirm receipt to complete the process."

                    # Check if notification already exists
                    check_notification_query = """
                        SELECT COUNT(*) FROM notifications 
                        WHERE order_id = %s AND message = %s
                    """
                    cursor.execute(check_notification_query, (order_id, notification_message))
                    notification_exists = cursor.fetchone()[0]

                    if not notification_exists:
                        insert_notification_query = """
                            INSERT INTO notifications (order_id, user_id, seller_id, product_name, product_image, message, created_at) 
                            VALUES (%s, %s, %s, %s, %s, %s, NOW())
                        """
                        cursor.execute(insert_notification_query, (order_id, user_id, seller_id, product_name, product_image, notification_message))

                # Commit changes after inserting notifications
                conn.commit()
                logging.info("Successfully inserted notifications for updated orders.")

            else:
                logging.info("No orders updated.")

            # Close connection
            cursor.close()
            conn.close()

        except Exception as e:
            logging.error(f"Error occurred while updating order statuses: {e}")
            time.sleep(10)  # Sleep for 10 seconds before retrying in case of error

# Start the background thread for status updates
status_update_thread = threading.Thread(target=update_order_status)
status_update_thread.daemon = True  # Ensures thread will exit when the main program exits
status_update_thread.start()




@app.route('/ship_order', methods=['POST'])
def ship_order():
    if 'seller_id' not in session:
        return "Seller not logged in", 401

    seller_id = session['seller_id']
    data = request.json
    order_id = data.get('id')

    if not order_id:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id FROM orders WHERE status = 'To Pay' AND seller_id = %s LIMIT 1", (seller_id,))
        result = cursor.fetchone()
        if result:
            order_id = result[0]
        else:
            return jsonify({'success': False, 'message': 'No orders available to update.'}), 404
        cursor.close()
        conn.close()

    try:
        order_id = int(order_id)
    except ValueError:
        return jsonify({'success': False, 'message': 'Invalid Order ID.'}), 400

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Retrieve order details
        cursor.execute("""
            SELECT product_id, quantity, user_id, ProductPrice, first_name, middle_name, last_name
            FROM orders WHERE id=%s AND seller_id=%s
        """, (order_id, seller_id))
        order_data = cursor.fetchone()

        if not order_data:
            return jsonify({'success': False, 'message': 'Order not found or not authorized.'}), 404

        product_id, order_quantity, buyer_id, ProductPrice, buyer_first, buyer_middle, buyer_last = order_data

        # Get product details (product name and image)
        cursor.execute("SELECT product_name, product_image, business_name FROM seller_add_product WHERE id=%s AND seller_id=%s", (product_id, seller_id))
        product_data = cursor.fetchone()
        if not product_data:
            return jsonify({'success': False, 'message': 'Product not found.'}), 404
        product_name, product_image, business_name = product_data

        # Validate stock
        cursor.execute("SELECT stock_quantity FROM seller_add_product WHERE id=%s AND seller_id=%s", (product_id, seller_id))
        stock_data = cursor.fetchone()
        if stock_data and stock_data[0] < order_quantity:
            return jsonify({'success': False, 'message': 'Not enough stock to fulfill this order.'}), 400

        # Update the order status to 'Waiting for Courier' if it is 'To Pay'
        cursor.execute("UPDATE orders SET status='Waiting for Courier' WHERE id=%s AND status='To Pay' AND seller_id=%s", (order_id, seller_id))
        if cursor.rowcount == 0:
            return jsonify({'success': False, 'message': 'No orders were updated. Check if the ID exists or if the order is not \"To Pay\".'}), 404

        # Deduct the quantity from seller's stock
        cursor.execute("UPDATE seller_add_product SET stock_quantity = stock_quantity - %s WHERE id=%s AND seller_id=%s", (order_quantity, product_id, seller_id))
        if cursor.rowcount == 0:
            return jsonify({'success': False, 'message': 'Failed to update stock quantity. Product not found or insufficient stock.'}), 404

        # Send a notification to the buyer
        notification_message = f"Your order is waiting for a courier to accept the delivery."
        notification_image = url_for('static', filename='upload_images/' + product_image)
        cursor.execute("""
            INSERT INTO notifications (user_id, order_id, message, product_name, product_image, seller_id, status)
            VALUES (%s, %s, %s, %s, %s, %s, 'unread')
        """, (buyer_id, order_id, notification_message, product_name, notification_image, seller_id))

        # --- GET SELLER'S NAME AND PICKUP LOCATION ---
        cursor.execute("""
            SELECT first_name, middle_name, last_name, barangay, municipality, province
            FROM user_info
            WHERE id=%s AND Roles='seller'
        """, (seller_id,))
        seller_info = cursor.fetchone()
        if seller_info:
            seller_first, seller_middle, seller_last, seller_barangay, seller_municipality, seller_province = seller_info
            seller_name = f"{seller_first} {seller_middle.strip() + ' ' if seller_middle and seller_middle.strip() else ''}{seller_last}".strip()
            pickup_location = f"{seller_barangay}, {seller_municipality}, {seller_province}"
        else:
            seller_name = "Unknown"
            pickup_location = "Unknown"

        # --- GET BUYER'S NAME AND DELIVERY LOCATION ---
        cursor.execute("""
            SELECT first_name, middle_name, last_name, barangay, municipality, province
            FROM user_info
            WHERE id=%s AND Roles='buyer'
        """, (buyer_id,))
        buyer_info = cursor.fetchone()
        if buyer_info:
            buyer_first, buyer_middle, buyer_last, buyer_barangay, buyer_municipality, buyer_province = buyer_info
            buyer_name = f"{buyer_first} {buyer_middle.strip() + ' ' if buyer_middle and buyer_middle.strip() else ''}{buyer_last}".strip()
            delivery_location = f"{buyer_barangay}, {buyer_municipality}, {buyer_province}"
        else:
            buyer_name = "Unknown"
            delivery_location = "Unknown"

        # --- DO NOT ASSIGN COURIER YET ---
        delivery_courier_id = None

        # --- INSERT INTO DELIVERY TABLE ---
        cursor.execute("""
            INSERT INTO delivery (
                order_id, seller_id, seller_name, buyer_id, buyer_name,
                pickup_location, delivery_location, delivery_fee, delivery_courier_id, delivered_at
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, NULL)
        """, (
            order_id, seller_id, seller_name, buyer_id, buyer_name,
            pickup_location, delivery_location, 50.00, delivery_courier_id
        ))

        conn.commit()

    except Exception as e:
        print(f"Error while updating the order: {str(e)}")
        conn.rollback()
        return jsonify({'success': False, 'message': f'An error occurred while updating the order: {str(e)}'}), 500

    finally:
        cursor.close()
        conn.close()

    return jsonify({'success': True, 'message': 'Order status updated to Waiting for Courier, stock quantity adjusted, delivery created, and notification sent.'})

#eto yung pag display ng  to ship ang status  sa my orders tab ni seller
@app.route('/to-ship-orders')
def to_ship_orders():
    if 'seller_id' not in session:
        return "Seller not logged in", 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
        SELECT id, username, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status IN ('To Pay', 'To Ship', 'Waiting for Courier') AND seller_id = %s
    """
    cursor.execute(query, (seller_id,))
    to_ship_orders = cursor.fetchall()

    cursor.close()
    conn.close()
    
    return jsonify({'to_ship_orders': to_ship_orders})

@app.route('/to-receive-orders')
def to_receive_orders():
    if 'seller_id' not in session:
        return "Seller not logged in", 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT id, username, product_image, productName, quantity, total, payment_method, status 
        FROM orders
        WHERE status = 'To Receive' AND seller_id = %s
    """
    cursor.execute(query, (seller_id,))
    to_receive_orders = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify({'to_receive_orders': to_receive_orders})


@app.route('/completed-orders')
def completed_orders():
    if 'seller_id' not in session:
        return "Seller not logged in", 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
        SELECT id, username, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'Completed' AND seller_id = %s
    """
    cursor.execute(query, (seller_id,))
    completed_orders = cursor.fetchall()

    cursor.close()
    conn.close()
    
    return jsonify({'completed_orders': completed_orders})

@app.route('/cancelled-orders')
def cancelled_orders():
    if 'seller_id' not in session:
        return "Seller not logged in", 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    query = """
        SELECT id, username, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'Cancelled' AND seller_id = %s
    """
    cursor.execute(query, (seller_id,))
    cancelled_orders = cursor.fetchall()

    cursor.close()
    conn.close()
    
    return jsonify({'cancelled_orders': cancelled_orders})

@app.route('/seller-refund-orders')
def seller_refund_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in seller's ID from the session
    seller_id = session.get('user_id')  # Assuming you store seller ID in the session

    # Ensure seller_id is available
    if seller_id is None:
        return jsonify({'error': 'Seller not logged in.'}), 403

    # Query to fetch refund orders where the seller is involved
    query = """
        SELECT o.id, o.business_name, o.product_image, o.productName, o.quantity, o.total, o.payment_method, o.status
        FROM orders o
        WHERE o.status IN ('Refund', 'Refund Request') AND o.seller_id = %s
    """
    cursor.execute(query, (seller_id,))
    refund_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'refund_orders': refund_orders})


@app.route('/accept-refund/<int:order_id>', methods=['POST'])
def accept_refund(order_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Query to update the status of the order to "Refund"
    query = """
        UPDATE orders
        SET status = 'Refund'
        WHERE id = %s AND status = 'Refund Request'
    """
    cursor.execute(query, (order_id,))

    # Fetch the order details for notification
    order_details_query = """
        SELECT o.user_id, o.seller_id, o.productName, o.product_image
        FROM orders o
        WHERE o.id = %s
    """
    cursor.execute(order_details_query, (order_id,))
    order_details = cursor.fetchone()

    if order_details:
        user_id, seller_id, product_name, product_image = order_details

        # Insert a notification for the seller
        notification_message = f"The refund request for Order #{order_id} of '{product_name}' has been accepted."
        insert_notification_query = """
            INSERT INTO notifications (order_id, user_id, seller_id, product_name, product_image, message, recipient_type, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, NOW())
        """
        cursor.execute(insert_notification_query, 
                       (order_id, user_id, seller_id, product_name, product_image, notification_message, 'seller'))

        # Insert a notification for the buyer (optional)
        notification_message_buyer = f"Your refund request for Order #{order_id} of '{product_name}' has been accepted."
        insert_notification_buyer_query = """
            INSERT INTO notifications (order_id, user_id, seller_id, product_name, product_image, message, recipient_type, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, NOW())
        """
        cursor.execute(insert_notification_buyer_query, 
                       (order_id, user_id, seller_id, product_name, product_image, notification_message_buyer, 'buyer'))

    # Commit the changes to the database
    conn.commit()

    # Close the connection
    cursor.close()
    conn.close()

    # Return a success response
    return jsonify({'success': True})


@app.route('/refund-reason/<int:order_id>', methods=['GET'])
def get_refund_reason(order_id):
    # Ensure the seller is logged in
    if 'seller_id' not in session:
        return jsonify({'success': False, 'message': 'Unauthorized access'}), 401

    seller_id = session['seller_id']  # Get the logged-in seller's ID

    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT refund_reason, refund_image_1, refund_image_2, refund_image_3, refund_image_4
        FROM orders
        WHERE id = %s AND seller_id = %s
    """
    cursor.execute(query, (order_id, seller_id))
    result = cursor.fetchone()

    cursor.close()
    conn.close()

    if result:
        refund_reason, *images = result
        return jsonify({
            'success': True,
            'reason': refund_reason,
            'images': [image for image in images if image]  # Filter out None values
        })
    else:
        return jsonify({'success': False, 'message': 'Order not found or not accessible'}), 4



#eto yung paglabas ng notification kay buyer pag click
@app.route('/fetch_notifications', methods=['GET'])
def fetch_notifications():
    if 'user_id' not in session:
        return jsonify({'success': False, 'message': 'User not logged in'}), 401

    user_id = session['user_id']
    user_type = session.get('user_type', 'buyer')  # Assuming you store user type in session

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch the notifications specifically for the logged-in user based on their type
        cursor.execute("""
            SELECT id, message, product_name, product_image, created_at, status
            FROM notifications
            WHERE user_id = %s AND recipient_type = %s
            ORDER BY created_at DESC
        """, (user_id, user_type))

        notifications = cursor.fetchall()

        # If there are no notifications
        if not notifications:
            return jsonify({'success': True, 'message': 'No notifications available.'}), 404

        # Format notifications as a list of dictionaries
        formatted_notifications = []
        for notification in notifications:
            formatted_notifications.append({
                'id': notification[0],
                'message': notification[1],
                'product_name': notification[2],
                'product_image': notification[3],
                'created_at': notification[4].strftime('%Y-%m-%d %H:%M:%S') if notification[4] else '',
                'status': notification[5]
            })

        return jsonify({'success': True, 'notifications': formatted_notifications})

    except Exception as e:
        print(f"Error fetching notifications: {str(e)}")
        return jsonify({'success': False, 'message': f'Error fetching notifications: {str(e)}'}), 500

    finally:
        cursor.close()
        conn.close()


#pag update kung na read na ba yung notif
@app.route('/mark_notifications_read', methods=['POST'])
def mark_notifications_read():
    if 'user_id' not in session:
        return jsonify({'success': False, 'message': 'User not logged in'}), 401

    user_id = session['user_id']
    user_type = session.get('user_type', 'buyer')  # Assuming user type is stored in session

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Mark all unread notifications as read for the current user
        cursor.execute("""
            UPDATE notifications
            SET status = 'read'
            WHERE user_id = %s AND recipient_type = %s AND status = 'unread'
        """, (user_id, user_type))
        conn.commit()

        # Fetch the updated unread notification count
        cursor.execute("""
            SELECT COUNT(*) FROM notifications
            WHERE user_id = %s AND recipient_type = %s AND status = 'unread'
        """, (user_id, user_type))
        unread_count = cursor.fetchone()[0]

        return jsonify({'success': True, 'message': 'Notifications marked as read', 'unread_count': unread_count})

    except Exception as e:
        print(f"Error marking notifications as read: {str(e)}")
        return jsonify({'success': False, 'message': 'An error occurred while marking notifications as read'}), 500

    finally:
        cursor.close()
        conn.close()



@app.route('/fetch_unread_notification_count', methods=['GET'])
def fetch_unread_notification_count():
    if 'user_id' not in session:
        return jsonify({'success': False, 'message': 'User not logged in'}), 401

    user_id = session['user_id']
    user_type = session.get('user_type', 'buyer')  # Assuming you store user type in session ('buyer' or 'seller')
    
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch the count of unread notifications for the logged-in user based on their type (buyer/seller)
        cursor.execute("""
            SELECT COUNT(*) FROM notifications
            WHERE user_id = %s AND recipient_type = %s AND status = 'unread'
        """, (user_id, user_type))
        unread_count = cursor.fetchone()[0]  # Getting the count of unread notifications

        return jsonify({'success': True, 'unread_count': unread_count})

    except Exception as e:
        print(f"Error fetching unread notification count: {e}")
        return jsonify({'success': False, 'message': 'An error occurred while fetching unread notifications'}), 500

    finally:
        cursor.close()
        conn.close()



@app.route('/fetch_seller_notifications', methods=['GET'])
def fetch_seller_notifications():
    if 'seller_id' not in session:
        return jsonify({'success': False, 'message': 'Seller not logged in'}), 401

    seller_id = session['seller_id']  # Use seller_id from the session
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch notifications for sellers only
        cursor.execute("""
            SELECT id, message, product_name, product_image, created_at, status
            FROM notifications
            WHERE seller_id = %s AND recipient_type = 'seller'  -- Filter by recipient type
            ORDER BY created_at DESC
        """, (seller_id,))

        notifications = cursor.fetchall()

        if not notifications:
            return jsonify({'success': True, 'message': 'No notifications available.'}), 404

        formatted_notifications = []
        for notification in notifications:
            formatted_notifications.append({
                'id': notification[0],
                'message': notification[1],
                'product_name': notification[2],
                'product_image': notification[3],
                'created_at': notification[4].strftime('%Y-%m-%d %H:%M:%S') if notification[4] else '',
                'status': notification[5]
            })

        return jsonify({'success': True, 'notifications': formatted_notifications})

    except Exception as e:
        print(f"Error fetching seller notifications: {str(e)}")
        return jsonify({'success': False, 'message': f'Error fetching notifications: {str(e)}'}), 500

    finally:
        cursor.close()
        conn.close()


@app.route('/mark_seller_notifications_read', methods=['POST'])
def mark_seller_notifications_read():
    if 'seller_id' not in session:
        return jsonify({'success': False, 'message': 'Seller not logged in'}), 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("""
            UPDATE notifications
            SET status = 'read'
            WHERE seller_id = %s AND recipient_type = 'seller' AND status = 'unread'  -- Filter by recipient type
        """, (seller_id,))
        conn.commit()

        # Get unread count for the seller
        cursor.execute("""
            SELECT COUNT(*) FROM notifications
            WHERE seller_id = %s AND recipient_type = 'seller' AND status = 'unread'  -- Filter by recipient type
        """, (seller_id,))
        unread_count = cursor.fetchone()[0]

        return jsonify({'success': True, 'message': 'Notifications marked as read', 'unread_count': unread_count})

    except Exception as e:
        print(f"Error marking seller notifications as read: {str(e)}")
        return jsonify({'success': False, 'message': 'An error occurred while marking notifications as read'}), 500

    finally:
        cursor.close()
        conn.close()

@app.route('/fetch_seller_unread_notification_count', methods=['GET'])
def fetch_seller_unread_notification_count():
    if 'seller_id' not in session:
        return jsonify({'success': False, 'message': 'Seller not logged in'}), 401

    seller_id = session['seller_id']
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("""
            SELECT COUNT(*) FROM notifications
            WHERE seller_id = %s AND recipient_type = 'seller' AND status = 'unread'  -- Filter by recipient type
        """, (seller_id,))
        unread_count = cursor.fetchone()[0]

        return jsonify({'success': True, 'unread_count': unread_count})

    except Exception as e:
        print(f"Error fetching seller unread notification count: {e}")
        return jsonify({'success': False, 'message': 'An error occurred while fetching unread notifications'}), 500

    finally:
        cursor.close()
        conn.close()







#FOR ADDING PRODUCTS IN SELLER
@app.route('/add_products', methods=['GET', 'POST'])
def add_products():
    if request.method == 'POST':
        if 'productImage' not in request.files:
            flash('No main image part', 'error')
            return redirect(url_for('add_products', active_tab='add-new-product'))

        main_image = request.files['productImage']
        if main_image.filename == '':
            flash('No main image selected', 'error')
            return redirect(url_for('add_products', active_tab='add-new-product'))

        # Handle sub-images
        sub_image_1 = request.files.get('subImage1')
        sub_image_2 = request.files.get('subImage2')
        sub_image_3 = request.files.get('subImage3')

        main_filename = None
        if main_image and allowed_file(main_image.filename):
            main_filename = secure_filename(main_image.filename)
            main_image.save(os.path.join(app.config['UPLOAD_FOLDER'], main_filename))
        
        sub_images_filenames = []
        for sub_image in [sub_image_1, sub_image_2, sub_image_3]:
            if sub_image and allowed_file(sub_image.filename):
                sub_image_filename = secure_filename(sub_image.filename)
                sub_image.save(os.path.join(app.config['UPLOAD_FOLDER'], sub_image_filename))
                sub_images_filenames.append(sub_image_filename)
            else:
                sub_images_filenames.append(None)

        # Retrieve product details
        product_name = request.form['productName']
        category = request.form['category']
        mini_description = request.form['miniDescription']
        main_description = request.form['mainDescription']
        price = request.form['price']
        stock_quantity = request.form['stockQuantity']
        seller_id = session.get('seller_id')

        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("SELECT business_name FROM user_info WHERE id = %s", (seller_id,))
            business_name_row = cursor.fetchone()
            business_name = business_name_row[0] if business_name_row else None

            sql = """
                INSERT INTO seller_add_product (
                    product_image, sub_image_1, sub_image_2, sub_image_3, 
                    product_name, category, mini_description, main_description, price, stock_quantity,
                    seller_id, business_name, product_status
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                main_filename,
                sub_images_filenames[0],
                sub_images_filenames[1],
                sub_images_filenames[2],
                product_name, category, mini_description, main_description, price, stock_quantity,
                seller_id, business_name, 'listed'
            )
            cursor.execute(sql, values)
            conn.commit()
            flash('Product added successfully!', 'success')
        except Exception as e:
            flash(f'Error adding product: {e}', 'error')
        finally:
            cursor.close()
            conn.close()

        # Redirect to seller_homepage with the My Products tab active
        return redirect(url_for('seller_homepage', active_tab='my-products'))

    # For GET, show the add product form
    return render_template('seller_homepage.html', active_tab='add-new-product')




#FOR EDIT PRODUCT
@app.route('/edit_product/<int:product_id>', methods=['GET', 'POST'])
def edit_product(product_id):
    # Check if the user is logged in and is a seller
    if 'user_id' not in session or session['role'] != 'seller':
        flash('Please log in as a seller to edit products.', 'error')
        return redirect(url_for('login'))

    # Establish database connection
    conn = get_db_connection()
    cursor = conn.cursor()

    # Verify product ownership based on seller_id from user_info
    cursor.execute("""
        SELECT p.id, p.product_name, p.category, p.mini_description, 
               p.main_description, p.price, p.stock_quantity, 
               p.product_image, p.sub_image_1, p.sub_image_2, p.sub_image_3 
        FROM seller_add_product p
        JOIN user_info u ON p.seller_id = u.ID
        WHERE p.id = %s AND p.seller_id = %s
    """, (product_id, session['user_id']))
    product = cursor.fetchone()

    if product is None:
        flash('Product not found or you do not have permission to edit this product.', 'error')
        return redirect(url_for('my_products'))

    # If the request is POST, handle the update
    if request.method == 'POST':
        # Retrieve product details (no image upload)
        product_name = request.form['product_name']
        category = request.form['category']
        mini_description = request.form['mini_description']
        main_description = request.form['main_description']
        price = request.form['price']
        stock_quantity = request.form['stock_quantity']

        # Prepare SQL statement for product update (no image fields)
        sql = """
        UPDATE seller_add_product 
        SET product_name = %s, category = %s, mini_description = %s, 
            main_description = %s, price = %s, stock_quantity = %s
        WHERE id = %s
        """

        values = (product_name, category, mini_description, 
                  main_description, price, stock_quantity, product_id)

        try:
            # Update the product in seller_add_product
            cursor.execute(sql, values)

            # Now update the wishlist table for all users who have this product
            wishlist_update_sql = """
            UPDATE wishlist 
            SET product_name = %s, product_price = %s
            WHERE product_id = %s
            """
            cursor.execute(wishlist_update_sql, (product_name, price, product_id))

            # Now update the carts table for all users who have this product in their cart
            carts_update_sql = """
            UPDATE carts 
            SET product_name = %s, price = %s
            WHERE product_id = %s
            """
            cursor.execute(carts_update_sql, (product_name, price, product_id))

            # Commit changes to database
            conn.commit()
            flash('Product updated successfully!', 'success')

        except Exception as e:
            flash(f'Error: {e}', 'error')
            print(f'Error during update: {e}')  # Log the error for debugging
        finally:
            cursor.close()
            conn.close()
            return redirect(url_for('my_products'))

    # Close the cursor and connection after fetching data
    cursor.close()
    conn.close()

    # Render the edit form template with the product data
    return render_template('seller_homepage.html', product=product)

@app.route('/edit_product_modal/<int:product_id>', methods=['POST'])
def edit_product_modal(product_id):
    if 'user_id' not in session or session['role'] != 'seller':
        return jsonify({'success': False, 'message': 'Unauthorized'}), 401

    data = request.get_json()
    product_name = data.get('product_name')
    category = data.get('category')
    mini_description = data.get('mini_description')
    main_description = data.get('main_description')
    price = data.get('price')
    stock_quantity = data.get('stock_quantity')

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Update the product
        sql = """
        UPDATE seller_add_product 
        SET product_name = %s, category = %s, mini_description = %s, 
            main_description = %s, price = %s, stock_quantity = %s
        WHERE id = %s AND seller_id = %s
        """
        cursor.execute(sql, (
            product_name, category, mini_description, main_description, price, stock_quantity, product_id, session['user_id']
        ))

        # Update wishlist and carts
        cursor.execute("""
            UPDATE wishlist SET product_name = %s, product_price = %s WHERE product_id = %s
        """, (product_name, price, product_id))
        cursor.execute("""
            UPDATE carts SET product_name = %s, price = %s WHERE product_id = %s
        """, (product_name, price, product_id))

        conn.commit()
        return jsonify({'success': True, 'message': 'Product updated successfully!'})
    except Exception as e:
        conn.rollback()
        return jsonify({'success': False, 'message': f'Error: {e}'})
    finally:
        cursor.close()
        conn.close()

@app.route('/my_products', methods=['GET', 'POST'])
def my_products():
    seller_id = session.get('seller_id')

    if not seller_id:
        flash("Please log in to access this page.")
        return redirect(url_for('login'))

    search_query = request.args.get('search_query', '').lower()
    selected_category = request.args.get('selected_category', 'all').lower()

    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Construct base query for listed products
        query = "SELECT * FROM seller_add_product WHERE seller_id = %s AND product_status = 'listed'"
        params = [seller_id]

        # Add filtering by search query (if provided)
        if search_query:
            query += " AND LOWER(product_name) LIKE %s"
            params.append(f"%{search_query}%")
        
        # Add filtering by category (if provided and not 'all')
        if selected_category != 'all':
            query += " AND LOWER(category) = %s"
            params.append(selected_category)

        # Execute query for listed products
        cursor.execute(query, tuple(params))
        listed_products = cursor.fetchall()

        # Unlisted products (same filtering logic)
        query = "SELECT * FROM seller_unlisted_products WHERE seller_id = %s"
        params = [seller_id]
        
        if search_query:
            query += " AND LOWER(product_name) LIKE %s"
            params.append(f"%{search_query}%")
        
        if selected_category != 'all':
            query += " AND LOWER(category) = %s"
            params.append(selected_category)

        cursor.execute(query, tuple(params))
        unlisted_products = cursor.fetchall()

    except Exception as e:
        flash(f"An error occurred: {e}", 'error')
        listed_products = []
        unlisted_products = []
    finally:
        cursor.close()
        conn.close()

    return render_template('seller_homepage.html',
                           listed_products=listed_products,
                           unlisted_products=unlisted_products,
                           search_query=search_query,
                           selected_category=selected_category,
                           active_tab='my-products')

# Route to unlist a product
@app.route('/unlist_product/<int:product_id>', methods=['POST'])
def unlist_product(product_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Fetch the product details from seller_add_product
        cursor.execute("SELECT * FROM seller_add_product WHERE id = %s", (product_id,))
        product = cursor.fetchone()

        if product:
            # Insert the product into seller_unlisted_products
            cursor.execute("""
                INSERT INTO seller_unlisted_products (
                    id, product_name, category, mini_description, main_description, price, stock_quantity, 
                    product_image, sub_image_1, sub_image_2, sub_image_3, seller_id, product_status, business_name
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                product[0], product[1], product[2], product[3], product[4], product[5], product[6],
                product[7], product[8], product[9], product[10], session['seller_id'], 'unlisted', product[13]
            ))

            # Delete the product from seller_add_product
            cursor.execute("DELETE FROM seller_add_product WHERE id = %s", (product_id,))
            conn.commit()

            flash('Product unlisted successfully!', 'success')
        else:
            flash('Product not found!', 'error')
    except Exception as e:
        flash(f'Error unlisting product: {e}', 'error')
    finally:
        cursor.close()
        conn.close()

    return redirect(url_for('my_products'))


@app.route('/move_back_to_listed/<int:product_id>', methods=['POST'])
def move_back_to_listed(product_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    seller_id = session.get('user_id')
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT id, product_name, category, mini_description, main_description, price, stock_quantity, 
                   product_image, sub_image_1, sub_image_2, sub_image_3, seller_id, product_status, business_name 
            FROM seller_unlisted_products 
            WHERE id = %s AND seller_id = %s
        """, (product_id, seller_id))
        product = cursor.fetchone()

        if product:
            # Set product_status explicitly to 'listed'
            listed_product = list(product)
            listed_product[12] = 'listed'  # Assuming index 12 is `product_status`

            cursor.execute("""
                INSERT INTO seller_add_product 
                (id, product_name, category, mini_description, main_description, price, stock_quantity, 
                 product_image, sub_image_1, sub_image_2, sub_image_3, seller_id, product_status, business_name)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, tuple(listed_product))

            cursor.execute("DELETE FROM seller_unlisted_products WHERE id = %s AND seller_id = %s", (product_id, seller_id))
            conn.commit()

            flash('Product successfully moved back to listed products!', 'success')
        else:
            flash('Product not found in unlisted products', 'error')

    conn.close()
    return redirect(url_for('seller_homepage'))


@app.route('/delete_product/<int:product_id>', methods=['POST'])
def delete_product(product_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        # Delete the product or update the is_deleted flag as needed
        cursor.execute("DELETE FROM seller_unlisted_products WHERE id = %s", (product_id,))
        conn.commit()  # Commit the changes to the database
        flash('Product deleted successfully!', 'success')
    except Exception as e:
        flash(f"An error occurred while deleting the product: {e}", 'error')
    finally:
        cursor.close()
        conn.close()
    
    return redirect(url_for('seller_homepage', active_tab='my-products'))  # Pass active tab here

#MY PRODUCTS TAB IN SELLER END


#FILTERING WHAT YHE CATEGORY OF A PRODUCT
def fetch_products_from_database(category):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        sql = "SELECT * FROM seller_add_product WHERE LOWER(category) = LOWER(%s)"
        print(f"Fetching products for category: {category}")  # Debugging line
        cursor.execute(sql, (category,))
        products = cursor.fetchall()
        print(f"Fetched products for {category}: {products}")  # Debugging line
        return products

    except mysql.connector.Error as err:
        print(f"Error fetching products: {err}")
        return []
    finally:
        cursor.close()
        conn.close()

#ETO YUNG PAG CLINICK YUNG CARD MAPUPUNTA SA PRODUCT PAGE
def get_product_by_id(product_id):
    connection = None
    cursor = None  
    try:
        connection = get_db_connection() 
        cursor = connection.cursor()
        
        cursor.execute('SELECT * FROM seller_add_product WHERE id = %s', (product_id,))
        product = cursor.fetchone() 
        
        return product
    except Exception as e:
        print(f"Error fetching product: {e}") 
        return None
    finally:
        if cursor:
            cursor.close()  # Close cursor if it was opened
        if connection:
            connection.close()  # Close connection if it was opened



# Function to fetch reviews by product_id, including the reviewer's username from the feedback table
def get_reviews_by_product_id(product_id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)  # Use dictionary to get results as a dictionary
    
    # Select the relevant columns, including 'username' from the 'feedback' table
    query = "SELECT username, rating, message, image_1, image_2, image_3, image_4 FROM feedback WHERE product_id = %s"
    cursor.execute(query, (product_id,))
    reviews = cursor.fetchall()  # Fetch all the reviews for the product_id
    
    cursor.close()
    connection.close()
    
    return reviews


@app.route('/product/<int:product_id>')
def product_detail(product_id):
    # Fetch the product details using the provided ID
    product = get_product_by_id(product_id)  # Fetch the product details

    # Fetch the reviews for the specific product
    product_reviews = get_reviews_by_product_id(product_id)  # Fetch reviews for the product

    # Calculate total ratings and average rating
    total_rating = sum(review['rating'] for review in product_reviews) if product_reviews else 0
    average_rating = total_rating / len(product_reviews) if product_reviews else 0

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('productPage.html', 
                           product=product, 
                           product_reviews=product_reviews,  # Pass reviews to the template
                           user_is_logged_in=user_is_logged_in, 
                           username=username,
                           average_rating=average_rating,  # Pass average rating to the template
                           total_rating=total_rating)  # Pass total rating to the template




#PRODUCT PAGE END
@app.route('/skincare')
def skincare():
    products = fetch_products_from_database('Skincare Products')

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('skincare.html', products=products, user_is_logged_in=user_is_logged_in, username=username)

@app.route('/haircare')
def haircare():
    products = fetch_products_from_database('Haircare Solutions')

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('haircare.html', products=products, user_is_logged_in=user_is_logged_in, username=username)

@app.route('/makeup')
def makeup():
    products = fetch_products_from_database('Makeup & Cosmetics')

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('makeup.html', products=products, user_is_logged_in=user_is_logged_in, username=username)

@app.route('/personal_care')
def personal_care():
    products = fetch_products_from_database('Personal Care Appliances')

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('personalcare.html', products=products, user_is_logged_in=user_is_logged_in, username=username)

@app.route('/mens')
def mens():
    products = fetch_products_from_database("Men's Grooming")

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('mens.html', products=products, user_is_logged_in=user_is_logged_in, username=username)

@app.route('/health')
def health():
    products = fetch_products_from_database('Health Supplements')

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    return render_template('health.html', products=products, user_is_logged_in=user_is_logged_in, username=username)

#FOR ADD TO CART FUNCTION START
def get_product_by_id(product_id):
    connection = None
    cursor = None
    try:
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM seller_add_product WHERE id = %s', (product_id,))
        product = cursor.fetchone()
        return product
    except Exception as e:
        print(f"Error fetching product: {e}")
        return None
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/product/<int:product_id>')
def view_product(product_id):  # Renamed here
    product = get_product_by_id(product_id)
    if product is None:
        return "Product not found", 404
    return render_template('productPage.html', product=product)


#Function for add to cart button
@app.route('/add-to-cart/<int:product_id>', methods=['POST'])
def add_to_cart(product_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']
    quantity = int(request.form.get('quantity', 1))

    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        # Check if the cart has reached its limit
        cursor.execute("SELECT COUNT(*) FROM carts WHERE user_id = %s", (user_id,))
        cart_count = cursor.fetchone()[0]

        if cart_count >= 25:
            return jsonify({'status': 'error', 'message': 'Cart is full. You can only add up to 25 products.'}), 400

        # Retrieve product details, including stock_quantity
        cursor.execute(
            "SELECT product_name, product_image, price, business_name, seller_id, stock_quantity FROM seller_add_product WHERE id = %s",
            (product_id,)
        )
        product_details = cursor.fetchone()

        if not product_details:
            return jsonify({'status': 'error', 'message': 'Product not found.'}), 404

        product_name, product_image, product_price, business_name, seller_id, stock_quantity = product_details

        # Check if the product is already in the cart
        cursor.execute(
            "SELECT quantity FROM carts WHERE user_id = %s AND product_id = %s",
            (user_id, product_id)
        )
        cart_item = cursor.fetchone()

        # Calculate the total quantity if the product is already in the cart
        current_quantity = cart_item[0] if cart_item else 0
        total_quantity = current_quantity + quantity

        # Ensure total quantity does not exceed stock
        if total_quantity > stock_quantity:
            return jsonify({
                'status': 'error',
                'message': f'Stock is insufficient. You can add up to {stock_quantity - current_quantity} more units.'
            }), 400

        if cart_item:
            # If the item already exists, update the quantity
            cursor.execute(
                "UPDATE carts SET quantity = %s WHERE user_id = %s AND product_id = %s",
                (total_quantity, user_id, product_id)
            )
        else:
            # Add the new product entry to the cart
            cursor.execute(
                """
                INSERT INTO carts (user_id, product_id, quantity, product_name, product_image, price, business_name, seller_id) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (user_id, product_id, quantity, product_name, product_image, product_price, business_name, seller_id)
            )

        connection.commit()

    except Exception as e:
        connection.rollback()
        return jsonify({'status': 'error', 'message': 'An error occurred while adding the item to your cart.'}), 500

    finally:
        cursor.close()
        connection.close()

    return jsonify({'status': 'success', 'message': 'Item added to your cart successfully.'}), 200

@app.route('/cart')
def cart():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']
    
    connection = get_db_connection()
    cursor = connection.cursor()

    # Retrieve cart items, including product_id, seller_id, and other product details
    cursor.execute("""
        SELECT c.id, c.product_id, c.product_name, c.price, c.quantity, c.product_image, s.business_name, s.seller_id
        FROM carts c
        JOIN seller_add_product s ON c.product_id = s.id
        WHERE c.user_id = %s
    """, (user_id,))

    cart_items = cursor.fetchall()

    cursor.close()
    connection.close()

    print(cart_items)  # For debugging, remove later

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available
    
    return render_template('cart_page.html', cart_items=cart_items, user_is_logged_in=user_is_logged_in, username=username)

@app.route('/update_cart_quantity', methods=['POST'])
def update_cart_quantity():
    if 'user_id' not in session:
        return jsonify({'success': False, 'message': 'User not logged in'}), 401

    data = request.get_json()
    cart_item_id = data.get('cart_item_id')
    new_quantity = data.get('new_quantity')

    if not cart_item_id or not new_quantity:
        return jsonify({'success': False, 'message': 'Invalid data'}), 400

    user_id = session['user_id']

    # Update the cart quantity in the database
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        cursor.execute("""
            UPDATE carts
            SET quantity = %s
            WHERE id = %s AND user_id = %s
        """, (new_quantity, cart_item_id, user_id))

        connection.commit()

        cursor.close()
        connection.close()

        return jsonify({'success': True})

    except Exception as e:
        connection.rollback()
        cursor.close()
        connection.close()

        print(f"Error updating cart: {e}")
        return jsonify({'success': False, 'message': 'Database error'}), 500


@app.route('/get_stock_quantity/<int:cart_item_id>', methods=['GET'])
def get_stock_quantity(cart_item_id):
    # Fetch the product ID from the cart item
    connection = get_db_connection()
    cursor = connection.cursor()

    cursor.execute("""
        SELECT p.stock_quantity
        FROM seller_add_product p
        JOIN carts c ON c.product_id = p.id
        WHERE c.id = %s
    """, (cart_item_id,))

    stock_quantity = cursor.fetchone()

    cursor.close()
    connection.close()

    if stock_quantity:
        return jsonify({'stock_quantity': stock_quantity[0]})
    else:
        return jsonify({'error': 'Product not found'}), 404



@app.route('/api/cart/<int:item_id>', methods=['DELETE'])
def delete_cart_item(item_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Execute the DELETE SQL statement
        cursor.execute('DELETE FROM carts WHERE id = %s', (item_id,))
        conn.commit()  # Commit the changes

        # Check if any rows were affected
        if cursor.rowcount == 0:
            return jsonify({"error": "Item not found"}), 404
        
        return jsonify({"message": "Item deleted successfully"}), 200
    
    except mysql.connector.Error as err:
        print("Database error:", err)  # Log the specific error
        return jsonify({"error": f"An error occurred: {err}"}), 500

    finally:
        cursor.close()
        conn.close()  # Ensure the connection is closed

@app.route('/cart/count')
def cart_count():
    user_id = session.get('user_id')  # Ensure user is logged in

    if user_id is not None:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Query to count the number of different products in the cart for the user
        cursor.execute('SELECT COUNT(DISTINCT product_id) FROM carts WHERE user_id = %s', (user_id,))
        count_result = cursor.fetchone()  # Fetch the count

        conn.close()  # Close the connection

        # Extract the count (first item in count_result)
        total_products_in_cart = count_result[0] if count_result else 0

        return jsonify(count=total_products_in_cart)  # Return total count as JSON
    
    return jsonify(count=0)  # Return 0 if user is not logged in or no products in the cart

#FOR ADD TO CART FUNCTION END


# Function to get user info by user_id
def get_user_info(user_id):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT first_name, middle_name, last_name, Username, Phone_number, 
                   municipality, province, barangay
            FROM user_info 
            WHERE id = %s
        """, (user_id,))
        user_info = cursor.fetchone()  # Fetch the first matching record
    conn.close()
    return user_info


# Function to get business name by seller_id (which is an id from the same user_info table)
def get_business_name(seller_id):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT Business_name FROM user_info WHERE id = %s", (seller_id,))
        business_name = cursor.fetchone()  # Fetch the first matching record
    conn.close()
    return business_name[0] if business_name else "No Business Name Provided"

def get_product_id(seller_id, product_name):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        # Query to find the product_id (id) in seller_add_product table
        cursor.execute("""
            SELECT id 
            FROM seller_add_product 
            WHERE seller_id = %s AND product_name = %s
        """, (seller_id, product_name))
        product = cursor.fetchone()  # Fetch the first matching record
    conn.close()
    return product[0] if product else None





@app.route('/checkout', methods=['POST'])
def checkout():
    # Check if user is logged in
    if 'user_id' not in session:
        return redirect(url_for('login'))

    # Collect form data
    product_name = request.form.get('product_name')
    seller_id = request.form.get('seller_id')

    # Debug print to check the values
    print(f"Product Name: {product_name}, Seller ID: {seller_id}")

    # Check if product_name or seller_id are None or empty
    if not product_name or not seller_id:
        return "Product name or seller ID is missing", 400

    # Get product_id using seller_id and product_name
    product_id = get_product_id(seller_id, product_name)
    if not product_id:
        return "Product ID not found", 400  

    # Other form data...
    product_image = request.form.get('product_image')
    
    # Ensure product_price is a valid float
    try:
        product_price = float(request.form.get('product_price', 0))
    except ValueError:
        return "Invalid product price", 400

    # Ensure quantity is a valid integer
    try:
        quantity = int(request.form.get('quantity', 1))
    except ValueError:
        return "Invalid quantity", 400

    # Get user info from session
    user_id = session['user_id']
    user_info = get_user_info(user_id)

    if user_info:
        first_name, middle_name, last_name, username, phone_number, municipality, province, barangay = user_info
        full_address = f"{barangay}, {municipality}, {province}"  # Properly formatted address
    else:
        first_name = middle_name = last_name = username = phone_number = municipality = province = barangay = ""
        full_address = ""

    # Fetch business name based on seller_id
    business_name = get_business_name(seller_id)

    # Fetch the available stock for the product
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT stock_quantity FROM seller_add_product WHERE id = %s", (product_id,))
    stock_quantity = cursor.fetchone()
    connection.close()

    if not stock_quantity:
        return "Product not found", 400  

    # Check if the requested quantity exceeds the available stock
    if quantity > stock_quantity[0]:
        return f"Only {stock_quantity[0]} items are available in stock. Please adjust your quantity.", 400

    # Fetch available vouchers
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT Voucher_name, Voucher_code, Voucher_function FROM voucher")
    vouchers = cursor.fetchall()
    connection.close()

    # Shipping fee logic
    free_shipping = False
    shipping_fee = 50  # Default shipping fee
    voucher_code = request.form.get('voucher_code', '')

    if voucher_code:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT voucher_function FROM voucher WHERE voucher_code = %s", (voucher_code,))
        voucher = cursor.fetchone()

        if voucher:
            if voucher[0] == '50':  # Free shipping voucher
                free_shipping = True
                shipping_fee = 0  

        cursor.close()
        conn.close()

    # Render the template with all data
    return render_template(
        'checkout_page.html',
        product_name=product_name,
        product_image=product_image,
        product_price=product_price,
        quantity=quantity,
        first_name=first_name,
        middle_name=middle_name,
        last_name=last_name,
        Username=username,
        phone_number=phone_number,
        full_address=full_address,  # Pass full address here
        Business_name=business_name,
        seller_id=seller_id,
        product_id=product_id,  
        vouchers=vouchers,  
        user_is_logged_in=True,
        free_shipping=free_shipping
    )



#eto is sa checkout_page pag ng place order
@app.route('/place-order', methods=['POST'])
def place_order():
    if 'user_id' not in session:
        return "User not logged in", 401

    user_id = session['user_id']

    # Retrieve product_id and other form data
    product_id = request.form.get('product_id')
    if not product_id:
        return "Product ID is missing", 400  # Handle missing product ID

    voucher_code = request.form.get('voucher_code', '')
    discount = 0  # Default no discount
    free_shipping = False
    shipping_fee = 50.00  # Default shipping fee

    # Retrieve the voucher details if a voucher is selected
    if voucher_code:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT voucher_function FROM voucher WHERE voucher_code = %s", (voucher_code,))
        voucher = cursor.fetchone()

        if voucher:
            if voucher[0] == '50':  # Check for the free shipping voucher
                free_shipping = True
                shipping_fee = 0  # Free shipping
            else:
                # Handle other voucher types (percentage discounts)
                discount = voucher[0]
                if '%' in discount:
                    discount_percentage = float(discount.replace('%', ''))
                    discount = discount_percentage / 100  # Convert to decimal
                else:
                    discount = 0  # If no percentage or invalid, no discount applied
        else:
            free_shipping = False  # No valid voucher applied

        cursor.close()
        conn.close()

   # Collect other form data
    first_name = request.form.get('first_name')
    middle_name = request.form.get('middle_name')
    last_name = request.form.get('last_name')
    username = request.form.get('username')
    phone_number = request.form.get('phone_number')

    # Updated Address Fields
    municipality = request.form.get('municipality')
    province = request.form.get('province')
    barangay = request.form.get('barangay')

    # Concatenated Address for Display Purposes
    full_address = f"{barangay}, {municipality}, {province}"

    product_name = request.form.get('product_name')
    product_price = float(request.form.get('product_price', 0))
    quantity = int(request.form.get('quantity', 1))
    product_image = request.form.get('product_image')
    payment_method = request.form.get('payment_method')
    business_name = request.form.get('business_name')
    seller_id = request.form.get('seller_id')


    # Calculate total price
    subtotal = product_price * quantity
    total = subtotal + shipping_fee

    # Calculate total_gross as 5% of the total (before discount)
    total_gross = total * 0.05

    # Apply the voucher discount (if any)
    if discount:
        discount_amount = total * discount
    else:
        discount_amount = 0

    # Calculate the final total after the discount
    final_total = total - discount_amount

    # Insert order into the database
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute('''INSERT INTO orders (user_id, seller_id, product_id, first_name, middle_name, last_name, username, phoneNumber, 
                                      municipality, province, barangay, 
                                      business_name, productName, product_image, productPrice, 
                                      quantity, total, payment_method, total_gross, total_net)
                  VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)''',
               (user_id, seller_id, product_id, first_name, middle_name, last_name, username, phone_number, 
                municipality, province, barangay, 
                business_name, product_name, product_image, product_price, 
                quantity, final_total, payment_method, total_gross, final_total))



    # Retrieve the last inserted order ID
    cursor.execute("SELECT LAST_INSERT_ID()")
    order_id = cursor.fetchone()[0]

    # Create a notification for the seller
    notification_message = f"New order placed for {product_name} by {first_name} {last_name}. Quantity: {quantity}, Total: {final_total:.2f}"

    cursor.execute('''INSERT INTO notifications (user_id, order_id, seller_id, message, product_name, product_image, recipient_type, status)
                      VALUES (%s, %s, %s, %s, %s, %s, %s, %s)''',
                   (user_id, order_id, seller_id, notification_message, product_name, product_image, 'seller', 'unread'))

    # Commit changes and close the connection
    conn.commit()
    cursor.close()
    conn.close()

    return make_response('', 204)


def get_vouchers():
    # Use the global database connection function
    connection = get_db_connection()
    cursor = connection.cursor()

    # Query to fetch only available vouchers
    query = """
        SELECT Voucher_name, Voucher_code
        FROM voucher
        WHERE Status = 'available'
    """
    cursor.execute(query)
    vouchers = cursor.fetchall()  # Fetch all rows that match the condition

    # Close the database connection
    connection.close()

    return vouchers  # Returns a list of tuples: [(Voucher_name1, Voucher_code1), ...]





#FOR BUYER PROFILE SETTINGS
@app.route('/my_account', methods=['GET', 'POST'])
def my_account():
    user_id = session.get('user_id')
    if not user_id:
        flash("Please log in first", "warning")
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch user data based on session user_id
        cursor.execute("""
            SELECT Username, Email, Phone_number, gender, date_of_birth, profile_picture, first_name, middle_name, last_name 
            FROM user_info 
            WHERE id = %s
        """, (user_id,))
        user_info = cursor.fetchone()  # Returns None if no data is found

        # If user_info is None, display an error and redirect to login
        if user_info is None:
            flash('User not found in the database', 'danger')
            return redirect(url_for('login'))

        # Process form data if the request method is POST
        if request.method == 'POST':
            username = request.form['username']
            email = request.form['email']
            phone_number = request.form['phone_number']
            gender = request.form['gender']
            dob = request.form['dob']
            first_name = request.form['firstname']
            middle_name = request.form['middlename']
            last_name = request.form['lastname']

            # Handle profile picture upload
            profile_picture = request.files.get('profile_picture')
            profile_picture_filename = user_info[5]  # Default to existing profile picture

            if profile_picture:
                # Save the new profile picture
                filename = secure_filename(profile_picture.filename)
                profile_picture_filename = filename
                upload_folder = os.path.join('static', 'profile_picture_uploads')
                profile_picture.save(os.path.join(upload_folder, filename))

            cursor.execute("""
                UPDATE user_info 
                SET Username = %s, Email = %s, Phone_number = %s, gender = %s, date_of_birth = %s, 
                    profile_picture = %s, first_name = %s, middle_name = %s, last_name = %s 
                WHERE id = %s
            """, (username, email, phone_number, gender, dob, profile_picture_filename, 
                  first_name, middle_name, last_name, user_id))
            conn.commit()
            flash('Profile updated successfully!', 'success')
            return redirect(url_for('my_account'))

    except Exception as e:
        flash(f"An error occurred: {e}", 'error')
    finally:
        cursor.close()
        conn.close()

    # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available

    # Pass the fetched user_info as 'user' to the template
    return render_template(
        'buyerProfile.html',
        user=user_info,
        active_tab='my-account',
        user_is_logged_in=user_is_logged_in,
        username=username
    )

@app.route('/manage_addresses')
def manage_addresses():
    user_id = session.get('user_id')
    if not user_id:
        return jsonify({"error": "Please log in first."}), 401

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Fetch default address details
        cursor.execute("SELECT Username, Phone_number, municipality, province, barangay FROM user_info WHERE id = %s", (user_id,))
        user = cursor.fetchone()  # user is None if no record is found

        # Fetch additional addresses
        cursor.execute("SELECT name, phone_number, municipality, province, barangay FROM additional_addresses WHERE user_id = %s", (user_id,))
        addresses = cursor.fetchall()  # empty list if no records are found

        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Database error: {e}")
        return jsonify({"error": "Could not retrieve address information."}), 500

    # Ensure default structure
    return jsonify({
        "default_address": user if user else None,  # Return None if no default address found
        "additional_addresses": addresses  # Return empty list if no additional addresses found
    })


@app.route('/add_address', methods=['POST'])
def add_address():
    # Ensure user is logged in
    user_id = session.get('user_id')
    if not user_id:
        return jsonify({"error": "Please log in first."}), 401

    # Retrieve address data from the request
    data = request.get_json()
    name = data.get('name')
    phone_number = data.get('phone_number')
    address = data.get('address')

    if not all([name, phone_number, address]):
        return jsonify({"error": "All address fields are required."}), 400

    try:
        # Insert the new address into the database
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO additional_addresses (user_id, name, phone_number, address) VALUES (%s, %s, %s, %s)",
            (user_id, name, phone_number, address)
        )
        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Database error: {e}")
        return jsonify({"error": "Could not add the address."}), 500

    # Return success response
    return jsonify({"success": True}), 200



@app.route('/to-pay-orders')
def to_pay_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in user's ID from the session
    user_id = session.get('user_id')  # Assuming you store user ID in the session

    # Ensure user_id is available
    if user_id is None:
        return jsonify({'error': 'User not logged in.'}), 403

    # Query to fetch orders with "To Pay" status for the logged-in user
    query = """
        SELECT id, business_name, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'To Pay' AND user_id = %s  -- Assuming you have a user_id field in your orders table
    """
    cursor.execute(query, (user_id,))
    to_pay_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'to_pay_orders': to_pay_orders})

@app.route('/cancel-order/<int:order_id>', methods=['POST'])
def cancel_order(order_id):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Update the order status to "Cancelled"
    query = """
        UPDATE orders
        SET status = 'Cancelled'
        WHERE id = %s AND status = 'To Pay'  -- Ensure you only cancel orders that are currently "To Pay"
    """
    cursor.execute(query, (order_id,))
    conn.commit()

    # Close the connection
    cursor.close()
    conn.close()

    return jsonify({'message': 'Order cancelled successfully.'})

@app.route('/buyer-ship-orders')
def buyer_ship_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in user's ID from the session
    user_id = session.get('user_id')  # Assuming you store user ID in the session

    # Ensure user_id is available
    if user_id is None:
        return jsonify({'error': 'User not logged in.'}), 403

    # Query to fetch orders with "To Ship" status for the logged-in user
    query = """
        SELECT id, business_name, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'To Ship' AND user_id = %s  -- Assuming you have a user_id field in your orders table
    """
    cursor.execute(query, (user_id,))
    to_ship_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'to_ship_orders': to_ship_orders})

@app.route('/buyer-receive-orders')
def buyer_receive_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in user's ID from the session
    user_id = session.get('user_id')  # Assuming you store user ID in the session

    # Ensure user_id is available
    if user_id is None:
        return jsonify({'error': 'User not logged in.'}), 403

    # Query to fetch orders with "To Receive" status for the logged-in user
    query = """
        SELECT id, business_name, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'To Receive' AND user_id = %s  -- Assuming you have a user_id field in your orders table
    """
    cursor.execute(query, (user_id,))
    to_receive_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'to_receive_orders': to_receive_orders})


#function para sa confirmation for order receive ni buyer
@app.route('/mark-as-completed/<int:order_id>', methods=['POST'])
def mark_as_completed(order_id):
    import logging
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Update the order status to "Completed"
        update_query = "UPDATE orders SET status = 'Completed' WHERE id = %s AND status = 'To Receive'"
        cursor.execute(update_query, (order_id,))

        # Set delivered_at in the delivery table
        cursor.execute("""
            UPDATE delivery
            SET delivered_at = NOW()
            WHERE order_id = %s
        """, (order_id,))

        # If the order was updated, send notification to seller
        if cursor.rowcount > 0:
            order_details_query = """
                SELECT o.user_id, o.seller_id, o.productName, o.product_image 
                FROM orders o 
                WHERE o.id = %s
            """
            cursor.execute(order_details_query, (order_id,))
            order_details = cursor.fetchone()

            if order_details:
                user_id, seller_id, product_name, product_image = order_details
                notification_message = f"The buyer has marked Order #{order_id} for '{product_name}' as 'Received'. Please review and process accordingly."
                insert_notification_query = """
                    INSERT INTO notifications (order_id, user_id, seller_id, product_name, product_image, message, recipient_type, created_at)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, NOW())
                """
                cursor.execute(insert_notification_query, 
                               (order_id, user_id, seller_id, product_name, product_image, notification_message, 'seller'))

        conn.commit()
        cursor.close()
        conn.close()
        return '', 204  # No content on successful update

    except Exception as e:
        logging.error(f"Error marking order {order_id} as completed: {e}")
        conn.rollback()
        cursor.close()
        conn.close()
        return jsonify({'success': False, 'message': str(e)}), 500
    

@app.route('/buyer-refund-orders')
def buyer_refund_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in user's ID from the session
    user_id = session.get('user_id')  # Assuming you store user ID in the session

    # Ensure user_id is available
    if user_id is None:
        return jsonify({'error': 'User not logged in.'}), 403

    # Query to fetch orders with "Refund" or "Refund Request" statuses for the logged-in user
    query = """
        SELECT id, business_name, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status IN ('Refund', 'Refund Request') AND user_id = %s
    """
    cursor.execute(query, (user_id,))
    refund_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'refund_orders': refund_orders})


@app.route('/submit-refund', methods=['POST'])
def submit_refund():
    data = request.form
    files = request.files

    # Ensure required fields are provided
    if not data.get('id') or not data.get('reason'):
        return jsonify({'error': 'Missing required fields'}), 400

    # Handle the images if provided
    image_paths = []
    for i in range(1, 5):  # Handle up to 4 images
        image = files.get(f'popup-image-{i}')
        if image and allowed_file(image.filename):
            filename = secure_filename(image.filename)
            image.save(os.path.join(app.config['UPLOAD_FOLDERS'], filename))
            image_paths.append(os.path.join(app.config['UPLOAD_FOLDERS'], filename))
        else:
            image_paths.append(None)

    # Connect to the database
    connection = get_db_connection()
    if not connection:
        return jsonify({'error': 'Failed to connect to the database'}), 500

    cursor = connection.cursor()

    # Find the order by id
    order_id = data['id']
    cursor.execute("SELECT * FROM orders WHERE id = %s", (order_id,))
    order = cursor.fetchone()

    if not order:
        return jsonify({'error': 'Order not found'}), 404

    # Update the order with the refund details and change the status
    update_query = """
    UPDATE orders 
    SET refund_reason = %s, 
        refund_image_1 = %s, 
        refund_image_2 = %s, 
        refund_image_3 = %s, 
        refund_image_4 = %s, 
        status = 'Refund Request' 
    WHERE id = %s
    """
    cursor.execute(update_query, (
        data['reason'],
        image_paths[0],
        image_paths[1],
        image_paths[2],
        image_paths[3],
        order_id
    ))

    # Fetch order details for notification
    order_details_query = """
        SELECT o.user_id, o.seller_id, o.productName, o.product_image 
        FROM orders o 
        WHERE o.id = %s
    """
    cursor.execute(order_details_query, (order_id,))
    order_details = cursor.fetchone()

    if order_details:
        user_id, seller_id, product_name, product_image = order_details

        # Insert a notification for the seller
        notification_message = f"A refund request has been submitted for Order #{order_id} of '{product_name}'. Please review the details."
        insert_notification_query = """
            INSERT INTO notifications (order_id, user_id, seller_id, product_name, product_image, message, recipient_type, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, NOW())
        """
        cursor.execute(insert_notification_query, 
                       (order_id, user_id, seller_id, product_name, product_image, notification_message, 'seller'))

    # Commit changes to the database
    connection.commit()

    # Close the connection
    cursor.close()
    connection.close()

    return jsonify({'message': 'Refund request submitted successfully'}), 200



@app.route('/buyer-completed-orders')
def buyer_completed_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in user's ID from the session
    user_id = session.get('user_id')  # Assuming you store user ID in the session

    # Ensure user_id is available
    if user_id is None:
        return jsonify({'error': 'User not logged in.'}), 403

    # Query to fetch orders with "Completed" status for the logged-in user
    query = """
        SELECT id, seller_id, business_name, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'Completed' AND user_id = %s  -- Assuming you have a user_id field in your orders table
    """
    cursor.execute(query, (user_id,))
    completed_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'completed_orders': completed_orders})

@app.route('/submit-feedback', methods=['POST'])
def submit_feedback():
    order_id = request.form.get('order_id')  # Order ID from the form
    rating = request.form.get('rating')     # Rating from the form
    message = request.form.get('message')   # Feedback message from the form

    # Collect image file paths
    image_filenames = [None, None, None, None]  # Initialize list to store image file paths

    for i in range(1, 5):  # Assuming 4 image inputs
        image = request.files.get(f'image_{i}')  # Image inputs named as image_1, image_2, etc.
        if image:
            image_filename = f"feedback_images/{image.filename}"
            image_path = os.path.join("static", image_filename)

            os.makedirs(os.path.dirname(image_path), exist_ok=True)
            image.save(image_path)
            image_filenames[i - 1] = image_filename  # Save the image path in the correct position

            print(f"Image {i} saved at {image_path}")

    if not order_id or not rating:
        return jsonify({"status": "error", "message": "Missing required fields!"}), 400

    # Debug log for received form data
    print(f"Received Feedback: Order ID: {order_id}, Rating: {rating}, Message: {message}, Images: {image_filenames}")

    # Connect to the database
    connection = get_db_connection()
    if not connection:
        return jsonify({"status": "error", "message": "Database connection failed!"}), 500

    try:
        cursor = connection.cursor()

        # Get user_id, username, and product_id from the orders table
        cursor.execute("""
            SELECT user_id, username, product_id
            FROM orders
            WHERE id = %s
        """, (order_id,))
        order_result = cursor.fetchone()

        if not order_result:
            return jsonify({"status": "error", "message": "Order not found!"}), 404

        user_id, username, product_id = order_result  # Extract user_id, username, and product_id

        # Log fetched data
        print(f"Fetched Data: User ID: {user_id}, Username: {username}, Product ID: {product_id}")

        # Prepare the SQL query for inserting feedback
        sql_query = """
            INSERT INTO feedback (order_id, user_id, username, product_id, rating, message, image_1, image_2, image_3, image_4)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Log the data to be inserted
        print(f"Inserting Feedback: Order ID: {order_id}, User ID: {user_id}, Username: {username}, Product ID: {product_id}, Rating: {rating}, Message: {message}, Images: {image_filenames}")

        # Execute the SQL query
        cursor.execute(sql_query, (
            order_id, user_id, username, product_id, rating, message,
            image_filenames[0], image_filenames[1], image_filenames[2], image_filenames[3]
        ))

        # Commit the transaction
        connection.commit()

        return jsonify({"status": "success", "message": "Feedback submitted successfully!"})

    except Exception as e:
        # Log the error for debugging
        print(f"Error inserting feedback: {e}")
        connection.rollback()  # Rollback in case of error
        return jsonify({"status": "error", "message": str(e)}), 500

    finally:
        # Close the database connection
        cursor.close()
        connection.close()







@app.route('/buyer-cancelled-orders')
def buyer_cancelled_orders():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get the logged-in user's ID from the session
    user_id = session.get('user_id')  # Assuming you store user ID in the session

    # Ensure user_id is available
    if user_id is None:
        return jsonify({'error': 'User not logged in.'}), 403

    # Query to fetch orders with "Cancelled" status for the logged-in user
    query = """
        SELECT id, business_name, product_image, productName, quantity, total, payment_method, status
        FROM orders
        WHERE status = 'Cancelled' AND user_id = %s  -- Assuming you have a user_id field in your orders table
    """
    cursor.execute(query, (user_id,))
    cancelled_orders = cursor.fetchall()

    # Close the connection
    cursor.close()
    conn.close()

    # Return data as JSON for AJAX
    return jsonify({'cancelled_orders': cancelled_orders})

from flask import jsonify

@app.route('/best-seller-data')
def best_seller_data():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    # Query to fetch products with the highest "Completed" orders
    query = """
        SELECT 
            product_id, 
            productName, 
            product_image, 
            COUNT(*) AS completed_count
        FROM orders
        WHERE status = 'Completed'
        GROUP BY product_id
        ORDER BY completed_count DESC
        LIMIT 7
    """
    
    cursor.execute(query)
    best_sellers = cursor.fetchall()

    cursor.close()
    connection.close()

    if best_sellers:
        return jsonify({'best_sellers': best_sellers})
    else:
        return jsonify({'best_sellers': []})  # Return empty list if no best sellers found




#PARA SA PAG add SA WISHLIST AYY KABOBO NAMAN
@app.route('/add_to_wishlist', methods=['POST'])
def add_to_wishlist():
    # Check if the user_id is stored in the session
    user_id = session.get('user_id')
    if not user_id:
        return jsonify({"error": "User not logged in"}), 401  # Unauthorized response if no user_id found

    product_data = request.json
    product_id = product_data.get('id')  # Assuming 'id' from the request data is product_id

    # Debug: Print incoming product data
    print("Received product data:", product_data)

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    # Retrieve product details from seller_add_product table
    cursor.execute(
        "SELECT product_name, product_image, price, business_name, seller_id FROM seller_add_product WHERE id = %s",
        (product_id,)
    )
    product = cursor.fetchone()

    if not product:
        return jsonify({"error": "Product not found"}), 404

    # Extract product details
    product_name = product['product_name']
    product_image = product['product_image']
    product_price = product['price']
    business_name = product['business_name']
    seller_id = product['seller_id']

    # Debug: Print extracted values
    print(f"User ID: {user_id}, Product ID: {product_id}, Product Name: {product_name}, "
          f"Product Image: {product_image}, Product Price: {product_price}, Business Name: {business_name}, Seller ID: {seller_id}")

    # Check if the product is already in the user's wishlist
    cursor.execute(
        "SELECT * FROM wishlist WHERE user_id = %s AND product_id = %s",
        (user_id, product_id)
    )
    wishlist_item = cursor.fetchone()

    if wishlist_item:
        # If the item is already in the wishlist, remove it
        cursor.execute(
            "DELETE FROM wishlist WHERE user_id = %s AND product_id = %s",
            (user_id, product_id)
        )
        status = "removed"
    else:
        # If the item is not in the wishlist, add it
        cursor.execute(
            "INSERT INTO wishlist (user_id, product_id, product_name, product_image, product_price, business_name, seller_id) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (user_id, product_id, product_name, product_image, product_price, business_name, seller_id)
        )
        status = "added"

    connection.commit()
    cursor.close()
    connection.close()

    return jsonify({"status": status})





#PARA SA PAG DISPLAY SA WISLIST TAB
@app.route('/wishlist')
def wishlist():
    # Retrieve user_id directly from the session
    user_id = session.get('user_id')

    if not user_id:
        return jsonify({'error': 'User not authenticated.'}), 403  # Return error if not authenticated

    print(f"Fetching wishlist for user ID: {user_id}")  # Debugging output

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)

    try:
        # Query to fetch wishlist items for the user
        cursor.execute("""
            SELECT w.product_id, w.product_name, w.product_image, w.product_price
            FROM wishlist w
            WHERE w.user_id = %s
        """, (user_id,))

        wishlist_items = cursor.fetchall()
        print(f"Fetched wishlist items: {wishlist_items}")  # Debugging output

        # Update product_image to include the full URL
        for item in wishlist_items:
            item['product_image'] = url_for('static', filename='upload_images/' + item['product_image'])

        return jsonify({'wishlist_items': wishlist_items})  # Return wishlist items as JSON
    except Exception as e:
        print(f"Error fetching wishlist items: {e}")
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        connection.close()

#WISLIST TO CARTS TO 
@app.route('/api/cart', methods=['POST'])
def add_to_carts():
    item = request.json  # Get the JSON data sent in the request
    user_id = session.get('user_id')  # Retrieve the user ID from the session

    print("Received item:", item)  # Log received data for debugging

    # Ensure the user is logged in and all required fields are present
    if user_id and item and all(key in item for key in ('product_id', 'name', 'price', 'image')):
        conn = get_db_connection()
        cursor = conn.cursor()

        # Retrieve seller_id and business_name from seller_add_product
        cursor.execute(
            "SELECT business_name, seller_id FROM seller_add_product WHERE id = %s",
            (item['product_id'],)
        )
        product_details = cursor.fetchone()

        if not product_details:
            return jsonify({"message": "Product not found"}), 404

        business_name, seller_id = product_details

        # Insert the item into the cart table, including seller_id and business_name
        query = """
            INSERT INTO carts (user_id, product_id, product_name, price, product_image, quantity, business_name, seller_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (user_id, item['product_id'], item['name'], item['price'], item['image'], 1, business_name, seller_id)
        cursor.execute(query, values)
        conn.commit()

        # Remove the item from the wishlist
        delete_query = "DELETE FROM wishlist WHERE user_id = %s AND product_id = %s"
        cursor.execute(delete_query, (user_id, item['product_id']))
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({"message": "Item added to cart and removed from wishlist", "item": item}), 201

    return jsonify({"message": "Invalid item data or user not logged in"}), 400

@app.route('/api/wishlist/<int:product_id>', methods=['DELETE'])
def remove_from_wishlist(product_id):
    user_id = session.get('user_id')  # Retrieve the user ID from the session
    
    # Ensure the user is logged in
    if user_id:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Delete the item from the wishlist table
        delete_query = "DELETE FROM wishlist WHERE user_id = %s AND product_id = %s"
        cursor.execute(delete_query, (user_id, product_id))
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({"message": "Item removed from wishlist"}), 200

    return jsonify({"message": "User not logged in"}), 400

@app.route('/api/wishlist', methods=['DELETE'])
def delete_all_wishlist_items():
    user_id = session.get('user_id')  # Retrieve the user ID from the session
    
    if user_id:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Delete all items from the wishlist for the current user
        cursor.execute("DELETE FROM wishlist WHERE user_id = %s", (user_id,))
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({"message": "All items removed from wishlist"}), 200
    
    return jsonify({"message": "User not logged in"}), 400


@app.route('/get-orders', methods=['GET'])
def get_orders():
    try:
        seller_id = session.get('seller_id')
        if not seller_id:
            return jsonify([]), 401  # Return empty list if not logged in

        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("""
            SELECT product_id, product_image, productName, SUM(quantity) AS total_quantity
            FROM orders
            WHERE status = 'Completed' AND seller_id = %s
            GROUP BY product_id, product_image, productName
            ORDER BY total_quantity DESC
        """, (seller_id,))
        completed_orders = cursor.fetchall()

        # Always return a list (even if empty)
        return jsonify(completed_orders), 200

    except Exception as e:
        return jsonify({"message": "Error fetching orders", "error": str(e)}), 500
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()



@app.route('/inbox')
def inbox():
    # Get the user_id from the session
    user_id = session.get('user_id')

    if not user_id:
        # If the user is not logged in, redirect to the login page
        return redirect(url_for('login'))

    # Establish database connection
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Query to get messages for the logged-in user
    cursor.execute('SELECT * FROM messages WHERE user_id = %s ORDER BY created_at DESC', (user_id,))
    messages = cursor.fetchall()

    # Close the cursor and connection
    cursor.close()
    conn.close()

    # Render the messages in the inbox template
    return render_template('messages.html', messages=messages)



#eto yung pag pass ng data mula buyerProfile into messages.html
@app.route('/contact-seller')
def contact_seller():
    # Extract query parameters
    seller_id = request.args.get('seller_id')
    seller_name = request.args.get('seller_name')
    order_id = request.args.get('order_id')
    product_name = request.args.get('product_name')
    product_image = request.args.get('product_image')
    product_price = request.args.get('product_price')

    # Fetch order details from the database (optional if needed)
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM orders WHERE id = %s", (order_id,))
    order_details = cursor.fetchone()
    cursor.close()
    conn.close()

     # Check if user is logged in
    user_is_logged_in = 'user_id' in session  # True if user is logged in
    username = session.get('username', None)  # Get username from session if available


    # Render the template with order, product, and seller details
    return render_template(
        'messages.html',
        seller_id=seller_id,
        seller_name=seller_name,
        order_id=order_id,
        product_name=product_name,
        product_image=product_image,
        product_price=product_price,
        order_details=order_details,
        user_is_logged_in=user_is_logged_in, username=username
    )


#pag send ng message ni buyer
@app.route('/send-message', methods=['POST'])
def send_message():
    try:
        # Get the data from the request
        data = request.get_json()

        # Extract data
        message = data.get('message')
        seller_id = data.get('seller_id')
        order_id = data.get('order_id')  # Optional field, can be None
        business_name = data.get('business_name')
        sender_type = data.get('sender_type')

        # Get user info from session
        user_id = session.get('user_id')  # Assuming the user ID is stored in the session
        username = session.get('username')  # Assuming the username is stored in the session

        # Optional: Add validation for required fields
        if not message or not seller_id or not business_name or not user_id or not username:
            return jsonify({'success': False, 'message': 'Required fields are missing'}), 400

        # Connect to the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Insert the message into the messages table
        query = """
        INSERT INTO messages (user_id, seller_id, order_id, username, business_name, message, sender_type)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (user_id, seller_id, order_id, username, business_name, message, sender_type))

        # Commit the transaction
        conn.commit()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # Return success response
        return jsonify({'success': True, 'message': 'Message sent successfully'}), 200

    except Error as e:
        # Handle database errors
        print(f"Error: {e}")
        return jsonify({'success': False, 'message': str(e)}), 500

    except Exception as e:
        # Handle any other errors
        print(f"Error: {e}")
        return jsonify({'success': False, 'message': 'An error occurred'}), 500

    

    
@app.route('/get-messages', methods=['GET'])
def get_messages():
    if 'user_id' not in session:
        return jsonify({'success': False, 'message': 'User is not logged in'}), 401

    user_id = session['user_id']
    seller_id = request.args.get('seller_id')

    if not seller_id:
        return jsonify({'success': False, 'message': 'Missing seller_id'}), 400

    print(f"User ID: {user_id}, Seller ID: {seller_id}")  # Debugging line

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT user_id, seller_id, message, sender_type, created_at 
            FROM messages 
            WHERE (user_id = %s AND seller_id = %s) OR (user_id = %s AND seller_id = %s)
        """, (user_id, seller_id, seller_id, user_id))
        messages = cursor.fetchall()

        print(f"Messages found: {messages}")  # Debugging line

        if not messages:
            return jsonify({'success': False, 'message': 'No messages found'}), 404

        return jsonify({
            'success': True,
            'messages': messages
        })

    except mysql.connector.Error as err:
        return jsonify({'success': False, 'message': f'Error: {err}'}), 500
    finally:
        cursor.close()
        conn.close()






@app.route('/seller_get_message', methods=['GET'])
def get_seller_messages():
    try:
        # Get the seller_id from the session
        seller_id = session.get('seller_id')
        if not seller_id:
            return jsonify({"error": "Unauthorized. Please log in."}), 401

        connection = get_db_connection()
        with connection.cursor() as cursor:
            # Query to get messages only for the logged-in seller
            query = """
                SELECT user_id, order_id, message, created_at, is_read, username, business_name
                FROM messages
                WHERE seller_id = %s
                ORDER BY created_at ASC
            """
            cursor.execute(query, (seller_id,))
            result = cursor.fetchall()

        # Debugging: Check the query result
        print(f"Query result: {result}")
        if not result:
            return jsonify({"message": "No messages found"}), 200

        # Process the messages
        messages = []
        for row in result:
            # Debugging: Check the message details
            print(f"Row data: {row}")  # Debugging line

            # Check sender_type based on user_id
            sender_type = 'buyer' if row[0] != seller_id else 'seller'

            # Debugging: Check which messages are being categorized as seller or buyer
            print(f"Message from: {sender_type}, User ID: {row[0]}")  # Debugging line

            message = {
                "user_id": row[0],
                "order_id": row[1],
                "message": row[2],
                "created_at": row[3],
                "is_read": row[4],
                "username": row[5],
                "business_name": row[6],
                "sender_type": sender_type  # Correct sender type logic
            }
            messages.append(message)

        return jsonify(messages), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        connection.close()







@app.route('/seller-send-message', methods=['POST'])
def seller_send_message():
    try:
        # Get the data from the request
        data = request.get_json()

        # Debugging: Log the received data
        print(f"Received data: {data}")

        # Extract data
        message = data.get('message')
        seller_id = session.get('seller_id')  # Fetch seller_id from the session
        user_id = data.get('user_id')  # Fetch user_id from the request
        order_id = data.get('order_id')  # Optional field, can be None
        sender_type = 'seller'  # Set sender_type as "seller" (no need to extract it from the request)
        username = session.get('username')  # Assuming the username is stored in the session

        # Debugging: Log all extracted values
        print(f"Message: {message}, Seller ID: {seller_id}, User ID: {user_id}, Order ID: {order_id}")

        # Validate required fields
        if not message or not seller_id or not user_id:
            return jsonify({'success': False, 'message': 'Required fields are missing'}), 400

        # Ensure user_id is an integer if it's being stored as an integer in the database
        user_id = int(user_id)

        # Check or fetch business_name
        business_name = session.get('business_name')
        if not business_name:
            conn = get_db_connection()
            cursor = conn.cursor()

            # Fetch the business_name from the database using the seller_id
            query = "SELECT business_name FROM user_info WHERE id = %s"
            cursor.execute(query, (seller_id,))
            result = cursor.fetchone()

            if result:
                business_name = result[0]
                session['business_name'] = business_name
            else:
                print("Business name not found in the database.")
                return jsonify({'success': False, 'message': 'Business name not found'}), 400

            cursor.close()
            conn.close()

        # Insert the message into the messages table
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO messages (seller_id, user_id, order_id, username, business_name, message, sender_type)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        values = (seller_id, user_id, order_id, username, business_name, message, sender_type)
        print(f"Executing Query: {query} with Values: {values}")

        try:
            cursor.execute(query, values)
            conn.commit()
            print("Message inserted successfully.")
        except Exception as e:
            print(f"Database Error: {e}")
            return jsonify({'success': False, 'message': 'Database error occurred'}), 500
        finally:
            cursor.close()
            conn.close()

        # Return success response
        return jsonify({'success': True, 'message': 'Message sent successfully'}), 200

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'success': False, 'message': 'An error occurred'}), 500







@app.route('/admin_get_messages', methods=['GET'])
def get_admin_messages():
    connection = None  # Initialize the connection variable
    try:
        # Check if admin is logged in
        admin_id = session.get('user_id')
        if not admin_id:
            return jsonify({"error": "Unauthorized. Please log in as admin."}), 401

        connection = get_db_connection()  # Establish the connection
        with connection.cursor() as cursor:
            # Query to get all messages between admin and sellers
            query = """
                SELECT user_id, seller_id, order_id, message, created_at, is_read, username, business_name
                FROM messages
                WHERE (seller_id = %s OR user_id = %s)  -- Admin will be either sender (user_id) or receiver (seller_id)
                ORDER BY created_at ASC
            """
            cursor.execute(query, (admin_id, admin_id))  # Use admin_id to filter messages from the admin or to the admin
            result = cursor.fetchall()

        # If no messages are found
        if not result:
            return jsonify({"message": "No messages found"}), 200

        # Process the messages
        messages = []
        for row in result:
            sender_type = "unknown"

            # Determine the sender type based on user_id or seller_id
            if row[0] == admin_id:  # If the user_id matches the admin, the admin sent the message
                sender_type = "admin"
            elif row[1] == admin_id:  # If the seller_id matches the admin, the seller sent the message
                sender_type = "seller"

            # Construct the message dictionary
            message = {
                "user_id": row[0],
                "seller_id": row[1],
                "order_id": row[2],
                "message": row[3],
                "created_at": row[4],
                "is_read": row[5],
                "username": row[6],
                "business_name": row[7],
                "sender_type": sender_type  # Store whether the sender is admin or seller
            }
            messages.append(message)

        return jsonify(messages), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        if connection:
            connection.close()  # Ensure connection is closed only if it was initialized


@app.route('/admin-send-message', methods=['POST'])
def admin_send_message():
    try:
        # Get the data from the request
        data = request.get_json()

        # Debugging: Log the received data
        print(f"Received data: {data}")

        # Extract data
        message = data.get('message')
        admin_id = session.get('user_id')  # Fetch admin_id from the session
        seller_id = data.get('seller_id')  # Seller ID passed from the frontend
        sender_type = 'admin'  # Sender is admin for this route

        # Debugging: Log all extracted values
        print(f"Message: {message}, Admin ID: {admin_id}, Seller ID: {seller_id}")

        # Validate required fields (message, admin_id, and seller_id)
        if not message or not admin_id or not seller_id:
            return jsonify({'success': False, 'message': 'Required fields are missing'}), 400

        # Fetch the username and business_name from the user_info table by admin_id (logged-in admin)
        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
        SELECT Roles, business_name FROM user_info WHERE id = %s
        """
        cursor.execute(query, (admin_id,))  # Use admin_id for the query
        admin_info = cursor.fetchone()

        if not admin_info:
            return jsonify({'success': False, 'message': 'Admin not found'}), 404

        admin_username, business_name = admin_info

        # Debugging: Log fetched admin username and business_name
        print(f"Fetched Admin Username: {admin_username}, Business Name: {business_name}")

        # Fetch the username from the seller based on seller_id
        query = """
        SELECT username FROM user_info WHERE id = %s
        """
        cursor.execute(query, (seller_id,))
        seller_info = cursor.fetchone()

        if not seller_info:
            return jsonify({'success': False, 'message': 'Seller not found'}), 404

        seller_username = seller_info[0]

        # Debugging: Log fetched seller username
        print(f"Fetched Seller Username: {seller_username}")

        # Insert the message into the messages table
        query = """
        INSERT INTO messages (user_id, seller_id, message, sender_type, username, business_name)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = (admin_id, seller_id, message, sender_type, admin_username, business_name)

        print(f"Executing Query: {query} with Values: {values}")  # Debugging query

        try:
            cursor.execute(query, values)
            conn.commit()
            print("Message inserted successfully.")
        except Exception as e:
            print(f"Database Error: {e}")
            return jsonify({'success': False, 'message': 'Database error occurred'}), 500
        finally:
            cursor.close()
            conn.close()

        # Return success response
        return jsonify({'success': True, 'message': 'Message sent successfully'}), 200

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'success': False, 'message': 'An error occurred'}), 500


from datetime import datetime

from datetime import datetime, timedelta

@app.route('/courier_dashboard_data')
def courier_dashboard_data():
    if 'user_id' not in session or session.get('role') != 'courier':
        return jsonify({'error': 'Courier not logged in.'}), 401

    courier_id = session['user_id']
    today = datetime.now().date()
    now = datetime.now()
    week_start = now - timedelta(days=now.weekday())
    month_start = now.replace(day=1)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Today's Delivery: bookings accepted today (picked_up_at is today)
    cursor.execute("""
        SELECT COUNT(*) AS todays_delivery
        FROM delivery
        WHERE delivery_courier_id = %s AND DATE(picked_up_at) = %s
    """, (courier_id, today))
    todays_delivery = cursor.fetchone()['todays_delivery']

    # Completed: deliveries completed today (delivered_at is today)
    cursor.execute("""
        SELECT COUNT(*) AS completed_today
        FROM delivery
        WHERE delivery_courier_id = %s AND delivered_at IS NOT NULL AND DATE(delivered_at) = %s
    """, (courier_id, today))
    completed_today = cursor.fetchone()['completed_today']

    # In Progress: orders with status 'To Ship' or 'To Receive' assigned to this courier
    cursor.execute("""
        SELECT COUNT(*) AS in_progress
        FROM orders o
        JOIN delivery d ON o.id = d.order_id
        WHERE d.delivery_courier_id = %s AND o.status IN ('To Ship', 'To Receive')
    """, (courier_id,))
    in_progress = cursor.fetchone()['in_progress']

    # Today's Earnings: sum of delivery_fee for deliveries completed today
    cursor.execute("""
        SELECT IFNULL(SUM(delivery_fee), 0) AS todays_earnings
        FROM delivery
        WHERE delivery_courier_id = %s AND delivered_at IS NOT NULL AND DATE(delivered_at) = %s
    """, (courier_id, today))
    todays_earnings = cursor.fetchone()['todays_earnings']

    # Earnings This Week
    cursor.execute("""
        SELECT IFNULL(SUM(delivery_fee), 0) AS earnings_week
        FROM delivery
        WHERE delivery_courier_id = %s AND delivered_at IS NOT NULL AND delivered_at >= %s
    """, (courier_id, week_start.strftime('%Y-%m-%d')))
    earnings_week = cursor.fetchone()['earnings_week']

    # Earnings This Month
    cursor.execute("""
        SELECT IFNULL(SUM(delivery_fee), 0) AS earnings_month
        FROM delivery
        WHERE delivery_courier_id = %s AND delivered_at IS NOT NULL AND delivered_at >= %s
    """, (courier_id, month_start.strftime('%Y-%m-%d')))
    earnings_month = cursor.fetchone()['earnings_month']

    # Earnings All Time
    cursor.execute("""
        SELECT IFNULL(SUM(delivery_fee), 0) AS earnings_all
        FROM delivery
        WHERE delivery_courier_id = %s AND delivered_at IS NOT NULL
    """, (courier_id,))
    earnings_all = cursor.fetchone()['earnings_all']

    cursor.close()
    conn.close()

    return jsonify({
        'todays_delivery': todays_delivery,
        'completed_today': completed_today,
        'in_progress': in_progress,
        'todays_earnings': todays_earnings,
        'earnings_week': earnings_week,
        'earnings_month': earnings_month,
        'earnings_all': earnings_all
    })

@app.route('/courier/my_deliveries')
def courier_my_deliveries():
    if 'user_id' not in session or session.get('role') != 'courier':
        return jsonify({'error': 'Courier not logged in.'}), 401

    courier_id = session['user_id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT d.order_id, d.buyer_name AS customer_name, d.delivery_location, d.seller_name, d.pickup_location,
               d.delivery_fee, d.picked_up_at, d.delivered_at, d.proof_of_delivery,  -- <-- add this
               o.productName, o.productPrice, o.status, o.product_image
        FROM delivery d
        JOIN orders o ON d.order_id = o.id
        WHERE d.delivery_courier_id = %s
        ORDER BY d.order_id DESC
    """, (courier_id,))
    deliveries = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify({'deliveries': deliveries})

@app.route('/courier/available_deliveries')
def courier_available_deliveries():
    if 'user_id' not in session or session.get('role') != 'courier':
        return jsonify({'error': 'Courier not logged in.'}), 401

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT d.order_id, d.buyer_name AS customer_name, d.delivery_location, d.seller_name, d.pickup_location,
               d.delivery_fee, d.picked_up_at, d.delivered_at, o.productName, o.productPrice, o.status
        FROM delivery d
        JOIN orders o ON d.order_id = o.id
        WHERE d.delivery_courier_id IS NULL
        ORDER BY d.order_id DESC
    """)
    deliveries = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify({'deliveries': deliveries})

@app.route('/accept_delivery/<int:order_id>', methods=['POST'])
def accept_delivery(order_id):
    if 'user_id' not in session or session.get('role') != 'courier':
        return

    courier_id = session['user_id']

    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Update the delivery_courier_id and set picked_up_at to NOW()
        cursor.execute("""
            UPDATE delivery 
            SET delivery_courier_id=%s, picked_up_at=NOW() 
            WHERE order_id=%s AND delivery_courier_id IS NULL
        """, (courier_id, order_id))
        # Update the order status to 'To Ship'
        cursor.execute("UPDATE orders SET status='To Ship' WHERE id=%s AND status='Waiting for Courier'", (order_id,))
        conn.commit()
        return jsonify({'success': True, 'message': 'Delivery accepted!'})
    except Exception as e:
        conn.rollback()
        return jsonify({'success': False, 'message': str(e)}), 500
    finally:
        cursor.close()
        conn.close()


@app.route('/courier/upload_proof_of_delivery', methods=['POST'])
def upload_proof_of_delivery():
    if 'user_id' not in session or session.get('role') != 'courier':
        return jsonify({'success': False, 'message': 'Not authorized'}), 401

    order_id = request.form.get('order_id')
    files = request.files.getlist('proof_images')
    if not order_id or not files:
        return jsonify({'success': False, 'message': 'Missing order ID or files'}), 400

    proof_filenames = []
    for file in files:
        if file and allowed_file(file.filename):
            filename = f"proof_{order_id}_{secure_filename(file.filename)}"
            save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(save_path)
            proof_filenames.append(filename)

    proof_str = ','.join(proof_filenames)

    conn = get_db_connection()
    cursor = conn.cursor()
    # Update delivery table
    cursor.execute(
        "UPDATE delivery SET proof_of_delivery=%s, delivered_at=NOW() WHERE order_id=%s",
        (proof_str, order_id)
    )
    # Update orders table status to Delivered
    cursor.execute(
        "UPDATE orders SET status='Delivered' WHERE id=%s",
        (order_id,)
    )
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({'success': True, 'message': 'Proof of delivery uploaded successfully.'})

if __name__ == '__main__':
    app.run(debug=True)