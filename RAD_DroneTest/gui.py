import tkinter as tk
from tkinter import *
from PIL import ImageTk, Image

root = tk.Tk()
font = 'Courier'
headerSize = 27
firstFontSize = 15
buttonFontSize = 12

HEIGHT = 700
WIDTH = 800

canvas = tk.Canvas(root, height=HEIGHT, width=WIDTH, bg="#80c1ff")
# canvas.place(relwidth=0.8, relheight=0.8, relx=0.05, rely=0.05)
canvas.pack()

frame = tk.Frame(root, bg="white")
frame.place(relwidth=1.0, relheight=1.0, relx=0.0, rely=0.0)

# # bg = ImageTk.PhotoImage(Image.open('roadsideSky.png'))
# bg = tk.PhotoImage(file='sky_4.png')
# bg_label = tk.Label(root, image=bg)   
# bg_label.place(relwidth=1, relheight=1)

# three widgets: button, label, entry
header = tk.Label(frame, text="Welcome to the Roadside Drone Application!", font=(font, headerSize), bg='white')
header.place(relx=0.0, rely=0.0, relheight=0.1)

locationPrompt = tk.Label(frame, text="What is your current location? i.e. (latitude, longitude)", 
    font=(font, firstFontSize), bg='white')
locationPrompt.place(relx=0.0, rely=0.2, relheight=0.025)

locationEntry = tk.Text(frame, bg='white')
locationEntry.place(relx=0.0, rely=0.23, relheight=0.05, relwidth=0.3)

situationPrompt = tk.Label(frame, text="Approx. how much fuel is left? (gallons)", font=(font, firstFontSize), bg='white')
situationPrompt.place(relx=0.0, rely=0.3, relheight=0.025)

situationEntry = tk.Text(frame, bg='white')
situationEntry.place(relx=0.0, rely=0.33, relheight=0.05, relwidth=0.3)

confirm = tk.Label(frame, text="", font=(font, firstFontSize), bg='white')
confirm.place(relx=0.0, rely=0.44, relheight=0.025)

nearestGasHeader = tk.Label(frame, text="", 
                        font=(font, firstFontSize), bg='white')
nearestGasHeader.pack(side='left')

def confirmEntries():
    confirm.config(text = "Your information has been received.")
    nearestGasHeader.config(text = "Your distance from the nearest gas station is 8.6 miles and you have 0.25 gallons left. You need 0.5 gallons more to make it.")

enterButton = tk.Button(root, text="Enter", padx=10, pady=5, 
                        fg="white", bg="#80c1ff", font=(font, buttonFontSize), command=confirmEntries)   
enterButton.place(relx=0.0, rely=0.3775, relheight=0.04, relwidth=0.09)




root.mainloop()
