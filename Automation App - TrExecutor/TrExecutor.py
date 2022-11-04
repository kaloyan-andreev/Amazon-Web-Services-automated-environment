from tkinter.filedialog import askdirectory 
import time
from tkinter import *
from tkinter.ttk import *
from PIL import ImageTk, Image 
from python_terraform import *
import os




app = Tk()
app.title('TrExecutor')
app.geometry('380x300') 



# Create an object of tkinter ImageTk
app_logo = ImageTk.PhotoImage(Image.open("C:/Users/user/Desktop/GitProjects/semester-3-case-study-project/App's logo/Automation App - logo.png"))

# Create a Label Widget to display the text or Image
label = Label(app, image = app_logo)
label.grid(row = 0, columnspan=3)


    
# Label that shows what to do with the button on right hand-side
sel_folder = Label(
    app, 
    text='Select folder with (.tr) scripts'
    )
sel_folder.grid(row=1, columnspan=2)



# Button to choose the certain folder
sel_folder = Button(
    app, 
    text ='Choose folder', 
    command = lambda:select_directory()
    ) 
sel_folder.grid(row=1, column=2)



# Button that execute the files in the selected folder
build_infra = Button(
    app,
    text='Build Infrastructure',
    command=lambda:[terraform_apply(), progress_bar(), build_message()]
)
build_infra.grid(row=4, column=0, pady=10)



# Button that execute the modified files in the selected folder
modify_infra = Button(
    app,
    text='Modify Infrastructure',
    command=lambda:[terraform_apply(), progress_bar(), modify_message()]
)
modify_infra.grid(row=4, column=1, pady=10)



# Button that destroys the infrastructure built from the files in the selected folder
destroy_infra = Button(
    app,
    text='Destroy Infrastructure',
    command=lambda:[open_popup()]
)
destroy_infra.grid(row=4, column=2, pady=10)



""" FUNCTIONS """

def open_popup():
    popup_window= Toplevel(app)
    popup_window.geometry("320x150")
    
    # Label that asks the user to confirm the deletion
    message = Label(
        popup_window,
        text= "Are you sure you want to destroy \nthe current cloud infrastructure!"
    )
    message.place(x=70,y=20)

    # Button that confirms user's choice
    confirm_button = Button(
    popup_window,
    text='Yes',
    command=lambda:[close_popup(), terraform_destroy(), progress_bar(), destroy_message()]
    )
    confirm_button.place(x=60, y=70)

    # Button that rejects user's choice
    confirm_button = Button(
    popup_window,
    text='No',
    command=lambda:[close_popup()]
    )
    confirm_button.place(x=180, y=70)

    # Function that closes automatically the new window
    def close_popup():
        popup_window.destroy()



# Function that albes the user to select certain directory
def select_directory():
    
    # Declare global variable that will store the folder's path
    global dir_path
    dir_path= askdirectory()
    
    # Label that shows the selected folder's path
    show_path = Label(
        app, 
        text="Path: " + dir_path
        )
    show_path.grid(row=2, columnspan=3, pady=10)

    # Condition to check if folder has been selected
    if dir_path is not None:
        pass



# Function that creates a progress bar 
def progress_bar():

    # Declare a variabel that stores the progress bar
    prog_bar = Progressbar(
        app, 
        orient=HORIZONTAL, 
        length=250, 
        mode='determinate'
        )
    
    # Put the progress bar on the display
    prog_bar.grid(row=5, columnspan=3, pady=20)
    
    # A loop that starts progress bar 
    for i in range(5):
        app.update_idletasks()
        prog_bar['value'] += 20
        time.sleep(1)
    
    # Destroying the bar at the end of the process
    prog_bar.destroy()
    


# Function that shows on the display whether the infrastructure is built successfully
def build_message():
    build_message = Label(
        app, 
        text='The infrastructure is built successfully!', 
        foreground='green')
    build_message.grid(row=5, columnspan=3, pady=10)
    build_message.after(7000, lambda:build_message.destroy())
    


# Function that shows on the display whether the infrastructure is modified successfully
def modify_message():
    modify_message = Label(
        app, 
        text='The infrastructure is modifyed successfully!', 
        foreground='green')
    modify_message.grid(row=5, columnspan=3, pady=10)
    modify_message.after(7000, lambda:modify_message.destroy())



# Function that shows on the display whether the infrastructure is destroyed successfully
def destroy_message():
    destroy_message = Label(
        app, 
        text='The infrastructure is destroyed successfully!', 
        foreground='green')
    destroy_message.grid(row=5, columnspan=3, pady=10)
    destroy_message.after(7000, lambda:destroy_message.destroy())



# Function that perform the command 'terraform apply'
def terraform_apply():
    tf = Terraform(working_dir=dir_path)
    tf.init()
    tf.apply(skip_plan=True)



# Function that perform the command 'terraform destroy'
def terraform_destroy():
    os.chdir(dir_path)
    os.system('terraform destroy -auto-approve')  
    


app.mainloop()